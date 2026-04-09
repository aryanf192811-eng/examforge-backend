"""
ExamForge — Supabase Client Initialization
Service-role client for backend-only access (bypasses RLS).
"""

import structlog
from supabase import create_client, Client

from app.core.config import settings

logger = structlog.get_logger(__name__)

_supabase_client: Client | None = None


def get_supabase() -> Client:
    """Get or create the Supabase service-role client.

    Uses service role key — bypasses RLS.
    This client must ONLY be used server-side.
    """
    global _supabase_client
    if _supabase_client is None:
        _supabase_client = create_client(
            settings.SUPABASE_URL,
            settings.SUPABASE_SERVICE_KEY,
        )
        logger.info("supabase_client_initialized")
    return _supabase_client
