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

-- Indices
CREATE INDEX IF NOT EXISTS idx_questions_subject ON questions(subject_id);
CREATE INDEX IF NOT EXISTS idx_questions_chapter ON questions(chapter_id);
CREATE INDEX IF NOT EXISTS idx_questions_type ON questions(type);
CREATE INDEX IF NOT EXISTS idx_questions_difficulty ON questions(difficulty);
CREATE INDEX IF NOT EXISTS idx_questions_gate_year ON questions(gate_year);
CREATE INDEX IF NOT EXISTS idx_flashcards_subject ON flashcards(subject_id);
CREATE INDEX IF NOT EXISTS idx_flashcards_chapter ON flashcards(chapter_id);
