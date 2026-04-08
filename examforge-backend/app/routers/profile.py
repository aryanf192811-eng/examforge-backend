"""
ExamForge — Profile Router (/api/profile)
User profile CRUD and avatar management.
"""

import structlog
from fastapi import APIRouter, Depends, UploadFile, File, HTTPException
from supabase import Client

from app.core.dependencies import get_current_user
from app.core.supabase import get_supabase
from app.models.user import (
    ProfileResponse,
    ProfileUpdateRequest,
    AvatarUploadResponse,
    SimpleResponse,
)
from app.services import progress_service

router = APIRouter()
logger = structlog.get_logger(__name__)

# ── Allowed avatar formats and size limit ────────────────────────────
ALLOWED_AVATAR_TYPES = {"image/jpeg", "image/png", "image/webp"}
MAX_AVATAR_SIZE = 2 * 1024 * 1024  # 2 MB


@router.get("/me", response_model=ProfileResponse)
async def get_profile(
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Get full profile with computed stats."""
    uid = current_user["uid"]

    # Fetch profile (standardized on uid)
    try:
        result = (
            supabase.table("profiles")
            .select("*")
            .eq("uid", uid)
            .single()
            .execute()
        )
    except Exception as e:
        logger.error("profile_fetch_failed", error=str(e), uid=uid)
        raise HTTPException(status_code=500, detail="Failed to fetch profile")

    if not result.data:
        raise HTTPException(status_code=404, detail="Profile not found")

    profile = result.data

    # Compute stats using progress_service
    stats = await progress_service.get_user_stats(
        current_user=current_user,
        supabase=supabase,
    )

    return ProfileResponse(
        id=profile["uid"],  # Mapping uid to id for legacy frontend compat
        firebase_uid=profile["uid"], # Usually identical in standard deployments
        email=profile.get("email", ""),
        name=profile.get("name", "Student"),
        avatar_url=profile.get("avatar_url"),
        bio=profile.get("bio"),
        role=profile.get("role", "free"),
        college=profile.get("college"),
        gate_year=profile.get("gate_year"),
        target_score=profile.get("target_score"),
        created_at=profile.get("created_at"),
        total_points=stats.get("total_points", 0),
        chapters_completed=stats.get("chapters_completed", 0),
        quizzes_taken=stats.get("quizzes_taken", 0),
        current_streak=stats.get("current_streak", 0),
        study_hours=stats.get("study_hours", 0.0),
        accuracy_pct=stats.get("accuracy_pct", 0.0),
    )


@router.patch("/me", response_model=ProfileResponse)
async def update_profile(
    request: ProfileUpdateRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Update profile fields."""
    uid = current_user["uid"]

    # Build update dict from non-None fields
    update_data = request.model_dump(exclude_none=True)
    if not update_data:
        raise HTTPException(status_code=400, detail="No fields to update")

    supabase.table("profiles").update(update_data).eq("uid", uid).execute()

    # Return updated profile
    return await get_profile(current_user=current_user, supabase=supabase)


@router.post("/avatar", response_model=AvatarUploadResponse)
async def upload_avatar(
    file: UploadFile = File(...),
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Upload avatar image. Max 2MB, only jpg/png/webp.

    Process:
    1. Validate file type and size
    2. Upload to Supabase Storage (avatars bucket)
    3. Get public URL
    4. Update profile avatar_url
    """
    uid = current_user["uid"]

    # Validate content type
    if file.content_type not in ALLOWED_AVATAR_TYPES:
        raise HTTPException(
            status_code=400,
            detail=f"Invalid file type. Allowed: {', '.join(ALLOWED_AVATAR_TYPES)}",
        )

    # Read and validate size
    content = await file.read()
    if len(content) > MAX_AVATAR_SIZE:
        raise HTTPException(
            status_code=400,
            detail=f"File too large. Max size: {MAX_AVATAR_SIZE // (1024 * 1024)} MB",
        )

    # Determine file extension
    ext_map = {"image/jpeg": "jpg", "image/png": "png", "image/webp": "webp"}
    ext = ext_map.get(file.content_type, "jpg")
    storage_path = f"avatars/{uid}.{ext}"

    # Upload to Supabase Storage
    try:
        supabase.storage.from_("avatars").upload(
            storage_path,
            content,
            file_options={"content-type": file.content_type, "upsert": "true"},
        )
    except Exception:
        raise HTTPException(status_code=500, detail="Failed to upload avatar")

    # Get public URL
    public_url = supabase.storage.from_("avatars").get_public_url(storage_path)

    # Update profile
    supabase.table("profiles").update({"avatar_url": public_url}).eq("uid", uid).execute()

    return AvatarUploadResponse(avatar_url=public_url)


@router.delete("/avatar", response_model=SimpleResponse)
async def delete_avatar(
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Remove avatar."""
    uid = current_user["uid"]

    # Clear avatar URL in profile
    supabase.table("profiles").update({"avatar_url": None}).eq("uid", uid).execute()

    # Try to remove files from storage (best-effort)
    for ext in ["jpg", "png", "webp"]:
        try:
            supabase.storage.from_("avatars").remove([f"avatars/{uid}.{ext}"])
        except Exception:
            pass  # Best-effort cleanup

    return SimpleResponse(ok=True)
