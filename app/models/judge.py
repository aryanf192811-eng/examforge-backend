"""
ExamForge — Piston Code Execution Pydantic Models
"""

from typing import Optional

from pydantic import BaseModel, Field


# Piston uses language name strings — this maps common names to Piston identifiers.
# Version "*" tells Piston to use the latest available version.
SUPPORTED_LANGUAGES: dict[str, str] = {
    "python": "python",
    "python3": "python",
    "py": "python",
    "c": "c",
    "gcc": "c",
    "c++": "c++",
    "cpp": "c++",
    "g++": "c++",
    "java": "java",
    "javascript": "javascript",
    "js": "javascript",
    "typescript": "typescript",
    "ts": "typescript",
    "rust": "rust",
    "rs": "rust",
    "go": "go",
    "golang": "go",
    "ruby": "ruby",
    "rb": "ruby",
    "kotlin": "kotlin",
    "kt": "kotlin",
    "swift": "swift",
    "csharp": "csharp.net",
    "cs": "csharp.net",
    "c#": "csharp.net",
    "bash": "bash",
    "sh": "bash",
    "sql": "sqlite3",
    "sqlite": "sqlite3",
    "lua": "lua",
    "perl": "perl",
    "php": "php",
    "scala": "scala",
    "haskell": "haskell",
    "hs": "haskell",
}


class JudgeSubmitRequest(BaseModel):
    """Request for POST /api/judge/submit."""
    language: str = Field(
        ...,
        description="Language name (e.g., 'python', 'c++', 'java', 'javascript')",
    )
    source_code: str = Field(..., min_length=1, max_length=50000)
    stdin: str = Field("", max_length=10000)


class JudgeSubmitResponse(BaseModel):
    """Response for POST /api/judge/submit."""
    status: str
    stdout: Optional[str] = None
    stderr: Optional[str] = None
    compile_output: Optional[str] = None
    exit_code: Optional[int] = None
    runs_remaining: int = 0
