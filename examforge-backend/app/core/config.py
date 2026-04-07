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
    ALLOWED_ORIGINS: list[str] = ["http://localhost:5173", "https://examforge-kohl.vercel.app"]

    # ── Firebase ─────────────────────────────────────────────────────────
    FIREBASE_CREDENTIALS_JSON: str = ""
    FIREBASE_CREDENTIALS_B64: str = ""

    # ── Supabase ─────────────────────────────────────────────────────────
    SUPABASE_URL: str = ""
    SUPABASE_SERVICE_KEY: str = ""
    SUPABASE_STORAGE_BUCKET: str = "notes-content"


    # ── AI ───────────────────────────────────────────────────────────────
    GEMINI_API_KEY: str = ""

    # ── Security ─────────────────────────────────────────────────────────
    SIGNED_URL_EXPIRY_S: int = 3600
    # How long to cache a signed URL in Redis before regenerating
    SIGNED_URL_CACHE_TTL_S: int = 3000  # 50 min < 60 min expiry — always valid

    # ── Quiz state ───────────────────────────────────────────────────────
    QUIZ_FLUSH_INTERVAL_S: int = 30      # Frontend polls this rate; backend mirrors it


settings = Settings()
