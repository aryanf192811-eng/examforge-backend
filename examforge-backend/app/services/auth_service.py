"""
ExamForge — Authentication Service
Handles Firebase → Supabase profile sync on login.
"""

import structlog
from supabase import Client

from app.core.firebase import verify_firebase_token

logger = structlog.get_logger(__name__)


async def create_or_sync_session(id_token: str, supabase: Client) -> dict:
    """Called once after Firebase login. Creates or syncs the Supabase profile.

    Process:
    1. verify_firebase_token(id_token) → get uid, email, name, picture
    2. Check if profile exists in profiles table
    3. If not exists: INSERT new profile (role defaults to 'free')
    4. If exists: UPDATE name and avatar_url to latest Firebase values

    Returns:
        dict with profile_id, role, name, email, is_new_user
    """
    # Step 1: Verify the Firebase token
    firebase_user = verify_firebase_token(id_token)
    uid = firebase_user["uid"]
    email = firebase_user["email"]
    name = firebase_user["name"] or email.split("@")[0]
    picture = firebase_user["picture"]

    # Step 2: Check if profile exists
    result = (
        supabase.table("profiles")
        .select("uid, role, name")
        .eq("uid", uid)
        .execute()
    )

    is_new_user = False

    if not result.data:
        # Step 3: Create new profile
        insert_result = (
            supabase.table("profiles")
            .insert({
                "uid": uid,
                "email": email,
                "name": name,
                "avatar_url": picture,
                "role": "free",
            })
            .execute()
        )
        profile = insert_result.data[0]
        is_new_user = True
        logger.info("new_profile_created", uid=uid, email=email)
    else:
        # Step 4: Update existing profile with latest Firebase data
        profile = result.data[0]
        supabase.table("profiles").update({
            "name": name,
            "avatar_url": picture,
        }).eq("uid", uid).execute()
        logger.info("profile_synced", uid=uid)

    return {
        "profile_id": profile["uid"],
        "role": profile.get("role", "free"),
        "name": profile.get("name", name),
        "email": email,
        "is_new_user": is_new_user,
    }
