"""
ExamForge — Error Handling
RFC 7807 Problem Details compliant error responses.
"""

import structlog
from fastapi import Request
from fastapi.responses import JSONResponse

logger = structlog.get_logger(__name__)


class ExamForgeError(Exception):
    """Application-level error that maps to an HTTP response."""

    def __init__(self, status_code: int, detail: str, error_type: str = "error"):
        self.status_code = status_code
        self.detail = detail
        self.error_type = error_type
        super().__init__(detail)


async def examforge_error_handler(request: Request, exc: ExamForgeError) -> JSONResponse:
    """Convert ExamForgeError into RFC 7807 Problem Details JSON."""
    logger.error(
        "examforge_error",
        status_code=exc.status_code,
        detail=exc.detail,
        error_type=exc.error_type,
        path=str(request.url),
    )
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "type": exc.error_type,
            "title": exc.detail,
            "status": exc.status_code,
            "instance": str(request.url),
        },
    )


async def unhandled_exception_handler(request: Request, exc: Exception) -> JSONResponse:
    """Catch-all for unhandled exceptions. Never leak internal details."""
    logger.exception(
        "unhandled_exception",
        path=str(request.url),
        method=request.method,
        exc_type=type(exc).__name__,
    )
    return JSONResponse(
        status_code=500,
        content={
            "type": "internal_error",
            "title": "An unexpected error occurred. Please try again later.",
            "status": 500,
            "instance": str(request.url),
        },
    )
