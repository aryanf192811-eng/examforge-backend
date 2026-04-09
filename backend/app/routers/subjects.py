"""
ExamForge — Subjects Router (/api/subjects)
Subject listing with per-user progress.
"""

from fastapi import APIRouter, Depends
from supabase import Client

from app.core.dependencies import get_current_user
from app.core.supabase import get_supabase
from app.models.notes import SubjectListResponse
from app.services import notes_service

router = APIRouter()


@router.get("", response_model=SubjectListResponse)
async def list_subjects(
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Get all published subjects with per-user progress.

    Returns all subjects ordered by order_index.
    Free users see all subjects (UI handles locking).
    """
    subjects = await notes_service.get_subjects_with_progress(
        current_user=current_user,
        supabase=supabase,
    )
    return SubjectListResponse(subjects=subjects)
