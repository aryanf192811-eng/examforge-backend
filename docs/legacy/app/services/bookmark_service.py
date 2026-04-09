"""
ExamForge — Bookmark Service (v3: Live Schema Aligned)
CRUD operations for note section bookmarks.
"""

import structlog
from supabase import Client

from app.core.errors import ExamForgeError

logger = structlog.get_logger(__name__)


async def get_bookmarks(
    current_user: dict, chapter_id: str | None, supabase: Client
) -> list[dict]:
    """Get all bookmarks for the current user, optionally filtered by chapter.
    
    Standardized on uid and chapter_slug.
    """
    uid = current_user["uid"]

    query = (
        supabase.table("bookmarks")
        .select("id, chapter_slug, subject_slug, created_at")
        .eq("uid", uid)
        .order("created_at", desc=True)
    )

    if chapter_id:
        # Front-end might pass the slug as 'chapter_id'
        query = query.eq("chapter_slug", chapter_id)

    result = query.execute()

    bookmarks = []
    for row in result.data or []:
        chapter_slug = row.get("chapter_slug", "")
        bookmarks.append({
            "id": row["id"],
            "chapter_id": chapter_slug,
            "chapter_title": chapter_slug.replace("-", " ").title(),
            "subject_slug": row.get("subject_slug", ""),
            "section_id": "main",
            "section_title": "Notes Section",
            "anchor_slug": "main",
            "created_at": row["created_at"],
        })

    return bookmarks


async def create_bookmark(
    current_user: dict, chapter_id: str, section_id: str,
    section_title: str, supabase: Client,
) -> dict:
    """Create a bookmark. UPSERT on (uid, chapter_slug).
    
    Aligned with live schema: bookmarks(uid, chapter_slug, subject_slug).
    """
    uid = current_user["uid"]
    
    # Extract subject_slug from the chapter_id if it's formatted as 'subject/chapter' 
    # OR just expect the caller to have sent slugs.
    # For now, we assume chapter_id is the slug.
    
    result = (
        supabase.table("bookmarks")
        .upsert(
            {
                "uid": uid,
                "chapter_slug": chapter_id,
                "subject_slug": "cs", # Default or infer from context if possible
            },
            on_conflict="uid,chapter_slug",
        )
        .execute()
    )

    bookmark = result.data[0] if result.data else {}
    logger.info("bookmark_created", uid=uid, chapter_slug=chapter_id)

    return {"id": bookmark.get("id", ""), "created": True}


async def delete_bookmark(
    current_user: dict, bookmark_id: str, supabase: Client
) -> dict:
    """Delete a bookmark. Verifies ownership via uid."""
    uid = current_user["uid"]

    # Delete with uid filter for security
    supabase.table("bookmarks").delete().eq("id", bookmark_id).eq("uid", uid).execute()
    logger.info("bookmark_deleted", uid=uid, bookmark_id=bookmark_id)

    return {"deleted": True}
