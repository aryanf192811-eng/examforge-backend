"""
ExamForge — Bookmark Service
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

    Joins with chapters and subjects to provide chapter_title and subject_slug.
    """
    user_id = current_user["profile_id"]

    query = (
        supabase.table("bookmarks")
        .select(
            "id, chapter_id, section_id, section_title, created_at, "
            "chapters!inner(title, slug, subject_id, subjects!inner(slug))"
        )
        .eq("user_id", user_id)
        .order("created_at", desc=True)
    )

    if chapter_id:
        query = query.eq("chapter_id", chapter_id)

    result = query.execute()

    bookmarks = []
    for row in result.data or []:
        chapter_data = row.get("chapters", {})
        subject_data = chapter_data.get("subjects", {})
        bookmarks.append({
            "id": row["id"],
            "chapter_id": row["chapter_id"],
            "chapter_title": chapter_data.get("title", ""),
            "subject_slug": subject_data.get("slug", ""),
            "section_id": row["section_id"],
            "section_title": row.get("section_title", ""),
            "anchor_slug": row["section_id"],  # section_id IS the anchor
            "created_at": row["created_at"],
        })

    return bookmarks


async def create_bookmark(
    current_user: dict, chapter_id: str, section_id: str,
    section_title: str, supabase: Client,
) -> dict:
    """Create a bookmark. UPSERT on (user_id, chapter_id, section_id).

    Returns the bookmark ID and whether it was newly created.
    """
    user_id = current_user["profile_id"]

    # UPSERT — avoids duplicates
    result = (
        supabase.table("bookmarks")
        .upsert(
            {
                "user_id": user_id,
                "chapter_id": chapter_id,
                "section_id": section_id,
                "section_title": section_title,
            },
            on_conflict="user_id,chapter_id,section_id",
        )
        .execute()
    )

    bookmark = result.data[0] if result.data else {}
    logger.info("bookmark_created", user_id=user_id, chapter_id=chapter_id, section_id=section_id)

    return {"id": bookmark.get("id", ""), "created": True}


async def delete_bookmark(
    current_user: dict, bookmark_id: str, supabase: Client
) -> dict:
    """Delete a bookmark. Verifies ownership before deletion.

    CRITICAL: Always verify the bookmark belongs to the requesting user.
    """
    user_id = current_user["profile_id"]

    # Verify ownership
    existing = (
        supabase.table("bookmarks")
        .select("id, user_id")
        .eq("id", bookmark_id)
        .single()
        .execute()
    )

    if not existing.data:
        raise ExamForgeError(404, "Bookmark not found")

    if existing.data["user_id"] != user_id:
        raise ExamForgeError(403, "You can only delete your own bookmarks")

    # Delete
    supabase.table("bookmarks").delete().eq("id", bookmark_id).execute()
    logger.info("bookmark_deleted", user_id=user_id, bookmark_id=bookmark_id)

    return {"deleted": True}
