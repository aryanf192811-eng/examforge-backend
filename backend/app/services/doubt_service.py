import logging
from ..core.supabase import get_supabase
# Mock or simplified Gemini integration
# In a real app, you would use google-generativeai package

logger = logging.getLogger(__name__)

def save_doubt(user_id: str, chapter_slug: str, subject_id: str, question: str, answer: str, selected_text: str = ""):
    supabase = get_supabase()
    data = {
        "user_id": user_id,
        "chapter_slug": chapter_slug,
        "subject_id": subject_id,
        "question": question,
        "answer": answer,
        "selected_text": selected_text
    }
    result = supabase.table("doubt_history").insert(data).execute()
    return result.data[0] if result.data else None

def get_user_doubts(user_id: str):
    supabase = get_supabase()
    result = supabase.table("doubt_history").select("*").eq("user_id", user_id).order("created_at", desc=True).execute()
    return result.data
