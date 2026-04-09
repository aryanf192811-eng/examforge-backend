"""
ExamForge — Content Service
Handles retrieval of subjects, chapters, questions, and flashcards from SQLite.
"""

import logging
from typing import List, Optional
from ..core.sqlite import query_all, query_one

logger = logging.getLogger(__name__)

def get_all_subjects():
    """Returns all subjects ordered by index."""
    return query_all("SELECT * FROM subjects ORDER BY order_index")

def get_subject_by_slug(slug: str):
    return query_one("SELECT * FROM subjects WHERE slug = ?", (slug,))

def get_chapters_by_subject(subject_id: str):
    """Returns all chapters for a subject."""
    return query_all("SELECT * FROM chapters WHERE subject_id = ? ORDER BY order_index", (subject_id,))

def get_chapter_by_slug(slug: str):
    return query_one("SELECT * FROM chapters WHERE slug = ?", (slug,))

def get_questions_by_chapter(chapter_id: str):
    """Returns questions for a chapter."""
    return query_all("SELECT * FROM questions WHERE chapter_id = ?", (chapter_id,))

def get_flashcards_by_chapter(chapter_id: str):
    """Returns flashcards for a chapter."""
    return query_all("SELECT * FROM flashcards WHERE chapter_id = ?", (chapter_id,))
