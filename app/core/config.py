"""
ExamForge — Application Configuration
Loads all settings from environment variables with pydantic-settings.
"""

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")

    # ── General ──────────────────────────────────────────────────────────
    APP_ENV: str = "development"
    DEBUG: bool = False
    ALLOWED_ORIGINS: list[str] = [
        "http://localhost:5173",
        "https://examforge-kohl.vercel.app",
        "https://examforgee.vercel.app"
    ]

    # ── Firebase ─────────────────────────────────────────────────────────
    FIREBASE_CREDENTIALS_JSON: str = ""
    FIREBASE_CREDENTIALS_B64: str = ""

    # ── Supabase ─────────────────────────────────────────────────────────
    SUPABASE_URL: str = ""
    SUPABASE_SERVICE_KEY: str = ""
    # ── Content ──────────────────────────────────────────────────────────
    MANIFEST_URL: str = "http://localhost:5173/content/manifest.json"

    # ── AI ───────────────────────────────────────────────────────────────
    GEMINI_API_KEY: str = ""

    # ── Quiz state ───────────────────────────────────────────────────────
    QUIZ_FLUSH_INTERVAL_S: int = 30      # Frontend polls this rate; backend mirrors it


settings = Settings()
