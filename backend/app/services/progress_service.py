"""
ExamForge — Progress Service
Tracks user reading progress and chapter completion in Supabase.
"""

import logging
from datetime import datetime
from typing import List, Dict, Any, Optional
from ..core.supabase import get_supabase

logger = logging.getLogger(__name__)

async def get_user_progress(uid: str, subject_id: Optional[str] = None):
    supabase = get_supabase()
    query = supabase.table("user_progress").select("*").eq("uid", uid)
    if subject_id:
        query = query.eq("subject_id", subject_id)
    result = query.execute()
    return result.data

async def update_progress(
    uid: str, 
    chapter_slug: str, 
    subject_slug: str, 
    progress_pct: int, 
    time_spent_s: int = 0,
    status: str = "not_started"
):
    supabase = get_supabase()
    data = {
        "uid": uid,
        "chapter_slug": chapter_slug,
        "subject_slug": subject_slug,
        "progress_pct": progress_pct,
        "time_spent_s": time_spent_s,
        "status": status,
        "last_read_at": "now()"
    }
    
    # Upsert logic
    result = supabase.table("user_progress").upsert(data, on_conflict="uid,chapter_slug").execute()
    return result.data[0] if result.data else None

async def get_user_stats(current_user: dict, supabase: Client) -> dict:
    """Calculate aggregated stats for the user dashboard."""
    uid = current_user["uid"]
    
    try:
        # 1. Chapters Completed
        completed_res = (
            supabase.table("user_progress")
            .select("id", count="exact")
            .eq("uid", uid)
            .eq("status", "done")
            .execute()
        )
        chapters_completed = completed_res.count if completed_res.count is not None else 0

        # 2. Points & Streak (from profile)
        profile_res = (
            supabase.table("profiles")
            .select("total_points, current_streak")
            .eq("uid", uid)
            .single()
            .execute()
        )
        profile = profile_res.data or {}

        # 3. Quizzes taken
        quiz_res = (
            supabase.table("quiz_sessions")
            .select("id", count="exact")
            .eq("uid", uid)
            .eq("status", "completed")
            .execute()
        )
        quizzes_taken = quiz_res.count if quiz_res.count is not None else 0

        return {
            "total_points": profile.get("total_points", 0),
            "chapters_completed": chapters_completed,
            "quizzes_taken": quizzes_taken,
            "current_streak": profile.get("current_streak", 0),
            "study_hours": 0.0,  # Placeholder or compute from time_spent_s
            "accuracy_pct": 0.0, # Placeholder or compute from quiz results
        }
    except Exception as e:
        logger.error("get_user_stats_failed", error=str(e), uid=uid)
        return {
            "total_points": 0,
            "chapters_completed": 0,
            "quizzes_taken": 0,
            "current_streak": 0,
            "study_hours": 0.0,
            "accuracy_pct": 0.0,
        }
