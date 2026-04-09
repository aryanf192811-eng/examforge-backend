"""
ExamForge — Progress Router
Endpoints for fetching and updating user progress.
"""

from fastapi import APIRouter, HTTPException, Depends, Body
from typing import Optional, List, Dict, Any
from ..services import progress_service
from ..core import dependencies

router = APIRouter(prefix="/progress", tags=["progress"])

@router.get("/")
async def get_progress(
    subject_id: Optional[str] = None,
    user: Dict = Depends(dependencies.get_current_user)
):
    return progress_service.get_user_progress(user["uid"], subject_id)

@router.post("/update")
async def update_user_progress(
    payload: Dict[str, Any] = Body(...),
    user: Dict = Depends(dependencies.get_current_user)
):
    try:
        result = progress_service.update_progress(
            user_id=user["uid"],
            chapter_slug=payload["chapter_slug"],
            subject_id=payload["subject_id"],
            progress_pct=payload.get("progress_pct", 0),
            time_spent=payload.get("time_spent_s", 0),
            completed=payload.get("completed", False)
        )
        return result
    except KeyError as e:
        raise HTTPException(status_code=400, detail=f"Missing field: {str(e)}")
