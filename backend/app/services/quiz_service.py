"""
ExamForge — Quiz Service
Manages quiz logic, question retrieval from SQLite, and session tracking in Supabase.
"""

import logging
from datetime import datetime
from typing import List, Dict, Any, Optional
from ..core.sqlite import query_all, query_one
from ..core.supabase import get_supabase

logger = logging.getLogger(__name__)

def get_quiz_questions(subject_id: str, chapter_id: Optional[str] = None, mode: str = "practice", limit: int = 10):
    """
    Fetches questions from SQLite based on subject/chapter and mode.
    """
    query = "SELECT * FROM questions WHERE subject_id = ?"
    params = [subject_id]
    
    if chapter_id:
        query += " AND chapter_id = ?"
        params.append(chapter_id)
        
    if mode == "pyq":
        query += " AND is_pyq = 1"
    
    query += " ORDER BY RANDOM() LIMIT ?"
    params.append(limit)
    
    questions = query_all(query, tuple(params))
    return questions

def create_quiz_session(user_id: str, subject_id: str, chapter_id: Optional[str], mode: str, total_questions: int):
    supabase = get_supabase()
    data = {
        "user_id": user_id,
        "subject_id": subject_id,
        "chapter_id": chapter_id,
        "mode": mode,
        "total_questions": total_questions,
        "started_at": datetime.utcnow().isoformat()
    }
    result = supabase.table("quiz_sessions").insert(data).execute()
    return result.data[0] if result.data else None

def submit_quiz_answer(session_id: str, question_id: str, selected_option: str, is_correct: bool, time_taken: int):
    supabase = get_supabase()
    data = {
        "session_id": session_id,
        "question_id": question_id,
        "selected_option": selected_option,
        "is_correct": is_correct,
        "time_taken_s": time_taken
    }
    supabase.table("quiz_session_answers").insert(data).execute()

def complete_quiz_session(session_id: str, score: int, correct_count: int, time_taken: int):
    supabase = get_supabase()
    data = {
        "score": score,
        "correct_count": correct_count,
        "time_taken_s": time_taken,
        "completed_at": datetime.utcnow().isoformat()
    }
    supabase.table("quiz_sessions").update(data).eq("id", session_id).execute()
    
    # Trigger leaderboard update via RPC or direct update if needed
    # (The Supabase SQL logic handles some of this via triggers on profiles, but let's be explicit if needed)
    session = supabase.table("quiz_sessions").select("user_id").eq("id", session_id).single().execute()
    if session.data:
        user_id = session.data["user_id"]
        # RPC call for incrementing points if we defined it
        supabase.rpc("increment_leaderboard_points", {
            "p_user_id": user_id,
            "p_points": score
        }).execute()
