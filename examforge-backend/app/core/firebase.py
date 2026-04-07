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

    Supports three credential sources (in priority order):
    1. FIREBASE_CREDENTIALS_B64 — base64-encoded JSON string
    2. FIREBASE_CREDENTIALS_JSON — Raw JSON string
    3. FIREBASE_CREDENTIALS_JSON — Path to a local service account JSON file
    """
    if firebase_admin._apps:
        logger.info("firebase_already_initialized")
        return

    cred = None

    # Method 1: Base64-encoded credentials (preferred for deployment)
    if settings.FIREBASE_CREDENTIALS_B64:
        try:
            b64_string = settings.FIREBASE_CREDENTIALS_B64
            missing_padding = len(b64_string) % 4
            if missing_padding:
                b64_string += "=" * (4 - missing_padding)
            
            decoded = base64.b64decode(b64_string)
            service_info = json.loads(decoded)
            cred = credentials.Certificate(service_info)
            logger.info("firebase_init_success", method="b64_string")
        except Exception as e:
            logger.error("firebase_b64_decode_failed", error=str(e))

    # Method 2 & 3: Raw JSON string or File Path
    if cred is None and settings.FIREBASE_CREDENTIALS_JSON:
        candidate = settings.FIREBASE_CREDENTIALS_JSON.strip()
        
        # Check if it's a JSON string (starts with '{' and ends with '}')
        if candidate.startswith("{") and candidate.endswith("}"):
            try:
                service_info = json.loads(candidate)
                cred = credentials.Certificate(service_info)
                logger.info("firebase_init_success", method="json_string")
            except Exception as e:
                logger.error("firebase_json_string_parse_failed", error=str(e))
        else:
            # Assume it's a file path
            try:
                # If path is relative, ensure it's absolute for better reliability
                if not os.path.isabs(candidate):
                    candidate = os.path.abspath(candidate)
                
                cred = credentials.Certificate(candidate)
                logger.info("firebase_init_success", method="file_path", path=candidate)
            except Exception as e:
                logger.error("firebase_file_load_failed", error=str(e), path=candidate)

    if cred is None:
        logger.critical("firebase_initialization_failed", 
                        reason="No valid credentials found in FIREBASE_CREDENTIALS_B64 or FIREBASE_CREDENTIALS_JSON")
        raise RuntimeError(
            "Firebase credentials not configured correctly. "
            "Ensure FIREBASE_CREDENTIALS_JSON is either a valid JSON string or a valid file path."
        )

    firebase_admin.initialize_app(cred)
    logger.info("firebase_app_initialized")



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
