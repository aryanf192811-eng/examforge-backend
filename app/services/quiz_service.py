"""
ExamForge — Quiz Service (v3: Hybrid Table)
Manages quiz sessions with the new flat questions table and uid-based profiles.
"""

import json
import uuid
from datetime import datetime, timedelta
from typing import Optional, List, Dict

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
    subject_slugs: list[str] | None,
    year: int | None,
    difficulty: str | None,
    count: int,
    supabase: Client,
) -> dict:
    """Create a new quiz session."""
    user_id = current_user["uid"]
    session_id = str(uuid.uuid4())

    # ── Build question query ─────────────────────────────────────────
    query = supabase.table("questions").select("*")

    if subject_slugs:
        query = query.in_("subject_slug", subject_slugs)
    if year:
        query = query.eq("gate_year", year).eq("is_pyq", True)
    if difficulty:
        query = query.eq("difficulty", difficulty)

    if mode == "mock":
        count = 65

    # Fetch and limit
    result = query.limit(count).execute()
    questions = result.data or []

    if not questions:
        raise ExamForgeError(404, "No questions found matching your criteria")

    question_ids = [q["id"] for q in questions]
    formatted_questions = []
    
    for q in questions:
        try:
            # Prepare options array and determine type
            options = []
            q_type = "MCQ"
            
            if q.get("option_a"):
                options.append({"key": "a", "text": q["option_a"]})
            if q.get("option_b"):
                options.append({"key": "b", "text": q["option_b"]})
            if q.get("option_c"):
                options.append({"key": "c", "text": q["option_c"]})
            if q.get("option_d"):
                options.append({"key": "d", "text": q["option_d"]})
            
            # If no options, it's NAT
            if not options:
                q_type = "NAT"

            formatted_questions.append({
                "id": q["id"],
                "question_text": q["question_text"],
                "type": q_type,
                "options": options,
                "subject_slug": q["subject_slug"],
                "chapter_slug": q["chapter_slug"],
                "difficulty": q.get("difficulty", "medium"),
                "marks": int(q.get("marks", 1)),
                "is_pyq": q.get("is_pyq", False),
                "gate_year": q.get("gate_year"),
                "option_a": q["option_a"],
                "option_b": q["option_b"],
                "option_c": q["option_c"],
                "option_d": q["option_d"],
                "explanation": q.get("explanation"),
            })
        except Exception as e:
            logger.error("quiz_question_format_failed", question_id=q.get("id"), error=str(e))
            continue

    # ── Calculate deadline ───────────────────────────────────────────
    now = datetime.utcnow()
    deadline = now + timedelta(hours=3 if mode == "mock" else 2)

    # ── Create session in PostgreSQL ─────────────────────────────────
    try:
        # Determine a primary subject_slug for the session
        primary_slug = subject_slugs[0] if subject_slugs else "mixed"
        
        supabase.table("quiz_sessions").insert({
            "id": session_id,
            "uid": user_id,
            "subject_slug": primary_slug,
            "mode": mode,
            "question_ids": question_ids,
            "status": "active",
            "started_at": now.isoformat(),
            "answers": {},
        }).execute()
    except Exception as e:
        logger.error("quiz_session_insert_failed", error=str(e), user=user_id)
        raise ExamForgeError(500, f"Could not start quiz session: {str(e)}")

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
    supabase: Client,
) -> dict:
    """Sync ephemeral quiz state to PostgreSQL directly."""
    user_id = current_user["uid"]
    
    try:
        supabase.table("quiz_sessions").update({
            "answers": answers,
        }).eq("id", session_id).eq("uid", user_id).eq("status", "active").execute()
        
        return {"ok": True, "saved_at": datetime.utcnow().isoformat()}
    except Exception as e:
        logger.error("quiz_state_save_failed", session_id=session_id, error=str(e))
        raise ExamForgeError(500, "Failed to save progress")


async def submit_quiz(
    current_user: dict, session_id: str, supabase: Client
) -> dict:
    """Submit quiz, calculate score, return results."""
    user_id = current_user["uid"]

    # 1. Fetch session
    session_res = (
        supabase.table("quiz_sessions")
        .select("*")
        .eq("id", session_id)
        .eq("uid", user_id)
        .single()
        .execute()
    )

    if not session_res.data:
        raise ExamForgeError(404, "Session not found")
    if session_res.data["status"] == "submitted":
        raise ExamForgeError(409, "Already submitted")

    session = session_res.data
    question_ids = session["question_ids"]
    answers = session.get("answers", {})

    # 2. Fetch questions
    questions_res = (
        supabase.table("questions")
        .select("*")
        .in_("id", question_ids)
        .execute()
    )
    questions_map = {q["id"]: q for q in questions_res.data or []}

    # 3. Grade
    total_marks = 0
    marks_obtained = 0.0
    correct = 0
    incorrect = 0
    unanswered = 0
    question_results = []

    for qid in question_ids:
        q = questions_map.get(qid)
        if not q: continue

        q_marks = int(q["marks"])
        total_marks += q_marks
        user_ans = answers.get(qid)
        
        is_correct = False
        marks_awarded = 0.0

        if not user_ans:
            unanswered += 1
        elif str(user_ans).upper() == str(q["correct_option"]).upper():
            is_correct = True
            correct += 1
            marks_awarded = float(q_marks)
            marks_obtained += marks_awarded
        else:
            incorrect += 1
            # Negative marking for MCQ (assume all are MCQ in new flat structure for now)
            neg = NEGATIVE_MARKING.get(q_marks, 0)
            marks_awarded = neg
            marks_obtained += neg

        question_results.append({
            "question_id": qid,
            "user_answer": user_ans,
            "correct_answer": q["correct_option"],
            "is_correct": is_correct,
            "marks_awarded": round(marks_awarded, 2),
            "explanation": q.get("explanation"),
        })

    # 4. Update session
    supabase.table("quiz_sessions").update({
        "status": "submitted",
        "score": round(marks_obtained, 2),
        "submitted_at": datetime.utcnow().isoformat(),
    }).eq("id", session_id).execute()

    # 5. Points
    if correct > 0:
        await add_points(user_id, "quiz_correct", correct * POINTS["quiz_correct"], supabase)

    return {
        "session_id": session_id,
        "total_marks": total_marks,
        "marks_obtained": round(marks_obtained, 2),
        "total_questions": len(question_ids),
        "correct": correct,
        "incorrect": incorrect,
        "unanswered": unanswered,
        "accuracy_pct": round((correct / len(question_ids)) * 100, 1) if question_ids else 0,
        "question_results": question_results,
    }

async def get_active_session(current_user: dict, supabase: Client) -> dict:
    """Check for active session."""
    user_id = current_user["uid"]
    
    res = (
        supabase.table("quiz_sessions")
        .select("id, question_ids, started_at, answers")
        .eq("uid", user_id)
        .eq("status", "active")
        .order("started_at", desc=True)
        .limit(1)
        .execute()
    )
    
    if not res.data:
        return {"has_active": False}
        
    s = res.data[0]
    return {
        "has_active": True,
        "session": {
            "id": s["id"],
            "question_count": len(s["question_ids"]),
            "answered_count": len(s.get("answers", {})),
            "started_at": s["started_at"]
        }
    }
