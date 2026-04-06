"""
ExamForge — Notes Pydantic Models
CDN-direct signed URL flow (v2).
"""

from typing import Optional

from pydantic import BaseModel, Field


# ── Response Models ──────────────────────────────────────────────────────


class NoteUrlResponse(BaseModel):
    """Response for GET /api/notes/url — CDN-direct signed URL.

    CRITICAL: storage_path and bucket name are NEVER included.
    The client fetches HTML directly from the signed URL.
    """
    signed_url: str
    chapter_id: str
    cached: bool = False


class NoteProgressRequest(BaseModel):
    """Request for POST /api/notes/progress."""
    chapter_id: str = Field(..., description="UUID of the chapter")
    status: str = Field(..., pattern="^(not_started|in_progress|done)$")
    time_spent_s: int = Field(0, ge=0, description="Time spent reading in seconds")


class NoteProgressResponse(BaseModel):
    """Response for POST /api/notes/progress."""
    ok: bool = True


# ── Subject / Chapter Models ────────────────────────────────────────────


class SubjectResponse(BaseModel):
    """Single subject in the subjects list."""
    id: str
    slug: str
    name: str
    category: str = "GATE"
    icon: str = ""
    is_published: bool = True
    order_index: int = 0
    chapter_count: int = 0
    completed_chapters: int = 0
    progress_pct: int = 0


class SubjectListResponse(BaseModel):
    """Response for GET /api/subjects."""
    subjects: list[SubjectResponse]


class ChapterResponse(BaseModel):
    """Single chapter in the chapters list."""
    id: str
    subject_id: str
    slug: str
    title: str
    order_index: int = 0
    is_published: bool = True
    has_notes: bool = False
    user_status: str = "not_started"
    time_spent_s: int = 0


class ChapterListResponse(BaseModel):
    """Response for GET /api/chapters/{subject_id}."""
    subject_id: str
    chapters: list[ChapterResponse]
