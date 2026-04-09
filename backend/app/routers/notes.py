"""
ExamForge — Notes Router (/api/notes)
Endpoints for note content and progress.
"""

from fastapi import APIRouter, Depends
from supabase import Client

from app.core.dependencies import get_current_user
from app.core.supabase import get_supabase
from app.models.notes import NoteProgressRequest
from app.services import notes_service

router = APIRouter()

@router.post("/progress")
async def update_note_progress(
    payload: NoteProgressRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Update reading progress for a chapter."""
    return await notes_service.update_note_progress(
        chapter_slug=payload.chapter_slug,
        subject_slug=payload.subject_slug,
        status=payload.status,
        time_spent_s=payload.time_spent_s,
        current_user=current_user,
        supabase=supabase,
    )
