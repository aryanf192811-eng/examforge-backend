# ══════════════════════════════════════════════════════════════════════════════
# EXAMFORGE — MASTER BINDING PROMPT v2.0
# The Single Source of Truth · Ties All 5 Artifacts Into One Coherent System
# Artifacts: Frontend v6 (Stitch) · Backend v2 (audited) · PYQ Seeds v2 ·
#            Notes HTML Files · Stitch Design System
# Updated: Redis removed · Judge0 removed · Piston · Gemini · html.dark theme
# ══════════════════════════════════════════════════════════════════════════════

---

## PURPOSE OF THIS DOCUMENT

This is the **master orchestration document** for ExamForge.
You are continuing development on an already-partially-built system.

| Artifact | File | Status |
|---|---|---|
| Frontend spec | `examforge-frontend-prompt-v6.md` | ✅ Use this — NOT v5 |
| Backend spec | `examforge-backend-prompt-v2.md` | ✅ With stack overrides applied |
| PYQ seeds spec | `examforge-pyq-universal-prompt-v2.md` | ✅ Seeds generated |
| Master binding | THIS FILE | ✅ v2 — updated stack |
| Stitch design | `stitch_ui_ux_design_project.zip` | ✅ Source of all UI |
| SQL seed files | `examforge-backend/db/seeds/` (126 files) | ✅ Done |
| Notes HTML | `Gate Cse notes/` (25 files) | ✅ Done |
| Backend code | `examforge-backend/` | ⚠️ Built, needs audit |
| Frontend code | `examforge/` | ❌ Rebuild with v6 |

**Confirmed live stack — these are the actual technologies in use:**
```
Auth:            Firebase Authentication
Database:        Supabase PostgreSQL
Storage:         Supabase Storage (bucket: notes-content)
Code Execution:  Piston API — POST https://emkc.org/api/v2/piston/execute
                 NO API KEY NEEDED
AI Doubts:       Gemini 1.5 Flash (google-generativeai, GEMINI_API_KEY)
Backend Deploy:  Render (free, $PORT auto-injected)
Frontend Deploy: Vercel (free)
Theme System:    html.dark class toggle (NOT data-theme attribute)
Icons:           Material Symbols Outlined (Google Font)
Design Source:   Stitch MCP Server — The Academic Atelier

REMOVED:         Redis / Upstash (quiz state → Supabase directly)
REMOVED:         Judge0 (replaced by Piston)
REMOVED:         Anthropic API (replaced by Gemini)
```

Read this entire document before touching any file.

---

## ❶ WHAT HAS ALREADY BEEN BUILT

### 1A — PYQ Seed Files (126 files in `examforge-backend/db/seeds/`)

| Subject | Slug | Seed Files |
|---|---|---|
| Algorithms | `algo` | `algo-seed.sql` + `algo-seed-p1.sql` … `algo-seed-p8.sql` |
| Compiler Design | `cd` | `cd-seed.sql` + `cd-seed-p1.sql` … `cd-seed-p8.sql` |
| Computer Networks | `cn` | `cn-seed.sql` + `cn-seed-p1.sql` … `cn-seed-p8.sql` |
| COA | `coa` | `coa-seed.sql` + `coa-seed-p1.sql` … `coa-seed-p8.sql` |
| C Programming | `cprog` | `cprog-seed.sql` + `cprog-seed-p1.sql` … `cprog-seed-p8.sql` |
| DBMS | `dbms` | `dbms-seed.sql` + `dbms-seed-p1.sql` … `dbms-seed-p7.sql` |
| Digital Logic | `dl` | `dl-seed.sql` + `dl-seed-p1.sql` … `dl-seed-p8.sql` |
| Discrete Mathematics | `dm` | `dm-seed.sql` + `dm-seed-p1.sql` … `dm-seed-p8.sql` |
| DSA | `dsa` | `dsa-seed.sql` + `dsa-seed-p1.sql` … `dsa-seed-p8.sql` |
| Engineering Math | `em` | `em-seed.sql` + `em-seed-p1.sql` … `em-seed-p8.sql` |
| General Aptitude | `ga` | `ga-seed.sql` + `ga-seed-p1.sql` … `ga-seed-p10.sql` |
| Operating Systems | `os` | `os-seed.sql` + `os-seed-p1.sql` … `os-seed-p8.sql` |
| Theory of Computation | `toc` | `toc-seed.sql` + `toc-seed-p1.sql` … `toc-seed-p8.sql` |

All seed files use `ON CONFLICT DO NOTHING` on tags — safe to re-run.
Always run base file first, then parts in order.

---

### 1B — Notes HTML Files (`Gate Cse notes/` folder — 25 files)

| Notes File | Slug | Maps To |
|---|---|---|
| `algo-01-complexity-sorting-searching.html` | `algo` | Chapter 1 |
| `algo-02-graph-algorithms.html` | `algo` | Chapter 2 |
| `algo-03-dp-greedy-divide-conquer.html` | `algo` | Chapter 3 |
| `cn-01-datalink-network-routing.html` | `cn` | Chapter 1 |
| `cn-02-transport-application-1.html` | `cn` | Chapter 2 |
| `coa-01-number-systems-boolean-circuits.html` | `coa` | Chapter 1 |
| `coa-02-cpu-isa-pipeline-memory.html` | `coa` | Chapter 2 |
| `compiler-design-complete.html` | `cd` | All chapters |
| `c-programming-complete-1.html` | `cprog` | All chapters |
| `dbms-gate-notes-v2-1.html` | `dbms` | Chapter 1 |
| `dbms-02-sql-relational-algebra-3.html` | `dbms` | Chapter 2 |
| `dbms-03-transactions-concurrency-1.html` | `dbms` | Chapter 3 |
| `dbms-04-er-indexing-relational-calculus.html` | `dbms` | Chapter 4 |
| `dm-01-logic-sets-relations-functions-2.html` | `dm` | Chapter 1 |
| `dm-02-graph-theory-combinatorics.html` | `dm` | Chapter 2 |
| `ds-01-linear-data-structures-2.html` | `dsa` | Chapter 1 |
| `ds-02-trees-heaps.html` | `dsa` | Chapter 2 |
| `em-01-calculus-linear-algebra-probability-2.html` | `em` | Chapter 1 |
| `em-02-differential-equations-numerical-methods.html` | `em` | Chapter 2 |
| `os-01-processes-scheduling-synchronization.html` | `os` | Chapter 1 |
| `os-02-memory-filesystems-io.html` | `os` | Chapter 2 |
| `toc-01-automata-grammars.html` | `toc` | Chapter 1 |
| `toc-02-turing-decidability.html` | `toc` | Chapter 2 |
| `aptitude-quantitative-master.html` | `ga` | Quantitative chapters |
| `aptitude-verbal-master.html` | `ga` | Verbal chapters |

**Missing notes (backend returns 404 — frontend shows "Notes not ready yet"):**
- `dl` — no HTML file, subject stays `is_published = false`
- `dsa` chapters 3–7 — only linear DS and trees exist

---

### 1C — Stitch Design System

The entire frontend visual design comes from `stitch_ui_ux_design_project.zip`.

| Stitch File | Maps To |
|---|---|
| `landing_page/code.html` | `Landing.tsx` |
| `login/code.html` | `Login.tsx` + `Signup.tsx` |
| `dashboard/code.html` | `Dashboard.tsx` + `AppShell.tsx` |
| `notes_viewer/code.html` | `Notes.tsx` |
| `practice_tokyo_night/code.html` | `Practice.tsx` |
| `leaderboard_tokyo_night/code.html` | `Leaderboard.tsx` |
| `skills_tokyo_night/code.html` | `Skills.tsx` |
| `profile_settings_tokyo_night/code.html` | `Profile.tsx` + `Settings.tsx` |
| `tokyo_night_forge/DESIGN.md` | Design philosophy + component rules |

---

## ❷ THE BINDING LAYER — HOW ALL 5 CONNECT

```
┌─────────────────────────────────────────────────────────────────────────┐
│                     EXAMFORGE SYSTEM MAP v2                             │
│                                                                         │
│  Stitch Design ──────────────────────────────────► Frontend React       │
│  (html.dark, Fraunces, Material Symbols, tokens)   (Tailwind CSS vars)  │
│                                                         │               │
│  Notes HTML Files ──upload──► Supabase Storage          │               │
│       │                           │                     │               │
│       │              Backend reads `notes` table        │               │
│       │              Generates signed URL               │               │
│       │              Client fetches CDN directly ◄──────┘               │
│                                                                         │
│  SQL Seed Files ──psql──► Supabase PostgreSQL                           │
│       │              subjects/chapters/topics/questions/                │
│       │              flashcards/tags/question_tags all seeded           │
│       │                           │                                     │
│  Backend FastAPI ◄────── Supabase DB + Firebase Auth                   │
│       │        ◄────── Piston API (code execution)                      │
│       │        ◄────── Gemini 1.5 Flash (AI doubts)                    │
│       │                           │                                     │
│  Frontend React ◄──── API calls ──┘                                    │
└─────────────────────────────────────────────────────────────────────────┘
```

Three explicit join points bind all artifacts:

---

### Join Point 1: `notes` table — Notes HTML ↔ Backend ↔ Frontend

Run this SQL **after** uploading HTML files to Supabase Storage.
The `slug` values in SELECTs must exactly match chapter slugs from seed files.

```sql
-- Add ON CONFLICT DO NOTHING for safe re-runs
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/algo/algo-01-complexity-sorting-searching.html', 'html', true
FROM chapters WHERE slug = 'complexity-sorting-searching' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/algo/algo-02-graph-algorithms.html', 'html', true
FROM chapters WHERE slug = 'graph-algorithms' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/algo/algo-03-dp-greedy-divide-conquer.html', 'html', true
FROM chapters WHERE slug = 'dp-greedy-divide-conquer' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/cn/cn-01-datalink-network-routing.html', 'html', true
FROM chapters WHERE slug = 'datalink-network-routing' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/cn/cn-02-transport-application-1.html', 'html', true
FROM chapters WHERE slug = 'transport-application' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/coa/coa-01-number-systems-boolean-circuits.html', 'html', true
FROM chapters WHERE slug = 'number-systems-boolean' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/coa/coa-02-cpu-isa-pipeline-memory.html', 'html', true
FROM chapters WHERE slug = 'cpu-isa-pipeline-memory' LIMIT 1
ON CONFLICT DO NOTHING;

-- CD — single file covers all chapters, one row per chapter
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/cd/compiler-design-complete.html', 'html', true
FROM chapters WHERE subject_id = (SELECT id FROM subjects WHERE slug = 'cd')
ON CONFLICT DO NOTHING;

-- CPROG — single file covers all chapters
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/cprog/c-programming-complete-1.html', 'html', true
FROM chapters WHERE subject_id = (SELECT id FROM subjects WHERE slug = 'cprog')
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dbms/dbms-gate-notes-v2-1.html', 'html', true
FROM chapters WHERE slug = 'relational-model' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dbms/dbms-02-sql-relational-algebra-3.html', 'html', true
FROM chapters WHERE slug = 'sql-ra' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dbms/dbms-03-transactions-concurrency-1.html', 'html', true
FROM chapters WHERE slug = 'transactions-concurrency' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dbms/dbms-04-er-indexing-relational-calculus.html', 'html', true
FROM chapters WHERE slug = 'er-indexing-relational-calculus' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dm/dm-01-logic-sets-relations-functions-2.html', 'html', true
FROM chapters WHERE slug = 'logic-sets-relations' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dm/dm-02-graph-theory-combinatorics.html', 'html', true
FROM chapters WHERE slug = 'graph-theory-combinatorics' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dsa/ds-01-linear-data-structures-2.html', 'html', true
FROM chapters WHERE slug = 'arrays-strings-hashing' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dsa/ds-02-trees-heaps.html', 'html', true
FROM chapters WHERE slug = 'trees-bst' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/em/em-01-calculus-linear-algebra-probability-2.html', 'html', true
FROM chapters WHERE slug = 'calculus-linear-algebra' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/em/em-02-differential-equations-numerical-methods.html', 'html', true
FROM chapters WHERE slug = 'differential-equations' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/os/os-01-processes-scheduling-synchronization.html', 'html', true
FROM chapters WHERE slug = 'processes-scheduling' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/os/os-02-memory-filesystems-io.html', 'html', true
FROM chapters WHERE slug = 'memory-filesystems' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/toc/toc-01-automata-grammars.html', 'html', true
FROM chapters WHERE slug = 'automata-grammars' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/toc/toc-02-turing-decidability.html', 'html', true
FROM chapters WHERE slug = 'turing-decidability' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/ga/aptitude-quantitative-master.html', 'html', true
FROM chapters WHERE slug = 'quantitative-aptitude' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/ga/aptitude-verbal-master.html', 'html', true
FROM chapters WHERE slug = 'verbal-aptitude' LIMIT 1
ON CONFLICT DO NOTHING;
```

**Slug reconciliation:** The slugs in the SELECTs above must match exactly
what your PYQ seed files inserted into the `chapters` table. If any SELECT
returns NULL, that INSERT fails silently. Verify with:
```sql
SELECT slug FROM chapters WHERE subject_id = (SELECT id FROM subjects WHERE slug = 'algo');
```

---

### Join Point 2: `subjects.is_published` — Seeds ↔ Frontend Visibility

```sql
-- Flip live after seed verification + notes upload + notes table insert
UPDATE subjects SET is_published = true WHERE slug IN (
  'algo', 'cd', 'cn', 'coa', 'cprog',
  'dbms', 'dm', 'dsa', 'em', 'ga', 'os', 'toc'
);

-- dl stays false until notes HTML files are created for it
-- UPDATE subjects SET is_published = false WHERE slug = 'dl'; ← already false
```

---

### Join Point 3: Supabase Storage — Notes Files ↔ Backend Path Lookup

Storage path structure (backend derives from `notes.storage_path` column):

```
notes-content/                    ← private bucket name
└── notes/
    └── gate/
        ├── algo/
        │   ├── algo-01-complexity-sorting-searching.html
        │   ├── algo-02-graph-algorithms.html
        │   └── algo-03-dp-greedy-divide-conquer.html
        ├── cd/
        │   └── compiler-design-complete.html
        ├── cn/
        │   ├── cn-01-datalink-network-routing.html
        │   └── cn-02-transport-application-1.html
        ├── coa/
        │   ├── coa-01-number-systems-boolean-circuits.html
        │   └── coa-02-cpu-isa-pipeline-memory.html
        ├── cprog/
        │   └── c-programming-complete-1.html
        ├── dbms/
        │   ├── dbms-gate-notes-v2-1.html
        │   ├── dbms-02-sql-relational-algebra-3.html
        │   ├── dbms-03-transactions-concurrency-1.html
        │   └── dbms-04-er-indexing-relational-calculus.html
        ├── dm/
        │   ├── dm-01-logic-sets-relations-functions-2.html
        │   └── dm-02-graph-theory-combinatorics.html
        ├── dsa/
        │   ├── ds-01-linear-data-structures-2.html
        │   └── ds-02-trees-heaps.html
        ├── em/
        │   ├── em-01-calculus-linear-algebra-probability-2.html
        │   └── em-02-differential-equations-numerical-methods.html
        ├── ga/
        │   ├── aptitude-quantitative-master.html
        │   └── aptitude-verbal-master.html
        ├── os/
        │   ├── os-01-processes-scheduling-synchronization.html
        │   └── os-02-memory-filesystems-io.html
        └── toc/
            ├── toc-01-automata-grammars.html
            └── toc-02-turing-decidability.html
```

---

## ❸ FULL DEPLOYMENT SEQUENCE

Run in exact order. Each step depends on the previous.

```
STEP 0 — Prerequisites
  [ ] Supabase project created
  [ ] Firebase project created + service account JSON downloaded
  [ ] Gemini API key from aistudio.google.com
  [ ] Render account + GitHub repo connected
  [ ] .env file filled in

STEP 1 — Schema Migration (run ONCE in Supabase SQL Editor)
  [ ] Run schema.sql from backend prompt Section ❾
  [ ] Run Supabase RLS policies
  [ ] Run RPC functions:
        increment_leaderboard_points
        get_question_counts
        get_question_meta
  [ ] Verify all tables exist: subjects · chapters · topics · questions ·
      tags · question_tags · flashcards · notes · bookmarks ·
      user_progress · user_notes · quiz_sessions · leaderboard_scores

STEP 2 — Run Base Seeds (creates branches, exam_configs, subjects, chapters)
  [ ] psql $DATABASE_URL -f ga-seed.sql  ← GA seed includes CSE branch + exam_configs
  [ ] Verify: SELECT COUNT(*) FROM subjects;  → 13+ rows

STEP 3 — Run All Subject Seeds
  [ ] algo: algo-seed.sql → p1 through p8
  [ ] cd:   cd-seed.sql   → p1 through p8
  [ ] cn:   cn-seed.sql   → p1 through p8
  [ ] coa:  coa-seed.sql  → p1 through p8
  [ ] cprog:cprog-seed.sql→ p1 through p8
  [ ] dbms: dbms-seed.sql → p1 through p7 (only 7 parts)
  [ ] dl:   dl-seed.sql   → p1 through p8
  [ ] dm:   dm-seed.sql   → p1 through p8
  [ ] dsa:  dsa-seed.sql  → p1 through p8
  [ ] em:   em-seed.sql   → p1 through p8
  [ ] ga:   ga-seed.sql   → p1 through p10 (10 parts — most)
  [ ] os:   os-seed.sql   → p1 through p8
  [ ] toc:  toc-seed.sql  → p1 through p8

STEP 4 — Verify Seeds
  [ ] SELECT slug, COUNT(q.id) FROM subjects s
      LEFT JOIN questions q ON q.subject_id = s.id
      GROUP BY s.slug ORDER BY s.slug;
      → Every slug: 100+ questions
  [ ] SELECT COUNT(*) FROM flashcards;     → 500+
  [ ] SELECT COUNT(*) FROM tags;           → 200+
  [ ] SELECT COUNT(*) FROM question_tags;  → 1000+

STEP 5 — Audit + Clean Backend (remove Redis/Judge0/Anthropic)
  [ ] Run audit prompt from execution guide Step 1.1
  [ ] Verify: /health returns ok, /docs shows all endpoints

STEP 6 — Deploy Backend to Render
  [ ] Push examforge-backend/ to GitHub
  [ ] Connect to Render → set all env vars → deploy
  [ ] Verify: curl https://examforge-backend.onrender.com/health → ok

STEP 7 — Create Supabase Storage Bucket
  [ ] Bucket name: notes-content
  [ ] Access: Private (NOT public)
  [ ] RLS policy: allow service_role full access

STEP 8 — Upload Notes HTML to Storage
  [ ] Run upload_notes.py (from execution guide Step 5.3)
  [ ] Verify 25 files in Supabase Dashboard → Storage → notes-content

STEP 9 — Insert notes Table Rows (binding SQL)
  [ ] Run Join Point 1 SQL above in Supabase SQL Editor
  [ ] Verify: SELECT COUNT(*) FROM notes; → 25 rows

STEP 10 — Flip Subjects Live
  [ ] Run Join Point 2 SQL (UPDATE subjects SET is_published = true)
  [ ] Verify: SELECT slug, is_published FROM subjects ORDER BY slug;
      → 12 true, dl = false

STEP 11 — Build Frontend with Stitch MCP
  [ ] Connect Stitch MCP server in Claude Code
  [ ] Generate using examforge-frontend-prompt-v6.md
  [ ] Verify builds without TypeScript errors

STEP 12 — Deploy Frontend to Vercel
  [ ] Set VITE_API_URL to Render backend URL
  [ ] Set all Firebase + Supabase env vars
  [ ] Deploy to Vercel

STEP 13 — Update CORS
  [ ] Add Vercel URL to ALLOWED_ORIGINS in Render env vars
  [ ] Render auto-redeploys

STEP 14 — Full End-to-End Verification
  [ ] Run verification queries from Section ❹ below
  [ ] Run manual browser checks from execution guide Step 5.6
```

---

## ❹ QUICK VERIFICATION QUERIES

Run after full deployment:

```sql
-- 1. Complete system health check
SELECT
  s.slug,
  s.is_published,
  COUNT(DISTINCT q.id)  AS questions,
  COUNT(DISTINCT f.id)  AS flashcards,
  COUNT(DISTINCT n.id)  AS notes_chapters,
  COUNT(DISTINCT t.id)  AS tags
FROM subjects s
LEFT JOIN questions q   ON q.subject_id = s.id
LEFT JOIN flashcards f  ON f.subject_id = s.id
LEFT JOIN chapters c    ON c.subject_id = s.id
LEFT JOIN notes n       ON n.chapter_id = c.id
LEFT JOIN question_tags qt ON qt.question_id = q.id
LEFT JOIN tags t        ON t.id = qt.tag_id
WHERE s.category = 'GATE'
GROUP BY s.slug, s.is_published
ORDER BY s.slug;
-- dl: is_published=false, 0 notes_chapters
-- all others: is_published=true, 100+ questions, 40+ flashcards

-- 2. Orphaned notes (storage path with no chapter)
SELECT n.storage_path
FROM notes n
LEFT JOIN chapters c ON c.id = n.chapter_id
WHERE c.id IS NULL;
-- Expected: 0 rows

-- 3. Questions missing topic_id (violates seed rules)
SELECT COUNT(*) FROM questions WHERE topic_id IS NULL;
-- Expected: 0 rows

-- 4. Tag health
SELECT COUNT(*) FROM tags;           -- 200+
SELECT COUNT(*) FROM question_tags;  -- 1000+
```

---

## ❺ KNOWN GAPS & RESOLUTIONS

| Gap | Impact | Resolution |
|---|---|---|
| `dl` has no notes HTML | Notes tab shows "not ready" | Generate `dl-01-combinational-sequential.html` + `dl-02-minimization-flipflops.html`, upload, insert notes row, flip is_published |
| `dsa` chapters 3–7 missing notes | No notes for avl-heaps, graphs, sorting | Generate 3 more DSA HTML files matching chapter slugs from dsa-seed.sql |
| `cd` + `cprog` are single files | All chapters share one storage_path | Fine — frontend renders the full file per subject, not per chapter |

---

## ❻ FRONTEND SUBJECT REGISTRY — FOR QA CROSS-REFERENCE

These come from the database. Listed here for verification only.
Frontend derives them from `GET /api/subjects`.

```ts
// What the API should return for GATE subjects
const GATE_CSE_SUBJECTS = [
  { slug: 'algo',  name: 'Algorithms',                           icon: '🔢', weight: 11, published: true },
  { slug: 'cd',    name: 'Compiler Design',                      icon: '⚙️', weight: 6,  published: true },
  { slug: 'cn',    name: 'Computer Networks',                    icon: '🌐', weight: 8,  published: true },
  { slug: 'coa',   name: 'Computer Organization & Architecture', icon: '🖥️', weight: 8,  published: true },
  { slug: 'cprog', name: 'C Programming',                       icon: '💻', weight: 5,  published: true },
  { slug: 'dbms',  name: 'Database Management Systems',          icon: '🗄️', weight: 11, published: true },
  { slug: 'dl',    name: 'Digital Logic',                        icon: '🔌', weight: 7,  published: false },
  { slug: 'dm',    name: 'Discrete Mathematics',                 icon: '∑',  weight: 8,  published: true },
  { slug: 'dsa',   name: 'Data Structures & Algorithms',         icon: '🌲', weight: 12, published: true },
  { slug: 'em',    name: 'Engineering Mathematics',              icon: '📐', weight: 13, published: true },
  { slug: 'ga',    name: 'General Aptitude',                    icon: '🎯', weight: 15, published: true },
  { slug: 'os',    name: 'Operating Systems',                    icon: '🖱️', weight: 9,  published: true },
  { slug: 'toc',   name: 'Theory of Computation',                icon: '🤖', weight: 7,  published: true },
];
```

---

## ❼ HANDOFF PROMPT — FOR NEW CLAUDE SESSIONS

Paste this at the top of any new session to instantly establish context:

```
I am continuing development on ExamForge — a GATE CSE exam prep platform.

CONFIRMED STACK:
- Backend: FastAPI + Python 3.11 + Supabase + Firebase Auth
- Code execution: Piston API (no key, POST https://emkc.org/api/v2/piston/execute)
- AI doubts: Gemini 1.5 Flash (google-generativeai, GEMINI_API_KEY)
- Backend deploy: Render ($PORT auto-injected)
- Frontend: React 18 + Vite + Tailwind (html.dark class) + Stitch design system
- Design: The Academic Atelier — Material Symbols icons, Fraunces/Newsreader/Inter/Lora fonts
- Frontend deploy: Vercel
- NO Redis. NO Judge0. NO Anthropic.

PROMPT FILES:
- examforge-frontend-prompt-v6.md  ← current frontend spec
- examforge-backend-prompt-v2.md   ← backend spec (audited, overrides applied)
- examforge-master-binding-prompt-v2.md ← this document

CURRENT STATUS: [STEP X OF DEPLOYMENT SEQUENCE FROM SECTION ❸]
CURRENT TASK: [describe specific thing needed]

Do NOT reinvent schema, slugs, file paths, or component structure.
Everything is defined. Work within the established system.
```

---

## ❽ CRITICAL CROSS-ARTIFACT RULES

```
1. The subject slug is the universal key across ALL artifacts:
   - subjects.slug in database
   - Storage path prefix: notes/gate/{slug}/
   - API response field: subject.slug
   - Frontend routing: /notes/{slug}
   Changing a slug in one place breaks everything.

2. Chapter slugs are the join key between notes table and chapters table.
   The slug in Join Point 1 SQL must exactly match what seed files inserted.

3. Notes HTML files are SACRED:
   - paper-grain class (bg: #faf7f2, text: #1a1a1a)
   - font-family: Lora
   - NEVER changes with theme
   - NEVER gets overlays or watermarks
   - DOMPurify MUST use DOMPURIFY_KATEX_CONFIG

4. Theme system: html.dark class on <html> element
   NOT data-theme attribute (that was the old v5 system)
   localStorage key: ef_theme (values: "dark" | "light")
   Default: "dark" (Tokyo Night)

5. Icons: Material Symbols Outlined ONLY
   Loaded as Google Font in index.html
   NOT an npm package
   NOT lucide-react

6. Seed files are idempotent — safe to re-run.
   Join Point 1 SQL has ON CONFLICT DO NOTHING — also safe to re-run.

7. dl subject: has PYQ seed data (questions exist) but is_published = false.
   DO NOT flip to true until dl notes HTML files exist and are uploaded.

8. signed_url: generated server-side ONLY, consumed immediately by frontend,
   NEVER stored in Zustand, NEVER logged to console.

9. Piston API is called from backend ONLY via /api/judge/submit.
   Frontend never calls emkc.org directly.

10. Gemini is called from backend ONLY via /api/doubts/ask.
    Frontend never uses google-generativeai package.
```

---

*ExamForge Master Binding Prompt v2.0*
*Ties: Frontend v6 (Stitch) · Backend v2 (audited) · PYQ Seeds v2 · 25 Notes HTML · 126 SQL Seeds*
*Stack: Firebase · Supabase · Piston · Gemini · Render · Vercel · NO Redis · NO Judge0*
*Design: Stitch MCP — The Academic Atelier — html.dark — Material Symbols*
*Subjects: algo · cd · cn · coa · cprog · dbms · dl · dm · dsa · em · ga · os · toc*
*Authored for Aryan's ExamForge platform — April 2026.*
