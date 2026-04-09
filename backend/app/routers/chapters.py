"""
ExamForge — Chapters Router (/api/chapters)
Chapter listing for a specific subject with per-user progress.
"""

from fastapi import APIRouter, Depends
from supabase import Client
from typing import List

from app.core.dependencies import get_current_user
from app.core.supabase import get_supabase
from app.models.notes import ChapterListResponse
from app.services import notes_service

router = APIRouter()

@router.get("/{subject_slug}", response_model=ChapterListResponse)
async def list_chapters(
    subject_slug: str,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Get all chapters for a subject with per-user progress."""
    chapters = await notes_service.get_chapters_with_progress(
        subject_slug=subject_slug,
        current_user=current_user,
        supabase=supabase,
    )
    return ChapterListResponse(chapters=chapters)
