"""
ExamForge — Quiz Router (/api/quiz)
Quiz sessions for the Hybrid Static architecture.
"""

from typing import Optional
from fastapi import APIRouter, Depends, Query
from supabase import Client

from app.core.dependencies import get_current_user
from app.core.errors import ExamForgeError
from app.core.supabase import get_supabase
from app.models.practice import (
    QuizSessionResponse,
    QuizSaveRequest,
    QuizSaveResponse,
    QuizSubmitRequest,
    QuizSubmitResponse,
    ActiveSessionResponse,
)
from app.services import quiz_service

router = APIRouter()


@router.get("/questions", response_model=QuizSessionResponse)
async def get_questions(
    mode: str = Query("custom", pattern="^(pyq|mock|custom|shadow)$"),
    subject_slugs: Optional[str] = Query(None, description="Comma-separated subject slugs"),
    year: Optional[int] = Query(None, description="GATE year for PYQ mode"),
    difficulty: Optional[str] = Query(None, pattern="^(easy|medium|hard)$"),
    count: int = Query(20, ge=1, le=65),
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Fetch questions and create a new quiz session."""
    parsed_slugs = None
    if subject_slugs:
        parsed_slugs = [s.strip() for s in subject_slugs.split(",") if s.strip()]

    try:
        result = await quiz_service.create_quiz_session(
            current_user=current_user,
            mode=mode,
            subject_slugs=parsed_slugs,
            year=year,
            difficulty=difficulty,
            count=count,
            supabase=supabase,
        )
        return QuizSessionResponse(**result)
    except Exception as e:
        import structlog
        logger = structlog.get_logger(__name__)
        logger.error("quiz_generation_failed", error=str(e))
        raise ExamForgeError(500, f"Failed to generate quiz: {str(e)}")


@router.post("/save", response_model=QuizSaveResponse)
async def save_quiz_state(
    request: QuizSaveRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Sync ephemeral quiz state to PostgreSQL."""
    result = await quiz_service.save_quiz_state(
        current_user=current_user,
        session_id=request.session_id,
        answers=request.answers,
        supabase=supabase,
    )
    return QuizSaveResponse(**result)


@router.post("/submit", response_model=QuizSubmitResponse)
async def submit_quiz(
    request: QuizSubmitRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Submit quiz and return results."""
    result = await quiz_service.submit_quiz(
        current_user=current_user,
        session_id=request.session_id,
        supabase=supabase,
    )
    return QuizSubmitResponse(**result)


@router.get("/active", response_model=ActiveSessionResponse)
async def get_active_session(
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Check for active session."""
    result = await quiz_service.get_active_session(
        current_user=current_user,
        supabase=supabase,
    )
    return ActiveSessionResponse(**result)
