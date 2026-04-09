"""
ExamForge — SQLite Core
Manages the read-only connection to content.db
"""

import sqlite3
import logging
from pathlib import Path
from .config import settings

logger = logging.getLogger(__name__)

def get_sqlite_conn():
    """
    Returns a connection to the SQLite content database.
    Optimized for read-only concurrency using WAL mode.
    """
    db_path = Path(settings.SQLITE_DB_PATH)
    
    # If using absolute path for safety
    if not db_path.is_absolute():
        # Backend is in Root/examforge-backend/
        # Root is one level up
        db_path = (Path(__file__).parent.parent.parent / settings.SQLITE_DB_PATH).resolve()

    if not db_path.exists():
        logger.error(f"SQLite database not found at {db_path}")
        raise FileNotFoundError(f"Content database missing at {db_path}")

    conn = sqlite3.connect(
        str(db_path),
        check_same_thread=False,
        timeout=10
    )
    conn.row_factory = sqlite3.Row  # Returns dict-like objects
    
    # Optimization pragmas
    conn.execute("PRAGMA journal_mode=WAL;")
    conn.execute("PRAGMA query_only=ON;")
    
    return conn

def query_one(query: str, params: tuple = ()):
    conn = get_sqlite_conn()
    try:
        row = conn.execute(query, params).fetchone()
        return dict(row) if row else None
    finally:
        conn.close()

def query_all(query: str, params: tuple = ()):
    conn = get_sqlite_conn()
    try:
        rows = conn.execute(query, params).fetchall()
        return [dict(row) for row in rows]
    finally:
        conn.close()
