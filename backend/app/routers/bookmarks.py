from fastapi import APIRouter, Depends, Body
from typing import Dict, Any
from app.services import bookmarks_service
from app.core import dependencies

router = APIRouter(prefix="/bookmarks", tags=["bookmarks"])

@router.get("/")
async def get_bookmarks(user: Dict = Depends(dependencies.get_current_user)):
    return bookmarks_service.get_user_bookmarks(user["uid"])

@router.post("/toggle")
async def toggle_bookmark(
    payload: Dict[str, Any] = Body(...),
    user: Dict = Depends(dependencies.get_current_user)
):
    return bookmarks_service.toggle_bookmark(
        user_id=user["uid"],
        chapter_slug=payload["chapter_slug"],
        subject_id=payload["subject_id"]
    )
