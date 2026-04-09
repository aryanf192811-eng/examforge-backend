"""
ExamForge — Application Configuration
Loads all settings from environment variables with pydantic-settings.
"""

from pydantic import field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict
from typing import List, Union


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
    ALLOWED_ORIGINS: List[str] = [
        "https://examforgee.vercel.app",
        "https://examforge-backend.onrender.com",
        "http://localhost:5173",
        "http://localhost:3000",
    ]

    @field_validator("ALLOWED_ORIGINS", mode="before")
    @classmethod
    def assemble_cors_origins(cls, v: Union[str, List[str]]) -> List[str]:
        if isinstance(v, str) and not v.startswith("["):
            return [i.strip() for i in v.split(",")]
        elif isinstance(v, (list, str)):
            return v
        return v

    # ── Firebase ─────────────────────────────────────────────────────────
    FIREBASE_CREDENTIALS_JSON: str = ""
    FIREBASE_CREDENTIALS_B64: str = ""

    # ── Supabase ─────────────────────────────────────────────────────────
    SUPABASE_URL: str = ""
    SUPABASE_SERVICE_KEY: str = ""
    # ── Database ────────────────────────────────────────────────────────
    SQLITE_DB_PATH: str = "content.db"


settings = Settings()
