"""
ExamForge — Notes Service (v3: Hybrid Static Content)
Reads content structure from manifest.json and joins with Supabase user state.
"""

import json
import urllib.request
import structlog
from supabase import Client
from typing import Optional, List, Dict

from app.core.config import settings
from app.core.errors import ExamForgeError
from app.services.leaderboard_service import add_points, POINTS

logger = structlog.get_logger(__name__)


def _fetch_manifest() -> Optional[Dict]:
    """Fetch the source-of-truth manifest from the configured URL."""
    try:
        # Prevent long hangs if the manifest URL is unresponsive
        with urllib.request.urlopen(settings.MANIFEST_URL, timeout=5.0) as response:
            return json.loads(response.read().decode())
    except Exception as e:
        logger.error("manifest_fetch_failed", url=settings.MANIFEST_URL, error=str(e))
        return None


async def get_subjects_with_progress(current_user: dict, supabase: Client) -> List[Dict]:
    """Get all published subjects from manifest with per-user progress from Supabase."""
    uid = current_user["uid"]
    manifest = _fetch_manifest()
    
    if not manifest:
        logger.warning("serving_empty_subjects_no_manifest")
        return []

    subjects_data = manifest.get("subjects", [])
    result = []

    for subj in subjects_data:
        if not subj.get("is_published", True):
            continue

        subject_slug = subj["slug"]
        chapters = subj.get("chapters", [])
        chapter_slugs = [ch["slug"] for ch in chapters]
        
        # Calculate progress from user_progress table
        completed_count = 0
        try:
            if chapter_slugs:
                progress_res = (
                    supabase.table("user_progress")
                    .select("id")
                    .eq("uid", uid)
                    .eq("status", "done")
                    .in_("chapter_slug", chapter_slugs)
                    .execute()
                )
                completed_count = len(progress_res.data) if progress_res.data else 0
        except Exception as e:
            logger.error("progress_fetch_failed", subject=subject_slug, error=str(e))

        chapter_count = len(chapters)
        progress_pct = round((completed_count / chapter_count * 100)) if chapter_count > 0 else 0

        result.append({
            "id": subj["id"],
            "slug": subject_slug,
            "name": subj["name"],
            "category": subj.get("category", "GATE"),
            "icon": subj.get("icon", "school"),
            "chapter_count": chapter_count,
            "completed_chapters": completed_count,
            "progress_pct": progress_pct,
        })

    return result


async def get_chapters_with_progress(
    subject_slug: str, current_user: dict, supabase: Client
) -> List[Dict]:
    """Get chapters for a subject from manifest with user progress."""
    uid = current_user["uid"]
    manifest = _fetch_manifest()
    
    if not manifest:
        return []

    # Find the subject in manifest
    subject = next((s for s in manifest.get("subjects", []) if s["slug"] == subject_slug or s["id"] == subject_slug), None)
    if not subject:
        # Check skills too
        subject = next((s for s in manifest.get("skills", []) if s["slug"] == subject_slug or s["id"] == subject_slug), None)
        
    if not subject:
        logger.warning("subject_not_found_in_manifest", slug=subject_slug)
        return []

    chapters = subject.get("chapters", [])
    chapter_slugs = [ch["slug"] for ch in chapters]
    chapter_ids = [ch["id"] for ch in chapters]
    
    # Batch fetch user progress
    user_progress_map = {}
    try:
        if chapter_slugs:
            prog_res = (
                supabase.table("user_progress")
                .select("chapter_slug, status, time_spent_s")
                .eq("uid", uid)
                .or_(f"chapter_slug.in.({','.join(chapter_slugs)}), chapter_slug.in.({','.join(chapter_ids)})")
                .execute()
            )
            for p in prog_res.data or []:
                user_progress_map[p["chapter_slug"]] = p
    except Exception as e:
        logger.error("chapters_progress_failed", subject=subject_slug, error=str(e))

    result = []
    for ch in chapters:
        prog = user_progress_map.get(ch["slug"], {})
        result.append({
            "id": ch["id"],
            "slug": ch["slug"],
            "title": ch["title"],
            "order_index": ch.get("order_index", 0),
            "has_notes": ch.get("has_notes", False),
            "user_status": prog.get("status", "not_started"),
            "time_spent_s": prog.get("time_spent_s", 0),
            "notes_url": f"/content/notes/{ch['notes_file']}" if ch.get("notes_file") else None
        })

    return result


async def update_note_progress(
    chapter_slug: str,
    subject_slug: str,
    status: str,
    time_spent_s: int,
    current_user: dict,
    supabase: Client,
) -> dict:
    """Update reading progress. Pure Supabase user-state update."""
    uid = current_user["uid"]

    try:
        # Check if already done for points
        existing = (
            supabase.table("user_progress")
            .select("status")
            .eq("uid", uid)
            .eq("chapter_slug", chapter_slug)
            .execute()
        )
        was_done = existing.data and existing.data[0].get("status") == "done"

        # UPSERT
        supabase.table("user_progress").upsert({
            "uid": uid,
            "chapter_slug": chapter_slug,
            "subject_slug": subject_slug,
            "status": status,
            "time_spent_s": time_spent_s,
            "last_read_at": "now()"
        }, on_conflict="uid,chapter_slug").execute()

        # Points
        if status == "done" and not was_done:
            await add_points(uid, "chapter_completed", POINTS["chapter_completed"], supabase)
            
        return {"ok": True}
    except Exception as e:
        logger.error("progress_update_failed", error=str(e))
        return {"ok": False, "error": str(e)}
