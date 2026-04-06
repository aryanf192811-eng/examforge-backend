"""
ExamForge — Profile Router (/api/profile)
User profile CRUD and avatar management.
"""

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

# ── Allowed avatar formats and size limit ────────────────────────────
ALLOWED_AVATAR_TYPES = {"image/jpeg", "image/png", "image/webp"}
MAX_AVATAR_SIZE = 2 * 1024 * 1024  # 2 MB


@router.get("/me", response_model=ProfileResponse)
async def get_profile(
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Get full profile with computed stats."""
    user_id = current_user["profile_id"]

    # Fetch profile
    result = (
        supabase.table("profiles")
        .select("*")
        .eq("id", user_id)
        .single()
        .execute()
    )

    if not result.data:
        raise HTTPException(status_code=404, detail="Profile not found")

    profile = result.data

    # Compute stats
    stats = await progress_service.get_user_stats(
        current_user=current_user,
        supabase=supabase,
    )

    return ProfileResponse(
        id=profile["id"],
        firebase_uid=profile.get("firebase_uid", ""),
        email=profile.get("email", ""),
        name=profile.get("name", ""),
        avatar_url=profile.get("avatar_url"),
        role=profile.get("role", "free"),
        college=profile.get("college"),
        gate_year=profile.get("gate_year"),
        target_score=profile.get("target_score"),
        created_at=profile.get("created_at"),
        total_points=stats["total_points"],
        chapters_completed=stats["chapters_completed"],
        quizzes_taken=stats["quizzes_taken"],
        current_streak=stats["current_streak"],
        study_hours=stats["study_hours"],
    )


@router.patch("/me", response_model=ProfileResponse)
async def update_profile(
    request: ProfileUpdateRequest,
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Update profile fields."""
    user_id = current_user["profile_id"]

    # Build update dict from non-None fields
    update_data = request.model_dump(exclude_none=True)
    if not update_data:
        raise HTTPException(status_code=400, detail="No fields to update")

    supabase.table("profiles").update(update_data).eq("id", user_id).execute()

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
    user_id = current_user["profile_id"]

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
    storage_path = f"avatars/{user_id}.{ext}"

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
    supabase.table("profiles").update({"avatar_url": public_url}).eq("id", user_id).execute()

    return AvatarUploadResponse(avatar_url=public_url)


@router.delete("/avatar", response_model=SimpleResponse)
async def delete_avatar(
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Remove avatar."""
    user_id = current_user["profile_id"]

    # Clear avatar URL in profile
    supabase.table("profiles").update({"avatar_url": None}).eq("id", user_id).execute()

    # Try to remove files from storage (best-effort)
    for ext in ["jpg", "png", "webp"]:
        try:
            supabase.storage.from_("avatars").remove([f"avatars/{user_id}.{ext}"])
        except Exception:
            pass  # Best-effort cleanup

    return SimpleResponse(ok=True)
