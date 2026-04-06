"""
ExamForge — Leaderboard Router (/api/leaderboard)
Weekly, all-time, and college leaderboards.
"""

from fastapi import APIRouter, Depends, Query
from supabase import Client

from app.core.dependencies import get_current_user
from app.core.supabase import get_supabase
from app.models.leaderboard import LeaderboardResponse
from app.services import leaderboard_service

router = APIRouter()


@router.get("", response_model=LeaderboardResponse)
async def get_leaderboard(
    scope: str = Query("weekly", pattern="^(weekly|all_time|college)$"),
    page: int = Query(1, ge=1),
    limit: int = Query(50, ge=1, le=100),
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Get the leaderboard with pagination.

    Scopes:
    - weekly: Ranked by weekly_points (resets every Monday)
    - all_time: Ranked by total_points
    - college: Filtered by matching college, ranked by total_points
    """
    # Get current user's college for college scope
    current_user_college = None
    if scope == "college":
        profile_result = (
            supabase.table("profiles")
            .select("college")
            .eq("id", current_user["profile_id"])
            .single()
            .execute()
        )
        if profile_result.data:
            current_user_college = profile_result.data.get("college")

    result = await leaderboard_service.get_leaderboard(
        scope=scope,
        page=page,
        limit=limit,
        current_user_id=current_user["profile_id"],
        current_user_college=current_user_college,
        supabase=supabase,
    )
    return LeaderboardResponse(**result)
