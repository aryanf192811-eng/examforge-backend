"""
ExamForge — Doubt Service (AI-powered Cite & Ask)
Google Gemini integration for generating doubt answers.
"""

import structlog
import google.generativeai as genai
from supabase import Client

from app.core.config import settings
from app.core.errors import ExamForgeError

logger = structlog.get_logger(__name__)

# Configure Gemini once at module load
genai.configure(api_key=settings.GEMINI_API_KEY)
_gemini_model = genai.GenerativeModel("gemini-1.5-flash")


async def generate_doubt_answer(
    chapter_title: str,
    subject_name: str,
    selected_text: str,
    question: str,
) -> str:
    """Generate an AI answer to a student's doubt using Google Gemini.

    Args:
        chapter_title: Title of the chapter the student is reading
        subject_name: Name of the subject (e.g., "DBMS")
        selected_text: Text the student selected/highlighted from notes
        question: The student's question about the selected text

    Returns:
        AI-generated answer string
    """
    prompt = (
        f"You are an expert GATE CSE tutor. A student is reading notes on "
        f"{subject_name} ({chapter_title}) and has a doubt.\n\n"
        f"Selected text from their notes:\n---\n{selected_text}\n---\n\n"
        f"Student's question: {question}\n\n"
        f"Instructions:\n"
        f"- Answer concisely and precisely (max 300 words)\n"
        f"- Use LaTeX math notation where appropriate: inline $..$ and block $$..$$\n"
        f"- Relate the answer to GATE exam context where relevant\n"
        f"- If the question has a common GATE trap, point it out\n"
        f"- Do not repeat the question back"
    )

    response = _gemini_model.generate_content(prompt)
    return response.text


async def create_doubt(
    current_user: dict,
    chapter_id: str,
    selected_text: str,
    question: str,
    supabase: Client,
) -> dict:
    """Create a doubt and generate an AI answer.

    Process:
    1. Fetch chapter + subject context for AI prompt
    2. Call Gemini API server-side
    3. Save doubt + answer to database
    4. Return the doubt with answer
    """
    user_id = current_user["profile_id"]

    # Step 1: Fetch chapter + subject context
    chapter_result = (
        supabase.table("chapters")
        .select("id, title, subject_id, subjects!inner(title)")
        .eq("id", chapter_id)
        .single()
        .execute()
    )

    if not chapter_result.data:
        raise ExamForgeError(404, "Chapter not found")

    chapter_title = chapter_result.data["title"]
    subject_title = chapter_result.data.get("subjects", {}).get("title", "Computer Science")

    # Step 2: Generate AI answer
    try:
        answer = await generate_doubt_answer(
            chapter_title=chapter_title,
            subject_name=subject_title,
            selected_text=selected_text or "No text selected",
            question=question,
        )
    except Exception as e:
        logger.exception("ai_answer_generation_failed", chapter_id=chapter_id)
        raise ExamForgeError(500, "Failed to generate answer. Please try again.")

    # Step 3: Save to database
    insert_result = (
        supabase.table("doubts")
        .insert({
            "user_id": current_user["uid"],
            "chapter_id": chapter_id,
            "selected_text": selected_text,
            "question": question,
            "answer": answer,
        })
        .execute()
    )

    doubt = insert_result.data[0]
    logger.info("doubt_created", user_id=current_user["uid"], chapter_id=chapter_id, doubt_id=doubt["id"])

    return {
        "id": doubt["id"],
        "answer": answer,
        "created_at": doubt["created_at"],
    }


async def get_doubts(
    current_user: dict, chapter_id: str | None, supabase: Client
) -> list[dict]:
    """Get all doubts for the current user, optionally filtered by chapter.

    Joins with chapters and subjects for context.
    """
    user_id = current_user["profile_id"]

    query = (
        supabase.table("doubts")
        .select(
            "id, chapter_id, selected_text, question, answer, created_at, "
            "chapters!inner(title, subjects!inner(title))"
        )
        .eq("user_id", user_id)
        .order("created_at", desc=True)
    )

    if chapter_id:
        query = query.eq("chapter_id", chapter_id)

    result = query.execute()

    doubts = []
    for row in result.data or []:
        chapter_data = row.get("chapters", {})
        subject_data = chapter_data.get("subjects", {})
        doubts.append({
            "id": row["id"],
            "chapter_id": row["chapter_id"],
            "chapter_title": chapter_data.get("title", ""),
            "subject_name": subject_data.get("title", ""),
            "selected_text": row["selected_text"] or "",
            "question": row["question"],
            "answer": row["answer"],
            "created_at": row["created_at"],
        })

    return doubts
