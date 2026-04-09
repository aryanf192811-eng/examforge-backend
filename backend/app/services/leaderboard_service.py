from supabase import Client
from ..core.supabase import get_supabase

POINTS = {
    "chapter_completed": 50,
    "quiz_completed": 100,
    "daily_streak": 20,
}

async def add_points(uid: str, action: str, amount: int, supabase: Client):
    """Add points to a user's total and log the activity."""
    try:
        # Fetch current score
        curr = (
            supabase.table("profiles")
            .select("total_points")
            .eq("uid", uid)
            .single()
            .execute()
        )
        current_points = curr.data.get("total_points", 0) if curr.data else 0

        # Update points
        supabase.table("profiles").update({
            "total_points": current_points + amount
        }).eq("uid", uid).execute()

        return True
    except Exception:
        return False
