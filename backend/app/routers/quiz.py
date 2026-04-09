"""
ExamForge — Quiz Router
Endpoints for fetching questions, starting sessions, and submitting results.
"""

from fastapi import APIRouter, HTTPException, Depends
from typing import Optional, List, Dict, Any
from ..services import quiz_service
from ..core import dependencies

router = APIRouter(prefix="/quiz", tags=["quiz"])

@router.get("/questions")
async def get_questions(
    subject_id: str,
    chapter_id: Optional[str] = None,
    mode: str = "practice",
    limit: int = 10
):
    questions = quiz_service.get_quiz_questions(subject_id, chapter_id, mode, limit)
    return questions

@router.post("/sessions")
async def start_session(
    data: Dict[str, Any],
    user: Dict = Depends(dependencies.get_current_user)
):
    session = quiz_service.create_quiz_session(
        user_id=user["uid"],
        subject_id=data["subject_id"],
        chapter_id=data.get("chapter_id"),
        mode=data.get("mode", "practice"),
        total_questions=data.get("total_questions", 10)
    )
    return session

@router.post("/sessions/{session_id}/submit")
async def submit_session(
    session_id: str,
    data: Dict[str, Any],
    user: Dict = Depends(dependencies.get_current_user)
):
    # data contains score, correct_count, time_taken, and answers array
    quiz_service.complete_quiz_session(
        session_id=session_id,
        score=data["score"],
        correct_count=data["correct_count"],
        time_taken=data["time_taken_s"]
    )
    
    # Save individual answers
    for ans in data.get("answers", []):
        quiz_service.submit_quiz_answer(
            session_id=session_id,
            question_id=ans["question_id"],
            selected_option=ans["selected_option"],
            is_correct=ans["is_correct"],
            time_taken=ans.get("time_taken_s", 0)
        )
    
    return {"status": "success"}
