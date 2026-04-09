"""
ExamForge — Main Application Factory
FastAPI app with Firebase, Supabase, Redis lifecycle management.
"""

import structlog
print("\n🚀 [DEBUG] EXAMFORGE SERVER BOOTING — SCRIPT STARTED\n")
from fastapi import FastAPI, Request, Response
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse, RedirectResponse

from slowapi import _rate_limit_exceeded_handler
from slowapi.errors import RateLimitExceeded

from app.core.config import settings
from app.core.firebase import init_firebase
from app.core.limiter import limiter
from app.core.errors import ExamForgeError, examforge_error_handler, unhandled_exception_handler
from app.routers import (
    auth,
    content,
    progress,
    bookmarks,
    doubts,
    quiz,
    flashcards,
    leaderboard,
    profile,
    subjects,
    chapters,
    notes,
)

# ── Configure structlog ─────────────────────────────────────────────────
try:
    from app.core.config import settings
    structlog.configure(
        processors=[
            structlog.contextvars.merge_contextvars,
            structlog.processors.add_log_level,
            structlog.processors.TimeStamper(fmt="iso"),
            structlog.processors.JSONRenderer(),
        ],
        wrapper_class=structlog.make_filtering_bound_logger(20),
        logger_factory=structlog.PrintLoggerFactory(),
    )
except Exception:
    pass

logger = structlog.get_logger(__name__)

def create_app() -> FastAPI:
    """Fast-booting Application Factory."""
    app = FastAPI(title="ExamForge API")

    # 1. IMMEDIATE NUCLEAR CORS (Absolute Priority)
    @app.middleware("http")
    async def nuclear_cors_middleware(request: Request, call_next):
        origin = request.headers.get("origin")
        if request.method == "OPTIONS":
            resp = Response(status_code=200)
            resp.headers["Access-Control-Allow-Origin"] = origin or "*"
            resp.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS, PATCH"
            resp.headers["Access-Control-Allow-Headers"] = "*"
            resp.headers["Access-Control-Allow-Credentials"] = "true"
            return resp
        
        try:
            response = await call_next(request)
        except Exception as e:
            logger.error("internal_crash", path=request.url.path, error=str(e))
            response = JSONResponse(status_code=500, content={"detail": str(e)})

        if origin:
            response.headers["Access-Control-Allow-Origin"] = origin
            response.headers["Access-Control-Allow-Credentials"] = "true"
        response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS, PATCH"
        response.headers["Access-Control-Allow-Headers"] = "*"
        return response

    # 2. LAZY ROUTER REGISTRATION
    @app.on_event("startup")
    async def startup_event():
        """Initialize heavy-weight dependencies after the port is bound."""
        try:
            from app.core.firebase import init_firebase
            init_firebase()
            logger.info("firebase_lazy_init_success")
        except Exception as e:
            logger.error("firebase_lazy_init_failed", error=str(e))

    # 3. REGISTER ROUTERS
    from app.routers import (
        auth, content, progress, bookmarks, doubts, quiz, 
        flashcards, leaderboard, profile, subjects, chapters, notes
    )
    
    for router_module, prefix, tag in [
        (auth, "/api/auth", "auth"),
        (profile, "/api/profile", "profile"),
        (subjects, "/api/subjects", "subjects"),
        (chapters, "/api/chapters", "chapters"),
        (notes, "/api/notes", "notes"),
        (content, "/api/content", "content"),
        (progress, "/api/progress", "progress"),
        (bookmarks, "/api/bookmarks", "bookmarks"),
        (doubts, "/api/doubts", "doubts"),
        (quiz, "/api/quiz", "quiz"),
        (flashcards, "/api/flashcards", "flashcards"),
        (leaderboard, "/api/leaderboard", "leaderboard"),
    ]:
        app.include_router(router_module.router, prefix=prefix, tags=[tag])

    @app.get("/health")
    async def health():
        return {"status": "ok", "service": "examforge"}

    return app

app = create_app()
