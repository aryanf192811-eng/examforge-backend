"""
ExamForge — Shared Dependencies
Authentication and authorization dependencies for FastAPI routes.
"""

import structlog
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from supabase import Client

from app.core.firebase import verify_firebase_token
from app.core.supabase import get_supabase

logger = structlog.get_logger(__name__)

bearer_scheme = HTTPBearer()


async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(bearer_scheme),
    supabase: Client = Depends(get_supabase),
) -> dict:
    """Verify Firebase token → return { uid, email, role, profile_id, name }.

    This dependency is the ONLY place Firebase tokens are verified.
    Never call verify_firebase_token directly in route handlers.
    """
    try:
        firebase_user = verify_firebase_token(credentials.credentials)
    except Exception:
        logger.warning("auth_token_invalid")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired authentication token",
        )

    # Fetch profile from Supabase
    try:
        # We standardized on 'id' being the primary identifier in profiles
        result = (
            supabase.table("profiles")
            .select("uid, role, name")
            .eq("uid", firebase_user["uid"])
            .single()
            .execute()
        )
    except Exception as e:
        logger.warning("profile_lookup_failed", error=str(e), uid=firebase_user["uid"])
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authentication failed or profile missing. Please log in again.",
        )

    if not result.data:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Profile not found. Please sign up.",
        )

    user_data = result.data
    return {
        "uid": firebase_user["uid"],
        "email": firebase_user["email"],
        "profile_id": user_data["uid"],
        "role": user_data.get("role", "free"),
        "name": user_data.get("name", "Student"),
    }


def require_pro(current_user: dict = Depends(get_current_user)) -> dict:
    """Dependency that enforces Pro or Admin role."""
    if current_user["role"] not in ("pro", "admin"):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Pro subscription required",
        )
    return current_user


def require_admin(current_user: dict = Depends(get_current_user)) -> dict:
    """Dependency that enforces Admin role."""
    if current_user["role"] != "admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Admin access required",
        )
    return current_user
