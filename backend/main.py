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
structlog.configure(
    processors=[
        structlog.contextvars.merge_contextvars,
        structlog.processors.add_log_level,
        structlog.processors.StackInfoRenderer(),
        structlog.dev.set_exc_info,
        structlog.processors.TimeStamper(fmt="iso"),
        structlog.processors.JSONRenderer(),
    ],
    wrapper_class=structlog.make_filtering_bound_logger(
        10 if settings.DEBUG else 20
    ),
    context_class=dict,
    logger_factory=structlog.PrintLoggerFactory(),
    cache_logger_on_first_use=True,
)

logger = structlog.get_logger(__name__)


def create_app() -> FastAPI:
    """Application factory. Creates and configures the FastAPI app."""

    # ── Initialize Firebase Admin SDK ────────────────────────────────
    try:
        init_firebase()
    except Exception as e:
        print(f"❌ [CRITICAL] Firebase initialization failed: {e}")
        logger.error("firebase_init_failed", error=str(e))

    # ── Create FastAPI app ───────────────────────────────────────────
    app = FastAPI(
        title="ExamForge API",
        description="GATE CSE exam prep platform backend",
        version="2.0.0",
        docs_url="/docs" if settings.DEBUG else None,
        redoc_url=None,
    )

    # ── NUCLEAR CORS MANIFEST ────────────────────────────────────────
    # We use a custom middleware to ensure headers are present even if 
    # the app crashes or Render returns a 502/503.
    
    @app.middleware("http")
    async def nuclear_cors_middleware(request: Request, call_next):
        origin = request.headers.get("origin")
        
        # 1. Handle OPTIONS (Preflight)
        if request.method == "OPTIONS":
            response = Response()
            response.status_code = 200
            if origin:
                response.headers["Access-Control-Allow-Origin"] = origin
            else:
                response.headers["Access-Control-Allow-Origin"] = "*"
                
            response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS, PATCH"
            response.headers["Access-Control-Allow-Headers"] = "*"
            response.headers["Access-Control-Allow-Credentials"] = "true"
            response.headers["Access-Control-Max-Age"] = "86400"
            return response

        # 2. Process the actual request
        try:
            response = await call_next(request)
        except Exception as e:
            logger.exception("request_failed", path=request.url.path, error=str(e))
            response = JSONResponse(
                status_code=500,
                content={"type": "internal_error", "title": "An internal error occurred."}
            )

        # 3. Inject headers into the response
        if origin:
             response.headers["Access-Control-Allow-Origin"] = origin
        else:
             response.headers["Access-Control-Allow-Origin"] = "*"
             
        response.headers["Access-Control-Allow-Credentials"] = "true"
        response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS, PATCH"
        response.headers["Access-Control-Allow-Headers"] = "*"
        
        return response

    # ── Exception Handlers ───────────────────────────────────────────
    app.add_exception_handler(ExamForgeError, examforge_error_handler)
    app.add_exception_handler(Exception, unhandled_exception_handler)
    app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)

    # ── Rate Limiter Connection ──────────────────────────────────────
    app.state.limiter = limiter

    # ── Lifecycle Events ─────────────────────────────────────────────
    @app.on_event("startup")
    async def startup():
        logger.info(
            "app_started", 
            env=settings.APP_ENV,
            allowed_origins=settings.ALLOWED_ORIGINS
        )

    @app.on_event("shutdown")
    async def shutdown():
        logger.info("app_shutdown")

    # ── Register Routers ─────────────────────────────────────────────
    app.include_router(auth.router,         prefix="/api/auth",         tags=["auth"])
    app.include_router(content.router,      prefix="/api/content",      tags=["content"])
    app.include_router(progress.router,     prefix="/api/progress",     tags=["progress"])
    app.include_router(bookmarks.router,    prefix="/api/bookmarks",    tags=["bookmarks"])
    app.include_router(doubts.router,       prefix="/api/doubts",       tags=["doubts"])
    app.include_router(quiz.router,         prefix="/api/quiz",         tags=["quiz"])
    app.include_router(flashcards.router,   prefix="/api/flashcards",   tags=["flashcards"])
    app.include_router(leaderboard.router,  prefix="/api/leaderboard",  tags=["leaderboard"])
    app.include_router(profile.router,      prefix="/api/profile",      tags=["profile"])
    app.include_router(subjects.router,     prefix="/api/subjects",     tags=["subjects"])
    app.include_router(chapters.router,     prefix="/api/chapters",     tags=["chapters"])
    app.include_router(notes.router,        prefix="/api/notes",        tags=["notes"])

    # ── Root & Health Check ─────────────────────────────────────────
    @app.get("/", include_in_schema=False)
    async def root():
        from fastapi.responses import RedirectResponse
        return RedirectResponse(url="/docs")

    # ── Health Check ─────────────────────────────────────────────────
    @app.get("/health", tags=["system"])
    async def health():
        """Health check endpoint."""
        return {
            "status": "ok",
            "env": settings.APP_ENV,
            "version": "2.0.0",
        }

    return app


# ── Create the app instance ──────────────────────────────────────────────
app = create_app()
