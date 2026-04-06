"""
ExamForge — Auth Router (/api/auth)
Firebase token exchange and session creation.
"""

from fastapi import APIRouter, Depends
from supabase import Client

from app.core.supabase import get_supabase
from app.models.user import SessionRequest, SessionResponse
from app.services import auth_service

router = APIRouter()


@router.post("/session", response_model=SessionResponse)
async def create_session(
    request: SessionRequest,
    supabase: Client = Depends(get_supabase),
):
    """[PUBLIC after Firebase login] Create or sync Supabase profile.

    Called once after Firebase login. Verifies the Firebase ID token
    and creates or updates the user's profile in Supabase.
    """
    result = await auth_service.create_or_sync_session(
        id_token=request.id_token,
        supabase=supabase,
    )
    return SessionResponse(**result)
