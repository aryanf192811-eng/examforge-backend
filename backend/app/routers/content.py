"""
ExamForge — Content Router
Endpoints for subjects and chapters.
"""

from fastapi import APIRouter, HTTPException
from ..services import content_service
from typing import List

router = APIRouter(prefix="/content", tags=["content"])

@router.get("/subjects")
async def list_subjects():
    subjects = content_service.get_all_subjects()
    return subjects

@router.get("/subjects/{subject_slug}/chapters")
async def list_chapters(subject_slug: str):
    subject = content_service.get_subject_by_slug(subject_slug)
    if not subject:
        raise HTTPException(status_code=404, detail="Subject not found")
    
    chapters = content_service.get_chapters_by_subject(subject["id"])
    return chapters

@router.get("/chapters/{chapter_slug}")
async def get_chapter(chapter_slug: str):
    chapter = content_service.get_chapter_by_slug(chapter_slug)
    if not chapter:
        raise HTTPException(status_code=404, detail="Chapter not found")
    return chapter
