"""
ExamForge — Notes Router (/api/notes)
CDN-direct signed URL delivery (v2) and progress tracking.
"""

from fastapi import APIRouter, Depends, Query
from supabase import Client

from app.core.dependencies import get_current_user
from app.core.supabase import get_supabase
from app.models.notes import NoteUrlResponse, NoteProgressRequest, NoteProgressResponse
from app.services import notes_service

router = APIRouter()


@router.get("/url", response_model=NoteUrlResponse)
async def get_note_url(
    chapter_id: str = Query(..., description="UUID of the chapter"),
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Get a signed URL for CDN-direct note access.

    The server authenticates and authorizes, then returns a short-lived
    signed URL. The client fetches HTML directly from the CDN.
    Server NEVER fetches the HTML content itself.
    """
    result = await notes_service.get_note_signed_url(
        chapter_id=chapter_id,
        current_user=current_user,
        supabase=supabase,
    )
    return NoteUrlResponse(**result)


@router.post("/progress", response_model=NoteProgressResponse)
async def update_progress(
    request: NoteProgressRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Update reading progress for a chapter.

    UPSERT into user_progress. Awards leaderboard points on completion.
    """
    result = await notes_service.update_note_progress(
        chapter_id=request.chapter_id,
        status=request.status,
        time_spent_s=request.time_spent_s,
        current_user=current_user,
        supabase=supabase,
    )
    return NoteProgressResponse(**result)
