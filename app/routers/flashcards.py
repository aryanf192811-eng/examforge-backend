"""
ExamForge — Flashcards Router (/api/flashcards)
SM-2 spaced repetition review system.
"""

from typing import Optional

from fastapi import APIRouter, Depends, Query
from supabase import Client

from app.core.dependencies import get_current_user
from app.core.supabase import get_supabase
from app.models.practice import (
    FlashcardDueResponse,
    FlashcardReviewRequest,
    FlashcardReviewResponse,
)
from app.services import flashcard_service

router = APIRouter()


@router.get("/due", response_model=FlashcardDueResponse)
async def get_due_flashcards(
    subject_id: Optional[str] = Query(None, description="Filter by subject UUID"),
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Get flashcards due for review today (SM-2 algorithm).

    Returns flashcards where next_review <= today, optionally filtered by subject.
    """
    result = await flashcard_service.get_due_flashcards(
        current_user=current_user,
        subject_id=subject_id,
        supabase=supabase,
    )
    return FlashcardDueResponse(**result)


@router.post("/review", response_model=FlashcardReviewResponse)
async def review_flashcard(
    request: FlashcardReviewRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Submit a flashcard review response. SM-2 runs server-side only.

    Quality scale (0-5):
    - 0-2: Complete blackout / incorrect → reset interval
    - 3: Correct with serious difficulty
    - 4: Correct with hesitation
    - 5: Perfect response

    CRITICAL: The SM-2 algorithm runs server-side only.
    Never trust client-submitted ease_factor values.
    """
    result = await flashcard_service.review_flashcard(
        current_user=current_user,
        flashcard_id=request.flashcard_id,
        quality=request.quality,
        supabase=supabase,
    )
    return FlashcardReviewResponse(**result)
