"""
ExamForge — Bookmarks Service
User bookmarks for chapters.
"""
from ..core.supabase import get_supabase

def get_user_bookmarks(user_id: str):
    supabase = get_supabase()
    result = supabase.table("bookmarks").select("*").eq("user_id", user_id).execute()
    return result.data

def toggle_bookmark(user_id: str, chapter_slug: str, subject_id: str):
    supabase = get_supabase()
    # Check if exists
    existing = supabase.table("bookmarks").select("id").eq("user_id", user_id).eq("chapter_slug", chapter_slug).execute()
    if existing.data:
        supabase.table("bookmarks").delete().eq("id", existing.data[0]["id"]).execute()
        return {"bookmarked": False}
    else:
        data = {"user_id": user_id, "chapter_slug": chapter_slug, "subject_id": subject_id}
        supabase.table("bookmarks").insert(data).execute()
        return {"bookmarked": True}
