"""
ExamForge — Firebase Admin SDK Integration
Handles Firebase App initialization and token verification.
"""

import base64
import json
import os
import tempfile

import structlog
import firebase_admin
from firebase_admin import credentials, auth

from app.core.config import settings

logger = structlog.get_logger(__name__)


def init_firebase() -> None:
    """Initialize Firebase Admin SDK.

    Supports two credential sources (in priority order):
    1. FIREBASE_CREDENTIALS_B64 — base64-encoded JSON (for Docker / Railway / Render)
    2. FIREBASE_CREDENTIALS_JSON — path to a local service account JSON file
    """
    if firebase_admin._apps:
        logger.info("firebase_already_initialized")
        return

    cred = None

    # Method 1: Base64-encoded credentials (preferred for deployment)
    if settings.FIREBASE_CREDENTIALS_B64:
        try:
            decoded = base64.b64decode(settings.FIREBASE_CREDENTIALS_B64)
            service_info = json.loads(decoded)
            cred = credentials.Certificate(service_info)
            logger.info("firebase_init_from_b64")
        except Exception as e:
            logger.error("firebase_b64_decode_failed", error=str(e))

    # Method 2: File path to service account JSON
    if cred is None and settings.FIREBASE_CREDENTIALS_JSON:
        try:
            cred = credentials.Certificate(settings.FIREBASE_CREDENTIALS_JSON)
            logger.info("firebase_init_from_file", path=settings.FIREBASE_CREDENTIALS_JSON)
        except Exception as e:
            logger.error("firebase_file_load_failed", error=str(e))

    if cred is None:
        logger.critical(
            "firebase_credentials_missing",
            message="Firebase credentials not configured. Auth features will FAIL. "
            "Set FIREBASE_CREDENTIALS_B64 or FIREBASE_CREDENTIALS_JSON."
        )
        return

    firebase_admin.initialize_app(cred)
    logger.info("firebase_initialized")


def verify_firebase_token(id_token: str) -> dict:
    """Verify a Firebase ID token and extract user claims.

    Args:
        id_token: The Firebase ID token string from the client.

    Returns:
        dict with keys: uid, email, name, picture

    Raises:
        firebase_admin.auth.InvalidIdTokenError: If the token is invalid or expired.
    """
    decoded = auth.verify_id_token(id_token)
    return {
        "uid": decoded["uid"],
        "email": decoded.get("email", ""),
        "name": decoded.get("name", ""),
        "picture": decoded.get("picture", ""),
    }
