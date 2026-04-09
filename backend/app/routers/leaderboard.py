from fastapi import APIRouter, Depends
from typing import Dict, Any, List
from ..services import leaderboard_service
from ..core import dependencies

router = APIRouter(prefix="/leaderboard", tags=["leaderboard"])

@router.get("/")
async def get_leaderboard(limit: int = 50):
    return leaderboard_service.get_top_users(limit)

@router.get("/me")
async def get_my_rank(user: Dict = Depends(dependencies.get_current_user)):
    rank = leaderboard_service.get_user_rank(user["uid"])
    return {"rank": rank}
