from fastapi import APIRouter, Depends, Body
from typing import Dict, Any, List
from ..services import flashcards_service, content_service
from ..core import dependencies

router = APIRouter(prefix="/flashcards", tags=["flashcards"])

@router.get("/due")
async def get_due(user: Dict = Depends(dependencies.get_current_user)):
    return flashcards_service.get_due_flashcards(user["uid"])

@router.post("/review")
async def review_card(
    payload: Dict[str, Any] = Body(...),
    user: Dict = Depends(dependencies.get_current_user)
):
    return flashcards_service.update_flashcard_review(
        user_id=user["uid"],
        flashcard_id=payload["flashcard_id"],
        rating=payload["rating"]
    )

@router.get("/chapter/{chapter_slug}")
async def get_by_chapter(chapter_slug: str):
    chapter = content_service.get_chapter_by_slug(chapter_slug)
    if not chapter:
        return []
    return content_service.get_flashcards_by_chapter(chapter["id"])
