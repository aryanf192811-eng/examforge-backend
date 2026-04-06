"""
ExamForge — Bookmark Pydantic Models
"""

from typing import Optional

from pydantic import BaseModel, Field


class BookmarkCreateRequest(BaseModel):
    """Request for POST /api/bookmarks."""
    chapter_id: str = Field(..., description="UUID of the chapter")
    section_id: str = Field(..., description="HTML section ID from the notes")
    section_title: str = Field("", max_length=500, description="Title of the bookmarked section")


class BookmarkResponse(BaseModel):
    """A single bookmark."""
    id: str
    chapter_id: str
    chapter_title: str = ""
    subject_slug: str = ""
    section_id: str
    section_title: str = ""
    anchor_slug: str = ""
    created_at: str


class BookmarkListResponse(BaseModel):
    """Response for GET /api/bookmarks."""
    bookmarks: list[BookmarkResponse]


class BookmarkCreateResponse(BaseModel):
    """Response for POST /api/bookmarks."""
    id: str
    created: bool = True


class BookmarkDeleteResponse(BaseModel):
    """Response for DELETE /api/bookmarks/{bookmark_id}."""
    deleted: bool = True
