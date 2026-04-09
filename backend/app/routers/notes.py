"""
ExamForge — Notes Router (/api/notes)
Progress tracking for the Hybrid Static architecture.
"""

from fastapi import APIRouter, Depends
from supabase import Client

from app.core.dependencies import get_current_user
from app.core.supabase import get_supabase
from app.models.notes import NoteProgressRequest, NoteProgressResponse
from app.services import notes_service

router = APIRouter()


@router.post("/progress", response_model=NoteProgressResponse)
async def update_progress(
    request: NoteProgressRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Update reading progress for a chapter.
    
    Awards leaderboard points on 'done' status.
    """
    result = await notes_service.update_note_progress(
        chapter_id=request.chapter_id,
        status=request.status,
        time_spent_s=request.time_spent_s,
        current_user=current_user,
        supabase=supabase,
    )
    return NoteProgressResponse(**result)
