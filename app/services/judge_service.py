"""
ExamForge — Piston Code Execution Service
Handles code submission and rate limiting via Redis.
Piston API: https://emkc.org/api/v2/piston/execute (free, no API key required)
"""

from datetime import datetime

import httpx
import structlog

from app.core.config import settings
from app.core.errors import ExamForgeError
from app.models.judge import SUPPORTED_LANGUAGES

logger = structlog.get_logger(__name__)

PISTON_URL = "https://emkc.org/api/v2/piston/execute"


async def submit_code(
    current_user: dict,
    language: str,
    source_code: str,
    stdin: str,
) -> dict:
    """Submit code for execution via Piston API.

    Process:
    1. Validate language and resolve alias
    3. Submit to Piston API (synchronous — returns result immediately)
    4. Parse and return result
    """
    user_id = current_user["profile_id"]

    # ── Step 1: Resolve language alias ────────────────────────────────
    lang_key = language.lower().strip()
    piston_language = SUPPORTED_LANGUAGES.get(lang_key)

    if not piston_language:
        raise ExamForgeError(
            400,
            f"Unsupported language: '{language}'. "
            f"Supported: {', '.join(sorted(set(SUPPORTED_LANGUAGES.values())))}",
        )

    # ── Step 3: Submit to Piston ─────────────────────────────────────
    payload = {
        "language": piston_language,
        "version": "*",
        "files": [
            {
                "name": f"main",
                "content": source_code,
            }
        ],
        "stdin": stdin or "",
        "args": [],
    }

    async with httpx.AsyncClient(timeout=30) as client:
        try:
            response = await client.post(PISTON_URL, json=payload)
        except httpx.RequestError as e:
            logger.error("piston_request_failed", error=str(e))
            raise ExamForgeError(502, "Code execution service unavailable")

        if response.status_code != 200:
            logger.error(
                "piston_submit_failed",
                status=response.status_code,
                body=response.text[:500],
            )
            raise ExamForgeError(502, "Code execution service unavailable")

        result = response.json()

    # ── Step 4: Parse Piston response ────────────────────────────────
    # Piston returns: { "run": { "stdout", "stderr", "code", "output" },
    #                   "compile": { "stdout", "stderr", "code", "output" } (if compiled) }
    run_data = result.get("run", {})
    compile_data = result.get("compile", {})

    exit_code = run_data.get("code", None)

    # Determine status from exit code and outputs
    if compile_data and compile_data.get("code", 0) != 0:
        status = "Compilation Error"
    elif exit_code == 0:
        status = "Accepted"
    elif exit_code is not None:
        status = "Runtime Error"
    else:
        status = "Unknown"

    logger.info(
        "piston_result",
        user_id=user_id,
        language=piston_language,
        status=status,
        exit_code=exit_code,
    )

    return {
        "status": status,
        "stdout": run_data.get("stdout") or None,
        "stderr": run_data.get("stderr") or None,
        "compile_output": (compile_data.get("output") or compile_data.get("stderr")) or None,
        "exit_code": exit_code,
        "runs_remaining": 0,
    }
