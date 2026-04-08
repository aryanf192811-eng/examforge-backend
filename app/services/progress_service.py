"""
ExamForge — Progress & Study Session Service
Tracks study sessions and computes aggregate progress stats.
"""

import uuid
from datetime import datetime

import structlog
from supabase import Client

from app.core.errors import ExamForgeError

logger = structlog.get_logger(__name__)


async def start_study_session(
    current_user: dict, chapter_id: str, supabase: Client
) -> dict:
    """Record the start of a study session.

    Creates a new entry in study_sessions with started_at timestamp.
    """
    user_id = current_user["profile_id"]
    session_id = str(uuid.uuid4())

    supabase.table("study_sessions").insert({
        "id": session_id,
        "user_id": user_id,
        "chapter_id": chapter_id,
        "started_at": datetime.utcnow().isoformat(),
    }).execute()

    logger.info("study_session_started", user_id=user_id, chapter_id=chapter_id)
    return {"session_id": session_id}


async def end_study_session(
    current_user: dict, session_id: str, supabase: Client
) -> dict:
    """Record the end of a study session.

    Calculates duration and updates the session record.
    """
    user_id = current_user["profile_id"]

    # Fetch session
    result = (
        supabase.table("study_sessions")
        .select("id, user_id, started_at")
        .eq("id", session_id)
        .single()
        .execute()
    )

    if not result.data:
        raise ExamForgeError(404, "Study session not found")

    if result.data["user_id"] != user_id:
        raise ExamForgeError(403, "Study session ownership mismatch")

    # Calculate duration
    started_at = result.data["started_at"]
    now = datetime.utcnow()
    try:
        start = datetime.fromisoformat(started_at.replace("Z", "+00:00"))
        duration_s = int((now - start.replace(tzinfo=None)).total_seconds())
    except (ValueError, TypeError):
        duration_s = 0

    # Update session
    supabase.table("study_sessions").update({
        "ended_at": now.isoformat(),
        "duration_s": duration_s,
    }).eq("id", session_id).execute()

    logger.info("study_session_ended", session_id=session_id, duration_s=duration_s)
    return {"duration_s": duration_s, "ok": True}


async def get_user_stats(current_user: dict, supabase: Client) -> dict:
    """Compute aggregate stats for a user's profile.

    Returns:
        total_points, chapters_completed, quizzes_taken, current_streak, study_hours
    """
    user_id = current_user["profile_id"]

    # Total points
    lb_result = (
        supabase.table("leaderboard_scores")
        .select("total_points")
        .eq("user_id", user_id)
        .execute()
    )
    total_points = 0
    if lb_result.data:
        total_points = lb_result.data[0].get("total_points", 0)

    # Chapters completed
    chapters_result = (
        supabase.table("user_progress")
        .select("id", count="exact")
        .eq("user_id", user_id)
        .eq("status", "done")
        .execute()
    )
    chapters_completed = chapters_result.count or 0

    # Quizzes taken
    quiz_result = (
        supabase.table("quiz_sessions")
        .select("id", count="exact")
        .eq("user_id", user_id)
        .eq("status", "submitted")
        .execute()
    )
    quizzes_taken = quiz_result.count or 0

    # Study hours (sum of study session durations)
    study_result = (
        supabase.table("study_sessions")
        .select("duration_s")
        .eq("user_id", user_id)
        .not_.is_("duration_s", "null")
        .execute()
    )
    total_study_s = sum(row.get("duration_s", 0) for row in study_result.data or [])
    study_hours = round(total_study_s / 3600, 1)

    # Current streak (consecutive days with activity)
    current_streak = await _calculate_streak(user_id, supabase)

    # Global Accuracy (Correct / Total questions in submitted quizzes)
    accuracy_result = (
        supabase.table("quiz_sessions")
        .select("correct_count, question_ids")
        .eq("user_id", user_id)
        .eq("status", "submitted")
        .execute()
    )
    total_correct = 0
    total_attempted = 0
    for row in accuracy_result.data or []:
        total_correct += row.get("correct_count", 0) or 0
        q_ids = row.get("question_ids")
        if isinstance(q_ids, list):
            total_attempted += len(q_ids)

    accuracy_pct = round((total_correct / total_attempted) * 100, 1) if total_attempted > 0 else 0.0

    return {
        "total_points": total_points,
        "chapters_completed": chapters_completed,
        "quizzes_taken": quizzes_taken,
        "current_streak": current_streak,
        "study_hours": study_hours,
        "accuracy_pct": accuracy_pct,
    }


async def _calculate_streak(user_id: str, supabase: Client) -> int:
    """Calculate the current consecutive-day study streak."""
    # Get recent study sessions ordered by date
    try:
        result = (
            supabase.table("study_sessions")
            .select("started_at")
            .eq("user_id", user_id)
            .order("started_at", desc=True)
            .limit(90)  # Check last 90 days max
            .execute()
        )
    except Exception as e:
        logger.error("streak_calculation_failed_missing_column", error=str(e))
        return 0

    if not result.data:
        return 0

    # Extract unique dates
    from datetime import date as date_type
    active_dates = set()
    for row in result.data:
        try:
            dt = datetime.fromisoformat(row["started_at"].replace("Z", "+00:00"))
            active_dates.add(dt.date())
        except (ValueError, TypeError):
            continue

    if not active_dates:
        return 0

    # Count consecutive days from today backwards
    today = date_type.today()
    streak = 0
    check_date = today

    while check_date in active_dates:
        streak += 1
        check_date -= __import__("datetime").timedelta(days=1)

    return streak
