"""
ExamForge — Application Configuration
Loads all settings from environment variables with pydantic-settings.
"""

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env", 
        env_file_encoding="utf-8",
        extra="ignore"  # Prevent crashes if extra env vars are present on Render
    )

    # ── General ──────────────────────────────────────────────────────────
    APP_ENV: str = "development"
    DEBUG: bool = False
    GEMINI_API_KEY: str = ""
    QUIZ_FLUSH_INTERVAL_S: int = 30
    MANIFEST_URL: str = ""
    ALLOWED_ORIGINS: list[str] = [
        "http://localhost:5173",
        "http://localhost:3000",
        "https://examforgee.vercel.app",
        "https://examforge-kohl.vercel.app",
    ]

    # ── Firebase ─────────────────────────────────────────────────────────
    FIREBASE_CREDENTIALS_JSON: str = ""
    FIREBASE_CREDENTIALS_B64: str = ""

    # ── Supabase ─────────────────────────────────────────────────────────
    SUPABASE_URL: str = ""
    SUPABASE_SERVICE_KEY: str = ""
    # ── Database ────────────────────────────────────────────────────────
    SQLITE_DB_PATH: str = "content.db"


settings = Settings()
