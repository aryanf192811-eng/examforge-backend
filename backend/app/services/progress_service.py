"""
ExamForge — Progress Service
Tracks user reading progress and chapter completion in Supabase.
"""

import logging
from datetime import datetime
from typing import List, Dict, Any, Optional
from ..core.supabase import get_supabase

logger = logging.getLogger(__name__)

def get_user_progress(user_id: str, subject_id: Optional[str] = None):
    supabase = get_supabase()
    query = supabase.table("user_progress").select("*").eq("user_id", user_id)
    if subject_id:
        query = query.eq("subject_id", subject_id)
    result = query.execute()
    return result.data

def update_progress(
    user_id: str, 
    chapter_slug: str, 
    subject_id: str, 
    progress_pct: int, 
    time_spent: int = 0,
    completed: bool = False
):
    supabase = get_supabase()
    data = {
        "user_id": user_id,
        "chapter_slug": chapter_slug,
        "subject_id": subject_id,
        "progress_pct": progress_pct,
        "time_spent_s": time_spent,
        "completed": completed,
        "last_read_at": datetime.utcnow().isoformat()
    }
    
    # Upsert logic
    result = supabase.table("user_progress").upsert(data, on_conflict="user_id,chapter_slug").execute()
    return result.data[0] if result.data else None
