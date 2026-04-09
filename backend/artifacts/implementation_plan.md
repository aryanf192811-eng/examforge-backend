# Remove Redis from Backend Architecture

The goal is to completely eliminate the Redis/Upstash dependency from the backend. This simplifies infrastructure but means we will handle hot paths (like quiz session states) directly against PostgreSQL, and rate-limiting entirely in memory.

## User Review Required

> [!WARNING]
> Moving quiz state directly to Supabase will increase your database write load, as every progress sync (from the frontend's 30s polling) will write to Postgres instead of Redis. This shouldn't be an issue for small scale, but keep it in mind.

> [!WARNING]
> Switching `slowapi` to use `MemoryLimiter` means rate limits are strictly per-instance. If you deploy multiple backend containers (e.g., horizontally scaled on Render/Railway), they will not share rate limit counters.

## Proposed Changes

---

### Quiz Service
Currently, `quiz_service.py` sets hot state in Redis and only flushes it on submission. We will refactor this to write directly to Supabase on every save.

#### [MODIFY] [quiz_service.py](file:///c:/Users/aryan/Desktop/backend%20examforge/app/services/quiz_service.py)
- Remove `get_redis` import and all `redis` logic.
- Change `save_quiz_state` to perform a `supabase.table("quiz_sessions").update(...)` directly instead of a Redis `hset`.
- Change `get_active_session` to read the answers directly from the `quiz_sessions` row instead of falling back to Redis.
- Modify `create_quiz_session` and `submit_quiz` to remove Redis setup and cleanup phases.

---

### Notes Service
Signed URLs are currently cached in Redis based on chapter IDs.

#### [MODIFY] [notes_service.py](file:///c:/Users/aryan/Desktop/backend%20examforge/app/services/notes_service.py)
- Remove `get_redis` import.
- Delete the Redis connection and cache hit checks in `get_note_signed_url`.
- Delete the caching save step. It will now generate a fresh signed URL from Supabase Storage on every valid request.

---

### Code Execution (Judge/Piston) Service
Rate limits are currently applied manually using a Redis hour key. Since we use `slowapi` MemoryLimiter app-wide now, we leave the actual restriction logic to the FastAPI router middleware and delete the manual Redis code in this service.

#### [MODIFY] [judge_service.py](file:///c:/Users/aryan/Desktop/backend%20examforge/app/services/judge_service.py)
- Remove `get_redis` import and the manual counter logic.
- Service is simplified to only resolve aliases, prepare the payload, and submit to Piston.

#### [MODIFY] [judge.py (Router)](file:///c:/Users/aryan/Desktop/backend%20examforge/app/routers/judge.py)
- Add `@limiter.limit` decorator on the `/submit` endpoint using `slowapi`, pointing to the global limiter (configured to the PISTON max runs setting).

---

### Application Core & Environment

#### [DELETE] [redis.py](file:///c:/Users/aryan/Desktop/backend%20examforge/app/core/redis.py)
- Delete the file entirely as the connection manager is no longer needed.

#### [MODIFY] [config.py](file:///c:/Users/aryan/Desktop/backend%20examforge/app/core/config.py)
- Delete all Redis environment variables: `REDIS_URL`, `REDIS_TOKEN`, `QUIZ_REDIS_TTL_S`
- Keep `QUIZ_FLUSH_INTERVAL_S` since frontend logic still polls.

#### [MODIFY] [main.py](file:///c:/Users/aryan/Desktop/backend%20examforge/main.py)
- Remove `get_redis` and `close_redis` from startup/shutdown events.
- Change `/health` endpoint to remove Redis connectivity checks.
- Add and configure `slowapi` utilizing `slowapi.util.get_remote_address` and it's in-memory backend.
- Hook up the `_rate_limit_exceeded_handler` to `SlowApi` exceptions.

#### [MODIFY] [requirements.txt](file:///c:/Users/aryan/Desktop/backend%20examforge/requirements.txt)
- Delete the `redis[asyncio]` dependency.

## Open Questions

None. This plan captures all changes needed to gracefully substitute functionality without the Redis layer.

## Verification Plan

### Manual Verification
1. `GET /health` returns status `ok` without any Redis keys checking.
2. Verify Judge route works (or fails with a rate limit appropriately handled by SlowAPI).
3. Test Quiz endpoints by validating states update appropriately in the `quiz_sessions` database table.
