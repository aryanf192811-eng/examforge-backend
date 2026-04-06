# ══════════════════════════════════════════════════════════════════════════════
# EXAMFORGE — BACKEND BUILD PROMPT v2.0
# FastAPI + Supabase + Firebase Admin + Redis · Production-Grade · Zero Shortcuts
# ── PATCH v2: CDN-direct notes delivery · Redis quiz state · Normalized schema
# ══════════════════════════════════════════════════════════════════════════════

---

## ❶ MISSION BRIEF

You are a senior backend engineer with 20+ years of experience in FastAPI,
PostgreSQL, Redis, cloud storage, and security architecture.

Build the **complete backend** for **ExamForge** — a premium GATE CSE exam prep
platform. This backend serves a React + Tailwind frontend, uses Firebase for
authentication, and Supabase (PostgreSQL) as the primary database and storage layer.

This prompt defines every endpoint, service layer, security rule, data flow, and
database integration. Read it fully before writing a single line of code.

**Non-negotiable rules before you begin:**
1. Every endpoint is authenticated unless explicitly marked [PUBLIC]
2. Firebase token verification happens in a shared dependency (`get_current_user`) — never skip it
3. Signed URLs are generated server-side — the client fetches from CDN directly (new in v2)
4. Role checks (free/pro/admin) happen at the service layer, not in routes
5. Never return raw storage paths or bucket names in API responses
6. Every endpoint has Pydantic request/response models — no bare dicts
7. Judge0 calls happen here — never from the frontend directly
8. All errors return RFC 7807 Problem Details format
9. Database queries use parameterized values only — no string concatenation
10. Rate limiting is enforced per user via Redis (high-frequency) and Supabase (persistent audit)
11. High-frequency quiz state writes hit Redis first — never PostgreSQL directly (new in v2)
12. All background Redis→Postgres flushes use idempotent UPSERT (new in v2)

---

## ❷ TECH STACK (LOCKED)

```
Runtime:          Python 3.11+
Framework:        FastAPI (latest stable)
ASGI Server:      Uvicorn with Gunicorn workers (production)
Auth:             Firebase Admin SDK (firebase-admin) for token verification
Database:         Supabase (PostgreSQL via supabase-py + asyncpg directly)
Storage:          Supabase Storage (private bucket: notes-content)
Cache / State:    Redis via upstash-redis (quiz session hot state, rate limit counters,
                  signed URL short-term cache)
Validation:       Pydantic v2
Migrations:       Alembic (schema.py → migration files)
Env Management:   python-dotenv + pydantic-settings
HTTP Client:      httpx (async, for Judge0 calls)
Rate Limiting:    slowapi (Starlette middleware) + Redis per-user counters
Logging:          structlog (JSON output, structured)
Testing:          pytest + pytest-asyncio + httpx TestClient
Code Quality:     ruff (linter + formatter), mypy (type checks)
Deployment:       Railway or Render (single service, Dockerfile provided)
Background Tasks: FastAPI BackgroundTasks (Redis→Postgres flush on quiz submit)
```

---

## ❸ PROJECT STRUCTURE

```
examforge-backend/
├── main.py
├── Dockerfile
├── requirements.txt
├── .env.example
├── alembic/
│   ├── env.py
│   └── versions/
├── app/
│   ├── core/
│   │   ├── config.py
│   │   ├── firebase.py
│   │   ├── supabase.py
│   │   ├── redis.py               ← NEW: Upstash Redis client init
│   │   ├── dependencies.py
│   │   ├── errors.py
│   │   ├── logging.py
│   │   └── rate_limit.py
│   ├── models/
│   │   ├── user.py
│   │   ├── notes.py               ← UPDATED: NoteUrlResponse (signed_url only)
│   │   ├── practice.py
│   │   ├── doubt.py
│   │   ├── bookmark.py
│   │   ├── leaderboard.py
│   │   └── judge.py
│   ├── services/
│   │   ├── auth_service.py
│   │   ├── notes_service.py       ← UPDATED: generates + returns signed_url
│   │   ├── bookmark_service.py
│   │   ├── doubt_service.py
│   │   ├── quiz_service.py        ← UPDATED: Redis-backed hot state
│   │   ├── judge_service.py
│   │   ├── leaderboard_service.py
│   │   ├── progress_service.py
│   │   └── export_service.py
│   └── routers/
│       ├── auth.py
│       ├── notes.py               ← UPDATED: /url endpoint
│       ├── subjects.py
│       ├── chapters.py
│       ├── bookmarks.py
│       ├── doubts.py
│       ├── quiz.py
│       ├── flashcards.py
│       ├── judge.py
│       ├── leaderboard.py
│       ├── profile.py
│       └── export.py
```

---

## ❹ CONFIGURATION

### `app/core/config.py`

```python
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")

    APP_ENV: str = "development"
    DEBUG: bool = False
    ALLOWED_ORIGINS: list[str] = ["http://localhost:5173", "https://examforge.in"]

    # Firebase
    FIREBASE_CREDENTIALS_JSON: str
    FIREBASE_CREDENTIALS_B64: str = ""

    # Supabase
    SUPABASE_URL: str
    SUPABASE_SERVICE_KEY: str
    SUPABASE_STORAGE_BUCKET: str = "notes-content"

    # Redis (Upstash — serverless compatible)
    REDIS_URL: str                   # e.g. rediss://default:...@...upstash.io:6379
    REDIS_TOKEN: str = ""            # Upstash REST token (alternative to URL)

    # Judge0
    JUDGE0_BASE_URL: str = "https://judge0-ce.p.rapidapi.com"
    JUDGE0_API_KEY: str
    JUDGE0_TIMEOUT_S: int = 5
    JUDGE0_MAX_RUNS_PER_USER_PER_HOUR: int = 20

    # AI
    ANTHROPIC_API_KEY: str

    # Security
    SIGNED_URL_EXPIRY_S: int = 3600
    # How long to cache a signed URL in Redis before regenerating
    SIGNED_URL_CACHE_TTL_S: int = 3000  # 50 min < 60 min expiry — always valid

    # Quiz state
    QUIZ_REDIS_TTL_S: int = 86400        # 24h — covers longest mock session
    QUIZ_FLUSH_INTERVAL_S: int = 30      # Frontend polls this rate; backend mirrors it

settings = Settings()
```

### `.env.example`

```
APP_ENV=development
DEBUG=false
ALLOWED_ORIGINS=["http://localhost:5173"]

FIREBASE_CREDENTIALS_JSON=/path/to/firebase-service-account.json
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_KEY=your-service-role-key

REDIS_URL=rediss://default:your-token@your-instance.upstash.io:6379

JUDGE0_BASE_URL=https://judge0-ce.p.rapidapi.com
JUDGE0_API_KEY=your-judge0-key

ANTHROPIC_API_KEY=your-anthropic-key
SIGNED_URL_EXPIRY_S=3600
SIGNED_URL_CACHE_TTL_S=3000
```

---

## ❺ CORE INFRASTRUCTURE

### Redis Client (`app/core/redis.py`)

```python
import redis.asyncio as aioredis
from app.core.config import settings

_redis_client: aioredis.Redis | None = None

async def get_redis() -> aioredis.Redis:
    global _redis_client
    if _redis_client is None:
        _redis_client = aioredis.from_url(
            settings.REDIS_URL,
            encoding="utf-8",
            decode_responses=True,
            socket_connect_timeout=3,
        )
    return _redis_client

async def close_redis():
    global _redis_client
    if _redis_client:
        await _redis_client.aclose()
        _redis_client = None
```

Register in `main.py`:
```python
@app.on_event("startup")
async def startup():
    await get_redis()   # warm the connection pool

@app.on_event("shutdown")
async def shutdown():
    await close_redis()
```

### Firebase Token Verification (`app/core/firebase.py`)

```python
import firebase_admin
from firebase_admin import credentials, auth

def init_firebase():
    cred = credentials.Certificate(settings.FIREBASE_CREDENTIALS_JSON)
    firebase_admin.initialize_app(cred)

def verify_firebase_token(id_token: str) -> dict:
    """Raises firebase_admin.auth.InvalidIdTokenError on failure."""
    decoded = auth.verify_id_token(id_token)
    return {
        "uid": decoded["uid"],
        "email": decoded.get("email", ""),
        "name": decoded.get("name", ""),
        "picture": decoded.get("picture", ""),
    }
```

### Authentication Dependency (`app/core/dependencies.py`)

```python
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from app.core.firebase import verify_firebase_token
from app.core.supabase import get_supabase

bearer_scheme = HTTPBearer()

async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(bearer_scheme),
    supabase = Depends(get_supabase)
) -> dict:
    """Verify Firebase token → return { uid, email, role, profile_id }."""
    try:
        firebase_user = verify_firebase_token(credentials.credentials)
    except Exception:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired authentication token"
        )

    result = supabase.table("profiles")\
        .select("id, role, name")\
        .eq("firebase_uid", firebase_user["uid"])\
        .single()\
        .execute()

    if not result.data:
        raise HTTPException(status_code=404, detail="Profile not found. Complete signup first.")

    return {
        "uid": firebase_user["uid"],
        "email": firebase_user["email"],
        "profile_id": result.data["id"],
        "role": result.data["role"],
        "name": result.data["name"],
    }

def require_pro(current_user: dict = Depends(get_current_user)) -> dict:
    if current_user["role"] not in ("pro", "admin"):
        raise HTTPException(status_code=403, detail="Pro subscription required")
    return current_user

def require_admin(current_user: dict = Depends(get_current_user)) -> dict:
    if current_user["role"] != "admin":
        raise HTTPException(status_code=403, detail="Admin access required")
    return current_user
```

### Error Handler (`app/core/errors.py`)

```python
from fastapi import Request
from fastapi.responses import JSONResponse

class ExamForgeError(Exception):
    def __init__(self, status_code: int, detail: str, error_type: str = "error"):
        self.status_code = status_code
        self.detail = detail
        self.error_type = error_type

async def examforge_error_handler(request: Request, exc: ExamForgeError):
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "type": exc.error_type,
            "title": exc.detail,
            "status": exc.status_code,
            "instance": str(request.url)
        }
    )
```

---

## ❻ API ENDPOINTS — COMPLETE SPECIFICATION

For each endpoint:
- `[PUBLIC]` = no auth required
- `[AUTH]` = Firebase token required
- `[PRO]` = Pro or Admin role required
- `[ADMIN]` = Admin role only

---

### AUTH ROUTER (`/api/auth`)

#### `POST /api/auth/session` [PUBLIC after Firebase login]
**Purpose:** Called once after Firebase login. Creates or syncs the Supabase profile.

Request body:
```json
{ "id_token": "firebase_id_token_string" }
```

Process:
1. `verify_firebase_token(id_token)` → get uid, email, name, picture
2. Check if profile exists: `SELECT id, role FROM profiles WHERE firebase_uid = uid`
3. If not exists: `INSERT INTO profiles (firebase_uid, email, name, avatar_url) VALUES (...)`
4. If exists: `UPDATE profiles SET name=name, avatar_url=picture WHERE firebase_uid=uid`

Response:
```json
{
  "profile_id": "uuid",
  "role": "free",
  "name": "Aryan",
  "email": "aryan@example.com",
  "is_new_user": true
}
```

---

### SUBJECTS ROUTER (`/api/subjects`)

#### `GET /api/subjects` [AUTH]
Returns all subjects ordered by order_index.
Free users: all subjects returned (UI handles locking).

Response:
```json
{
  "subjects": [
    {
      "id": "uuid",
      "slug": "dbms",
      "name": "Database Management Systems",
      "category": "GATE",
      "icon": "🗄️",
      "is_published": true,
      "order_index": 1,
      "chapter_count": 7,
      "completed_chapters": 3,
      "progress_pct": 42
    }
  ]
}
```

---

### CHAPTERS ROUTER (`/api/chapters`)

#### `GET /api/chapters/{subject_id}` [AUTH]
Returns chapters for a subject, with per-user progress and notes availability.

---

### NOTES ROUTER (`/api/notes`) — ✦ UPDATED v2

#### `GET /api/notes/url` [AUTH]
**Purpose:** Authenticate user, cache-check, and return a short-lived signed URL
for the client to fetch the note file directly from the CDN.

**Why CDN-direct (v2 change):**
- Server no longer fetches the HTML — removes one hop and eliminates backend bandwidth cost
- Signed URL is still scoped to this user's session and expires in 1h
- Backend remains the gatekeeper (auth + publish check happen here)

Query params: `?chapter_id={uuid}`

**Process:**
```python
# Step 1: Verify chapter access + publish status
chapter = supabase.table("chapters").select("id, is_published, subject_id")\
    .eq("id", chapter_id).single().execute()
if not chapter.data or not chapter.data["is_published"]:
    raise ExamForgeError(404, "Chapter notes not available")

# Step 2: Check Redis cache for an existing valid signed URL
redis = await get_redis()
cache_key = f"notes_url:{chapter_id}"
cached_url = await redis.get(cache_key)
if cached_url:
    return {"signed_url": cached_url, "chapter_id": chapter_id, "cached": True}

# Step 3: Get exact storage path
note = supabase.table("notes").select("storage_path")\
    .eq("chapter_id", chapter_id).single().execute()
if not note.data:
    raise ExamForgeError(404, "Notes file not uploaded yet")

# Step 4: Generate signed URL
storage_path = note.data["storage_path"]
signed = supabase.storage.from_(settings.SUPABASE_STORAGE_BUCKET)\
    .create_signed_url(storage_path, settings.SIGNED_URL_EXPIRY_S)
if not signed.get("signedURL"):
    raise ExamForgeError(500, "Could not generate content access URL")

# Step 5: Cache the signed URL in Redis (TTL = SIGNED_URL_CACHE_TTL_S < expiry)
await redis.setex(cache_key, settings.SIGNED_URL_CACHE_TTL_S, signed["signedURL"])

# Step 6: Return signed URL to client
# CRITICAL: The client fetches from CDN directly. The backend NEVER fetches HTML.
# Storage path and bucket name are NEVER returned.
return {"signed_url": signed["signedURL"], "chapter_id": chapter_id, "cached": False}
```

Response:
```json
{
  "signed_url": "https://[project].supabase.co/storage/v1/object/sign/...",
  "chapter_id": "uuid",
  "cached": false
}
```

**Security rules (unchanged from v1):**
- `storage_path` is NEVER returned
- Bucket name is NEVER returned
- Access check (is_published + auth) happens before URL generation
- Log storage_path only at DEBUG level in production

#### `POST /api/notes/progress` [AUTH]
Update reading progress for a chapter.

Request:
```json
{ "chapter_id": "uuid", "status": "done", "time_spent_s": 1234 }
```

Process: UPSERT into `user_progress`. Increment leaderboard points if status = "done" and was previously not "done".

Response: `{ "ok": true }`

---

### BOOKMARKS ROUTER (`/api/bookmarks`)

#### `GET /api/bookmarks` [AUTH]
Returns all bookmarks for the current user, grouped by chapter.

Query params: `?chapter_id={uuid}` (optional — filter by chapter)

Response:
```json
{
  "bookmarks": [
    {
      "id": "uuid",
      "chapter_id": "uuid",
      "chapter_title": "SQL",
      "subject_slug": "dbms",
      "section_id": "join-types-01",
      "section_title": "Types of JOINs",
      "anchor_slug": "join-types-01",
      "created_at": "..."
    }
  ]
}
```

#### `POST /api/bookmarks` [AUTH]
Create a bookmark. UPSERT on (user_id, chapter_id, section_id).
Response: `{ "id": "uuid", "created": true }`

#### `DELETE /api/bookmarks/{bookmark_id}` [AUTH]
Delete bookmark. Verify ownership before deletion.
Response: `{ "deleted": true }`

---

### DOUBTS ROUTER (`/api/doubts`)

#### `POST /api/doubts` [AUTH]
Create a doubt (Cite & Ask) and generate AI answer.

Request:
```json
{
  "chapter_id": "uuid",
  "selected_text": "The text the user selected from the notes",
  "question": "What does BCNF mean exactly?"
}
```

Process: Fetch chapter + subject context → call Anthropic API server-side → save to DB → return.

Response:
```json
{
  "id": "uuid",
  "answer": "BCNF (Boyce-Codd Normal Form) requires that...",
  "created_at": "..."
}
```

#### `GET /api/doubts` [AUTH]
Returns all doubts for current user.
Query: `?chapter_id={uuid}` (optional filter)

---

### QUIZ ROUTER (`/api/quiz`) — ✦ UPDATED v2

#### `GET /api/quiz/questions` [AUTH]
Fetch questions for a quiz session.

Query params:
- `subject_ids`: comma-separated subject UUIDs (optional)
- `year`: integer (optional)
- `type`: MCQ | NAT | MSQ (optional)
- `difficulty`: easy | medium | hard (optional)
- `count`: int (default 20, max 65)
- `mode`: pyq | mock | custom | shadow

For `mode=mock`: return exactly 65 questions, GATE distribution (GA + CS).
For `mode=shadow`: requires `source_session_id` — return only wrong question IDs from that session.

**On session creation, initialize Redis hash immediately:**
```python
redis = await get_redis()
session_key = f"quiz_session:{session_id}"
await redis.hset(session_key, mapping={
    "answers": "{}",
    "flags": "[]",
    "started_at": datetime.utcnow().isoformat(),
})
await redis.expire(session_key, settings.QUIZ_REDIS_TTL_S)
```

Response:
```json
{
  "session_id": "uuid",
  "questions": [
    {
      "id": "uuid",
      "type": "MCQ",
      "marks": 2,
      "stem": "Which of the following...",
      "options": [{"key": "A", "text": "..."}],
      "subject": "DBMS"
    }
  ],
  "server_deadline": "2026-04-01T15:00:00Z"
}
```

**Note: `correct` field is NEVER returned in this endpoint.**

#### `POST /api/quiz/save` [AUTH] — ✦ UPDATED v2 (Redis-backed)
Sync ephemeral quiz state. Called every 30s from frontend.

Request:
```json
{
  "session_id": "uuid",
  "answers": { "question_uuid": "A", "question_uuid2": "B" },
  "flags": ["question_uuid3"]
}
```

**Process (Redis-first, zero PostgreSQL writes):**
```python
# Step 1: Verify session ownership (checked against PostgreSQL once on first save,
#         then cached in Redis for subsequent calls to avoid repeated DB hits)
redis = await get_redis()
owner_key = f"quiz_owner:{session_id}"
cached_owner = await redis.get(owner_key)

if not cached_owner:
    session = supabase.table("quiz_sessions")\
        .select("user_id, status")\
        .eq("id", session_id).single().execute()
    if not session.data:
        raise ExamForgeError(404, "Session not found")
    if session.data["user_id"] != current_user["profile_id"]:
        raise ExamForgeError(403, "Session ownership mismatch")
    if session.data["status"] == "submitted":
        raise ExamForgeError(409, "Session already submitted")
    await redis.setex(owner_key, settings.QUIZ_REDIS_TTL_S, current_user["profile_id"])
else:
    if cached_owner != current_user["profile_id"]:
        raise ExamForgeError(403, "Session ownership mismatch")

# Step 2: CRITICAL — write to Redis ONLY. Never PostgreSQL here.
# High-frequency writes (every 30s × 65 questions × N users) MUST NOT hit the DB.
session_key = f"quiz_session:{session_id}"
await redis.hset(session_key, mapping={
    "answers": json.dumps(answers),
    "flags": json.dumps(flags),
    "last_saved": datetime.utcnow().isoformat(),
})
await redis.expire(session_key, settings.QUIZ_REDIS_TTL_S)

# Step 3: Background task flushes to PostgreSQL periodically (see below)
# The flush happens on submit (guaranteed) and optionally on a cron/timer.
```

Response: `{ "ok": true, "saved_at": "timestamp" }`

#### `POST /api/quiz/submit` [AUTH]
Submit quiz, calculate score, flush Redis state to PostgreSQL, return results.

Request: `{ "session_id": "uuid" }`

**Process:**
```python
# Step 1: Flush Redis state to PostgreSQL (guaranteed flush on submit)
redis = await get_redis()
session_key = f"quiz_session:{session_id}"
redis_state = await redis.hgetall(session_key)

if redis_state:
    answers = json.loads(redis_state.get("answers", "{}"))
    flags = json.loads(redis_state.get("flags", "[]"))
    # Flush to PostgreSQL
    supabase.table("quiz_sessions").update({
        "answers": answers,
        "flags": flags,
    }).eq("id", session_id).execute()

# Step 2: Fetch session + questions + correct answers from DB
# Step 3: Calculate score using GATE negative marking rules
# Step 4: Update session: status="submitted", score, submitted_at
# Step 5: Update user_progress for each chapter involved
# Step 6: Update leaderboard points
# Step 7: Clean up Redis keys
await redis.delete(session_key, f"quiz_owner:{session_id}")

# Step 8: Return full results with correct answers + explanations
```

Response: Full results with per-question breakdown, subject analysis, TPQ data.

#### `GET /api/quiz/active` [AUTH]
Check if user has an active (non-submitted) quiz session.
First check Redis for session keys, fall back to PostgreSQL.

Response:
```json
{
  "has_active": true,
  "session": {
    "id": "uuid",
    "type": "mock",
    "question_count": 65,
    "answered_count": 23,
    "started_at": "...",
    "server_deadline": "..."
  }
}
```

---

### FLASHCARDS ROUTER (`/api/flashcards`)

#### `GET /api/flashcards/due` [AUTH]
Returns flashcards due for review today (SM-2 algorithm).
Query: `?subject_id={uuid}` (optional)

#### `POST /api/flashcards/review` [AUTH]
Submit a flashcard review response. SM-2 update runs server-side only.

```python
def sm2_update(ease_factor: float, interval: int, quality: int) -> tuple[float, int, date]:
    if quality < 3:
        return max(1.3, ease_factor - 0.2), 1, date.today() + timedelta(days=1)
    new_ef = ease_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    new_ef = max(1.3, new_ef)
    if interval == 1:
        new_interval = 6
    elif interval == 6:
        new_interval = round(interval * new_ef)
    else:
        new_interval = round(interval * new_ef)
    next_review = date.today() + timedelta(days=new_interval)
    return new_ef, new_interval, next_review
```

---

### JUDGE ROUTER (`/api/judge`)

#### `POST /api/judge/submit` [AUTH][PRO]
Submit code for execution via Judge0.

Request:
```json
{
  "language_id": 54,
  "source_code": "...",
  "stdin": ""
}
```

**Rate limiting via Redis (replaces DB counters for performance):**
```python
redis = await get_redis()
hour_key = f"judge_runs:{current_user['profile_id']}:{datetime.utcnow().strftime('%Y%m%d%H')}"
runs_this_hour = await redis.incr(hour_key)
if runs_this_hour == 1:
    await redis.expire(hour_key, 3600)  # TTL = 1 hour
if runs_this_hour > settings.JUDGE0_MAX_RUNS_PER_USER_PER_HOUR:
    await redis.decr(hour_key)  # undo the increment
    raise ExamForgeError(429, f"Rate limit: 20 runs/hour. Resets at the top of the hour.")
```

Judge0 status map:
```python
STATUS_MAP = {
    1: "In Queue", 2: "Processing", 3: "Accepted",
    4: "Wrong Answer", 5: "Time Limit Exceeded",
    6: "Compilation Error", 7: "Runtime Error (SIGSEGV)",
    8: "Runtime Error (SIGFPE)", 9: "Runtime Error (SIGABRT)",
    10: "Runtime Error (NZEC)", 11: "Runtime Error (Other)",
    12: "Internal Error", 13: "Exec Format Error"
}
```

Response:
```json
{
  "status": "Accepted",
  "stdout": "Hello World\n",
  "stderr": "",
  "compile_output": "",
  "time": "0.003",
  "memory": 1024,
  "runs_remaining": 17
}
```

---

### LEADERBOARD ROUTER (`/api/leaderboard`)

#### `GET /api/leaderboard` [AUTH]
Query params: `?scope=weekly|all_time|college&page=1&limit=50`

For `scope=college`: filter by `profiles.college` matching current user's college.

---

### PROFILE ROUTER (`/api/profile`)

#### `GET /api/profile/me` [AUTH]
Returns full profile with computed stats.

#### `PATCH /api/profile/me` [AUTH]
Update profile fields.

#### `POST /api/profile/avatar` [AUTH]
Upload avatar image. Accepts multipart/form-data.
Process: Validate (max 2MB, only jpg/png/webp) → upload → update URL.

#### `DELETE /api/profile/avatar` [AUTH]
Remove avatar. Response: `{ "ok": true }`

---

### EXPORT ROUTER (`/api/export`)

#### `GET /api/export/data` [AUTH]
Generate and return a JSON export of all user data.
Set `Content-Disposition: attachment; filename="examforge-export-{date}.json"`

---

### STUDY SESSION ROUTER (`/api/study`)

#### `POST /api/study/start` [AUTH]
Record start of a study session.
Request: `{ "chapter_id": "uuid" }`
Response: `{ "session_id": "uuid" }`

#### `POST /api/study/end` [AUTH]
Record end of study session.
Request: `{ "session_id": "uuid" }`
Response: `{ "duration_s": 1234, "ok": true }`

---

## ❼ MAIN APP FACTORY

```python
# main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.core.firebase import init_firebase
from app.core.redis import get_redis, close_redis
from app.core.errors import ExamForgeError, examforge_error_handler
from app.routers import (
    auth, notes, subjects, chapters, bookmarks,
    doubts, quiz, flashcards, judge, leaderboard, profile, export_router
)

def create_app() -> FastAPI:
    init_firebase()

    app = FastAPI(
        title="ExamForge API",
        version="2.0.0",
        docs_url="/docs" if settings.DEBUG else None,
        redoc_url=None,
    )

    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.ALLOWED_ORIGINS,
        allow_credentials=True,
        allow_methods=["GET", "POST", "PATCH", "DELETE"],
        allow_headers=["Authorization", "Content-Type"],
    )

    app.add_exception_handler(ExamForgeError, examforge_error_handler)

    @app.on_event("startup")
    async def startup():
        await get_redis()

    @app.on_event("shutdown")
    async def shutdown():
        await close_redis()

    app.include_router(auth.router,          prefix="/api/auth",        tags=["auth"])
    app.include_router(subjects.router,      prefix="/api/subjects",    tags=["subjects"])
    app.include_router(chapters.router,      prefix="/api/chapters",    tags=["chapters"])
    app.include_router(notes.router,         prefix="/api/notes",       tags=["notes"])
    app.include_router(bookmarks.router,     prefix="/api/bookmarks",   tags=["bookmarks"])
    app.include_router(doubts.router,        prefix="/api/doubts",      tags=["doubts"])
    app.include_router(quiz.router,          prefix="/api/quiz",        tags=["quiz"])
    app.include_router(flashcards.router,    prefix="/api/flashcards",  tags=["flashcards"])
    app.include_router(judge.router,         prefix="/api/judge",       tags=["judge"])
    app.include_router(leaderboard.router,   prefix="/api/leaderboard", tags=["leaderboard"])
    app.include_router(profile.router,       prefix="/api/profile",     tags=["profile"])
    app.include_router(export_router.router, prefix="/api/export",      tags=["export"])

    @app.get("/health")
    async def health():
        redis = await get_redis()
        redis_ok = await redis.ping()
        return {"status": "ok", "env": settings.APP_ENV, "redis": redis_ok}

    return app

app = create_app()
```

---

## ❽ SUPABASE ROW LEVEL SECURITY (RLS)

Enable RLS on all user-data tables. Backend uses service role key (bypasses RLS).
These policies protect direct Supabase client access.

```sql
ALTER TABLE profiles              ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress         ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookmarks             ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_notes            ENABLE ROW LEVEL SECURITY;
ALTER TABLE doubts                ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_flashcard_state  ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_sessions         ENABLE ROW LEVEL SECURITY;
ALTER TABLE study_sessions        ENABLE ROW LEVEL SECURITY;
ALTER TABLE leaderboard_scores    ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users see own profile"
  ON profiles FOR ALL USING (firebase_uid = auth.uid()::text);

CREATE POLICY "Users see own progress"
  ON user_progress FOR ALL
  USING (user_id = (SELECT id FROM profiles WHERE firebase_uid = auth.uid()::text));

-- (Replicate same pattern for all user-data tables)

CREATE POLICY "Questions public read"
  ON questions FOR SELECT USING (true);

CREATE POLICY "Published subjects public"
  ON subjects FOR SELECT USING (is_published = true);

CREATE POLICY "Published chapters public"
  ON chapters FOR SELECT USING (is_published = true);

-- Storage bucket: notes-content — no public access (service key only)
-- avatars bucket — public read, auth write
```

---

## ❾ NORMALIZED DATABASE SCHEMA — ✦ UPDATED v2

The v2 patch normalizes `questions.tags` from a flat TEXT[] into a proper
junction table for analytics scalability, and adds NUMERIC(10,2) precision
for NAT answer ranges.

```sql
-- Questions (PYQ Bank) — normalized schema
CREATE TABLE questions (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  subject_id      UUID REFERENCES subjects(id) ON DELETE CASCADE,
  chapter_id      UUID REFERENCES chapters(id) ON DELETE CASCADE,
  topic_id        UUID REFERENCES topics(id) ON DELETE SET NULL,
  exam_slug       TEXT REFERENCES exam_configs(slug),
  is_pyq          BOOLEAN DEFAULT false,
  gate_year       INT,
  set_code        TEXT,
  type            TEXT NOT NULL CHECK (type IN ('MCQ', 'NAT', 'MSQ')),
  difficulty      TEXT NOT NULL CHECK (difficulty IN ('easy', 'medium', 'hard')),
  marks           NUMERIC NOT NULL,
  question_text   TEXT NOT NULL,
  option_a        TEXT,
  option_b        TEXT,
  option_c        TEXT,
  option_d        TEXT,
  correct_option  TEXT CHECK (correct_option IN ('A','B','C','D')),
  correct_options TEXT[],
  nat_answer_min  NUMERIC(10,2),  -- Strict precision for GATE NAT ranges
  nat_answer_max  NUMERIC(10,2),  -- Strict precision for GATE NAT ranges
  nat_unit        TEXT,
  explanation     TEXT
);

-- Tags (scalable normalized analytics, replaces TEXT[] array on questions)
CREATE TABLE tags (
  id   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL
);

-- Question Tags Junction (many-to-many)
CREATE TABLE question_tags (
  question_id UUID REFERENCES questions(id) ON DELETE CASCADE,
  tag_id      UUID REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (question_id, tag_id)
);

-- Recommended indexes for tag-filtered queries
CREATE INDEX idx_question_tags_question ON question_tags(question_id);
CREATE INDEX idx_question_tags_tag ON question_tags(tag_id);
CREATE INDEX idx_questions_subject_year ON questions(subject_id, gate_year);
CREATE INDEX idx_questions_type_difficulty ON questions(type, difficulty);
```

**Migration note:** If you already have questions with a `tags TEXT[]` column,
migrate using:
```sql
-- 1. Insert unique tags
INSERT INTO tags (slug, name)
SELECT DISTINCT LOWER(REGEXP_REPLACE(tag, '\s+', '-', 'g')), tag
FROM questions, UNNEST(tags) AS tag
ON CONFLICT (slug) DO NOTHING;

-- 2. Create junction rows
INSERT INTO question_tags (question_id, tag_id)
SELECT q.id, t.id
FROM questions q, UNNEST(q.tags) AS tag_text
JOIN tags t ON t.name = tag_text
ON CONFLICT DO NOTHING;

-- 3. Drop old column
ALTER TABLE questions DROP COLUMN tags;
```

---

## ❿ LEADERBOARD POINTS SYSTEM

```python
# app/services/leaderboard_service.py

POINTS = {
    "chapter_completed":    50,
    "quiz_correct":         5,
    "mock_completed":       100,
    "flashcard_known":      3,
    "streak_bonus_per_day": 2,
}

async def add_points(user_id: str, reason: str, amount: int, supabase):
    """Atomic increment of total_points and weekly_points via Supabase RPC."""
    await supabase.rpc("increment_leaderboard_points", {
        "p_user_id": user_id,
        "p_points": amount
    }).execute()
```

Supabase RPC function:
```sql
CREATE OR REPLACE FUNCTION increment_leaderboard_points(p_user_id UUID, p_points INT)
RETURNS VOID AS $$
BEGIN
  INSERT INTO leaderboard_scores (user_id, total_points, weekly_points)
  VALUES (p_user_id, p_points, p_points)
  ON CONFLICT (user_id) DO UPDATE
    SET total_points  = leaderboard_scores.total_points + p_points,
        weekly_points = leaderboard_scores.weekly_points + p_points,
        updated_at    = now();
END;
$$ LANGUAGE plpgsql;
```

Weekly reset — Supabase cron (every Monday 00:00 IST):
```sql
UPDATE leaderboard_scores SET weekly_points = 0, updated_at = now();
```

---

## ⓫ AI DOUBT ANSWERING

```python
# app/services/doubt_service.py
import anthropic

async def generate_doubt_answer(
    chapter_title: str,
    subject_name: str,
    selected_text: str,
    question: str,
    api_key: str
) -> str:
    client = anthropic.Anthropic(api_key=api_key)

    message = client.messages.create(
        model="claude-sonnet-4-20250514",
        max_tokens=1000,
        messages=[{
            "role": "user",
            "content": f"""You are an expert GATE CSE tutor. A student is reading notes on {subject_name} ({chapter_title}) and has a doubt.

Selected text from their notes:
---
{selected_text}
---

Student's question: {question}

Instructions:
- Answer concisely and precisely (max 300 words)
- Use LaTeX math notation where appropriate: inline $..$ and block $$..$$
- Relate the answer to GATE exam context where relevant
- If the question has a common GATE trap, point it out
- Do not repeat the question back
"""
        }]
    )

    return message.content[0].text
```

---

## ⓬ DOCKERFILE

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["gunicorn", "main:app", \
     "--worker-class", "uvicorn.workers.UvicornWorker", \
     "--workers", "2", \
     "--bind", "0.0.0.0:8000", \
     "--timeout", "60", \
     "--access-logfile", "-"]
```

---

## ⓭ REQUIREMENTS.TXT

```
fastapi==0.110.0
uvicorn[standard]==0.27.1
gunicorn==21.2.0
pydantic==2.6.4
pydantic-settings==2.2.1
firebase-admin==6.4.0
supabase==2.4.3
httpx==0.27.0
anthropic==0.21.3
python-dotenv==1.0.1
slowapi==0.1.9
structlog==24.1.0
python-multipart==0.0.9
alembic==1.13.1
asyncpg==0.29.0
redis[asyncio]==5.0.3
upstash-redis==1.0.0
ruff==0.3.4
mypy==1.9.0
pytest==8.1.1
pytest-asyncio==0.23.6
```

---

## ⓮ BUILD ORDER

```
1.  config.py + .env.example         — settings, env vars, Redis config
2.  errors.py                         — custom exception + handler
3.  firebase.py                       — Firebase Admin init + verify_token
4.  supabase.py                       — Supabase service-key client init
5.  redis.py                          — Upstash Redis async client
6.  dependencies.py                   — get_current_user, require_pro, require_admin
7.  models/ (all Pydantic)            — types before services
8.  leaderboard_service.py            — needed by all other services
9.  auth_service.py
10. notes_service.py                  — CDN-direct signed URL flow + Redis cache
11. bookmark_service.py
12. doubt_service.py                  — Anthropic integration
13. quiz_service.py                   — Redis hot state + flush on submit
14. flashcard_service.py              — SM-2 server-side
15. judge_service.py                  — Judge0 + Redis rate limit counters
16. progress_service.py
17. export_service.py
18. All routers
19. main.py                           — app factory with Redis lifecycle
20. Dockerfile + requirements.txt
21. Alembic migration from schema.sql
22. seed.sql                          — subjects + chapters
23. Supabase RLS policies
24. Supabase RPC functions (increment_leaderboard_points, get_question_counts, get_question_meta)
25. Tag migration (if upgrading from TEXT[] schema)
```

---

## ⓯ CRITICAL RULES — NEVER VIOLATE

```
1.  NEVER call Firebase verify_token in route handlers — always use get_current_user dependency
2.  NEVER return storage_path, bucket name in any API response
3.  NEVER construct storage paths client-side — always derive from notes table
4.  NEVER check roles in route handlers — use require_pro/require_admin dependencies
5.  NEVER use string concatenation in SQL — always parameterized via supabase-py or asyncpg
6.  NEVER store API keys in code — always from settings
7.  NEVER let Judge0 calls happen from frontend — only from /api/judge/submit
8.  NEVER write quiz_sessions to PostgreSQL on every /api/quiz/save call —
    Redis absorbs the high-frequency writes; Postgres gets the final flush only
9.  NEVER respond to failed auth with 200 OK — use 401 consistently
10. NEVER silently swallow exceptions — log at ERROR level + return 500 with safe message
11. ALWAYS verify bookmark ownership before deletion
12. ALWAYS verify quiz session ownership (cache in Redis to avoid repeated DB hits)
13. ALWAYS use UPSERT for user_progress and user_notes to avoid race conditions
14. ALWAYS encode/decode base64 for Judge0 on the backend
15. The SM-2 algorithm runs server-side only — never trust client-submitted ease_factor
16. ALWAYS cache signed URLs in Redis with TTL < expiry (prevents Supabase Storage overload)
17. ALWAYS clean up Redis keys after quiz submit (session + owner keys)
18. The signed URL is returned to the client — the client fetches HTML from CDN directly.
    This is safe because: (a) auth check happened on the backend, (b) URL expires in 1h,
    (c) it grants read-only access to a single HTML file only
```

---

*ExamForge Backend Build Prompt v2.0 — FastAPI + Firebase + Supabase + Redis*
*Patch v2: CDN-direct notes delivery · Redis quiz hot state · Normalized tag schema*
*Authored for Aryan's ExamForge platform — April 2026.*
