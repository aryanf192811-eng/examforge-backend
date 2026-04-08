"""
ExamForge — Notes Service (v2: CDN-direct signed URL flow)
Generates signed URLs for direct CDN access. Server never fetches HTML.
"""

import structlog
from supabase import Client

from app.core.config import settings
from app.core.errors import ExamForgeError
from app.services.leaderboard_service import add_points, POINTS

logger = structlog.get_logger(__name__)


async def get_note_signed_url(chapter_id: str, current_user: dict, supabase: Client) -> dict:
    """Generate a short-lived signed URL for CDN-direct note access.

    Process:
    1. Verify chapter access + publish status
    2. Get exact storage path from notes table
    3. Generate signed URL via Supabase Storage
    4. Return signed URL — client fetches from CDN directly

    CRITICAL: storage_path and bucket name are NEVER returned.
    """
    # Step 1: Verify chapter access + publish status
    chapter = (
        supabase.table("chapters")
        .select("id, is_published, subject_id")
        .eq("id", chapter_id)
        .single()
        .execute()
    )
    if not chapter.data or not chapter.data["is_published"]:
        raise ExamForgeError(404, "Chapter notes not available")


    # Step 3: Get exact storage path
    note = (
        supabase.table("notes")
        .select("storage_path")
        .eq("chapter_id", chapter_id)
        .single()
        .execute()
    )
    if not note.data:
        raise ExamForgeError(404, "Notes file not uploaded yet")

    # Step 4: Generate signed URL
    storage_path = note.data["storage_path"]
    logger.debug("generating_signed_url", chapter_id=chapter_id)  # Never log path at INFO+

    signed = (
        supabase.storage
        .from_(settings.SUPABASE_STORAGE_BUCKET)
        .create_signed_url(storage_path, settings.SIGNED_URL_EXPIRY_S)
    )

    signed_url = None
    if isinstance(signed, dict):
        signed_url = signed.get("signedURL") or signed.get("signed_url")
    elif hasattr(signed, "signed_url"):
        signed_url = signed.signed_url

    if not signed_url:
        logger.error("signed_url_generation_failed", chapter_id=chapter_id)
        raise ExamForgeError(500, "Could not generate content access URL")

    logger.info("notes_url_generated", chapter_id=chapter_id)

    # Step 4: Return signed URL to client
    # CRITICAL: The client fetches from CDN directly. The backend NEVER fetches HTML.
    return {"signed_url": signed_url, "chapter_id": chapter_id, "cached": False}


async def update_note_progress(
    chapter_id: str,
    status: str,
    time_spent_s: int,
    current_user: dict,
    supabase: Client,
) -> dict:
    """Update reading progress for a chapter.

    Uses UPSERT to avoid race conditions.
    Awards leaderboard points if status transitions to 'done'.
    """
    user_id = current_user["profile_id"]

    # Check current status before update (for points award)
    existing = (
        supabase.table("user_progress")
        .select("status")
        .eq("user_id", user_id)
        .eq("chapter_id", chapter_id)
        .execute()
    )
    was_done = existing.data and existing.data[0].get("status") == "done"

    # UPSERT progress
    supabase.table("user_progress").upsert(
        {
            "user_id": user_id,
            "chapter_id": chapter_id,
            "status": status,
            "time_spent_s": time_spent_s,
        },
        on_conflict="user_id,chapter_id",
    ).execute()

    # Award points if transitioning to 'done'
    if status == "done" and not was_done:
        await add_points(
            user_id=user_id,
            reason="chapter_completed",
            amount=POINTS["chapter_completed"],
            supabase=supabase,
        )
        logger.info("chapter_completed", user_id=user_id, chapter_id=chapter_id)

    return {"ok": True}


async def get_subjects_with_progress(current_user: dict, supabase: Client) -> list[dict]:
    """Get all published subjects with per-user progress stats."""
    user_id = current_user["profile_id"]

    # Fetch all published subjects ordered by order_index
    subjects_result = (
        supabase.table("subjects")
        .select("id, slug, name, category, icon, is_published, order_index")
        .eq("is_published", True)
        .order("order_index")
        .execute()
    )

    subjects = []
    for subj in subjects_result.data or []:
        try:
            # Count chapters for this subject
            chapters_result = (
                supabase.table("chapters")
                .select("id", count="exact")
                .eq("subject_id", subj["id"])
                .eq("is_published", True)
                .execute()
            )
            chapter_count = chapters_result.count or 0

            # Count completed chapters for this user
            completed_chapters = 0
            if chapter_count > 0:
                # Fetch chapter IDs for this subject
                subject_chapters = (
                    supabase.table("chapters")
                    .select("id")
                    .eq("subject_id", subj["id"])
                    .execute()
                ).data or []
                
                chapter_ids = [ch["id"] for ch in subject_chapters]
                
                if chapter_ids:
                    completed_result = (
                        supabase.table("user_progress")
                        .select("id", count="exact")
                        .eq("user_id", user_id)
                        .eq("status", "done")
                        .in_("chapter_id", chapter_ids)
                        .execute()
                    )
                    completed_chapters = completed_result.count or 0

            progress_pct = (
                round((completed_chapters / chapter_count) * 100)
                if chapter_count > 0 else 0
            )

            subjects.append({
                "id": subj["id"],
                "slug": subj["slug"],
                "name": subj["name"],
                "category": subj.get("category", "GATE"),
                "icon": subj.get("icon", ""),
                "is_published": subj["is_published"],
                "order_index": subj.get("order_index", 0),
                "chapter_count": chapter_count,
                "completed_chapters": completed_chapters,
                "progress_pct": progress_pct,
            })
        except Exception as e:
            logger.error("subject_progress_failed", subject_id=subj.get("id"), error=str(e))
            # Append basic subject info even if progress fails
            subjects.append({
                "id": subj["id"],
                "slug": subj["slug"],
                "name": subj["name"],
                "category": subj.get("category", "GATE"),
                "icon": subj.get("icon", ""),
                "is_published": subj["is_published"],
                "order_index": subj.get("order_index", 0),
                "chapter_count": 0,
                "completed_chapters": 0,
                "progress_pct": 0,
            })

    return subjects


async def get_chapters_with_progress(
    subject_id: str, current_user: dict, supabase: Client
) -> list[dict]:
    """Get chapters for a subject with per-user progress."""
    user_id = current_user["profile_id"]

    # Fetch chapters
    chapters_result = (
        supabase.table("chapters")
        .select("id, subject_id, slug, title, order_index, is_published")
        .eq("subject_id", subject_id)
        .eq("is_published", True)
        .order("order_index")
        .execute()
    )

    chapters = []
    for ch in chapters_result.data or []:
        # Check if notes exist
        notes_result = (
            supabase.table("notes")
            .select("id")
            .eq("chapter_id", ch["id"])
            .execute()
        )
        has_notes = bool(notes_result.data)

        # Get user progress
        progress_result = (
            supabase.table("user_progress")
            .select("status, time_spent_s")
            .eq("user_id", user_id)
            .eq("chapter_id", ch["id"])
            .execute()
        )
        user_status = "not_started"
        time_spent_s = 0
        if progress_result.data:
            user_status = progress_result.data[0].get("status", "not_started")
            time_spent_s = progress_result.data[0].get("time_spent_s", 0)

        chapters.append({
            "id": ch["id"],
            "subject_id": ch["subject_id"],
            "slug": ch["slug"],
            "title": ch["title"],
            "order_index": ch.get("order_index", 0),
            "is_published": ch["is_published"],
            "has_notes": has_notes,
            "user_status": user_status,
            "time_spent_s": time_spent_s,
        })

    return chapters
