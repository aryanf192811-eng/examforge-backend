"""
ExamForge — User & Profile Pydantic Models
"""

from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field, EmailStr


# ── Request Models ───────────────────────────────────────────────────────


class SessionRequest(BaseModel):
    """POST /api/auth/session — Firebase token exchange."""
    id_token: str = Field(..., min_length=10, description="Firebase ID token")


class ProfileUpdateRequest(BaseModel):
    """PATCH /api/profile/me — Updatable profile fields."""
    name: Optional[str] = Field(None, max_length=100)
    college: Optional[str] = Field(None, max_length=200)
    gate_year: Optional[int] = Field(None, ge=2024, le=2030)
    target_score: Optional[float] = Field(None, ge=0, le=100)


# ── Response Models ──────────────────────────────────────────────────────


class SessionResponse(BaseModel):
    """Response for POST /api/auth/session."""
    profile_id: str
    role: str
    name: str
    email: str
    is_new_user: bool


class ProfileResponse(BaseModel):
    """Response for GET /api/profile/me."""
    id: str
    firebase_uid: str
    email: str
    name: str
    avatar_url: Optional[str] = None
    role: str = "free"
    college: Optional[str] = None
    gate_year: Optional[int] = None
    target_score: Optional[float] = None
    created_at: Optional[str] = None

    # Computed stats
    total_points: int = 0
    chapters_completed: int = 0
    quizzes_taken: int = 0
    current_streak: int = 0
    study_hours: float = 0.0


class AvatarUploadResponse(BaseModel):
    """Response for POST /api/profile/avatar."""
    avatar_url: str
    ok: bool = True


class SimpleResponse(BaseModel):
    """Generic success response."""
    ok: bool = True
