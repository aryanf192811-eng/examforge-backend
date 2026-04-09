# ══════════════════════════════════════════════════════════════════════════════
# EXAMFORGE — COMPLETE SYSTEM REBUILD PROMPT v1.0
# SQLite Content Layer · Supabase Pure Logic · Static Notes · Production Grade
# Firebase Auth → FastAPI → SQLite (questions) + Supabase (user state) → React
# ══════════════════════════════════════════════════════════════════════════════

You are a senior full-stack engineer and systems architect with 20+ years of
production experience in FastAPI, React, SQLite, and PostgreSQL.

Your task: Rebuild ExamForge from a broken multi-layer architecture into a
clean, production-grade, fully functional platform.

Read this entire prompt before writing a single line of code.
Every decision below is final. No improvisation. No approximation.

---

## ❶ THE ARCHITECTURE DECISION — WHY THIS STACK

### The Problem With the Old Architecture
The previous architecture had three fatal design mistakes:
1. Questions stored in Supabase → PostgREST schema cache errors, column mismatches,
   500s from strict Pydantic models on NULL rows
2. Notes stored in Supabase Storage → signed URL generation, 800ms latency,
   Redis cache dependency, storage_path leakage risk
3. Supabase used for EVERYTHING → schema drift caused the ENTIRE app to break
   when any single column was missing

### The New Architecture — Two Databases, Clean Separation

```
┌─────────────────────────────────────────────────────────────┐
│                    WHAT GOES WHERE                          │
├─────────────────┬───────────────────────────────────────────┤
│ SQLITE          │ Questions, Flashcards, Chapter metadata   │
│ (content.db)    │ Read-only after seeding. Never changes    │
│                 │ per user. Bundled with backend.           │
├─────────────────┼───────────────────────────────────────────┤
│ STATIC FILES    │ Notes HTML files                          │
│ (/public/notes) │ Served by Vercel CDN. Zero latency.       │
│                 │ Drop file → live. No code change.         │
├─────────────────┼───────────────────────────────────────────┤
│ SUPABASE        │ ONLY: profiles, user_progress,            │
│ (user state)    │ quiz_sessions, bookmarks, doubt_history,  │
│                 │ leaderboard_scores                        │
│                 │ Nothing else. Ever.                       │
└─────────────────┴───────────────────────────────────────────┘
```

### Why SQLite for Questions
- Your 126 SQL seed files are already written. One migration converts them all.
- SQLite is a single file (`content.db`) bundled with the FastAPI backend.
- Zero connection overhead, zero schema cache issues, zero PostgREST.
- Full SQL power: complex filters, RANDOM(), subject/chapter/difficulty JOINs.
- Read-only at runtime — immune to data corruption.
- Adding new questions = drop new SQL file, run seed script, redeploy.

### Why Static Files for Notes
- Your 25 HTML files are already built and named by slug.
- Vercel serves them from the CDN edge in <50ms.
- No auth layer on the file itself — auth happens at the route level in React.
- Updating a note = replace file, git push. Live in 30 seconds.

### Why Supabase ONLY for User State
- User state is the only thing that truly needs a cloud-hosted relational DB.
- Progress, quiz history, bookmarks, leaderboard — all per-user, dynamic.
- Supabase is excellent at this. It just cannot be the content layer too.

---

## ❷ COMPLETE FOLDER STRUCTURE

```
examforge/                              ← Frontend (React + Vite)
├── index.html
├── public/
│   └── notes/                          ← DROP HTML FILES HERE
│       ├── dbms-gate-notes-v2-1.html
│       ├── ds-01-linear-data-structures-2.html
│       ├── ds-02-trees-heaps.html
│       ├── algo-01-complexity-sorting-searching.html
│       ├── algo-02-graph-algorithms.html
│       ├── algo-03-dp-greedy-divide-conquer.html
│       ├── cn-01-datalink-network-routing.html
│       ├── cn-02-transport-application-1.html
│       ├── coa-01-number-systems-boolean-circuits.html
│       ├── coa-02-cpu-isa-pipeline-memory.html
│       ├── compiler-design-complete.html
│       ├── c-programming-complete-1.html
│       ├── dbms-02-sql-relational-algebra-3.html
│       ├── dbms-03-transactions-concurrency-1.html
│       ├── dbms-04-er-indexing-relational-calculus.html
│       ├── dm-01-logic-sets-relations-functions-2.html
│       ├── dm-02-graph-theory-combinatorics.html
│       ├── em-01-calculus-linear-algebra-probability-2.html
│       ├── em-02-differential-equations-numerical-meth.html
│       ├── os-01-processes-scheduling-synchronization.html
│       ├── os-02-memory-filesystems-io.html
│       ├── toc-01-automata-grammars.html
│       ├── toc-02-turing-decidability.html
│       ├── aptitude-quantitative-master.html
│       └── aptitude-verbal-master.html
├── src/
│   ├── main.tsx
│   ├── App.tsx
│   ├── index.css
│   ├── types/
│   │   └── index.ts                    ← ALL interfaces here only
│   ├── lib/
│   │   ├── firebase.ts
│   │   ├── supabase.ts                 ← user-state queries only
│   │   ├── api.ts                      ← typed fetch wrappers
│   │   ├── manifest.ts                 ← static subject/chapter registry
│   │   └── store/
│   │       ├── authStore.ts
│   │       ├── themeStore.ts
│   │       └── quizStore.ts
│   ├── hooks/
│   │   ├── usePlatformSecurity.ts
│   │   ├── useProgress.ts
│   │   └── useTheme.ts
│   ├── components/
│   │   ├── layout/
│   │   │   ├── Sidebar.tsx
│   │   │   ├── TopBar.tsx
│   │   │   ├── BottomTabBar.tsx
│   │   │   └── AppShell.tsx
│   │   ├── ui/
│   │   │   ├── Button.tsx
│   │   │   ├── Input.tsx
│   │   │   ├── Badge.tsx
│   │   │   ├── Modal.tsx
│   │   │   ├── Toast.tsx
│   │   │   ├── Skeleton.tsx
│   │   │   ├── EmptyState.tsx
│   │   │   └── ProgressBar.tsx
│   │   ├── notes/
│   │   │   ├── NotesViewer.tsx         ← blob-URL iframe protocol
│   │   │   ├── FocusModeWrapper.tsx
│   │   │   ├── DoubtDrawer.tsx         ← POST /api/doubts/ask
│   │   │   └── BookmarkPanel.tsx
│   │   ├── practice/
│   │   │   ├── QuestionCard.tsx
│   │   │   ├── OptionButton.tsx
│   │   │   ├── FocusTimer.tsx
│   │   │   └── TagFilterBar.tsx
│   │   ├── dashboard/
│   │   │   ├── ProgressRing.tsx
│   │   │   ├── ActivityHeatmap.tsx
│   │   │   ├── SubjectMasteryChart.tsx
│   │   │   └── StudyVelocityChart.tsx
│   │   └── global/
│   │       ├── CommandPalette.tsx
│   │       └── OfflineBanner.tsx
│   └── pages/
│       ├── Landing.tsx
│       ├── Login.tsx
│       ├── Signup.tsx
│       ├── Dashboard.tsx
│       ├── Notes.tsx
│       ├── Practice.tsx
│       ├── Skills.tsx
│       ├── Leaderboard.tsx
│       ├── Profile.tsx
│       └── Settings.tsx
├── tailwind.config.js
└── vite.config.ts

examforge-backend/                      ← Backend (FastAPI)
├── main.py
├── Dockerfile
├── requirements.txt
├── .env.example
├── content.db                          ← SQLite DB (questions + chapters)
│                                          GENERATED by seed script
│                                          BUNDLED with deployment
├── seeds/
│   ├── questions/                      ← DROP SQL FILES HERE
│   │   ├── algo-seed.sql
│   │   ├── algo-seed-p1.sql
│   │   │   ... (all 126 files)
│   │   └── [new]-seed.sql
│   ├── build_sqlite.py                 ← MASTER SEED SCRIPT
│   └── schema.sql                      ← SQLite schema definition
└── app/
    ├── core/
    │   ├── config.py
    │   ├── firebase.py
    │   ├── supabase.py                 ← user-state ONLY
    │   ├── sqlite.py                   ← SQLite connection manager
    │   ├── dependencies.py
    │   └── errors.py
    ├── models/
    │   ├── user.py
    │   ├── content.py                  ← Subject, Chapter, Question, Flashcard
    │   ├── practice.py                 ← Quiz session models
    │   ├── doubt.py
    │   └── progress.py
    ├── services/
    │   ├── auth_service.py
    │   ├── content_service.py          ← reads SQLite
    │   ├── quiz_service.py             ← reads SQLite + writes Supabase
    │   ├── progress_service.py         ← reads/writes Supabase only
    │   ├── doubt_service.py            ← calls Gemini
    │   └── leaderboard_service.py      ← reads/writes Supabase only
    └── routers/
        ├── auth.py
        ├── content.py                  ← /api/subjects, /api/chapters
        ├── quiz.py
        ├── progress.py
        ├── doubts.py
        ├── bookmarks.py
        ├── flashcards.py
        └── leaderboard.py
```

---

## ❸ SQLITE SCHEMA — content.db

This is the ONLY schema for SQLite. Build it in `seeds/schema.sql`.
Run it first when building content.db.

```sql
-- seeds/schema.sql

PRAGMA journal_mode=WAL;
PRAGMA foreign_keys=ON;

-- Subjects (the static registry of GATE subjects + skill tracks)
CREATE TABLE IF NOT EXISTS subjects (
  id           TEXT PRIMARY KEY,        -- e.g. "dbms", "dsa", "cpp"
  name         TEXT NOT NULL,
  slug         TEXT UNIQUE NOT NULL,
  category     TEXT NOT NULL DEFAULT 'GATE',  -- 'GATE' or 'SKILL'
  icon         TEXT DEFAULT 'book',
  description  TEXT DEFAULT '',
  order_index  INTEGER DEFAULT 0,
  is_published INTEGER DEFAULT 1        -- 1=true, 0=false
);

-- Chapters (each chapter belongs to a subject)
CREATE TABLE IF NOT EXISTS chapters (
  id              TEXT PRIMARY KEY,     -- e.g. "dbms-ch-01"
  subject_id      TEXT NOT NULL REFERENCES subjects(id),
  slug            TEXT UNIQUE NOT NULL, -- matches HTML filename (without .html)
  title           TEXT NOT NULL,
  order_index     INTEGER DEFAULT 0,
  has_notes       INTEGER DEFAULT 1,    -- 1=true, 0=false
  notes_file      TEXT,                 -- e.g. "dbms-gate-notes-v2-1.html"
  has_questions   INTEGER DEFAULT 0,    -- 1=true, 0=false
  is_published    INTEGER DEFAULT 1
);

-- Questions (seeded from all SQL files)
CREATE TABLE IF NOT EXISTS questions (
  id              TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  subject_id      TEXT NOT NULL REFERENCES subjects(id),
  chapter_id      TEXT REFERENCES chapters(id),
  stem            TEXT NOT NULL,
  type            TEXT NOT NULL CHECK (type IN ('MCQ','MSQ','NAT')),
  option_a        TEXT,
  option_b        TEXT,
  option_c        TEXT,
  option_d        TEXT,
  correct_option  TEXT,                 -- 'A','B','C','D' for MCQ
  correct_options TEXT,                 -- JSON array string for MSQ: '["A","C"]'
  nat_answer_min  REAL,
  nat_answer_max  REAL,
  explanation     TEXT DEFAULT '',
  difficulty      TEXT DEFAULT 'medium' CHECK (difficulty IN ('easy','medium','hard')),
  gate_year       INTEGER,
  marks           REAL DEFAULT 1.0,
  is_pyq          INTEGER DEFAULT 0     -- 1 = Previous Year Question
);

-- Flashcards (derived from chapter content, seeded alongside questions)
CREATE TABLE IF NOT EXISTS flashcards (
  id          TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
  subject_id  TEXT NOT NULL REFERENCES subjects(id),
  chapter_id  TEXT REFERENCES chapters(id),
  front       TEXT NOT NULL,            -- question/concept
  back        TEXT NOT NULL,            -- answer/definition
  tags        TEXT DEFAULT '[]'         -- JSON array of tag strings
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_questions_subject ON questions(subject_id);
CREATE INDEX IF NOT EXISTS idx_questions_chapter ON questions(chapter_id);
CREATE INDEX IF NOT EXISTS idx_questions_type ON questions(type);
CREATE INDEX IF NOT EXISTS idx_questions_difficulty ON questions(difficulty);
CREATE INDEX IF NOT EXISTS idx_questions_gate_year ON questions(gate_year);
CREATE INDEX IF NOT EXISTS idx_flashcards_subject ON flashcards(subject_id);
CREATE INDEX IF NOT EXISTS idx_flashcards_chapter ON flashcards(chapter_id);
```

---

## ❹ SUPABASE RESET — EXECUTE THIS COMPLETELY

Run this in the Supabase SQL editor. This replaces ALL existing tables.
This is the clean reset. Run it once. Never touch Supabase schema again after this.

```sql
-- ══════════════════════════════════════════
-- STEP 1: DROP EVERYTHING (clean slate)
-- ══════════════════════════════════════════
DROP TABLE IF EXISTS doubt_history CASCADE;
DROP TABLE IF EXISTS leaderboard_scores CASCADE;
DROP TABLE IF EXISTS bookmarks CASCADE;
DROP TABLE IF EXISTS study_sessions CASCADE;
DROP TABLE IF EXISTS quiz_session_answers CASCADE;
DROP TABLE IF EXISTS quiz_sessions CASCADE;
DROP TABLE IF EXISTS user_progress CASCADE;
DROP TABLE IF EXISTS flashcard_reviews CASCADE;
DROP TABLE IF EXISTS notes CASCADE;
DROP TABLE IF EXISTS chapters CASCADE;
DROP TABLE IF EXISTS subjects CASCADE;
DROP TABLE IF EXISTS profiles CASCADE;
DROP FUNCTION IF EXISTS handle_new_user CASCADE;
DROP FUNCTION IF EXISTS increment_leaderboard_points CASCADE;

-- ══════════════════════════════════════════
-- STEP 2: CREATE ONLY USER-STATE TABLES
-- ══════════════════════════════════════════

-- User profiles (synced from Firebase on first login)
CREATE TABLE profiles (
  id              TEXT PRIMARY KEY,         -- Firebase UID
  email           TEXT NOT NULL DEFAULT '',
  name            TEXT NOT NULL DEFAULT '',
  role            TEXT NOT NULL DEFAULT 'free' CHECK (role IN ('free','pro','admin')),
  bio             TEXT DEFAULT '',
  avatar_url      TEXT DEFAULT '',
  streak_days     INTEGER DEFAULT 0,
  total_score     INTEGER DEFAULT 0,
  last_active_at  TIMESTAMPTZ DEFAULT now(),
  created_at      TIMESTAMPTZ DEFAULT now()
);

-- Per-chapter reading progress
-- chapter_slug matches SQLite chapters.slug
CREATE TABLE user_progress (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         TEXT NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  chapter_slug    TEXT NOT NULL,
  subject_id      TEXT NOT NULL,
  completed       BOOLEAN DEFAULT false,
  progress_pct    INTEGER DEFAULT 0 CHECK (progress_pct BETWEEN 0 AND 100),
  time_spent_s    INTEGER DEFAULT 0,
  last_read_at    TIMESTAMPTZ DEFAULT now(),
  UNIQUE(user_id, chapter_slug)
);

-- Quiz sessions (one row per quiz attempt)
CREATE TABLE quiz_sessions (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         TEXT NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  subject_id      TEXT NOT NULL,            -- matches SQLite subjects.id
  chapter_id      TEXT,                     -- optional chapter scoping
  mode            TEXT DEFAULT 'practice' CHECK (mode IN ('practice','mock','pyq','mixed')),
  score           INTEGER DEFAULT 0,
  correct_count   INTEGER DEFAULT 0,
  total_questions INTEGER DEFAULT 0,
  time_taken_s    INTEGER DEFAULT 0,
  started_at      TIMESTAMPTZ DEFAULT now(),
  completed_at    TIMESTAMPTZ
);

-- Per-question answers within a quiz session
CREATE TABLE quiz_session_answers (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id      UUID NOT NULL REFERENCES quiz_sessions(id) ON DELETE CASCADE,
  question_id     TEXT NOT NULL,            -- matches SQLite questions.id
  selected_option TEXT,                     -- 'A','B','C','D' or JSON for MSQ
  is_correct      BOOLEAN DEFAULT false,
  time_taken_s    INTEGER DEFAULT 0
);

-- Bookmarks (chapter-level)
CREATE TABLE bookmarks (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         TEXT NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  chapter_slug    TEXT NOT NULL,
  subject_id      TEXT NOT NULL,
  created_at      TIMESTAMPTZ DEFAULT now(),
  UNIQUE(user_id, chapter_slug)
);

-- Doubt/AI chat history
CREATE TABLE doubt_history (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         TEXT NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  chapter_slug    TEXT NOT NULL,
  subject_id      TEXT NOT NULL,
  selected_text   TEXT DEFAULT '',
  question        TEXT NOT NULL,
  answer          TEXT NOT NULL,
  created_at      TIMESTAMPTZ DEFAULT now()
);

-- Flashcard review state per user (SM-2 algorithm state)
CREATE TABLE flashcard_reviews (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         TEXT NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  flashcard_id    TEXT NOT NULL,            -- matches SQLite flashcards.id
  ease_factor     REAL DEFAULT 2.5,
  interval_days   INTEGER DEFAULT 1,
  repetitions     INTEGER DEFAULT 0,
  next_review_at  TIMESTAMPTZ DEFAULT now(),
  last_rated      INTEGER,                  -- 0-5 SM-2 rating
  UNIQUE(user_id, flashcard_id)
);

-- Leaderboard scores
CREATE TABLE leaderboard_scores (
  user_id         TEXT PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  total_points    INTEGER DEFAULT 0,
  weekly_points   INTEGER DEFAULT 0,
  updated_at      TIMESTAMPTZ DEFAULT now()
);

-- ══════════════════════════════════════════
-- STEP 3: FUNCTIONS AND TRIGGERS
-- ══════════════════════════════════════════

-- Auto-create profile + leaderboard row on Firebase user sync
CREATE OR REPLACE FUNCTION handle_new_profile()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO leaderboard_scores (user_id, total_points, weekly_points)
  VALUES (NEW.id, 0, 0)
  ON CONFLICT (user_id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_profile_created
  AFTER INSERT ON profiles
  FOR EACH ROW EXECUTE FUNCTION handle_new_profile();

-- Atomic leaderboard point increment
CREATE OR REPLACE FUNCTION increment_leaderboard_points(
  p_user_id TEXT,
  p_points  INTEGER
) RETURNS VOID AS $$
BEGIN
  INSERT INTO leaderboard_scores (user_id, total_points, weekly_points)
  VALUES (p_user_id, p_points, p_points)
  ON CONFLICT (user_id) DO UPDATE
    SET total_points  = leaderboard_scores.total_points + p_points,
        weekly_points = leaderboard_scores.weekly_points + p_points,
        updated_at    = now();

  UPDATE profiles
  SET total_score = total_score + p_points,
      last_active_at = now()
  WHERE id = p_user_id;
END;
$$ LANGUAGE plpgsql;

-- Weekly leaderboard reset (run via Supabase cron every Monday 00:00 IST)
-- Schedule: 0 18 * * 0 (Sunday 18:30 UTC = Monday 00:00 IST)
-- SQL: UPDATE leaderboard_scores SET weekly_points = 0, updated_at = now();

-- ══════════════════════════════════════════
-- STEP 4: ROW LEVEL SECURITY
-- ══════════════════════════════════════════

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_session_answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookmarks ENABLE ROW LEVEL SECURITY;
ALTER TABLE doubt_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE flashcard_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE leaderboard_scores ENABLE ROW LEVEL SECURITY;

-- Profiles: user reads/updates own row only
CREATE POLICY "profiles_own" ON profiles
  FOR ALL USING (id = current_setting('app.current_user_id', true));

-- user_progress: own rows only
CREATE POLICY "progress_own" ON user_progress
  FOR ALL USING (user_id = current_setting('app.current_user_id', true));

-- quiz_sessions: own rows only
CREATE POLICY "quiz_sessions_own" ON quiz_sessions
  FOR ALL USING (user_id = current_setting('app.current_user_id', true));

-- quiz_session_answers: own sessions only (via join)
CREATE POLICY "quiz_answers_own" ON quiz_session_answers
  FOR ALL USING (
    session_id IN (
      SELECT id FROM quiz_sessions
      WHERE user_id = current_setting('app.current_user_id', true)
    )
  );

-- bookmarks: own rows only
CREATE POLICY "bookmarks_own" ON bookmarks
  FOR ALL USING (user_id = current_setting('app.current_user_id', true));

-- doubt_history: own rows only
CREATE POLICY "doubts_own" ON doubt_history
  FOR ALL USING (user_id = current_setting('app.current_user_id', true));

-- flashcard_reviews: own rows only
CREATE POLICY "flashcard_reviews_own" ON flashcard_reviews
  FOR ALL USING (user_id = current_setting('app.current_user_id', true));

-- leaderboard: readable by all authenticated users
CREATE POLICY "leaderboard_read" ON leaderboard_scores
  FOR SELECT USING (true);
CREATE POLICY "leaderboard_own_write" ON leaderboard_scores
  FOR ALL USING (user_id = current_setting('app.current_user_id', true));

-- ══════════════════════════════════════════
-- STEP 5: RELOAD CACHE
-- ══════════════════════════════════════════
NOTIFY pgrst, 'reload schema';
```

---

## ❺ SQLITE SEED SCRIPT — build_sqlite.py

Build this at `examforge-backend/seeds/build_sqlite.py`.
This is the MASTER script that converts all 126 SQL files into content.db.

```python
#!/usr/bin/env python3
"""
ExamForge SQLite Builder
Converts all seed SQL files into content.db

Usage:
  python seeds/build_sqlite.py              # full build
  python seeds/build_sqlite.py --subject dbms  # one subject only
  python seeds/build_sqlite.py --dry-run    # validate only, no write
  python seeds/build_sqlite.py --reset      # drop and rebuild from scratch
"""

import sqlite3
import pathlib
import argparse
import json
import re
import sys
from datetime import datetime

ROOT = pathlib.Path(__file__).parent.parent
DB_PATH = ROOT / "content.db"
SCHEMA_PATH = ROOT / "seeds" / "schema.sql"
SEEDS_DIR = ROOT / "seeds" / "questions"

# ─── Subject + Chapter Registry ───────────────────────────────────────────────
# This is the authoritative mapping of subjects and chapters.
# Update this when adding new subjects or chapters.

SUBJECTS = [
  {"id": "algo",    "name": "Algorithms",                  "slug": "algo",    "category": "GATE", "icon": "psychology",    "order_index": 1},
  {"id": "cd",      "name": "Compiler Design",             "slug": "cd",      "category": "GATE", "icon": "code",          "order_index": 2},
  {"id": "cn",      "name": "Computer Networks",           "slug": "cn",      "category": "GATE", "icon": "lan",           "order_index": 3},
  {"id": "coa",     "name": "Computer Organisation & Architecture", "slug": "coa", "category": "GATE", "icon": "memory",   "order_index": 4},
  {"id": "cprog",   "name": "C Programming",               "slug": "cprog",   "category": "GATE", "icon": "terminal",      "order_index": 5},
  {"id": "dbms",    "name": "Database Management Systems", "slug": "dbms",    "category": "GATE", "icon": "database",      "order_index": 6},
  {"id": "dl",      "name": "Digital Logic",               "slug": "dl",      "category": "GATE", "icon": "schema",        "order_index": 7},
  {"id": "dm",      "name": "Discrete Mathematics",        "slug": "dm",      "category": "GATE", "icon": "functions",     "order_index": 8},
  {"id": "dsa",     "name": "Data Structures & Algorithms","slug": "dsa",     "category": "GATE", "icon": "account_tree",  "order_index": 9},
  {"id": "em",      "name": "Engineering Mathematics",     "slug": "em",      "category": "GATE", "icon": "calculate",     "order_index": 10},
  {"id": "ga",      "name": "General Aptitude",            "slug": "ga",      "category": "GATE", "icon": "quiz",          "order_index": 11},
  {"id": "os",      "name": "Operating Systems",           "slug": "os",      "category": "GATE", "icon": "computer",      "order_index": 12},
  {"id": "toc",     "name": "Theory of Computation",       "slug": "toc",     "category": "GATE", "icon": "auto_awesome",  "order_index": 13},
  {"id": "cpp",     "name": "C++ Mastery",                 "slug": "cpp",     "category": "SKILL","icon": "code_blocks",   "order_index": 14},
  {"id": "python",  "name": "Python Essentials",           "slug": "python",  "category": "SKILL","icon": "terminal",      "order_index": 15},
]

CHAPTERS = [
  # ALGO
  {"id":"algo-ch-01","subject_id":"algo","slug":"algo-01-complexity-sorting-searching","title":"Complexity, Sorting & Searching","order_index":1,"has_notes":1,"notes_file":"algo-01-complexity-sorting-searching.html","has_questions":1},
  {"id":"algo-ch-02","subject_id":"algo","slug":"algo-02-graph-algorithms",            "title":"Graph Algorithms",              "order_index":2,"has_notes":1,"notes_file":"algo-02-graph-algorithms.html",            "has_questions":1},
  {"id":"algo-ch-03","subject_id":"algo","slug":"algo-03-dp-greedy-divide-conquer",    "title":"DP, Greedy & Divide-Conquer",   "order_index":3,"has_notes":1,"notes_file":"algo-03-dp-greedy-divide-conquer.html",    "has_questions":1},
  # CD
  {"id":"cd-ch-01", "subject_id":"cd",  "slug":"compiler-design-complete",            "title":"Compiler Design Complete",      "order_index":1,"has_notes":1,"notes_file":"compiler-design-complete.html",            "has_questions":1},
  # CN
  {"id":"cn-ch-01", "subject_id":"cn",  "slug":"cn-01-datalink-network-routing",      "title":"Data Link & Network Routing",   "order_index":1,"has_notes":1,"notes_file":"cn-01-datalink-network-routing.html",      "has_questions":1},
  {"id":"cn-ch-02", "subject_id":"cn",  "slug":"cn-02-transport-application-1",       "title":"Transport & Application Layer", "order_index":2,"has_notes":1,"notes_file":"cn-02-transport-application-1.html",       "has_questions":1},
  # COA
  {"id":"coa-ch-01","subject_id":"coa", "slug":"coa-01-number-systems-boolean-circuits","title":"Number Systems & Boolean Circuits","order_index":1,"has_notes":1,"notes_file":"coa-01-number-systems-boolean-circuits.html","has_questions":1},
  {"id":"coa-ch-02","subject_id":"coa", "slug":"coa-02-cpu-isa-pipeline-memory",      "title":"CPU, ISA, Pipeline & Memory",   "order_index":2,"has_notes":1,"notes_file":"coa-02-cpu-isa-pipeline-memory.html",      "has_questions":1},
  # CPROG
  {"id":"cprog-ch-01","subject_id":"cprog","slug":"c-programming-complete-1",         "title":"C Programming Complete",        "order_index":1,"has_notes":1,"notes_file":"c-programming-complete-1.html",            "has_questions":1},
  # DBMS
  {"id":"dbms-ch-01","subject_id":"dbms","slug":"dbms-gate-notes-v2-1",               "title":"Relational Model, FDs & Normal Forms","order_index":1,"has_notes":1,"notes_file":"dbms-gate-notes-v2-1.html",          "has_questions":1},
  {"id":"dbms-ch-02","subject_id":"dbms","slug":"dbms-02-sql-relational-algebra-3",   "title":"SQL & Relational Algebra",      "order_index":2,"has_notes":1,"notes_file":"dbms-02-sql-relational-algebra-3.html",    "has_questions":1},
  {"id":"dbms-ch-03","subject_id":"dbms","slug":"dbms-03-transactions-concurrency-1", "title":"Transactions & Concurrency",    "order_index":3,"has_notes":1,"notes_file":"dbms-03-transactions-concurrency-1.html",  "has_questions":1},
  {"id":"dbms-ch-04","subject_id":"dbms","slug":"dbms-04-er-indexing-relational-calculus","title":"ER, Indexing & Relational Calculus","order_index":4,"has_notes":1,"notes_file":"dbms-04-er-indexing-relational-calculus.html","has_questions":1},
  # DL
  {"id":"dl-ch-01", "subject_id":"dl",  "slug":"dl-01-gates-combinational",           "title":"Gates & Combinational Circuits","order_index":1,"has_notes":0,"notes_file":None,                                       "has_questions":1},
  # DM
  {"id":"dm-ch-01", "subject_id":"dm",  "slug":"dm-01-logic-sets-relations-functions-2","title":"Logic, Sets, Relations & Functions","order_index":1,"has_notes":1,"notes_file":"dm-01-logic-sets-relations-functions-2.html","has_questions":1},
  {"id":"dm-ch-02", "subject_id":"dm",  "slug":"dm-02-graph-theory-combinatorics",    "title":"Graph Theory & Combinatorics",  "order_index":2,"has_notes":1,"notes_file":"dm-02-graph-theory-combinatorics.html",    "has_questions":1},
  # DSA
  {"id":"dsa-ch-01","subject_id":"dsa", "slug":"ds-01-linear-data-structures-2",      "title":"Arrays, LL, Stack, Queue, Hash","order_index":1,"has_notes":1,"notes_file":"ds-01-linear-data-structures-2.html",      "has_questions":1},
  {"id":"dsa-ch-02","subject_id":"dsa", "slug":"ds-02-trees-heaps",                   "title":"Trees, BST, AVL & Heap",        "order_index":2,"has_notes":1,"notes_file":"ds-02-trees-heaps.html",                    "has_questions":1},
  # EM
  {"id":"em-ch-01", "subject_id":"em",  "slug":"em-01-calculus-linear-algebra-probability-2","title":"Calculus, Linear Algebra & Probability","order_index":1,"has_notes":1,"notes_file":"em-01-calculus-linear-algebra-probability-2.html","has_questions":1},
  {"id":"em-ch-02", "subject_id":"em",  "slug":"em-02-differential-equations-numerical-meth","title":"Differential Equations & Numerical Methods","order_index":2,"has_notes":1,"notes_file":"em-02-differential-equations-numerical-meth.html","has_questions":1},
  # GA
  {"id":"ga-ch-01", "subject_id":"ga",  "slug":"ga-01-verbal",                        "title":"Verbal Ability",                "order_index":1,"has_notes":1,"notes_file":"aptitude-verbal-master.html",               "has_questions":1},
  {"id":"ga-ch-02", "subject_id":"ga",  "slug":"ga-02-quantitative",                  "title":"Quantitative Aptitude",         "order_index":2,"has_notes":1,"notes_file":"aptitude-quantitative-master.html",         "has_questions":1},
  # OS
  {"id":"os-ch-01", "subject_id":"os",  "slug":"os-01-processes-scheduling-synchronization","title":"Processes, Scheduling & Synchronization","order_index":1,"has_notes":1,"notes_file":"os-01-processes-scheduling-synchronization.html","has_questions":1},
  {"id":"os-ch-02", "subject_id":"os",  "slug":"os-02-memory-filesystems-io",         "title":"Memory, Filesystems & I/O",     "order_index":2,"has_notes":1,"notes_file":"os-02-memory-filesystems-io.html",          "has_questions":1},
  # TOC
  {"id":"toc-ch-01","subject_id":"toc", "slug":"toc-01-automata-grammars",            "title":"Automata & Grammars",           "order_index":1,"has_notes":1,"notes_file":"toc-01-automata-grammars.html",             "has_questions":1},
  {"id":"toc-ch-02","subject_id":"toc", "slug":"toc-02-turing-decidability",          "title":"Turing Machines & Decidability","order_index":2,"has_notes":1,"notes_file":"toc-02-turing-decidability.html",           "has_questions":1},
  # SKILL: C++
  {"id":"cpp-ch-01","subject_id":"cpp", "slug":"cpp-mastery-part1",                   "title":"C++ Foundations & Patterns",    "order_index":1,"has_notes":1,"notes_file":"c-programming-complete-1.html",            "has_questions":0},
  # SKILL: Python (placeholder — add notes file when ready)
  {"id":"py-ch-01", "subject_id":"python","slug":"python-essentials-part1",           "title":"Python Essentials",             "order_index":1,"has_notes":0,"notes_file":None,                                        "has_questions":0},
]

# ─── Subject slug → SQL file prefix mapping ───────────────────────────────────
# Maps subject id → prefix used in seed filenames
SUBJECT_PREFIX_MAP = {
  "algo": "algo", "cd": "cd", "cn": "cn", "coa": "coa",
  "cprog": "cprog", "dbms": "dbms", "dl": "dl", "dm": "dm",
  "dsa": "dsa", "em": "em", "ga": "ga", "os": "os", "toc": "toc",
}

def get_seed_files_for_subject(subject_id: str) -> list[pathlib.Path]:
    prefix = SUBJECT_PREFIX_MAP.get(subject_id, subject_id)
    files = sorted(SEEDS_DIR.glob(f"{prefix}-seed*.sql"), key=lambda p: (
        0 if p.stem == f"{prefix}-seed" else
        int(re.search(r'p(\d+)$', p.stem).group(1)) if re.search(r'p(\d+)$', p.stem) else 999
    ))
    return files

def build_db(subject_filter: str = None, dry_run: bool = False, reset: bool = False):
    if reset and DB_PATH.exists():
        DB_PATH.unlink()
        print(f"[RESET] Deleted {DB_PATH}")

    print(f"[BUILD] SQLite DB at {DB_PATH}")
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # Apply schema
    schema_sql = SCHEMA_PATH.read_text()
    conn.executescript(schema_sql)
    print("[SCHEMA] Applied schema.sql")

    # Seed subjects
    for s in SUBJECTS:
        cur.execute("""
            INSERT OR IGNORE INTO subjects (id, name, slug, category, icon, order_index)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (s["id"], s["name"], s["slug"], s["category"], s["icon"], s["order_index"]))
    conn.commit()
    print(f"[SUBJECTS] Seeded {len(SUBJECTS)} subjects")

    # Seed chapters
    for c in CHAPTERS:
        cur.execute("""
            INSERT OR IGNORE INTO chapters
              (id, subject_id, slug, title, order_index, has_notes, notes_file, has_questions)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """, (c["id"], c["subject_id"], c["slug"], c["title"],
              c["order_index"], c["has_notes"], c["notes_file"], c["has_questions"]))
    conn.commit()
    print(f"[CHAPTERS] Seeded {len(CHAPTERS)} chapters")

    # Process questions from SQL seed files
    subjects_to_seed = [subject_filter] if subject_filter else list(SUBJECT_PREFIX_MAP.keys())
    total_inserted = 0
    total_skipped = 0
    total_errors = 0

    for subject_id in subjects_to_seed:
        files = get_seed_files_for_subject(subject_id)
        if not files:
            print(f"[WARN] No seed files found for subject: {subject_id}")
            continue

        for sql_file in files:
            if dry_run:
                print(f"[DRY-RUN] Would process: {sql_file.name}")
                continue

            try:
                sql_content = sql_file.read_text(encoding='utf-8')
                # Strip any Supabase-specific syntax that SQLite doesn't support
                sql_content = re.sub(r'ON CONFLICT DO NOTHING', 'OR IGNORE', sql_content, flags=re.IGNORECASE)
                sql_content = re.sub(r'ON CONFLICT \(id\) DO NOTHING', 'OR IGNORE', sql_content, flags=re.IGNORECASE)
                sql_content = re.sub(r'gen_random_uuid\(\)', "lower(hex(randomblob(16)))", sql_content, flags=re.IGNORECASE)
                sql_content = re.sub(r'::[a-zA-Z\[\]]+', '', sql_content)  # remove Postgres casts

                before = cur.execute("SELECT COUNT(*) FROM questions").fetchone()[0]
                conn.executescript(sql_content)
                after = cur.execute("SELECT COUNT(*) FROM questions").fetchone()[0]
                inserted = after - before
                total_inserted += inserted
                print(f"[OK] {sql_file.name:40s} +{inserted} questions")
            except Exception as e:
                total_errors += 1
                print(f"[ERROR] {sql_file.name}: {e}")
                conn.rollback()

    conn.commit()

    # Summary
    total_q = cur.execute("SELECT COUNT(*) FROM questions").fetchone()[0]
    total_c = cur.execute("SELECT COUNT(*) FROM chapters").fetchone()[0]
    print(f"\n{'='*50}")
    print(f"[DONE] content.db built at {datetime.now().strftime('%H:%M:%S')}")
    print(f"  Subjects:  {len(SUBJECTS)}")
    print(f"  Chapters:  {total_c}")
    print(f"  Questions: {total_q} (this run: +{total_inserted})")
    print(f"  Errors:    {total_errors}")
    print(f"{'='*50}")
    conn.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--subject", help="Seed only this subject (e.g. dbms)")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--reset", action="store_true", help="Delete and rebuild from scratch")
    args = parser.parse_args()
    build_db(subject_filter=args.subject, dry_run=args.dry_run, reset=args.reset)
```

### IMPORTANT: SQL SEED FILE FORMAT

Your existing seed files MUST use this format (one INSERT per file — no extra DDL):

```sql
INSERT OR IGNORE INTO questions
  (subject_id, stem, type, option_a, option_b, option_c, option_d,
   correct_option, correct_options, nat_answer_min, nat_answer_max,
   explanation, difficulty, gate_year, marks)
VALUES
  ('dbms', 'Which normal form eliminates transitive dependencies?',
   'MCQ', '1NF', '2NF', '3NF', 'BCNF', 'C', NULL, NULL, NULL,
   '3NF eliminates transitive dependencies where a non-prime attribute
    depends on another non-prime attribute.', 'medium', 2022, 1.0),
  ('dbms', 'For BCNF, every determinant must be a...', 'MCQ',
   'Candidate Key', 'Primary Key', 'Foreign Key', 'Super Key',
   'A', NULL, NULL, NULL,
   'BCNF requires every determinant to be a candidate key.', 'hard', 2021, 2.0);
```

The build script handles the Postgres → SQLite conversion automatically.
If your existing files use `INSERT INTO questions (...) VALUES ...` with
PostgreSQL syntax, the build script strips casts, replaces gen_random_uuid(),
and handles ON CONFLICT syntax. Review the 3-4 error files manually if any fail.

---

## ❻ BACKEND — app/core/sqlite.py

```python
import sqlite3
import pathlib
from contextlib import contextmanager
from functools import lru_cache

DB_PATH = pathlib.Path(__file__).parent.parent.parent / "content.db"

@lru_cache(maxsize=1)
def get_db_path() -> str:
    if not DB_PATH.exists():
        raise RuntimeError(
            f"content.db not found at {DB_PATH}. "
            "Run: python seeds/build_sqlite.py"
        )
    return str(DB_PATH)

@contextmanager
def get_sqlite():
    """Context manager for SQLite read queries."""
    conn = sqlite3.connect(get_db_path(), check_same_thread=False)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA journal_mode=WAL")
    conn.execute("PRAGMA foreign_keys=ON")
    conn.execute("PRAGMA query_only=ON")    # READ-ONLY at runtime
    try:
        yield conn
    finally:
        conn.close()

def sqlite_row_to_dict(row: sqlite3.Row) -> dict:
    return dict(row)
```

---

## ❼ BACKEND — COMPLETE ROUTER SPECIFICATION

### app/routers/content.py — /api/subjects, /api/chapters

```python
GET /api/subjects  [AUTH]
  Query SQLite:
    SELECT s.*, COUNT(c.id) as chapter_count
    FROM subjects s
    LEFT JOIN chapters c ON c.subject_id = s.id AND c.is_published = 1
    WHERE s.is_published = 1
    GROUP BY s.id
    ORDER BY s.order_index

  For each subject, also query Supabase for user progress:
    SELECT chapter_slug, completed
    FROM user_progress
    WHERE user_id = :uid AND subject_id = :subject_id

  Compute: completed_chapters = count(completed=true)
           progress_pct = round(completed_chapters / chapter_count * 100)

  Response: SubjectResponse[] with progress enrichment

GET /api/chapters/{subject_id}  [AUTH]
  Query SQLite:
    SELECT * FROM chapters
    WHERE subject_id = :subject_id AND is_published = 1
    ORDER BY order_index

  For each chapter, query Supabase:
    SELECT progress_pct, completed, time_spent_s
    FROM user_progress
    WHERE user_id = :uid AND chapter_slug = :slug

  Compute: notes_url = f"/notes/{chapter.notes_file}" (public static path)
           progress_pct = from user_progress or 0

  Response: ChapterResponse[] with notes_url and progress_pct
```

### app/routers/quiz.py — /api/quiz

```python
GET /api/quiz/questions  [AUTH]
  Query params: subject_id, chapter_id (optional), mode, count (default 10),
                difficulty (optional), pyq_only (optional bool)

  Query SQLite:
    SELECT * FROM questions
    WHERE subject_id = :subject_id
      AND (:chapter_id IS NULL OR chapter_id = :chapter_id)
      AND (:difficulty IS NULL OR difficulty = :difficulty)
      AND (:pyq_only IS NULL OR is_pyq = :pyq_only)
    ORDER BY RANDOM()
    LIMIT :count

  If 0 results: return 200 with empty list + message "No questions found for filter"
  NEVER return 500 for empty results.

  Response:
    { session_id: uuid, questions: QuizQuestion[], total: int }

  Side effect: INSERT INTO quiz_sessions (Supabase)
    { user_id, subject_id, chapter_id, mode, total_questions, started_at }

POST /api/quiz/submit  [AUTH]
  Body: { session_id: uuid, answers: [{ question_id, selected_option, time_taken_s }] }

  Process:
    1. For each answer, fetch question from SQLite
    2. Grade: compare selected_option to correct_option / correct_options
    3. For NAT: check nat_answer_min <= float(selected) <= nat_answer_max
    4. Compute score, correct_count
    5. UPDATE quiz_sessions SET score, correct_count, completed_at (Supabase)
    6. INSERT quiz_session_answers batch (Supabase)
    7. Call increment_leaderboard_points(uid, correct_count * 5)
    8. Return detailed results

  Response:
    {
      session_id, score, correct_count, total_questions,
      accuracy_pct: float,
      results: [{
        question_id, stem, selected_option, correct_option,
        is_correct, explanation
      }]
    }

GET /api/quiz/history  [AUTH]
  Query Supabase:
    SELECT * FROM quiz_sessions
    WHERE user_id = :uid
    ORDER BY started_at DESC
    LIMIT 20
  Response: QuizSession[]
```

### app/routers/progress.py — /api/progress

```python
GET /api/progress/stats  [AUTH]
  RESILIENCE RULE: Every sub-query MUST be in its own try/except.
  Return partial data on error. NEVER return 500 for stats.

  Data sources:
    - profiles.streak_days, profiles.total_score (Supabase)
    - COUNT/SUM from quiz_sessions (Supabase)
    - SUM time_spent_s from study_sessions (Supabase)
    - COUNT completed from user_progress (Supabase)

  Return defaults if any query fails:
    {
      questions_attempted: 0,
      questions_correct: 0,
      accuracy_percent: 0.0,
      study_time_minutes: 0,
      streak_days: 0,
      chapters_completed: 0,
      total_score: 0
    }

POST /api/progress/chapter  [AUTH]
  Body: { chapter_slug, subject_id, completed, progress_pct, time_spent_s }

  UPSERT into Supabase user_progress:
    INSERT INTO user_progress (user_id, chapter_slug, subject_id, completed,
                                progress_pct, time_spent_s, last_read_at)
    VALUES (...)
    ON CONFLICT (user_id, chapter_slug) DO UPDATE
      SET completed = EXCLUDED.completed,
          progress_pct = EXCLUDED.progress_pct,
          time_spent_s = user_progress.time_spent_s + EXCLUDED.time_spent_s,
          last_read_at = now()

  If completed = true AND was previously not completed:
    increment_leaderboard_points(uid, 50)

  Response: { ok: true }
```

### app/routers/doubts.py — /api/doubts

```python
POST /api/doubts/ask  [AUTH]
  Body: {
    chapter_slug: str,
    subject_id: str,
    selected_text: str,    # text user highlighted in notes (max 500 chars)
    question: str          # user's question (max 300 chars)
  }

  Rate limit: 10 requests per user per hour (track in Supabase doubt_history count)

  Process:
    1. Check rate limit: COUNT(*) FROM doubt_history WHERE user_id=uid
       AND created_at > now() - interval '1 hour'
       If count >= 10: return 429 { detail: "Doubt limit reached. Try again in 1 hour." }

    2. Get chapter + subject context from SQLite for prompt grounding

    3. Call Gemini API (google-generativeai):
       model = genai.GenerativeModel("gemini-1.5-flash")
       response = model.generate_content(prompt)

    4. INSERT into doubt_history (Supabase)

    5. Return { answer: str, doubt_id: uuid }

  GEMINI PROMPT TEMPLATE:
    You are an expert GATE CSE tutor helping a student understand {subject_name}
    ({chapter_title}).

    The student highlighted this text from their notes:
    ---
    {selected_text}
    ---

    Student's question: {question}

    Instructions:
    - Answer concisely (max 300 words)
    - Use LaTeX math notation where needed: inline $...$ and block $$...$$
    - Relate to GATE exam context where relevant
    - Point out common GATE traps if applicable
    - Do not repeat the question back
    - If the selected text is empty, answer the question based on the subject/chapter context

GET /api/doubts/history  [AUTH]
  Query Supabase:
    SELECT id, question, answer, chapter_slug, created_at
    FROM doubt_history
    WHERE user_id = :uid
    ORDER BY created_at DESC
    LIMIT 50
```

### app/routers/flashcards.py — /api/flashcards

```python
GET /api/flashcards  [AUTH]
  Query params: subject_id (required), chapter_id (optional), due_only (bool)

  Query SQLite for cards:
    SELECT * FROM flashcards
    WHERE subject_id = :subject_id
      AND (:chapter_id IS NULL OR chapter_id = :chapter_id)

  Query Supabase for user review state:
    SELECT flashcard_id, ease_factor, interval_days, next_review_at, repetitions
    FROM flashcard_reviews
    WHERE user_id = :uid AND flashcard_id IN (:card_ids)

  Merge: for each card, attach review state or defaults
  If due_only: filter to cards where next_review_at <= now()

  Response: FlashcardWithReview[]

POST /api/flashcards/review  [AUTH]
  Body: { flashcard_id: str, rating: int }  -- rating 0-5 (SM-2)

  SM-2 Algorithm (server-side):
    EF = max(1.3, old_EF + 0.1 - (5-rating) * (0.08 + (5-rating) * 0.02))
    if rating < 3: interval = 1, repetitions = 0
    elif repetitions == 0: interval = 1
    elif repetitions == 1: interval = 6
    else: interval = round(old_interval * EF)
    next_review = now() + interval days

  UPSERT into Supabase flashcard_reviews.
  If rating >= 3: increment_leaderboard_points(uid, 3)

  Response: { next_review_at: str, interval_days: int }
```

### app/routers/bookmarks.py — /api/bookmarks

```python
GET /api/bookmarks  [AUTH]
  Query Supabase: SELECT * FROM bookmarks WHERE user_id = :uid ORDER BY created_at DESC
  Enrich: for each bookmark, fetch chapter title from SQLite by chapter_slug
  Response: BookmarkWithTitle[]

POST /api/bookmarks  [AUTH]
  Body: { chapter_slug: str, subject_id: str }
  INSERT OR IGNORE into bookmarks (idempotent)
  Response: { ok: true, bookmark_id: uuid }

DELETE /api/bookmarks/{chapter_slug}  [AUTH]
  DELETE FROM bookmarks WHERE user_id = :uid AND chapter_slug = :slug
  Response: { ok: true }
```

### app/routers/leaderboard.py — /api/leaderboard

```python
GET /api/leaderboard  [AUTH]
  Query params: period = 'weekly' | 'all_time' (default: weekly)

  Query Supabase:
    SELECT ls.user_id, ls.total_points, ls.weekly_points, ls.updated_at,
           p.name, p.avatar_url
    FROM leaderboard_scores ls
    JOIN profiles p ON p.id = ls.user_id
    ORDER BY (CASE WHEN period='weekly' THEN weekly_points ELSE total_points END) DESC
    LIMIT 100

  Compute: rank = position in result set
  Mark: is_current_user = (entry.user_id == uid)

  Response: { entries: LeaderboardEntry[], current_user_rank: int | null }
```

---

## ❽ PYDANTIC MODELS — ALL OPTIONAL, ZERO STRICT

```python
# app/models/content.py

from pydantic import BaseModel
from typing import Optional

class SubjectResponse(BaseModel):
    id: str
    name: str
    slug: str
    category: Optional[str] = "GATE"
    icon: Optional[str] = "book"
    description: Optional[str] = ""
    order_index: Optional[int] = 0
    chapter_count: Optional[int] = 0
    completed_chapters: Optional[int] = 0
    progress_pct: Optional[int] = 0
    is_published: Optional[bool] = True

class ChapterResponse(BaseModel):
    id: str
    subject_id: str
    slug: str
    title: str
    order_index: Optional[int] = 0
    has_notes: Optional[bool] = False
    notes_url: Optional[str] = None      # public static path: /notes/<file>.html
    has_questions: Optional[bool] = False
    progress_pct: Optional[int] = 0
    completed: Optional[bool] = False
    time_spent_s: Optional[int] = 0

class QuizQuestion(BaseModel):
    id: str
    stem: str
    type: str
    option_a: Optional[str] = None
    option_b: Optional[str] = None
    option_c: Optional[str] = None
    option_d: Optional[str] = None
    correct_option: Optional[str] = None
    correct_options: Optional[str] = None   # JSON array string
    nat_answer_min: Optional[float] = None
    nat_answer_max: Optional[float] = None
    explanation: Optional[str] = ""
    difficulty: Optional[str] = "medium"
    gate_year: Optional[int] = None
    marks: Optional[float] = 1.0
    is_pyq: Optional[bool] = False

class FlashCard(BaseModel):
    id: str
    subject_id: str
    chapter_id: Optional[str] = None
    front: str
    back: str
    tags: Optional[list[str]] = []
    # Review state (merged from Supabase)
    ease_factor: Optional[float] = 2.5
    interval_days: Optional[int] = 1
    next_review_at: Optional[str] = None
    repetitions: Optional[int] = 0

class UserStats(BaseModel):
    questions_attempted: Optional[int] = 0
    questions_correct: Optional[int] = 0
    accuracy_percent: Optional[float] = 0.0
    study_time_minutes: Optional[int] = 0
    streak_days: Optional[int] = 0
    chapters_completed: Optional[int] = 0
    total_score: Optional[int] = 0

class LeaderboardEntry(BaseModel):
    user_id: str
    name: Optional[str] = "Student"
    avatar_url: Optional[str] = None
    total_points: Optional[int] = 0
    weekly_points: Optional[int] = 0
    rank: Optional[int] = None
    is_current_user: Optional[bool] = False

class ProfileResponse(BaseModel):
    id: str
    email: Optional[str] = ""
    name: Optional[str] = "Student"
    role: Optional[str] = "free"
    bio: Optional[str] = ""
    avatar_url: Optional[str] = None
    streak_days: Optional[int] = 0
    total_score: Optional[int] = 0
    created_at: Optional[str] = None
```

---

## ❾ BACKEND CONFIGURATION

### app/core/config.py

```python
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env")

    APP_ENV: str = "development"
    DEBUG: bool = False
    ALLOWED_ORIGINS: list[str] = ["http://localhost:5173"]

    FIREBASE_CREDENTIALS_JSON: str
    SUPABASE_URL: str
    SUPABASE_SERVICE_KEY: str
    GEMINI_API_KEY: str

settings = Settings()
```

### .env.example

```
APP_ENV=development
DEBUG=false
ALLOWED_ORIGINS=["http://localhost:5173","https://your-app.vercel.app"]
FIREBASE_CREDENTIALS_JSON=/path/to/firebase-service-account.json
SUPABASE_URL=https://ahcgguknfkuapsfakmiy.supabase.co
SUPABASE_SERVICE_KEY=your-service-role-key
GEMINI_API_KEY=your-gemini-api-key
```

### requirements.txt

```
fastapi==0.110.0
uvicorn[standard]==0.27.1
gunicorn==21.2.0
pydantic==2.6.4
pydantic-settings==2.2.1
firebase-admin==6.4.0
supabase==2.4.3
google-generativeai==0.5.4
python-dotenv==1.0.1
structlog==24.1.0
python-multipart==0.0.9
httpx==0.27.0
```

Note: No Redis, no Judge0, no anthropic, no slowapi.
SQLite is stdlib — no package needed.

---

## ❿ FRONTEND — KEY IMPLEMENTATION RULES

### tsconfig.app.json
```json
{
  "compilerOptions": {
    "strict": true,
    "noUnusedLocals": false,
    "noUnusedParameters": false,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "skipLibCheck": true
  }
}
```

### src/lib/api.ts — Typed Fetch Wrapper

```typescript
const BASE = import.meta.env.VITE_API_URL;

class ApiError extends Error {
  constructor(public status: number, public detail: string) {
    super(detail);
  }
}

async function request<T>(
  method: string,
  path: string,
  body?: unknown
): Promise<T> {
  const { getState } = await import('./store/authStore');
  const token = getState().idToken;

  const res = await fetch(`${BASE}${path}`, {
    method,
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    },
    body: body ? JSON.stringify(body) : undefined,
  });

  if (res.status === 401) {
    getState().signOut();
    throw new ApiError(401, 'Session expired');
  }

  if (!res.ok) {
    const err = await res.json().catch(() => ({ detail: 'Unknown error' }));
    throw new ApiError(res.status, err.detail ?? 'Request failed');
  }

  return res.json() as Promise<T>;
}

export const api = {
  getSubjects: () => request<SubjectResponse[]>('GET', '/api/subjects'),
  getChapters: (subjectId: string) =>
    request<ChapterResponse[]>('GET', `/api/chapters/${subjectId}`),
  startQuiz: (subjectId: string, mode: string, count: number, chapterId?: string) =>
    request('GET', `/api/quiz/questions?subject_id=${subjectId}&mode=${mode}&count=${count}${chapterId ? `&chapter_id=${chapterId}` : ''}`),
  submitQuiz: (payload: QuizSubmitPayload) =>
    request('POST', '/api/quiz/submit', payload),
  getQuizHistory: () => request('GET', '/api/quiz/history'),
  getStats: () => request<UserStats>('GET', '/api/progress/stats'),
  updateProgress: (payload: ProgressUpdate) =>
    request('POST', '/api/progress/chapter', payload),
  askDoubt: (payload: DoubtRequest) =>
    request<{ answer: string; doubt_id: string }>('POST', '/api/doubts/ask', payload),
  getDoubtHistory: () => request('GET', '/api/doubts/history'),
  getFlashcards: (subjectId: string, chapterId?: string, dueOnly?: boolean) =>
    request<FlashCard[]>('GET',
      `/api/flashcards?subject_id=${subjectId}${chapterId ? `&chapter_id=${chapterId}` : ''}${dueOnly ? '&due_only=true' : ''}`),
  reviewFlashcard: (flashcardId: string, rating: number) =>
    request('POST', '/api/flashcards/review', { flashcard_id: flashcardId, rating }),
  getLeaderboard: (period: 'weekly' | 'all_time' = 'weekly') =>
    request<LeaderboardResponse>('GET', `/api/leaderboard?period=${period}`),
  getBookmarks: () => request('GET', '/api/bookmarks'),
  addBookmark: (chapterSlug: string, subjectId: string) =>
    request('POST', '/api/bookmarks', { chapter_slug: chapterSlug, subject_id: subjectId }),
  removeBookmark: (chapterSlug: string) =>
    request('DELETE', `/api/bookmarks/${chapterSlug}`),
  getProfile: () => request<ProfileResponse>('GET', '/api/auth/me'),
  updateProfile: (payload: Partial<ProfileResponse>) =>
    request<ProfileResponse>('PUT', '/api/auth/profile', payload),
  syncAuth: (payload: AuthSyncPayload) =>
    request<ProfileResponse>('POST', '/api/auth/session', payload),
};
```

### NotesViewer.tsx — Blob-URL Iframe Protocol (NO DOMPurify)

```typescript
// The notes_url from /api/chapters is a PUBLIC path like:
// /notes/dbms-gate-notes-v2-1.html
// Vercel serves this from CDN — same origin, no auth header needed.

const NotesViewer = ({ notesUrl, chapterSlug, chapterTitle, subjectId }) => {
  const iframeRef = useRef<HTMLIFrameElement>(null);
  const [iframeHeight, setIframeHeight] = useState(600);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const blobUrlRef = useRef<string | null>(null);

  const HEIGHT_SCRIPT = `
    <script>
      function reportHeight() {
        window.parent.postMessage(
          { type: 'ef-notes-height', height: document.body.scrollHeight },
          '*'
        );
      }
      window.addEventListener('load', reportHeight);
      new ResizeObserver(reportHeight).observe(document.body);
    </script>`;

  useEffect(() => {
    let cancelled = false;
    setIsLoading(true);
    setError(null);

    const load = async () => {
      try {
        const html = await fetch(notesUrl).then(r => {
          if (!r.ok) throw new Error(`Notes file not found: ${notesUrl}`);
          return r.text();
        });

        if (cancelled) return;

        // Inject height reporting script before </body>
        const injected = html.includes('</body>')
          ? html.replace('</body>', `${HEIGHT_SCRIPT}</body>`)
          : html + HEIGHT_SCRIPT;

        // Revoke previous blob URL
        if (blobUrlRef.current) URL.revokeObjectURL(blobUrlRef.current);

        const blob = new Blob([injected], { type: 'text/html' });
        const blobUrl = URL.createObjectURL(blob);
        blobUrlRef.current = blobUrl;

        if (iframeRef.current) {
          iframeRef.current.src = blobUrl;
        }
      } catch (e) {
        if (!cancelled) setError((e as Error).message);
      } finally {
        if (!cancelled) setIsLoading(false);
      }
    };

    load();

    const handler = (e: MessageEvent) => {
      if (e.data?.type === 'ef-notes-height') {
        setIframeHeight(e.data.height + 40);
      }
    };
    window.addEventListener('message', handler);

    return () => {
      cancelled = true;
      window.removeEventListener('message', handler);
      if (blobUrlRef.current) URL.revokeObjectURL(blobUrlRef.current);
    };
  }, [notesUrl]);

  if (isLoading) return <Skeleton variant="notes-page" />;
  if (error) return <EmptyState icon="error" title="Notes unavailable" message={error} />;

  return (
    <div style={{ overflowY: 'auto', maxHeight: 'calc(100vh - 120px)' }}>
      <iframe
        ref={iframeRef}
        style={{ width: '100%', height: iframeHeight, border: 'none' }}
        title={chapterTitle}
        sandbox="allow-scripts allow-same-origin"
      />
    </div>
  );
};
```

### NULL-SAFETY CONTRACT — APPLY EVERYWHERE

Every numeric field from the API is null-coalesced before rendering:
```typescript
// Stats
const score = stats?.total_score ?? 0
const streak = stats?.streak_days ?? 0
const accuracy = stats?.accuracy_percent ?? 0
const attempted = stats?.questions_attempted ?? 0

// Leaderboard
const points = entry?.total_points ?? entry?.weekly_points ?? 0
const rank = entry?.rank ?? '-'

// Profile
const name = profile?.name || 'Student'
const bio = profile?.bio || 'No bio yet'

// Arrays
const subjects = data?.subjects ?? []
const questions = data?.questions ?? []
const flashcards = data?.flashcards ?? []
```

---

## ⓫ COMPLETE SYSTEM WORKFLOW VERIFICATION

This section defines the exact end-to-end flow for every major feature.
Verify each flow works before declaring the build complete.

### FLOW 1: New User Signup

```
1. User opens app → sees Landing page (public, no auth)
2. User clicks "Get Started" → navigates to /signup
3. Firebase createUserWithEmailAndPassword() OR signInWithPopup(GoogleAuthProvider)
4. On Firebase success: get idToken from user.getIdToken()
5. POST /api/auth/session { id_token }
   Backend: verify_firebase_token(id_token)
            INSERT INTO profiles (id=uid, email, name) ON CONFLICT DO NOTHING
            profiles trigger: INSERT INTO leaderboard_scores
   Response: { profile_id, role: "free", name, is_new_user: true }
6. Store profile in authStore, store idToken in authStore
7. Navigate to /dashboard
8. Dashboard loads: GET /api/progress/stats → all zeros (new user)
   Shows 0 questions, 0 streak, 0 score — NOT NaN, NOT crash
```

### FLOW 2: Login (Returning User)

```
1. User opens app → ProtectedRoute detects no auth → /login
2. Firebase signInWithEmailAndPassword() OR Google OAuth
3. onIdTokenChanged fires → get fresh idToken
4. POST /api/auth/session → upsert profile → return existing data
5. Navigate to /dashboard (or returnUrl if set)
6. Dashboard data loads from Supabase (progress, stats)
```

### FLOW 3: Load Notes

```
1. User navigates to /notes
2. GET /api/subjects → SubjectResponse[] from SQLite
   Frontend renders subject list with progress_pct from Supabase
3. User selects subject → GET /api/chapters/{subject_id}
   Returns ChapterResponse[] with notes_url: "/notes/dbms-gate-notes-v2-1.html"
4. User clicks chapter → NotesViewer receives notes_url
5. fetch("/notes/dbms-gate-notes-v2-1.html") → raw HTML
   (Same-origin Vercel CDN fetch — <50ms, no auth header)
6. Inject height-reporting script → create Blob URL → set iframe.src
7. iframe fires postMessage → parent sets iframeHeight
8. Notes display at full correct height — NO double scrollbars
9. KaTeX renders automatically (CSS already loaded in index.html)
10. User can highlight text → DoubtDrawer appears → POST /api/doubts/ask
11. POST /api/progress/chapter { chapter_slug, progress_pct: 25 } on scroll depth
```

### FLOW 4: Start Quiz

```
1. User on Notes page → clicks "Practice" for current chapter
   OR User navigates to /practice → selects subject + mode
2. GET /api/quiz/questions?subject_id=dbms&mode=practice&count=10&chapter_id=dbms-ch-01
   Backend: SQLite query → 10 random questions
            INSERT quiz_sessions into Supabase → returns session_id
3. QuestionCard renders one question at a time
   Options shown as OptionButton components
   Timer running (optional, toggleable)
4. User selects answer → stored in quizStore (local)
5. User submits quiz → POST /api/quiz/submit
   Backend: grade each answer from SQLite question data
            UPDATE quiz_sessions (Supabase)
            INSERT quiz_session_answers (Supabase)
            increment_leaderboard_points(uid, correct * 5)
6. Results screen: score, accuracy, per-question explanation
7. Leaderboard updates on next GET /api/leaderboard
```

### FLOW 5: Flashcard Review

```
1. User navigates to chapter → clicks "Flashcards" tab
2. GET /api/flashcards?subject_id=dbms&chapter_id=dbms-ch-01&due_only=true
   Backend: SQLite flashcards + Supabase review state merged
3. FlashcardViewer shows front → user clicks → reveals back
4. User rates: 0-5 (Again, Hard, Good, Easy, Very Easy, Perfect)
5. POST /api/flashcards/review { flashcard_id, rating }
   Backend: SM-2 algorithm → UPSERT flashcard_reviews (Supabase)
            If rating >= 3: +3 leaderboard points
   Response: { next_review_at, interval_days }
6. Next card shown or "All done for today" EmptyState
```

### FLOW 6: Ask Doubt

```
1. User reading notes → selects text
2. "Ask Doubt" floating button appears near selection
3. DoubtDrawer opens (right panel)
4. User types question (or just clicks Ask with selected text)
5. POST /api/doubts/ask {
     chapter_slug: "dbms-gate-notes-v2-1",
     subject_id: "dbms",
     selected_text: "<highlighted text>",
     question: "Why does BCNF require candidate key?"
   }
   Backend: Rate limit check (10/hour per user, Supabase COUNT query)
            Build Gemini prompt with context
            gemini-1.5-flash response
            INSERT into doubt_history (Supabase)
6. Answer displays in DoubtDrawer with LaTeX rendered (KaTeX already loaded)
7. User can ask follow-up (new POST each time — stateless)
```

### FLOW 7: Leaderboard

```
1. User navigates to /leaderboard
2. GET /api/leaderboard?period=weekly
   Backend: Supabase JOIN leaderboard_scores + profiles
            Rank by weekly_points DESC
            Mark is_current_user
3. Table renders: Rank | Name | Score | Weekly
   Current user row highlighted in primary-container bg
   Score column: entry.total_points ?? entry.weekly_points ?? 0
   Empty leaderboard (new platform): EmptyState "Be the first on the board!"
```

---

## ⓬ ADDING NEW CONTENT — FOREVER WORKFLOW

### Add a new notes chapter:
```
1. Drop HTML file → examforge/public/notes/<slug>.html
2. Add to CHAPTERS list in seeds/build_sqlite.py:
   {"id":"new-ch-01","subject_id":"dbms","slug":"new-slug","title":"Title",
    "order_index":5,"has_notes":1,"notes_file":"new-slug.html","has_questions":1}
3. Run: python seeds/build_sqlite.py --reset
4. git push → Vercel deploys frontend + Render redeploys backend with new content.db
Done.
```

### Add new questions:
```
1. Write SQL file → examforge-backend/seeds/questions/dbms-seed-p9.sql
   (use INSERT OR IGNORE INTO questions format)
2. Run: python seeds/build_sqlite.py --subject dbms
   (or --reset for full rebuild)
3. git push → Render redeploys with updated content.db
Done.
```

### Add a new subject entirely:
```
1. Add to SUBJECTS list in build_sqlite.py
2. Add chapters to CHAPTERS list
3. Drop HTML notes files (if any) → public/notes/
4. Drop SQL seed files → seeds/questions/
5. Run: python seeds/build_sqlite.py --reset
6. git push
Done. Subject appears in app automatically.
```

---

## ⓭ DEPLOYMENT CONFIGURATION

### Render (Backend)
- Service type: Web Service
- Build command: pip install -r requirements.txt && python seeds/build_sqlite.py --reset
- Start command: gunicorn main:app --worker-class uvicorn.workers.UvicornWorker --workers 2 --bind 0.0.0.0:$PORT --timeout 60
- content.db is built during deployment — bundled in the running container
- Add all env vars from .env.example in Render dashboard

### Vercel (Frontend)
- Framework: Vite
- Build command: npm run build
- Output directory: dist
- VITE_API_URL env var → set to Render service URL
- VITE_FIREBASE_* env vars → set from Firebase project settings
- public/notes/ files are served as static assets automatically

### CORS (CRITICAL — common failure point)
In FastAPI main.py:
```python
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.ALLOWED_ORIGINS,  # exact Vercel URL + localhost
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```
ALLOWED_ORIGINS must include:
  "http://localhost:5173"
  "https://your-app.vercel.app"  ← exact URL, no trailing slash
  "https://examforge.in"          ← custom domain if any

---

## ⓮ PRE-LAUNCH VERIFICATION CHECKLIST

Run through every item before considering the build complete.

### Backend
- [ ] python seeds/build_sqlite.py --reset runs without errors
- [ ] content.db exists, SELECT COUNT(*) FROM questions > 0
- [ ] SELECT subject_id, COUNT(*) FROM questions GROUP BY 1 — all 13 subjects present
- [ ] uvicorn main:app starts without import errors
- [ ] GET /api/subjects returns 200 with all subjects
- [ ] GET /api/chapters/dbms returns 200 with chapters + notes_url
- [ ] GET /api/quiz/questions?subject_id=dbms&mode=practice&count=5 returns 5 questions
- [ ] GET /api/quiz/questions?subject_id=dbms&count=999 returns available questions, not 500
- [ ] POST /api/quiz/submit with valid answers returns score + results
- [ ] GET /api/progress/stats returns 200 with defaults (no crash on empty DB)
- [ ] POST /api/doubts/ask returns 200 with Gemini answer
- [ ] POST /api/auth/session with valid Firebase token creates profile

### Supabase
- [ ] profiles table exists with all columns
- [ ] user_progress table exists with UNIQUE(user_id, chapter_slug)
- [ ] quiz_sessions table exists with mode column
- [ ] leaderboard_scores table exists
- [ ] doubt_history table exists
- [ ] flashcard_reviews table exists
- [ ] on_profile_created trigger fires (sign up → leaderboard row auto-created)
- [ ] increment_leaderboard_points RPC works

### Frontend
- [ ] npm run build — zero TypeScript errors
- [ ] vite build — zero errors
- [ ] grep "as any" src/ — zero results
- [ ] Signup flow: new user → dashboard shows zeros, not NaN
- [ ] Notes load in iframe — correct height, no double scrollbars
- [ ] KaTeX renders in notes (check a DBMS or TOC note with math)
- [ ] Quiz starts, answers submit, results display with explanations
- [ ] Doubt drawer: type question, get Gemini answer
- [ ] Leaderboard: renders or shows empty state — never crashes
- [ ] Theme toggle persists across page reload
- [ ] Mobile layout: BottomTabBar visible, sidebar hidden

---

*ExamForge Complete System Rebuild Prompt v1.0*
*SQLite (questions) + Static files (notes) + Supabase (user state only)*
*Firebase Auth → FastAPI → SQLite + Supabase → React 18 + Vite*
*Gemini 1.5 Flash for doubts · No Redis · No Judge0 · No Piston*
*Drop files to publish content. Zero schema pain. Production grade.*
