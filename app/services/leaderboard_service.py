"""
ExamForge — Leaderboard Service
Points system and leaderboard queries.
"""

import structlog
from supabase import Client

logger = structlog.get_logger(__name__)

# ── Points configuration ────────────────────────────────────────────────
POINTS = {
    "chapter_completed": 50,
    "quiz_correct": 5,
    "mock_completed": 100,
    "flashcard_known": 3,
    "streak_bonus_per_day": 2,
}


async def add_points(user_id: str, reason: str, amount: int, supabase: Client) -> None:
    """Atomic increment of total_points and weekly_points via Supabase RPC.

    Uses the increment_leaderboard_points PostgreSQL function for atomicity.
    """
    try:
        supabase.rpc(
            "increment_leaderboard_points",
            {"p_user_id": user_id, "p_points": amount},
        ).execute()
        logger.info("points_added", user_id=user_id, reason=reason, amount=amount)
    except Exception:
        logger.exception("points_add_failed", user_id=user_id, reason=reason)


async def get_leaderboard(
    scope: str,
    page: int,
    limit: int,
    current_user_id: str,
    current_user_college: str | None,
    supabase: Client,
) -> dict:
    """Fetch leaderboard entries with pagination.

    Args:
        scope: 'weekly', 'all_time', or 'college'
        page: Page number (1-indexed)
        limit: Entries per page (max 50)
        current_user_id: Profile ID of the requesting user
        current_user_college: College name for college scope filtering
        supabase: Supabase client instance

    Returns:
        dict with entries, total count, and current user rank
    """
    offset = (page - 1) * limit
    order_col = "weekly_points" if scope == "weekly" else "total_points"

    # Base query with profile join
    query = (
        supabase.table("leaderboard_scores")
        .select(
            "user_id, total_points, weekly_points, "
            "profiles!inner(id, name, avatar_url, college)",
            count="exact",
        )
        .order(order_col, desc=True)
        .range(offset, offset + limit - 1)
    )

    # College scope: filter by matching college
    if scope == "college" and current_user_college:
        query = query.eq("profiles.college", current_user_college)

    result = query.execute()

    entries = []
    for i, row in enumerate(result.data or []):
        profile = row.get("profiles", {})
        entries.append({
            "rank": offset + i + 1,
            "user_id": row["user_id"],
            "name": profile.get("name", "Anonymous"),
            "avatar_url": profile.get("avatar_url"),
            "college": profile.get("college"),
            "total_points": row.get("total_points", 0),
            "weekly_points": row.get("weekly_points", 0),
            "is_current_user": row["user_id"] == current_user_id,
        })

    # Get current user's rank
    current_user_rank = None
    try:
        rank_query = (
            supabase.table("leaderboard_scores")
            .select("user_id")
            .order(order_col, desc=True)
        )
        if scope == "college" and current_user_college:
            # For college scope, we need a different approach
            pass

        rank_result = rank_query.execute()
        for idx, row in enumerate(rank_result.data or []):
            if row["user_id"] == current_user_id:
                current_user_rank = idx + 1
                break
    except Exception:
        logger.warning("rank_lookup_failed", user_id=current_user_id)

    return {
        "scope": scope,
        "entries": entries,
        "total_entries": result.count or len(entries),
        "current_user_rank": current_user_rank,
        "page": page,
        "limit": limit,
    }
