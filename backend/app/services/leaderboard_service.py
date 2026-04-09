from ..core.supabase import get_supabase

def get_top_users(limit: int = 50):
    supabase = get_supabase()
    result = supabase.table("leaderboard_scores")\
        .select("user_id, total_points, weekly_points, profiles(name, avatar_url)")\
        .order("total_points", desc=True)\
        .limit(limit)\
        .execute()
    return result.data

def get_user_rank(user_id: str):
    supabase = get_supabase()
    # Simple way to get rank is to count how many users have more points
    user_score = supabase.table("leaderboard_scores").select("total_points").eq("user_id", user_id).single().execute()
    if not user_score.data:
        return None
    
    count = supabase.table("leaderboard_scores").select("user_id", count="exact").gt("total_points", user_score.data["total_points"]).execute()
    return count.count + 1
