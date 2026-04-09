from fastapi import APIRouter, Depends, Body
from typing import Dict, Any, List
from ..services import doubt_service
from ..core import dependencies

router = APIRouter(prefix="/doubts", tags=["doubts"])

@router.get("/")
async def get_doubts(user: Dict = Depends(dependencies.get_current_user)):
    return doubt_service.get_user_doubts(user["uid"])

@router.post("/ask")
async def ask_doubt(
    payload: Dict[str, Any] = Body(...),
    user: Dict = Depends(dependencies.get_current_user)
):
    # This would normally call Gemini
    # For now, we simulate an answer or call the service to save a placeholder
    answer = f"This is an AI generated explanation for: {payload['question'][:50]}..."
    
    result = doubt_service.save_doubt(
        user_id=user["uid"],
        chapter_slug=payload["chapter_slug"],
        subject_id=payload["subject_id"],
        question=payload["question"],
        answer=answer,
        selected_text=payload.get("selected_text", "")
    )
    return {"answer": answer, "history_item": result}
