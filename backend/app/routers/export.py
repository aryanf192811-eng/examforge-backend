"""
ExamForge — Export Router (/api/export)
User data export (GDPR-friendly).
"""

import json
from datetime import datetime

from fastapi import APIRouter, Depends
from fastapi.responses import Response
from supabase import Client

from app.core.dependencies import get_current_user
from app.core.supabase import get_supabase
from app.services import export_service

router = APIRouter()


@router.get("/data")
async def export_data(
    current_user: dict = Depends(get_current_user),
    supabase: Client = Depends(get_supabase),
):
    """[AUTH] Generate and return a JSON export of all user data.

    Returns a downloadable JSON file with Content-Disposition header.
    """
    export = await export_service.export_user_data(
        current_user=current_user,
        supabase=supabase,
    )

    # Generate filename with date
    date_str = datetime.utcnow().strftime("%Y-%m-%d")
    filename = f"examforge-export-{date_str}.json"

    # Return as downloadable JSON file
    content = json.dumps(export, indent=2, default=str)
    return Response(
        content=content,
        media_type="application/json",
        headers={
            "Content-Disposition": f'attachment; filename="{filename}"',
        },
    )
