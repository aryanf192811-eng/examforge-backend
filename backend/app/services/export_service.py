"""
ExamForge — Data Export Service
Generates JSON exports of all user data (GDPR-friendly).
"""

from datetime import datetime

import structlog
from supabase import Client

logger = structlog.get_logger(__name__)


async def export_user_data(current_user: dict, supabase: Client) -> dict:
    """Generate a comprehensive JSON export of all user data.

    Exports:
    - Profile information
    - Study progress (per chapter)
    - Quiz session history + results
    - Bookmarks
    - Doubts + AI answers
    - Flashcard states
    - Study sessions
    - Leaderboard stats
    """
    user_id = current_user["profile_id"]

    # ── Profile ──────────────────────────────────────────────────────
    profile_result = (
        supabase.table("profiles")
        .select("*")
        .eq("id", user_id)
        .single()
        .execute()
    )
    profile = profile_result.data or {}

    # ── Progress ─────────────────────────────────────────────────────
    progress_result = (
        supabase.table("user_progress")
        .select("chapter_id, status, time_spent_s, updated_at, chapters(title, subjects(name))")
        .eq("user_id", user_id)
        .execute()
    )
    progress = []
    for row in progress_result.data or []:
        ch = row.get("chapters", {})
        subj = ch.get("subjects", {})
        progress.append({
            "chapter": ch.get("title", ""),
            "subject": subj.get("name", ""),
            "status": row["status"],
            "time_spent_s": row.get("time_spent_s", 0),
            "updated_at": row.get("updated_at"),
        })

    # ── Quiz Sessions ────────────────────────────────────────────────
    quiz_result = (
        supabase.table("quiz_sessions")
        .select(
            "id, mode, status, score, total_marks, correct_count, incorrect_count, "
            "unanswered_count, started_at, submitted_at, time_taken_s"
        )
        .eq("user_id", user_id)
        .order("started_at", desc=True)
        .execute()
    )
    quizzes = quiz_result.data or []

    # ── Bookmarks ────────────────────────────────────────────────────
    bookmarks_result = (
        supabase.table("bookmarks")
        .select("section_id, section_title, created_at, chapters(title, subjects(name))")
        .eq("user_id", user_id)
        .execute()
    )
    bookmarks = []
    for row in bookmarks_result.data or []:
        ch = row.get("chapters", {})
        subj = ch.get("subjects", {})
        bookmarks.append({
            "section_id": row["section_id"],
            "section_title": row.get("section_title", ""),
            "chapter": ch.get("title", ""),
            "subject": subj.get("name", ""),
            "created_at": row["created_at"],
        })

    # ── Doubts ───────────────────────────────────────────────────────
    doubts_result = (
        supabase.table("doubts")
        .select("question, answer, selected_text, created_at, chapters(title)")
        .eq("user_id", user_id)
        .order("created_at", desc=True)
        .execute()
    )
    doubts = []
    for row in doubts_result.data or []:
        ch = row.get("chapters", {})
        doubts.append({
            "question": row["question"],
            "answer": row["answer"],
            "selected_text": row["selected_text"],
            "chapter": ch.get("title", ""),
            "created_at": row["created_at"],
        })

    # ── Flashcard States ─────────────────────────────────────────────
    flashcard_result = (
        supabase.table("user_flashcard_state")
        .select("question_id, ease_factor, interval, next_review, review_count")
        .eq("user_id", user_id)
        .execute()
    )
    flashcards = flashcard_result.data or []

    # ── Study Sessions ───────────────────────────────────────────────
    study_result = (
        supabase.table("study_sessions")
        .select("started_at, ended_at, duration_s, chapters(title)")
        .eq("user_id", user_id)
        .order("started_at", desc=True)
        .execute()
    )
    study_sessions = []
    for row in study_result.data or []:
        ch = row.get("chapters", {})
        study_sessions.append({
            "chapter": ch.get("title", ""),
            "started_at": row["started_at"],
            "ended_at": row.get("ended_at"),
            "duration_s": row.get("duration_s"),
        })

    # ── Leaderboard ──────────────────────────────────────────────────
    lb_result = (
        supabase.table("leaderboard_scores")
        .select("total_points, weekly_points, updated_at")
        .eq("user_id", user_id)
        .execute()
    )
    leaderboard = lb_result.data[0] if lb_result.data else {}

    # ── Assemble export ──────────────────────────────────────────────
    export_data = {
        "export_version": "2.0",
        "exported_at": datetime.utcnow().isoformat(),
        "platform": "ExamForge",
        "profile": {
            "name": profile.get("name"),
            "email": profile.get("email"),
            "role": profile.get("role"),
            "college": profile.get("college"),
            "gate_year": profile.get("gate_year"),
            "created_at": profile.get("created_at"),
        },
        "progress": progress,
        "quiz_sessions": quizzes,
        "bookmarks": bookmarks,
        "doubts": doubts,
        "flashcard_states": flashcards,
        "study_sessions": study_sessions,
        "leaderboard": leaderboard,
        "stats": {
            "total_chapters_completed": len([p for p in progress if p["status"] == "done"]),
            "total_quizzes_taken": len([q for q in quizzes if q.get("status") == "submitted"]),
            "total_bookmarks": len(bookmarks),
            "total_doubts_asked": len(doubts),
            "total_study_hours": round(
                sum(s.get("duration_s", 0) or 0 for s in study_sessions) / 3600, 1
            ),
        },
    }

    logger.info("data_exported", user_id=user_id)
    return export_data
