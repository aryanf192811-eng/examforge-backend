"""
ExamForge — Flashcards Service
Handles SRS (Spaced Repetition System) for flashcards using the SM-2 algorithm.
Reviews are stored in Supabase; content is in SQLite.
"""

from datetime import datetime, timedelta
from ..core.supabase import get_supabase
from ..core.sqlite import query_all

def get_due_flashcards(user_id: str):
    supabase = get_supabase()
    # Fetch due reviews from Supabase
    now = datetime.utcnow().isoformat()
    result = supabase.table("flashcard_reviews")\
        .select("*")\
        .eq("user_id", user_id)\
        .lte("next_review_at", now)\
        .execute()
    return result.data

def update_flashcard_review(user_id: str, flashcard_id: str, rating: int):
    """
    Very basic SM-2 implementation.
    rating: 0-5
    """
    supabase = get_supabase()
    
    # Get existing review or default
    res = supabase.table("flashcard_reviews")\
        .select("*")\
        .eq("user_id", user_id)\
        .eq("flashcard_id", flashcard_id)\
        .execute()
    
    rev = res.data[0] if res.data else {
        "user_id": user_id,
        "flashcard_id": flashcard_id,
        "ease_factor": 2.5,
        "interval_days": 1,
        "repetitions": 0
    }
    
    # Simplistic SM-2 update logic
    if rating >= 3:
        if rev["repetitions"] == 0:
            rev["interval_days"] = 1
        elif rev["repetitions"] == 1:
            rev["interval_days"] = 6
        else:
            rev["interval_days"] = round(rev["interval_days"] * rev["ease_factor"])
        rev["repetitions"] += 1
    else:
        rev["repetitions"] = 0
        rev["interval_days"] = 1
    
    rev["ease_factor"] = max(1.3, rev["ease_factor"] + (0.1 - (5 - rating) * (0.08 + (5 - rating) * 0.02)))
    rev["next_review_at"] = (datetime.utcnow() + timedelta(days=rev["interval_days"])).isoformat()
    rev["last_rated"] = rating
    
    supabase.table("flashcard_reviews").upsert(rev, on_conflict="user_id,flashcard_id").execute()
    return rev
