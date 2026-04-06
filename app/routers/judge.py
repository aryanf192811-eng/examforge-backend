"""
ExamForge — Judge Router (/api/judge)
Code execution via Piston API (Pro users only).
"""

from fastapi import APIRouter, Depends, Request


from app.core.dependencies import require_pro
from app.core.config import settings
from app.core.limiter import limiter
from app.models.judge import JudgeSubmitRequest, JudgeSubmitResponse
from app.services import judge_service

router = APIRouter()


@router.post("/submit", response_model=JudgeSubmitResponse)
@limiter.limit(f"{settings.PISTON_MAX_RUNS_PER_USER_PER_HOUR}/hour")
async def submit_code(
    request: JudgeSubmitRequest,
    req: Request,
    current_user: dict = Depends(require_pro),
):
    """[AUTH][PRO] Submit code for execution via Piston.

    Process:
    1. Validate language
    2. Rate limit check (via slowapi)
    3. Submit to Piston API (free, no API key)
    4. Return result

    CRITICAL: Code execution calls ONLY happen on the backend.
    The frontend NEVER calls Piston directly.
    """
    result = await judge_service.submit_code(
        current_user=current_user,
        language=request.language,
        source_code=request.source_code,
        stdin=request.stdin,
    )
    return JudgeSubmitResponse(**result)
