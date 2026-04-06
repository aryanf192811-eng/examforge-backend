# ══════════════════════════════════════════════════════════════════════════════
# EXAMFORGE — EXECUTION GUIDE
# Your personal step-by-step build guide · Read top to bottom · Never skip steps
# Written for: Aryan · April 2026
# ══════════════════════════════════════════════════════════════════════════════

---

## BEFORE YOU START — READ THIS ONCE

You have 4 artifacts already created:

| What | File | Status |
|---|---|---|
| Backend spec | `examforge-backend-prompt-v2.md` | ✅ Ready |
| Frontend spec | `examforge-frontend-prompt-v5.md` | ✅ Ready |
| PYQ seed spec | `examforge-pyq-universal-prompt-v2.md` | ✅ Ready |
| Master binding | `examforge-master-binding-prompt-v1.md` | ✅ Ready |
| SQL seed files | `examforge-backend/db/seeds/` (126 files) | ✅ Done |
| Notes HTML files | `Gate Cse notes/` (25 files) | ✅ Done |
| **Backend code** | `examforge-backend/` | ❌ Not built yet |
| **Frontend code** | `examforge/` | ❌ Not built yet |

The build order is fixed. Do not jump ahead.

```
PHASE 1 → Build Backend
PHASE 2 → Extract API Contract
PHASE 3 → Build Frontend
PHASE 4 → Deploy & Connect Everything
PHASE 5 → Bind Notes + Seeds to Live DB
```

Keep all 4 prompt files in one folder on your desktop. You will paste from them.
Never modify the prompt files — they are your source of truth.

---

---

# PHASE 1 — BUILD THE BACKEND

## What you are building
A FastAPI Python server that:
- Authenticates users via Firebase
- Serves questions, notes, flashcards from Supabase
- Generates signed URLs for notes HTML files
- Handles quiz state via Redis
- Runs code via **Piston API** (free, no key needed — replaces Judge0)
- Answers doubts via **Gemini 1.5 Flash** (free — replaces Anthropic)

## Folder it lives in
```
examforge-backend/        ← already exists (has db/seeds/ inside)
```

---

## Step 1.1 — Set up your environment

Create these folders if they don't exist:
```
examforge-backend/
├── app/
│   ├── core/
│   ├── models/
│   ├── services/
│   └── routers/
├── alembic/
│   └── versions/
├── db/
│   └── seeds/    ← your 126 .sql files already here
└── main.py
```

Install Python 3.11+ if you haven't. Then:
```bash
cd examforge-backend
python -m venv venv
source venv/bin/activate       # Windows: venv\Scripts\activate
pip install -r requirements.txt   # you'll generate this in Step 1.2
```

---

## Step 1.2 — Generate the backend code

Open a **fresh Claude session** (claude.ai or Claude Code).

Paste this prompt exactly:

```
═══════════════════════════════════════════════════════════════
EXAMFORGE BACKEND GENERATION
═══════════════════════════════════════════════════════════════

[PASTE THE ENTIRE CONTENTS OF examforge-backend-prompt-v2.md HERE]

═══════════════════════════════════════════════════════════════
PROVIDER OVERRIDES — APPLY THESE BEFORE WRITING ANY CODE:

OVERRIDE 1 — Replace Anthropic with Google Gemini (free):
- Remove: anthropic package, ANTHROPIC_API_KEY from config
- Add: google-generativeai package, GEMINI_API_KEY in config
- In app/services/doubt_service.py use:
    import google.generativeai as genai
    genai.configure(api_key=settings.GEMINI_API_KEY)
    model = genai.GenerativeModel("gemini-1.5-flash")
    response = model.generate_content(prompt)
    return response.text
- Keep the same function signature and response format.
  Only the AI provider changes internally.

OVERRIDE 2 — Replace Judge0 with Piston API (free, no key):
- Remove: JUDGE0_API_KEY, JUDGE0_BASE_URL from config entirely
- Remove: all RapidAPI headers
- In app/services/judge_service.py use:
    PISTON_URL = "https://emkc.org/api/v2/piston/execute"
    payload = {
        "language": language,   # e.g. "cpp", "python", "java"
        "version": "*",
        "files": [{"name": "main", "content": source_code}],
        "stdin": stdin,
        "args": []
    }
    response = await httpx.AsyncClient().post(PISTON_URL, json=payload)
    result = response.json()
    return {
        "stdout": result["run"]["stdout"],
        "stderr": result["run"]["stderr"],
        "exit_code": result["run"]["code"]
    }
- Keep the same /api/judge/submit endpoint — only the provider changes.
- No API key needed. No auth headers needed.
- Rate limiting via Redis still applies per user.

OVERRIDE 3 — Use Render instead of Railway for deployment:
- In Dockerfile and README, reference Render as the deploy target.
- Start command: gunicorn main:app --worker-class uvicorn.workers.UvicornWorker
  --workers 2 --bind 0.0.0.0:$PORT --timeout 60 --access-logfile -
  (Note: Render injects $PORT automatically — do not hardcode 8000)

═══════════════════════════════════════════════════════════════
INSTRUCTIONS:
Build the complete backend following the build order in Section ⓮.
Apply all 3 provider overrides above before writing any file.
Generate files one by one in this exact order:

1.  app/core/config.py
2.  app/core/errors.py
3.  app/core/firebase.py
4.  app/core/supabase.py
5.  app/core/redis.py
6.  app/core/dependencies.py
7.  app/models/user.py
8.  app/models/notes.py
9.  app/models/practice.py
10. app/models/doubt.py
11. app/models/bookmark.py
12. app/models/leaderboard.py
13. app/models/judge.py
14. app/services/leaderboard_service.py
15. app/services/auth_service.py
16. app/services/notes_service.py
17. app/services/bookmark_service.py
18. app/services/doubt_service.py      ← uses Gemini (Override 1)
19. app/services/quiz_service.py
20. app/services/flashcard_service.py
21. app/services/judge_service.py      ← uses Piston (Override 2)
22. app/services/progress_service.py
23. app/services/export_service.py
24. app/routers/auth.py
25. app/routers/notes.py
26. app/routers/subjects.py
27. app/routers/chapters.py
28. app/routers/bookmarks.py
29. app/routers/doubts.py
30. app/routers/quiz.py
31. app/routers/flashcards.py
32. app/routers/judge.py
33. app/routers/leaderboard.py
34. app/routers/profile.py
35. app/routers/export.py
36. main.py
37. Dockerfile                         ← uses $PORT (Override 3)
38. requirements.txt                   ← google-generativeai instead of anthropic
39. .env.example                       ← GEMINI_API_KEY instead of ANTHROPIC_API_KEY

Output each file with its full path as a header.
Do NOT skip any file. Do NOT summarize. Output complete code only.
═══════════════════════════════════════════════════════════════
```

> **Note:** Claude may hit its output limit before finishing all 39 files.
> When it stops, continue with: `"Continue from where you stopped. Next file: [last file it was on]"`

---

## Step 1.3 — Create your .env file

Copy `.env.example` to `.env` and fill in every value:

```bash
cp .env.example .env
```

You need these credentials. All of them are **free** — no credit card required anywhere.

| Variable | Free source | How to get it |
|---|---|---|
| `FIREBASE_CREDENTIALS_JSON` | Firebase Console | Project Settings → Service Accounts → Generate new private key → download JSON |
| `SUPABASE_URL` | Supabase free tier | Dashboard → Project Settings → API → Project URL |
| `SUPABASE_SERVICE_KEY` | Supabase free tier | Dashboard → Project Settings → API → service_role key |
| `REDIS_URL` | Upstash free tier | upstash.com → Create Database → Connect → .env tab |
| `GEMINI_API_KEY` | Google AI Studio | aistudio.google.com → Get API Key → free, 1500 req/day |

> ⚠️ No `ANTHROPIC_API_KEY`. No `JUDGE0_API_KEY`. Both have been replaced with free alternatives.
> Piston API (code execution) needs no key at all — it's just an HTTP call.

---

## Step 1.4 — Run the schema migration

This creates all your database tables in Supabase.

In Supabase Dashboard → SQL Editor, run the schema from the backend prompt
(Section ❾ of `examforge-backend-prompt-v2.md`).

Then run the RPC functions and RLS policies from the same section.

Verify in Supabase → Table Editor that these tables exist:
```
branches · exam_configs · subjects · chapters · topics
questions · tags · question_tags · flashcards · notes
bookmarks · user_progress · user_notes · doubt_sessions
quiz_sessions · leaderboard_scores
```

---

## Step 1.5 — Test the backend locally

```bash
cd examforge-backend
uvicorn main:app --reload --port 8000
```

Open `http://localhost:8000/docs` — you should see the Swagger UI with all endpoints.

Quick smoke tests:
```bash
# Health check
curl http://localhost:8000/health
# → {"status": "ok"}

# Subjects (empty for now — seeds not run yet, that's Phase 5)
curl http://localhost:8000/api/subjects
# → {"subjects": []}  or 401 if auth required — both are fine
```

If it starts without errors, Phase 1 is done. ✅

---

---

# PHASE 2 — EXTRACT THE API CONTRACT

## Why this step exists

The frontend must know exactly what the backend returns.
If you skip this, you'll spend hours debugging mismatched field names.
This step takes 10 minutes and saves 10 hours.

---

## Step 2.1 — Generate the API contract file

Open a **new Claude session**. Paste this:

```
═══════════════════════════════════════════════════════════════
EXAMFORGE — API CONTRACT EXTRACTION
═══════════════════════════════════════════════════════════════

I have a FastAPI backend for ExamForge. Below are all the Pydantic
response models from my backend. Extract and output a single
TypeScript file called `api-contract.ts` that defines:

1. A typed interface for every API response
2. A typed interface for every API request body
3. A const object `API_ENDPOINTS` mapping every endpoint name
   to its path string

[PASTE YOUR app/models/*.py FILES HERE — all 7 of them]

Output only the TypeScript file. No explanation. No markdown fences.
Start with: // ExamForge API Contract — Auto-generated from backend models
═══════════════════════════════════════════════════════════════
```

Save the output as `examforge-api-contract.ts` in your project root.

---

## Step 2.2 — Verify the contract has these key types

Scan the output and confirm these interfaces exist (they're needed by frontend):

```
SubjectResponse         → slug, name, icon, is_published, exam_weight_pct
ChapterResponse         → id, title, slug, order_index, gate_weightage
TopicResponse           → id, name, slug
QuestionResponse        → id, type, difficulty, marks, question_text,
                          option_a/b/c/d, correct_option, correct_options,
                          nat_answer_min, nat_answer_max, explanation, tags
FlashcardResponse       → id, front, back, topic_id, sm2 fields
NoteUrlResponse         → signed_url (ONLY this — no storage_path)
LeaderboardResponse     → user entries with points + rank
QuizSessionResponse     → session_id, questions[], current_index, time_left
UserProgressResponse    → subject-level completion percentages
```

If any are missing, prompt: `"Add the missing interface for [name] based on the backend models"`

---

---

# PHASE 3 — BUILD THE FRONTEND

## What you are building
A React + Vite + Tailwind frontend with:
- Tokyo Night (dark) + Sakura Pastel (light) dual theme
- Notes viewer (paper aesthetic, KaTeX math)
- PYQ practice hub (5 tabs, virtual calculator, timer)
- SM-2 flashcard system
- Dashboard with 10 progress metrics
- Offline PWA support

## Folder it lives in
```
examforge/        ← separate from examforge-backend/
```

---

## Step 3.1 — Scaffold the project

```bash
npm create vite@latest examforge -- --template react-ts
cd examforge
npm install
```

Then install all dependencies from the frontend prompt tech stack (Section ❷):
```bash
npm install tailwindcss @tailwindcss/vite zustand framer-motion recharts \
  lucide-react firebase @supabase/supabase-js dompurify @types/dompurify \
  @monaco-editor/react @codesandbox/sandpack-react react-draggable \
  vite-plugin-pwa katex
```

---

## Step 3.2 — Generate the frontend code

Open a **fresh Claude session**. Paste this prompt:

```
═══════════════════════════════════════════════════════════════
EXAMFORGE FRONTEND GENERATION
═══════════════════════════════════════════════════════════════

[PASTE THE ENTIRE CONTENTS OF examforge-frontend-prompt-v5.md HERE]

═══════════════════════════════════════════════════════════════
ADDITIONAL CONTEXT — API CONTRACT:
The backend is already built. Here is the full API contract:

[PASTE THE ENTIRE CONTENTS OF examforge-api-contract.ts HERE]

Backend base URL: http://localhost:8000
All API calls go to /api/* endpoints.
Firebase auth token is sent as: Authorization: Bearer {idToken}

═══════════════════════════════════════════════════════════════
INSTRUCTIONS:
Build the complete frontend following the build order in Section ⓯.
Generate files in this exact order:

1.  index.css                    (all CSS vars, dark + light themes)
2.  tailwind.config.js
3.  src/types/index.ts
4.  src/lib/dompurify-config.ts  ← CRITICAL: build before NotesViewer
5.  src/lib/firebase.ts
6.  src/lib/supabase.ts
7.  src/lib/store/authStore.ts
8.  src/lib/store/notesStore.ts
9.  src/lib/store/themeStore.ts
10. src/lib/store/quizStore.ts
11. src/lib/api.ts
12. src/lib/sm2.ts
13. src/lib/utils.ts
14. src/hooks/usePlatformSecurity.ts  (debugger trap, NOT dimension poll)
15. src/hooks/useBookmarks.ts
16. src/hooks/useUserNotes.ts
17. src/hooks/useProgress.ts
18. src/hooks/useTheme.ts
19. src/App.tsx
20. All UI primitives (Button, Input, Badge, Modal, Toast, Skeleton)
21. Layout components (Sidebar, TopBar, BottomTabBar, Breadcrumb)
22. src/pages/Landing.tsx
23. src/pages/Login.tsx
24. src/pages/Signup.tsx
25. src/pages/Dashboard.tsx
26. src/components/notes/NotesViewer.tsx  (CDN-direct fetch flow)
27. All other note components (FocusModeWrapper, ActiveRecallBlock, etc.)
28. src/pages/Notes.tsx
29. src/pages/Practice.tsx
30. src/pages/Skills.tsx
31. src/pages/Leaderboard.tsx
32. src/pages/Profile.tsx
33. src/pages/Settings.tsx
34. src/components/global/CommandPalette.tsx
35. vite.config.ts                (with PWA plugin)
36. index.html                    (theme flash fix script BEFORE React mounts)

Output each file with its full path as a header.
Do NOT skip. Do NOT summarize. Complete code only.
═══════════════════════════════════════════════════════════════
```

> **Note:** This is the largest generation. Claude will definitely hit output limits.
> Continue with: `"Continue from where you stopped. Next file: [file name]"`
> Keep a checklist of which files are done.

---

## Step 3.3 — Critical things to verify in the generated code

After generation, manually check these before running:

**In `index.html`** — must have this BEFORE the React script tag:
```html
<script>
  (function() {
    const theme = localStorage.getItem('ef_theme') || 'dark';
    document.documentElement.setAttribute('data-theme', theme);
  })();
</script>
```
If missing, add it manually. Without this, there's a light flash on every reload.

**In `src/lib/dompurify-config.ts`** — must export `DOMPURIFY_KATEX_CONFIG`.
If DOMPurify is called anywhere without this config, all math equations will break.

**In `src/components/notes/NotesViewer.tsx`** — notes must be fetched via:
```
GET /api/notes/{chapter_id}/url  → returns { signed_url }
→ fetch(signed_url) directly from frontend
→ sanitize with DOMPURIFY_KATEX_CONFIG
→ inject into paper div
```
NOT fetched via the backend proxy. CDN-direct is the correct v2 flow.

---

## Step 3.4 — Test the frontend locally

```bash
cd examforge
npm run dev
```

Open `http://localhost:5173`. Check:
- [ ] Page loads in dark theme (Tokyo Night)
- [ ] Theme toggle switches to light (Sakura Pastel)
- [ ] No console errors on load
- [ ] Login page renders correctly
- [ ] No TypeScript errors: `npm run build` completes

If build passes with no errors, Phase 3 is done. ✅

---

---

# PHASE 4 — DEPLOY BOTH SERVICES

Deploy backend first. Frontend needs the live backend URL before its own deploy.

---

## Step 4.1 — Deploy the backend

**Recommended: Render** (free tier, no credit card for basic usage)

1. Push your `examforge-backend/` folder to a GitHub repo
2. Go to render.com → New → Web Service
3. Connect your GitHub repo → select `examforge-backend`
4. Fill in:
   - **Build command:** `pip install -r requirements.txt`
   - **Start command:** `gunicorn main:app --worker-class uvicorn.workers.UvicornWorker --workers 2 --bind 0.0.0.0:$PORT --timeout 60 --access-logfile -`
   - **Instance type:** Free
5. Add all your environment variables from `.env` in the Environment tab
6. Click Deploy

> Note: Render free tier spins down after 15 min of inactivity (cold start ~30s).
> This is fine for development and early users. Upgrade later when you have traffic.

After deploy, your backend URL will look like:
```
https://examforge-backend.onrender.com
```

Health check: `curl https://examforge-backend.onrender.com/health` → `{"status": "ok"}`

---

## Step 4.2 — Update frontend with production backend URL

In `examforge/src/lib/api.ts`, update the base URL:
```ts
const BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000';
```

Create `examforge/.env.production`:
```
VITE_API_URL=https://examforge-backend.onrender.com
VITE_FIREBASE_API_KEY=...
VITE_FIREBASE_PROJECT_ID=...
VITE_SUPABASE_URL=...
VITE_SUPABASE_ANON_KEY=...
```

---

## Step 4.3 — Deploy the frontend

**Recommended: Vercel** (simplest for React + Vite)

```bash
npm install -g vercel
cd examforge
vercel
```

Set your environment variables in Vercel dashboard → Project Settings → Environment Variables.

After deploy, note your frontend URL:
```
https://examforge.vercel.app
```

---

## Step 4.4 — Update CORS on backend

In `examforge-backend/app/core/config.py`, your `ALLOWED_ORIGINS` must include
the Vercel URL. Update the environment variable on Render dashboard → Environment:
```
ALLOWED_ORIGINS=["https://examforge.vercel.app","http://localhost:5173"]
```

Render will auto-redeploy after saving environment variable changes.

---

---

# PHASE 5 — BIND EVERYTHING TO THE LIVE DATABASE

This is where the master binding prompt activates. You are now:
- Running seeds against the live Supabase DB
- Uploading notes HTML to Supabase Storage
- Inserting the notes table rows that connect chapters to files

---

## Step 5.1 — Run the SQL seeds

You already have 126 seed files. Run them against your live Supabase DB.

Get your database connection string from:
Supabase Dashboard → Project Settings → Database → Connection string → URI

```bash
export DATABASE_URL="postgresql://postgres:[password]@[host]:5432/postgres"

cd examforge-backend/db/seeds

# Run in this order — base file first, then parts
for subject in algo cd cn coa cprog dbms dl dm dsa em ga os toc; do
  echo "Seeding $subject..."
  psql $DATABASE_URL -f ${subject}-seed.sql
  for part in ${subject}-seed-p*.sql; do
    [ -f "$part" ] && psql $DATABASE_URL -f "$part"
  done
  echo "✅ $subject done"
done
```

> **Note:** `ga` goes up to p10, all others up to p8 (except dbms which is p7).
> The loop handles this automatically via glob.

Verify:
```sql
-- Run in Supabase SQL Editor
SELECT slug, COUNT(q.id) as questions
FROM subjects s
LEFT JOIN questions q ON q.subject_id = s.id
GROUP BY slug ORDER BY slug;
```
Every subject should show 100+ questions.

---

## Step 5.2 — Create the Supabase Storage bucket

In Supabase Dashboard → Storage → New bucket:
- Name: `notes-content`
- Public: **NO** (must be private — backend generates signed URLs)

---

## Step 5.3 — Upload notes HTML files

Run the Python upload script from your `Gate Cse notes/` folder:

```python
# save as upload_notes.py in your project root
from supabase import create_client
import os

SUPABASE_URL = os.environ["SUPABASE_URL"]
SUPABASE_SERVICE_KEY = os.environ["SUPABASE_SERVICE_KEY"]
NOTES_FOLDER = "Gate Cse notes"   # adjust path if needed
BUCKET = "notes-content"

sb = create_client(SUPABASE_URL, SUPABASE_SERVICE_KEY)

UPLOAD_MAP = {
    "algo":  ["algo-01-complexity-sorting-searching.html",
              "algo-02-graph-algorithms.html",
              "algo-03-dp-greedy-divide-conquer.html"],
    "cd":    ["compiler-design-complete.html"],
    "cn":    ["cn-01-datalink-network-routing.html",
              "cn-02-transport-application-1.html"],
    "coa":   ["coa-01-number-systems-boolean-circuits.html",
              "coa-02-cpu-isa-pipeline-memory.html"],
    "cprog": ["c-programming-complete-1.html"],
    "dbms":  ["dbms-gate-notes-v2-1.html",
              "dbms-02-sql-relational-algebra-3.html",
              "dbms-03-transactions-concurrency-1.html",
              "dbms-04-er-indexing-relational-calculus.html"],
    "dm":    ["dm-01-logic-sets-relations-functions-2.html",
              "dm-02-graph-theory-combinatorics.html"],
    "dsa":   ["ds-01-linear-data-structures-2.html",
              "ds-02-trees-heaps.html"],
    "em":    ["em-01-calculus-linear-algebra-probability-2.html",
              "em-02-differential-equations-numerical-methods.html"],
    "ga":    ["aptitude-quantitative-master.html",
              "aptitude-verbal-master.html"],
    "os":    ["os-01-processes-scheduling-synchronization.html",
              "os-02-memory-filesystems-io.html"],
    "toc":   ["toc-01-automata-grammars.html",
              "toc-02-turing-decidability.html"],
}

for subject, files in UPLOAD_MAP.items():
    for filename in files:
        local_path = os.path.join(NOTES_FOLDER, filename)
        storage_path = f"notes/gate/{subject}/{filename}"
        if not os.path.exists(local_path):
            print(f"⚠️  MISSING: {local_path}")
            continue
        with open(local_path, "rb") as f:
            sb.storage.from_(BUCKET).upload(
                storage_path, f,
                file_options={"content-type": "text/html", "upsert": "true"}
            )
        print(f"✅ {storage_path}")

print("\nDone. Verify in Supabase Dashboard → Storage → notes-content")
```

Run it:
```bash
SUPABASE_URL="https://xxx.supabase.co" \
SUPABASE_SERVICE_KEY="your-service-key" \
python upload_notes.py
```

---

## Step 5.4 — Insert notes table rows (the binding SQL)

Open Supabase Dashboard → SQL Editor. Run the binding SQL from
`examforge-master-binding-prompt-v1.md` Section ❷ (Join Point 1).

This is the SQL that connects each chapter to its HTML file via `storage_path`.

After running, verify:
```sql
SELECT COUNT(*) FROM notes;
-- Expected: 25 rows
```

---

## Step 5.5 — Flip subjects live

Run in Supabase SQL Editor:
```sql
UPDATE subjects SET is_published = true WHERE slug IN (
  'algo', 'cd', 'cn', 'coa', 'cprog',
  'dbms', 'dm', 'dsa', 'em', 'ga', 'os', 'toc'
);
-- dl stays false — no notes yet
```

---

## Step 5.6 — Full system verification

Run all 4 verification queries from `examforge-master-binding-prompt-v1.md` Section ❽.

Then do a manual end-to-end test:

```
[ ] Open https://examforge.vercel.app
[ ] Sign up with a new account
[ ] Dashboard loads with empty progress (expected)
[ ] Go to Subjects → DBMS → Chapter 1
[ ] Notes load with paper aesthetic (cream background, Lora font)
[ ] Math equations render (KaTeX working)
[ ] Go to Practice → DBMS → Start Quiz
[ ] Questions load, timer starts, submit works
[ ] Go to Flashcards → DBMS → flip card → SM-2 rating works
[ ] Go to DL → Notes → "Notes not ready yet" toast appears
[ ] Turn off WiFi → reload → cached notes still load
[ ] Cmd+K opens command palette
[ ] Theme toggle switches dark ↔ light
```

If all pass, you're live. ✅

---

---

# WHAT TO DO WHEN YOU GET STUCK

## Claude session hit its output limit mid-generation

```
Continue from where you stopped.
Last file completed: [filename]
Next file needed: [filename]
Do not repeat already-generated files. Output complete code only.
```

## Generated code has a bug or missing piece

```
I am building ExamForge using examforge-backend-prompt-v2.md (or frontend v5).
Here is the file that has a bug:

[paste the file]

The bug is: [describe exactly what's wrong]
Fix only this file. Do not change anything else.
```

## Something doesn't connect between frontend and backend

```
I am building ExamForge. The frontend and backend are not connecting correctly.

Frontend is calling: [endpoint]
Backend returns: [what it actually returns]
Frontend expects: [what it needs]
API contract says: [paste the relevant interface from api-contract.ts]

Fix the mismatch. Show me both the corrected frontend code and backend code.
```

## Starting a new Claude session mid-build

Always paste this at the top:
```
I am building ExamForge — a GATE CSE prep platform.
I have these prompt files: frontend-v5, backend-v2, pyq-v2, master-binding-v1.
Currently at: PHASE [X], Step [X.X]
The backend [is / is not] built yet.
The frontend [is / is not] built yet.
Seeds [are / are not] run.
Notes [are / are not] uploaded.

My current task: [describe it]
Do not reinvent anything. Work within the existing system.
```

---

---

# ZERO-COST STACK — COMPLETE REFERENCE

Every service used in ExamForge is free. No credit card. No trial expiry.

| Service | What it does | Provider | Cost | Free limit |
|---|---|---|---|---|
| Auth | User login, Google OAuth | Firebase Auth | ✅ Free | Unlimited |
| Database | All app data (PostgreSQL) | Supabase | ✅ Free | 500MB, 50MB file |
| Storage | Notes HTML files | Supabase Storage | ✅ Free | 1GB |
| Cache | Quiz hot state, rate limits | Upstash Redis | ✅ Free | 10,000 cmds/day |
| AI Doubts | Doubt answering in notes | Gemini 1.5 Flash | ✅ Free | 1,500 req/day |
| Code Run | Run C++/Python/Java | Piston API | ✅ Free | No hard limit |
| Backend Deploy | Host FastAPI server | Render | ✅ Free | Spins down after 15min idle |
| Frontend Deploy | Host React app | Vercel | ✅ Free | Unlimited |

**Total monthly cost: ₹0**

### Where to sign up (all free, all no credit card)

```
Firebase    → console.firebase.google.com   → Add project
Supabase    → supabase.com                  → New project
Upstash     → upstash.com                   → Create Database → Redis
Gemini Key  → aistudio.google.com           → Get API Key
Render      → render.com                    → New Web Service
Vercel      → vercel.com                    → Import Git Repository
```

### When you outgrow free tiers (much later)

```
Supabase DB full (500MB)   → Upgrade to Pro ($25/mo) or self-host
Render cold starts annoying → Upgrade to Starter ($7/mo) to keep alive
Gemini 1500/day not enough → Switch to Gemini Pro or add rate limiting per user
Upstash 10k cmds/day full  → Upgrade to Pay-as-you-go (fractions of a cent per cmd)
```
You will not hit any of these limits during development or early launch.

---

---

# QUICK REFERENCE

## All your files and where they live

```
Your project root/
├── examforge-backend-prompt-v2.md       ← Paste into backend generation
├── examforge-frontend-prompt-v5.md      ← Paste into frontend generation
├── examforge-pyq-universal-prompt-v2.md ← Reference only (seeds done)
├── examforge-master-binding-prompt-v1.md← Reference for binding SQL
├── examforge-api-contract.ts            ← Generated in Phase 2
├── upload_notes.py                      ← Generated in Phase 5 (above)
│
├── examforge/                           ← Frontend codebase (Phase 3)
│
├── examforge-backend/                   ← Backend codebase (Phase 1)
│   └── db/
│       └── seeds/                       ← Your 126 SQL files ✅
│
└── Gate Cse notes/                      ← Your 25 HTML files ✅
```

## The 5 phases at a glance

| Phase | What | Tool | Time estimate |
|---|---|---|---|
| 1 | Build Backend | Claude session | 2–3 hours generation + setup |
| 2 | Extract API Contract | Claude session | 15 minutes |
| 3 | Build Frontend | Claude session | 3–4 hours generation + setup |
| 4 | Deploy both | Render (backend) + Vercel (frontend) | 1 hour |
| 5 | Bind DB + Storage | Supabase + scripts | 1–2 hours |

## The universal slug table (never change these)

| Subject | Slug |
|---|---|
| Algorithms | `algo` |
| Compiler Design | `cd` |
| Computer Networks | `cn` |
| COA | `coa` |
| C Programming | `cprog` |
| DBMS | `dbms` |
| Digital Logic | `dl` |
| Discrete Math | `dm` |
| DSA | `dsa` |
| Engineering Math | `em` |
| General Aptitude | `ga` |
| Operating Systems | `os` |
| Theory of Computation | `toc` |

These slugs are used in: database rows, storage paths, API responses, frontend routing.
If you ever rename one, you must update all four places simultaneously.

---

*ExamForge Execution Guide v2 · Aryan · April 2026*
*Zero-cost stack: Firebase · Supabase · Upstash · Gemini · Piston · Render · Vercel*
*Phases: Backend → API Contract → Frontend → Deploy → Bind*
