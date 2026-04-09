"""
ExamForge — Bookmarks Router (/api/bookmarks)
CRUD operations for note section bookmarks.
"""

from typing import Optional

from fastapi import APIRouter, Depends, Query
from supabase import Client

from app.core.dependencies import get_current_user
from app.core.supabase import get_supabase
from app.models.bookmark import (
    BookmarkCreateRequest,
    BookmarkCreateResponse,
    BookmarkDeleteResponse,
    BookmarkListResponse,
)
from app.services import bookmark_service

router = APIRouter()


@router.get("", response_model=BookmarkListResponse)
async def list_bookmarks(
    chapter_id: Optional[str] = Query(None, description="Filter by chapter UUID"),
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Get all bookmarks for the current user.

    Optionally filtered by chapter_id. Includes chapter and subject context.
    """
    bookmarks = await bookmark_service.get_bookmarks(
        current_user=current_user,
        chapter_id=chapter_id,
        supabase=supabase,
    )
    return BookmarkListResponse(bookmarks=bookmarks)


@router.post("", response_model=BookmarkCreateResponse)
async def create_bookmark(
    request: BookmarkCreateRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Create a bookmark. UPSERT on (user_id, chapter_id, section_id)."""
    result = await bookmark_service.create_bookmark(
        current_user=current_user,
        chapter_id=request.chapter_id,
        section_id=request.section_id,
        section_title=request.section_title,
        supabase=supabase,
    )
    return BookmarkCreateResponse(**result)


@router.delete("/{bookmark_id}", response_model=BookmarkDeleteResponse)
async def delete_bookmark(
    bookmark_id: str,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Delete a bookmark. Verifies ownership before deletion."""
    result = await bookmark_service.delete_bookmark(
        current_user=current_user,
        bookmark_id=bookmark_id,
        supabase=supabase,
    )
    return BookmarkDeleteResponse(**result)
