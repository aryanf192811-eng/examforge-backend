"""
ExamForge — Progress & Study Session Service (v3)
Tracks study sessions and computes aggregate progress stats using uid-based schema.
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
    """Record the start of a study session."""
    user_id = current_user["uid"]
    session_id = str(uuid.uuid4())

    try:
        supabase.table("study_sessions").insert({
            "id": session_id,
            "uid": user_id,
            "chapter_id": chapter_id,
            "started_at": datetime.utcnow().isoformat(),
        }).execute()
    except Exception as e:
        logger.error("study_session_start_failed", error=str(e))
        # Don't crash for analytics failure
        return {"session_id": session_id, "error": str(e)}

    return {"session_id": session_id}


async def end_study_session(
    current_user: dict, session_id: str, supabase: Client
) -> dict:
    """Record the end of a study session."""
    user_id = current_user["uid"]

    try:
        result = (
            supabase.table("study_sessions")
            .select("id, uid, started_at")
            .eq("id", session_id)
            .single()
            .execute()
        )
        if not result.data or result.data["uid"] != user_id:
             return {"ok": False, "error": "Session not found or forbidden"}

        started_at = result.data["started_at"]
        now = datetime.utcnow()
        duration_s = 0
        try:
            start = datetime.fromisoformat(started_at.replace("Z", "+00:00"))
            duration_s = int((now - start.replace(tzinfo=None)).total_seconds())
        except: pass

        supabase.table("study_sessions").update({
            "ended_at": now.isoformat(),
            "duration_s": duration_s,
        }).eq("id", session_id).execute()

        return {"duration_s": duration_s, "ok": True}
    except Exception as e:
        logger.error("study_session_end_failed", error=str(e))
        return {"ok": False, "error": str(e)}


async def get_user_stats(current_user: dict, supabase: Client) -> dict:
    """Compute aggregate stats for a user's profile."""
    user_id = current_user["uid"]

    # 1. Points
    total_points = 0
    try:
        lb_res = supabase.table("profiles").select("total_points").eq("uid", user_id).single().execute()
        if lb_res.data:
            total_points = lb_res.data.get("total_points", 0)
    except: pass

    # 2. Chapters completed
    chapters_completed = 0
    try:
        chapters_res = supabase.table("user_progress").select("id", count="exact").eq("uid", user_id).eq("status", "done").execute()
        chapters_completed = chapters_res.count or 0
    except: pass

    # 3. Quizzes taken
    quizzes_taken = 0
    try:
        quiz_res = supabase.table("quiz_sessions").select("id", count="exact").eq("uid", user_id).eq("status", "submitted").execute()
        quizzes_taken = quiz_res.count or 0
    except: pass

    # 4. Study hours
    study_hours = 0.0
    try:
        study_res = supabase.table("study_sessions").select("duration_s").eq("uid", user_id).execute()
        total_s = sum(row.get("duration_s", 0) or 0 for row in study_res.data or [])
        study_hours = round(total_s / 3600, 1)
    except: pass

    # 5. Global Accuracy
    accuracy_pct = 0.0
    try:
        res = supabase.table("quiz_sessions").select("score, question_ids").eq("uid", user_id).eq("status", "submitted").execute()
        total_score = 0
        total_q = 0
        for row in res.data or []:
             total_score += row.get("score", 0) or 0
             q_ids = row.get("question_ids", [])
             total_q += len(q_ids) if isinstance(q_ids, list) else 0
        
        # Simple accuracy proxy if exact count missing: score/total_q
        if total_q > 0:
            accuracy_pct = round((total_score / total_q) * 100, 1)
            if accuracy_pct < 0: accuracy_pct = 0.0
    except: pass

    return {
        "total_points": total_points,
        "chapters_completed": chapters_completed,
        "quizzes_taken": quizzes_taken,
        "current_streak": 0, # To be implemented or simplified
        "study_hours": study_hours,
        "accuracy_pct": accuracy_pct,
    }
