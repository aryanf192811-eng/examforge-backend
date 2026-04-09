"""
ExamForge — Doubt Service (AI-powered Cite & Ask — v3: Live Schema Aligned)
Google Gemini integration for generating doubt answers.
"""

import structlog
import google.generativeai as genai
from supabase import Client

from app.core.config import settings
from app.core.errors import ExamForgeError

logger = structlog.get_logger(__name__)

# Configure Gemini
genai.configure(api_key=settings.GEMINI_API_KEY)
_gemini_model = genai.GenerativeModel("gemini-1.5-flash")


async def generate_doubt_answer(
    chapter_title: str,
    subject_name: str,
    selected_text: str,
    question: str,
) -> str:
    """Generate an AI answer to a student's doubt."""
    prompt = (
        f"You are an expert GATE CSE tutor. A student is reading notes on "
        f"{subject_name} ({chapter_title}) and has a doubt.\n\n"
        f"Selected text from their notes:\n---\n{selected_text}\n---\n\n"
        f"Student's question: {question}\n\n"
        f"Instructions:\n"
        f"- Answer concisely and precisely (max 300 words)\n"
        f"- Use LaTeX math notation: $..$ and $$..$$\n"
        f"- Relate to GATE context\n"
    )

    response = _gemini_model.generate_content(prompt)
    return response.text


async def create_doubt(
    current_user: dict,
    chapter_id: str, # passed as slug
    selected_text: str,
    question: str,
    supabase: Client,
) -> dict:
    """Create a doubt and generate an AI answer. 
    Uses doubt_history table (uid, chapter_slug).
    """
    uid = current_user["uid"]

    # Generate answer
    try:
        # Contextualize for Gemini
        chapter_title = chapter_id.replace("-", " ").title()
        answer = await generate_doubt_answer(
            chapter_title=chapter_title,
            subject_name="Computer Science",
            selected_text=selected_text,
            question=question,
        )
    except Exception as e:
        logger.exception("ai_answer_generation_failed", chapter_slug=chapter_id)
        raise ExamForgeError(500, "Failed to generate answer.")

    # Save to doubt_history
    insert_result = (
        supabase.table("doubt_history")
        .insert({
            "uid": uid,
            "chapter_slug": chapter_id,
            "question": question,
            "answer": answer,
        })
        .execute()
    )

    doubt = insert_result.data[0]
    logger.info("doubt_created", uid=uid, chapter_slug=chapter_id, doubt_id=doubt["id"])

    return {
        "id": doubt["id"],
        "answer": answer,
        "created_at": doubt["created_at"],
    }


async def get_doubts(
    current_user: dict, chapter_id: str | None, supabase: Client
) -> list[dict]:
    """Get all doubts for the current user. Uses doubt_history table."""
    uid = current_user["uid"]

    query = (
        supabase.table("doubt_history")
        .select("id, chapter_slug, question, answer, created_at")
        .eq("uid", uid)
        .order("created_at", desc=True)
    )

    if chapter_id:
        query = query.eq("chapter_slug", chapter_id)

    result = query.execute()

    doubts = []
    for row in result.data or []:
        chapter_slug = row.get("chapter_slug", "")
        doubts.append({
            "id": row["id"],
            "chapter_id": chapter_slug,
            "chapter_title": chapter_slug.replace("-", " ").title(),
            "subject_name": "CS",
            "selected_text": "", # selected_text is not in the live doubt_history schema columns found
            "question": row["question"],
            "answer": row["answer"],
            "created_at": row["created_at"],
        })

    return doubts
