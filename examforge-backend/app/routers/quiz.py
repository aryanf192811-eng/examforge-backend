"""
ExamForge — Quiz Router (/api/quiz)
Quiz sessions with Redis-backed hot state (v2).
"""

from typing import Optional

from fastapi import APIRouter, Depends, Query
from supabase import Client

from app.core.dependencies import get_current_user
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
    subject_ids: Optional[str] = Query(None, description="Comma-separated subject UUIDs"),
    year: Optional[int] = Query(None, description="GATE year for PYQ mode"),
    type: Optional[str] = Query(None, pattern="^(MCQ|NAT|MSQ)$"),
    difficulty: Optional[str] = Query(None, pattern="^(easy|medium|hard)$"),
    count: int = Query(20, ge=1, le=65),
    source_session_id: Optional[str] = Query(None, description="Session ID for shadow mode"),
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Fetch questions and create a new quiz session.

    Modes:
    - pyq: Previous Year Questions filtered by params
    - mock: Full 65-question GATE mock test
    - custom: User-defined filters
    - shadow: Retry wrong questions from a previous session

    CRITICAL: The 'correct' field is NEVER returned in this endpoint.
    """
    # Parse comma-separated subject IDs
    parsed_subject_ids = None
    if subject_ids:
        parsed_subject_ids = [s.strip() for s in subject_ids.split(",") if s.strip()]

    try:
        result = await quiz_service.create_quiz_session(
            current_user=current_user,
            mode=mode,
            subject_ids=parsed_subject_ids,
            year=year,
            question_type=type,
            difficulty=difficulty,
            count=count,
            source_session_id=source_session_id,
            supabase=supabase,
        )
    except Exception as e:
        # Fallback to prevent 500 errors
        from datetime import datetime, timedelta
        return QuizSessionResponse(
            session_id=f"err_{mode}_{datetime.utcnow().timestamp()}",
            questions=[],
            question_count=0,
            server_deadline=(datetime.utcnow() + timedelta(hours=1)).isoformat()
        )
    
    return QuizSessionResponse(**result)


@router.post("/save", response_model=QuizSaveResponse)
async def save_quiz_state(
    request: QuizSaveRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Sync ephemeral quiz state to Redis. Called every 30s.

    CRITICAL: Writes to Redis ONLY — NEVER PostgreSQL.
    High-frequency writes must not hit the database.
    """
    result = await quiz_service.save_quiz_state(
        current_user=current_user,
        session_id=request.session_id,
        answers=request.answers,
        flags=request.flags,
        supabase=supabase,
    )
    return QuizSaveResponse(**result)


@router.post("/submit", response_model=QuizSubmitResponse)
async def submit_quiz(
    request: QuizSubmitRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Submit quiz, flush Redis→PostgreSQL, calculate score, return results.

    Process:
    1. Flush Redis state to PostgreSQL (guaranteed flush)
    2. Calculate score with GATE negative marking
    3. Update session status to 'submitted'
    4. Award leaderboard points
    5. Clean up Redis keys
    6. Return full results with per-question breakdown
    """
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
    """[AUTH] Check if user has an active (non-submitted) quiz session.

    Checks Redis first for session keys, falls back to PostgreSQL.
    """
    result = await quiz_service.get_active_session(
        current_user=current_user,
        supabase=supabase,
    )
    return ActiveSessionResponse(**result)
