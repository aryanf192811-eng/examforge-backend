"""
ExamForge — Doubt (Cite & Ask) Pydantic Models
"""

from typing import Optional

from pydantic import BaseModel, Field


class DoubtCreateRequest(BaseModel):
    """Request for POST /api/doubts — create a new doubt."""
    chapter_id: str = Field(..., description="UUID of the chapter")
    selected_text: str = Field(
        ..., min_length=1, max_length=2000,
        description="Text the user selected from notes",
    )
    question: str = Field(
        ..., min_length=1, max_length=1000,
        description="The user's question about the selected text",
    )


class DoubtResponse(BaseModel):
    """Response for a single doubt."""
    id: str
    chapter_id: str
    chapter_title: Optional[str] = None
    subject_name: Optional[str] = None
    selected_text: str
    question: str
    answer: str
    created_at: str


class DoubtCreateResponse(BaseModel):
    """Response for POST /api/doubts."""
    id: str
    answer: str
    created_at: str


class DoubtListResponse(BaseModel):
    """Response for GET /api/doubts."""
    doubts: list[DoubtResponse]
