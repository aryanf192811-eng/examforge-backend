"""
ExamForge — Main Application Factory
FastAPI app with Firebase, Supabase, Redis lifecycle management.
"""

import structlog
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

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
    init_firebase()

    # ── Create FastAPI app ───────────────────────────────────────────
    app = FastAPI(
        title="ExamForge API",
        description="GATE CSE exam prep platform backend",
        version="2.0.0",
        docs_url="/docs" if settings.DEBUG else None,
        redoc_url=None,
    )

    # ── CORS Middleware ──────────────────────────────────────────────
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["https://examforge-kohl.vercel.app"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    # ── Exception Handlers ───────────────────────────────────────────
    app.add_exception_handler(ExamForgeError, examforge_error_handler)
    app.add_exception_handler(Exception, unhandled_exception_handler)
    app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)

    # ── Rate Limiter Connection ──────────────────────────────────────
    app.state.limiter = limiter

    # ── Lifecycle Events ─────────────────────────────────────────────
    @app.on_event("startup")
    async def startup():
        logger.info("app_started", env=settings.APP_ENV)

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
