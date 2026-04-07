"""
ExamForge — Quiz Service (v2: Redis-backed hot state)
Manages quiz sessions with Redis for high-frequency saves and PostgreSQL for persistence.
"""

import json
import uuid
from datetime import datetime, timedelta
from typing import Optional

import structlog
from supabase import Client

from app.core.config import settings
from app.core.errors import ExamForgeError
from app.services.leaderboard_service import add_points, POINTS

logger = structlog.get_logger(__name__)

# ── GATE Marking Scheme ─────────────────────────────────────────────────
NEGATIVE_MARKING = {
    1: -1 / 3,  # 1-mark MCQ: -1/3
    2: -2 / 3,  # 2-mark MCQ: -2/3
}


async def create_quiz_session(
    current_user: dict,
    mode: str,
    subject_ids: list[str] | None,
    year: int | None,
    question_type: str | None,
    difficulty: str | None,
    count: int,
    source_session_id: str | None,
    supabase: Client,
) -> dict:
    """Create a new quiz session in PostgreSQL.

    Modes:
    - pyq: Previous Year Questions filtered by params
    - mock: Full 65-question GATE mock (GA + CS distribution)
    - custom: User-defined filters
    - shadow: Retry wrong questions from a previous session
    """
    user_id = current_user["profile_id"]
    session_id = str(uuid.uuid4())

    # ── Build question query based on mode ───────────────────────────
    query = supabase.table("questions").select(
        "id, type, marks, question_text, option_a, option_b, option_c, option_d, "
        "difficulty, is_pyq, gate_year, subject_id, chapter_id, category, "
        "subjects!inner(name), chapters(title)"
    )

    if mode == "shadow" and source_session_id:
        # Get wrong questions from source session
        source = (
            supabase.table("quiz_sessions")
            .select("answers, question_ids")
            .eq("id", source_session_id)
            .eq("user_id", user_id)
            .single()
            .execute()
        )
        if not source.data:
            raise ExamForgeError(404, "Source session not found")

        # Get correct answers for source questions
        source_q_ids = source.data.get("question_ids", [])
        source_answers = source.data.get("answers", {})

        wrong_ids = []
        for qid in source_q_ids:
            q_data = (
                supabase.table("questions")
                .select("id, correct_option, correct_options, type, nat_answer_min, nat_answer_max")
                .eq("id", qid)
                .single()
                .execute()
            )
            if q_data.data:
                user_ans = source_answers.get(qid)
                if not _is_answer_correct(q_data.data, user_ans):
                    wrong_ids.append(qid)

        if not wrong_ids:
            raise ExamForgeError(400, "No wrong answers found in that session")

        query = query.in_("id", wrong_ids)

    else:
        # Apply filters
        if subject_ids:
            query = query.in_("subject_id", subject_ids)
        if year:
            query = query.eq("gate_year", year).eq("is_pyq", True)
        if question_type:
            query = query.eq("type", question_type)
        if difficulty:
            query = query.eq("difficulty", difficulty)

        if mode == "mock":
            count = 65  # GATE standard

    # Fetch and limit
    result = query.limit(count).execute()
    questions = result.data or []

    if not questions:
        raise ExamForgeError(404, "No questions found matching your criteria")

    # ── Build question list (correct answers NEVER returned) ─────────
    question_ids = [q["id"] for q in questions]
    formatted_questions = []
    for q in questions:
        try:
            options = []
            for key in ["A", "B", "C", "D"]:
                opt_text = q.get(f"option_{key.lower()}")
                if opt_text:
                    options.append({"key": key, "text": opt_text})

            subject_info = q.get("subjects", {})
            chapter_info = q.get("chapters", {})

            formatted_questions.append({
                "id": q["id"],
                "type": q.get("type", "MCQ"),
                "marks": float(q.get("marks", 1.0)),
                "stem": q["question_text"],
                "options": options,
                "subject": subject_info.get("name", ""),
                "chapter": chapter_info.get("title") if chapter_info else None,
                "category": q.get("category"),
                "difficulty": q.get("difficulty", "medium"),
                "is_pyq": q.get("is_pyq", False),
                "gate_year": q.get("gate_year"),
                "explanation": q.get("explanation"),
                "image_url": q.get("image_url"),
            })
        except Exception as e:
            logger.error("quiz_question_format_failed", question_id=q.get("id"), error=str(e))
            continue

    # ── Calculate deadline ───────────────────────────────────────────
    now = datetime.utcnow()
    if mode == "mock":
        deadline = now + timedelta(hours=3)  # GATE standard: 3 hours
    else:
        deadline = now + timedelta(hours=2)  # Custom sessions: 2 hours

    # ── Create session in PostgreSQL ─────────────────────────────────
    try:
        supabase.table("quiz_sessions").insert({
            "id": session_id,
            "user_id": user_id,
            "mode": mode,
            "question_ids": question_ids,
            "status": "active",
            "started_at": now.isoformat(),
            "server_deadline": deadline.isoformat(),
            "answers": {},
            "flags": [],
        }).execute()
    except Exception as e:
        logger.warning("quiz_session_insert_failed_retrying", error=str(e))
        # Retry without mode column
        supabase.table("quiz_sessions").insert({
            "id": session_id,
            "user_id": user_id,
            "question_ids": question_ids,
            "status": "active",
            "started_at": now.isoformat(),
            "server_deadline": deadline.isoformat(),
            "answers": {},
            "flags": [],
        }).execute()


    logger.info(
        "quiz_session_created",
        session_id=session_id, user_id=user_id, mode=mode,
        question_count=len(formatted_questions),
    )

    return {
        "session_id": session_id,
        "questions": formatted_questions,
        "server_deadline": deadline.isoformat(),
        "question_count": len(formatted_questions),
    }


async def save_quiz_state(
    current_user: dict,
    session_id: str,
    answers: dict,
    flags: list,
    supabase: Client,
) -> dict:
    """Sync ephemeral quiz state to PostgreSQL directly.
    """
    user_id = current_user["profile_id"]

    # Verify ownership and update directly
    # Postgrest doesn't easily return rows on update without returning(), 
    # but we can select then update, or just update where id=session_id AND user_id=user_id and status='active'
    
    session = (
        supabase.table("quiz_sessions")
        .select("id, user_id, status")
        .eq("id", session_id)
        .single()
        .execute()
    )
    if not session.data:
        raise ExamForgeError(404, "Session not found")
    if session.data["user_id"] != user_id:
        raise ExamForgeError(403, "Session ownership mismatch")
    if session.data["status"] == "submitted":
        raise ExamForgeError(409, "Session already submitted")

    now = datetime.utcnow().isoformat()
    supabase.table("quiz_sessions").update({
        "answers": answers,
        "flags": flags,
    }).eq("id", session_id).execute()

    return {"ok": True, "saved_at": now}


async def submit_quiz(
    current_user: dict, session_id: str, supabase: Client
) -> dict:
    """Submit quiz, calculate score, return results.
    """
    user_id = current_user["profile_id"]

    # ── Step 1: Fetch session + verify ───────────────────────────────
    try:
        session = (
            supabase.table("quiz_sessions")
            .select("id, user_id, mode, question_ids, status, started_at, server_deadline, answers")
            .eq("id", session_id)
            .single()
            .execute()
        )
    except Exception as e:
        logger.warning("quiz_submission_fetch_failed_retrying", error=str(e))
        # Retry without mode column
        session = (
            supabase.table("quiz_sessions")
            .select("id, user_id, question_ids, status, started_at, server_deadline, answers")
            .eq("id", session_id)
            .single()
            .execute()
        )

    if not session.data:
        raise ExamForgeError(404, "Session not found")
    if session.data["user_id"] != user_id:
        raise ExamForgeError(403, "Session ownership mismatch")
    if session.data["status"] == "submitted":
        raise ExamForgeError(409, "Session already submitted")

    answers = session.data.get("answers", {})

    question_ids = session.data.get("question_ids", [])
    started_at = session.data.get("started_at")

    # ── Step 3: Fetch questions with correct answers ─────────────────
    questions_result = (
        supabase.table("questions")
        .select(
            "id, type, marks, question_text, correct_option, correct_options, "
            "nat_answer_min, nat_answer_max, explanation, subject_id, "
            "subjects!inner(name)"
        )
        .in_("id", question_ids)
        .execute()
    )

    questions_map = {q["id"]: q for q in questions_result.data or []}

    # ── Step 4: Calculate score (GATE negative marking) ──────────────
    total_marks = 0.0
    marks_obtained = 0.0
    correct = 0
    incorrect = 0
    unanswered = 0
    negative_marks = 0.0
    question_results = []
    subject_stats: dict[str, dict] = {}

    for qid in question_ids:
        q = questions_map.get(qid)
        if not q:
            continue

        q_marks = float(q["marks"])
        total_marks += q_marks
        user_answer = answers.get(qid)
        subject_name = q.get("subjects", {}).get("name", "Unknown")

        # Initialize subject stats
        if subject_name not in subject_stats:
            subject_stats[subject_name] = {
                "total_questions": 0, "correct": 0, "incorrect": 0,
                "unanswered": 0, "marks_obtained": 0.0, "marks_possible": 0.0,
            }
        subject_stats[subject_name]["total_questions"] += 1
        subject_stats[subject_name]["marks_possible"] += q_marks

        is_correct = False
        marks_awarded = 0.0

        if not user_answer:
            unanswered += 1
            subject_stats[subject_name]["unanswered"] += 1
        elif _is_answer_correct(q, user_answer):
            is_correct = True
            correct += 1
            marks_awarded = q_marks
            marks_obtained += q_marks
            subject_stats[subject_name]["correct"] += 1
            subject_stats[subject_name]["marks_obtained"] += q_marks
        else:
            incorrect += 1
            # Apply negative marking for MCQ only
            if q["type"] == "MCQ":
                neg = NEGATIVE_MARKING.get(int(q_marks), 0)
                negative_marks += abs(neg)
                marks_awarded = neg
                marks_obtained += neg
                subject_stats[subject_name]["marks_obtained"] += neg
            subject_stats[subject_name]["incorrect"] += 1

        # Determine correct answer string for display
        correct_answer = q.get("correct_option", "")
        if q["type"] == "MSQ" and q.get("correct_options"):
            correct_answer = ",".join(q["correct_options"])
        elif q["type"] == "NAT":
            nat_min = q.get("nat_answer_min")
            nat_max = q.get("nat_answer_max")
            if nat_min is not None and nat_max is not None:
                if float(nat_min) == float(nat_max):
                    correct_answer = str(nat_min)
                else:
                    correct_answer = f"{nat_min} to {nat_max}"

        question_results.append({
            "question_id": qid,
            "user_answer": user_answer,
            "correct_answer": correct_answer,
            "is_correct": is_correct,
            "marks_awarded": round(marks_awarded, 2),
            "explanation": q.get("explanation"),
        })

    # ── Step 5: Calculate time taken ─────────────────────────────────
    time_taken_s = None
    if started_at:
        try:
            start = datetime.fromisoformat(started_at.replace("Z", "+00:00"))
            time_taken_s = int((datetime.utcnow() - start.replace(tzinfo=None)).total_seconds())
        except (ValueError, TypeError):
            pass

    total_questions = len(question_ids)
    accuracy_pct = round((correct / total_questions) * 100, 1) if total_questions > 0 else 0.0

    # ── Step 6: Update session status ────────────────────────────────
    supabase.table("quiz_sessions").update({
        "status": "submitted",
        "score": round(marks_obtained, 2),
        "total_marks": round(total_marks, 2),
        "correct_count": correct,
        "incorrect_count": incorrect,
        "unanswered_count": unanswered,
        "submitted_at": datetime.utcnow().isoformat(),
        "time_taken_s": time_taken_s,
    }).eq("id", session_id).execute()

    # ── Step 7: Award leaderboard points ─────────────────────────────
    if correct > 0:
        await add_points(
            user_id=user_id,
            reason="quiz_correct",
            amount=correct * POINTS["quiz_correct"],
            supabase=supabase,
        )

    if session.data.get("mode") == "mock":
        await add_points(
            user_id=user_id,
            reason="mock_completed",
            amount=POINTS["mock_completed"],
            supabase=supabase,
        )


    logger.info(
        "quiz_submitted",
        session_id=session_id, score=round(marks_obtained, 2),
        correct=correct, total=total_questions,
    )

    # ── Step 9: Build subject analysis ───────────────────────────────
    subject_analysis = []
    for subj, stats in subject_stats.items():
        total_q = stats["total_questions"]
        subject_analysis.append({
            "subject": subj,
            "total_questions": total_q,
            "correct": stats["correct"],
            "incorrect": stats["incorrect"],
            "unanswered": stats["unanswered"],
            "marks_obtained": round(stats["marks_obtained"], 2),
            "marks_possible": round(stats["marks_possible"], 2),
            "accuracy_pct": round((stats["correct"] / total_q) * 100, 1) if total_q > 0 else 0.0,
        })

    return {
        "session_id": session_id,
        "total_marks": round(total_marks, 2),
        "marks_obtained": round(marks_obtained, 2),
        "total_questions": total_questions,
        "correct": correct,
        "incorrect": incorrect,
        "unanswered": unanswered,
        "accuracy_pct": accuracy_pct,
        "negative_marks": round(negative_marks, 2),
        "time_taken_s": time_taken_s,
        "question_results": question_results,
        "subject_analysis": subject_analysis,
    }


async def get_active_session(current_user: dict, supabase: Client) -> dict:
    """Check if user has an active (non-submitted) quiz session.
    """
    user_id = current_user["profile_id"]

    # Check PostgreSQL for active sessions
    try:
        result = (
            supabase.table("quiz_sessions")
            .select("id, mode, question_ids, started_at, server_deadline, answers, status")
            .eq("user_id", user_id)
            .eq("status", "active")
            .order("started_at", desc=True)
            .limit(1)
            .execute()
        )
    except Exception as e:
        logger.warning("quiz_active_session_fetch_failed_retrying", error=str(e))
        # Retry without mode column
        result = (
            supabase.table("quiz_sessions")
            .select("id, question_ids, started_at, server_deadline, answers, status")
            .eq("user_id", user_id)
            .eq("status", "active")
            .order("started_at", desc=True)
            .limit(1)
            .execute()
        )

    if not result.data:
        return {"has_active": False, "session": None}

    session = result.data[0]
    question_ids = session.get("question_ids", [])

    # Get answered count from DB
    db_answers = session.get("answers", {})
    answered_count = len(db_answers) if isinstance(db_answers, dict) else 0

    return {
        "has_active": True,
        "session": {
            "id": session["id"],
            "type": session.get("mode", "custom"),
            "question_count": len(question_ids),
            "answered_count": answered_count,
            "started_at": session["started_at"],
            "server_deadline": session.get("server_deadline"),
        },
    }


def _is_answer_correct(question: dict, user_answer: str | None) -> bool:
    """Check if a user's answer is correct for any question type."""
    if not user_answer:
        return False

    q_type = question.get("type", "MCQ")

    if q_type == "MCQ":
        return user_answer.strip().upper() == (question.get("correct_option") or "").strip().upper()

    elif q_type == "MSQ":
        correct = set(question.get("correct_options") or [])
        user_set = set(ans.strip().upper() for ans in user_answer.split(","))
        return user_set == correct

    elif q_type == "NAT":
        try:
            user_val = float(user_answer)
            nat_min = float(question.get("nat_answer_min", 0))
            nat_max = float(question.get("nat_answer_max", 0))
            return nat_min <= user_val <= nat_max
        except (ValueError, TypeError):
            return False

    return False
