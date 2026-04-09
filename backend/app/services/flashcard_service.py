"""
ExamForge — Flashcard Service (SM-2 Spaced Repetition)
Server-side SM-2 algorithm — never trust client-submitted ease_factor.
"""

from datetime import date, timedelta

import structlog
from supabase import Client

from app.core.errors import ExamForgeError
from app.services.leaderboard_service import add_points, POINTS

logger = structlog.get_logger(__name__)


def sm2_update(ease_factor: float, interval: int, quality: int) -> tuple[float, int, date]:
    """SM-2 spaced repetition algorithm.

    Args:
        ease_factor: Current ease factor (min 1.3)
        interval: Current interval in days
        quality: Review quality (0-5)
            0-2: Complete blackout / incorrect
            3: Correct with serious difficulty
            4: Correct with hesitation
            5: Perfect response

    Returns:
        Tuple of (new_ease_factor, new_interval, next_review_date)

    The SM-2 algorithm runs SERVER-SIDE ONLY.
    Never trust client-submitted ease_factor values.
    """
    if quality < 3:
        # Failed review — reset to 1 day
        return max(1.3, ease_factor - 0.2), 1, date.today() + timedelta(days=1)

    # Successful review — calculate new ease factor
    new_ef = ease_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    new_ef = max(1.3, new_ef)

    # Calculate new interval
    if interval <= 1:
        new_interval = 1
    elif interval == 1:
        new_interval = 6
    else:
        new_interval = round(interval * new_ef)

    next_review = date.today() + timedelta(days=new_interval)
    return new_ef, new_interval, next_review


async def get_due_flashcards(
    current_user: dict, subject_id: str | None, supabase: Client
) -> dict:
    """Get flashcards due for review today (SM-2 algorithm).

    Fetches user_flashcard_state entries where next_review <= today,
    joined with questions for card content.
    """
    user_id = current_user["profile_id"]
    today = date.today().isoformat()

    query = (
        supabase.table("user_flashcard_state")
        .select(
            "id, question_id, ease_factor, interval, next_review, review_count, "
            "questions!inner(question_text, explanation, subject_id, "
            "subjects!inner(name), chapters(title))"
        )
        .eq("user_id", user_id)
        .lte("next_review", today)
        .order("next_review")
    )

    if subject_id:
        query = query.eq("questions.subject_id", subject_id)

    result = query.execute()

    flashcards = []
    for row in result.data or []:
        q = row.get("questions", {})
        subject_info = q.get("subjects", {})
        chapter_info = q.get("chapters", {})

        flashcards.append({
            "id": row["id"],
            "question_id": row["question_id"],
            "front": q.get("question_text", ""),
            "back": q.get("explanation", ""),
            "subject": subject_info.get("name", ""),
            "chapter": chapter_info.get("title") if chapter_info else None,
            "ease_factor": row.get("ease_factor", 2.5),
            "interval": row.get("interval", 1),
            "next_review": row["next_review"],
            "review_count": row.get("review_count", 0),
        })

    return {
        "due_count": len(flashcards),
        "flashcards": flashcards,
    }


async def review_flashcard(
    current_user: dict, flashcard_id: str, quality: int, supabase: Client
) -> dict:
    """Submit a flashcard review response. SM-2 update runs server-side only.

    Args:
        flashcard_id: The flashcard state ID
        quality: SM-2 quality rating (0-5)

    Returns:
        Updated scheduling info
    """
    user_id = current_user["profile_id"]

    # Fetch current state
    result = (
        supabase.table("user_flashcard_state")
        .select("id, user_id, ease_factor, interval, review_count")
        .eq("id", flashcard_id)
        .single()
        .execute()
    )

    if not result.data:
        raise ExamForgeError(404, "Flashcard state not found")

    if result.data["user_id"] != user_id:
        raise ExamForgeError(403, "Flashcard ownership mismatch")

    current_ef = result.data.get("ease_factor", 2.5)
    current_interval = result.data.get("interval", 1)
    review_count = result.data.get("review_count", 0)

    # Run SM-2 algorithm SERVER-SIDE ONLY
    new_ef, new_interval, next_review = sm2_update(current_ef, current_interval, quality)

    # Update state
    supabase.table("user_flashcard_state").update({
        "ease_factor": round(new_ef, 2),
        "interval": new_interval,
        "next_review": next_review.isoformat(),
        "review_count": review_count + 1,
        "last_reviewed": date.today().isoformat(),
    }).eq("id", flashcard_id).execute()

    # Award points if the user knew the answer (quality >= 3)
    if quality >= 3:
        await add_points(
            user_id=user_id,
            reason="flashcard_known",
            amount=POINTS["flashcard_known"],
            supabase=supabase,
        )

    logger.info(
        "flashcard_reviewed",
        user_id=user_id, flashcard_id=flashcard_id,
        quality=quality, new_interval=new_interval,
    )

    return {
        "ok": True,
        "next_review": next_review.isoformat(),
        "new_interval": new_interval,
        "new_ease_factor": round(new_ef, 2),
    }
