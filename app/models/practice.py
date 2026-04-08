"""
ExamForge — Practice (Quiz & Flashcard) Pydantic Models
"""

from datetime import datetime, date
from typing import Optional

from pydantic import BaseModel, Field


# ── Quiz Models ──────────────────────────────────────────────────────────


class QuizOption(BaseModel):
    """A single quiz option."""
    key: str
    text: str


class QuizQuestion(BaseModel):
    """A question returned in a quiz session (correct answer NEVER included)."""
    id: str
    question_text: str
    subject_slug: str
    chapter_slug: str
    type: str = "MCQ" # Root cause fix: ensure type is serialized
    difficulty: str = "medium"
    marks: int = 1
    is_pyq: bool = False
    gate_year: Optional[int] = None
    option_a: Optional[str] = None
    option_b: Optional[str] = None
    option_c: Optional[str] = None
    option_d: Optional[str] = None
    explanation: Optional[str] = None
    tags: Optional[list[str]] = None


class QuizSessionResponse(BaseModel):
    """Response for GET /api/quiz/questions — new quiz session."""
    session_id: str
    questions: list[QuizQuestion]
    server_deadline: Optional[str] = None
    question_count: int = 0


class QuizSaveRequest(BaseModel):
    """Request for POST /api/quiz/save — Redis-backed hot state."""
    session_id: str
    answers: dict[str, str] = Field(default_factory=dict)
    flags: list[str] = Field(default_factory=list)


class QuizSaveResponse(BaseModel):
    """Response for POST /api/quiz/save."""
    ok: bool = True
    saved_at: str


class QuizSubmitRequest(BaseModel):
    """Request for POST /api/quiz/submit."""
    session_id: str


class QuestionResult(BaseModel):
    """Per-question result in the quiz submission response."""
    question_id: str
    user_answer: Optional[str] = None
    correct_answer: str
    is_correct: bool
    marks_awarded: float
    explanation: Optional[str] = None


class SubjectAnalysis(BaseModel):
    """Per-subject score analysis."""
    subject: str
    total_questions: int = 0
    correct: int = 0
    incorrect: int = 0
    unanswered: int = 0
    marks_obtained: float = 0.0
    marks_possible: float = 0.0
    accuracy_pct: float = 0.0


class QuizSubmitResponse(BaseModel):
    """Response for POST /api/quiz/submit — full results."""
    session_id: str
    total_marks: float
    marks_obtained: float
    total_questions: int
    correct: int
    incorrect: int
    unanswered: int
    accuracy_pct: float
    negative_marks: float = 0.0
    time_taken_s: Optional[int] = None
    question_results: list[QuestionResult]
    subject_analysis: list[SubjectAnalysis]


class ActiveSession(BaseModel):
    """Active session info for GET /api/quiz/active."""
    id: str
    type: str = "custom"
    question_count: int
    answered_count: int = 0
    started_at: str
    server_deadline: Optional[str] = None


class ActiveSessionResponse(BaseModel):
    """Response for GET /api/quiz/active."""
    has_active: bool
    session: Optional[ActiveSession] = None


# ── Flashcard Models ─────────────────────────────────────────────────────


class FlashcardResponse(BaseModel):
    """A single flashcard due for review."""
    id: str
    question_id: str
    front: str
    back: str
    subject: str = ""
    chapter: Optional[str] = None
    ease_factor: float = 2.5
    interval: int = 1
    next_review: str
    review_count: int = 0


class FlashcardDueResponse(BaseModel):
    """Response for GET /api/flashcards/due."""
    due_count: int
    flashcards: list[FlashcardResponse]


class FlashcardReviewRequest(BaseModel):
    """Request for POST /api/flashcards/review."""
    flashcard_id: str
    quality: int = Field(..., ge=0, le=5, description="SM-2 quality: 0-5")


class FlashcardReviewResponse(BaseModel):
    """Response for POST /api/flashcards/review."""
    ok: bool = True
    next_review: str
    new_interval: int
    new_ease_factor: float
