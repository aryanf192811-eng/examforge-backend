"""
ExamForge — Doubts Router (/api/doubts)
Cite & Ask feature with AI-powered answers.
"""

from typing import Optional

from fastapi import APIRouter, Depends, Query
from supabase import Client

from app.core.dependencies import get_current_user
from app.core.supabase import get_supabase
from app.models.doubt import (
    DoubtCreateRequest,
    DoubtCreateResponse,
    DoubtListResponse,
)
from app.services import doubt_service

router = APIRouter()


@router.post("", response_model=DoubtCreateResponse)
async def create_doubt(
    request: DoubtCreateRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Create a doubt and generate an AI answer.

    Select text from notes, ask a question, receive an AI-generated
    answer from Claude (server-side only).
    """
    result = await doubt_service.create_doubt(
        current_user=current_user,
        chapter_id=request.chapter_id,
        selected_text=request.selected_text,
        question=request.question,
        supabase=supabase,
    )
    return DoubtCreateResponse(**result)


@router.get("", response_model=DoubtListResponse)
async def list_doubts(
    chapter_id: Optional[str] = Query(None, description="Filter by chapter UUID"),
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Get all doubts for the current user.

    Optionally filtered by chapter_id. Includes AI-generated answers.
    """
    doubts = await doubt_service.get_doubts(
        current_user=current_user,
        chapter_id=chapter_id,
        supabase=supabase,
    )
    return DoubtListResponse(doubts=doubts)
