"""
ExamForge — Leaderboard Pydantic Models
"""

from typing import Optional

from pydantic import BaseModel, Field


class LeaderboardEntry(BaseModel):
    """A single entry on the leaderboard."""
    rank: int
    user_id: str
    name: str
    avatar_url: Optional[str] = None
    college: Optional[str] = None
    total_points: int = 0
    weekly_points: int = 0
    is_current_user: bool = False


class LeaderboardResponse(BaseModel):
    """Response for GET /api/leaderboard."""
    scope: str  # weekly | all_time | college
    entries: list[LeaderboardEntry]
    total_entries: int = 0
    current_user_rank: Optional[int] = None
    page: int = 1
    limit: int = 50
