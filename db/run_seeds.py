#!/usr/bin/env python3
"""
ExamForge Supabase Seed Injection Script
Executes 126 SQL seed files + uploads 25 notes HTML files
DB password: fy@/8uzPzTwrnAM
"""

import os
import sys
import requests
import psycopg2
from psycopg2 import sql

# ── Config ────────────────────────────────────────────────────────────────────
DB_HOST     = "aws-0-ap-south-1.pooler.supabase.com"
DB_PORT     = 5432
DB_NAME     = "postgres"
DB_USER     = "postgres.ahcgguknfkuapsfakmiy"
DB_PASSWORD = "fy@/8uzPzTwrnAM"

SUPABASE_URL        = "https://ahcgguknfkuapsfakmiy.supabase.co"
SUPABASE_SERVICE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoY2dndWtuZmt1YXBzZmFrbWl5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3NTM4OTY4OSwiZXhwIjoyMDkwOTY1Njg5fQ.iflGdPoT7E3rgPyGSzABlkazPkJ9M8NsIqiMeXnzPv4"
STORAGE_BUCKET      = "notes-content"

SEEDS_DIR = os.path.join(os.path.dirname(__file__), "seeds")
NOTES_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), "Gate Cse notes")

# ── Seed injection order (base first, then parts) ─────────────────────────────
SEED_ORDER = [
    # algo (9 files)
    "algo-seed.sql", "algo-seed-p1.sql", "algo-seed-p2.sql", "algo-seed-p3.sql",
    "algo-seed-p4.sql", "algo-seed-p5.sql", "algo-seed-p6.sql", "algo-seed-p7.sql",
    "algo-seed-p8.sql",
    # cd (9 files)
    "cd-seed.sql", "cd-seed-p1.sql", "cd-seed-p2.sql", "cd-seed-p3.sql",
    "cd-seed-p4.sql", "cd-seed-p5.sql", "cd-seed-p6.sql", "cd-seed-p7.sql",
    "cd-seed-p8.sql",
    # cn (9 files)
    "cn-seed.sql", "cn-seed-p1.sql", "cn-seed-p2.sql", "cn-seed-p3.sql",
    "cn-seed-p4.sql", "cn-seed-p5.sql", "cn-seed-p6.sql", "cn-seed-p7.sql",
    "cn-seed-p8.sql",
    # coa (9 files)
    "coa-seed.sql", "coa-seed-p1.sql", "coa-seed-p2.sql", "coa-seed-p3.sql",
    "coa-seed-p4.sql", "coa-seed-p5.sql", "coa-seed-p6.sql", "coa-seed-p7.sql",
    "coa-seed-p8.sql",
    # cprog (9 files)
    "cprog-seed.sql", "cprog-seed-p1.sql", "cprog-seed-p2.sql", "cprog-seed-p3.sql",
    "cprog-seed-p4.sql", "cprog-seed-p5.sql", "cprog-seed-p6.sql", "cprog-seed-p7.sql",
    "cprog-seed-p8.sql",
    # dbms (8 files — p7 is last)
    "dbms-seed.sql", "dbms-seed-p1.sql", "dbms-seed-p2.sql", "dbms-seed-p3.sql",
    "dbms-seed-p4.sql", "dbms-seed-p5.sql", "dbms-seed-p6.sql", "dbms-seed-p7.sql",
    # dl (9 files — stays unpublished)
    "dl-seed.sql", "dl-seed-p1.sql", "dl-seed-p2.sql", "dl-seed-p3.sql",
    "dl-seed-p4.sql", "dl-seed-p5.sql", "dl-seed-p6.sql", "dl-seed-p7.sql",
    "dl-seed-p8.sql",
    # dm (9 files)
    "dm-seed.sql", "dm-seed-p1.sql", "dm-seed-p2.sql", "dm-seed-p3.sql",
    "dm-seed-p4.sql", "dm-seed-p5.sql", "dm-seed-p6.sql", "dm-seed-p7.sql",
    "dm-seed-p8.sql",
    # dsa (9 files)
    "dsa-seed.sql", "dsa-seed-p1.sql", "dsa-seed-p2.sql", "dsa-seed-p3.sql",
    "dsa-seed-p4.sql", "dsa-seed-p5.sql", "dsa-seed-p6.sql", "dsa-seed-p7.sql",
    "dsa-seed-p8.sql",
    # em (9 files)
    "em-seed.sql", "em-seed-p1.sql", "em-seed-p2.sql", "em-seed-p3.sql",
    "em-seed-p4.sql", "em-seed-p5.sql", "em-seed-p6.sql", "em-seed-p7.sql",
    "em-seed-p8.sql",
    # ga (11 files — p10 is last)
    "ga-seed.sql", "ga-seed-p1.sql", "ga-seed-p2.sql", "ga-seed-p3.sql",
    "ga-seed-p4.sql", "ga-seed-p5.sql", "ga-seed-p6.sql", "ga-seed-p7.sql",
    "ga-seed-p8.sql", "ga-seed-p9.sql", "ga-seed-p10.sql",
    # os (9 files)
    "os-seed.sql", "os-seed-p1.sql", "os-seed-p2.sql", "os-seed-p3.sql",
    "os-seed-p4.sql", "os-seed-p5.sql", "os-seed-p6.sql", "os-seed-p7.sql",
    "os-seed-p8.sql",
    # toc (9 files)
    "toc-seed.sql", "toc-seed-p1.sql", "toc-seed-p2.sql", "toc-seed-p3.sql",
    "toc-seed-p4.sql", "toc-seed-p5.sql", "toc-seed-p6.sql", "toc-seed-p7.sql",
    "toc-seed-p8.sql",
]

# ── Notes upload mapping ──────────────────────────────────────────────────────
NOTES_UPLOADS = [
    ("algo-01-complexity-sorting-searching.html", "notes/gate/algo/algo-01-complexity-sorting-searching.html"),
    ("algo-02-graph-algorithms.html",             "notes/gate/algo/algo-02-graph-algorithms.html"),
    ("algo-03-dp-greedy-divide-conquer.html",     "notes/gate/algo/algo-03-dp-greedy-divide-conquer.html"),
    ("compiler-design-complete.html",             "notes/gate/cd/compiler-design-complete.html"),
    ("cn-01-datalink-network-routing.html",       "notes/gate/cn/cn-01-datalink-network-routing.html"),
    ("cn-02-transport-application-1.html",        "notes/gate/cn/cn-02-transport-application-1.html"),
    ("coa-01-number-systems-boolean-circuits.html","notes/gate/coa/coa-01-number-systems-boolean-circuits.html"),
    ("coa-02-cpu-isa-pipeline-memory.html",       "notes/gate/coa/coa-02-cpu-isa-pipeline-memory.html"),
    ("c-programming-complete-1.html",             "notes/gate/cprog/c-programming-complete-1.html"),
    ("dbms-gate-notes-v2-1.html",                 "notes/gate/dbms/dbms-gate-notes-v2-1.html"),
    ("dbms-02-sql-relational-algebra-3.html",     "notes/gate/dbms/dbms-02-sql-relational-algebra-3.html"),
    ("dbms-03-transactions-concurrency-1.html",   "notes/gate/dbms/dbms-03-transactions-concurrency-1.html"),
    ("dbms-04-er-indexing-relational-calculus.html","notes/gate/dbms/dbms-04-er-indexing-relational-calculus.html"),
    ("dm-01-logic-sets-relations-functions-2.html","notes/gate/dm/dm-01-logic-sets-relations-functions-2.html"),
    ("dm-02-graph-theory-combinatorics.html",     "notes/gate/dm/dm-02-graph-theory-combinatorics.html"),
    ("ds-01-linear-data-structures-2.html",       "notes/gate/dsa/ds-01-linear-data-structures-2.html"),
    ("ds-02-trees-heaps.html",                    "notes/gate/dsa/ds-02-trees-heaps.html"),
    ("em-01-calculus-linear-algebra-probability-2.html","notes/gate/em/em-01-calculus-linear-algebra-probability-2.html"),
    ("em-02-differential-equations-numerical-methods.html","notes/gate/em/em-02-differential-equations-numerical-methods.html"),
    ("os-01-processes-scheduling-synchronization.html","notes/gate/os/os-01-processes-scheduling-synchronization.html"),
    ("os-02-memory-filesystems-io.html",          "notes/gate/os/os-02-memory-filesystems-io.html"),
    ("toc-01-automata-grammars.html",             "notes/gate/toc/toc-01-automata-grammars.html"),
    ("toc-02-turing-decidability.html",           "notes/gate/toc/toc-02-turing-decidability.html"),
    ("aptitude-quantitative-master.html",         "notes/gate/ga/aptitude-quantitative-master.html"),
    ("aptitude-verbal-master.html",               "notes/gate/ga/aptitude-verbal-master.html"),
]

# ── Binding SQL ───────────────────────────────────────────────────────────────
BINDING_SQL = """
-- ALGO
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

-- CN
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/cn/cn-01-datalink-network-routing.html', 'html', true
FROM chapters WHERE slug = 'datalink-network-routing' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/cn/cn-02-transport-application-1.html', 'html', true
FROM chapters WHERE slug = 'transport-application' LIMIT 1
ON CONFLICT DO NOTHING;

-- COA
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/coa/coa-01-number-systems-boolean-circuits.html', 'html', true
FROM chapters WHERE slug = 'number-systems-boolean' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/coa/coa-02-cpu-isa-pipeline-memory.html', 'html', true
FROM chapters WHERE slug = 'cpu-isa-pipeline-memory' LIMIT 1
ON CONFLICT DO NOTHING;

-- CD — covers ALL cd chapters
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/cd/compiler-design-complete.html', 'html', true
FROM chapters WHERE subject_id = (SELECT id FROM subjects WHERE slug = 'cd')
ON CONFLICT DO NOTHING;

-- CPROG — covers ALL cprog chapters
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/cprog/c-programming-complete-1.html', 'html', true
FROM chapters WHERE subject_id = (SELECT id FROM subjects WHERE slug = 'cprog')
ON CONFLICT DO NOTHING;

-- DBMS
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

-- DM
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dm/dm-01-logic-sets-relations-functions-2.html', 'html', true
FROM chapters WHERE slug = 'logic-sets-relations' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dm/dm-02-graph-theory-combinatorics.html', 'html', true
FROM chapters WHERE slug = 'graph-theory-combinatorics' LIMIT 1
ON CONFLICT DO NOTHING;

-- DSA
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dsa/ds-01-linear-data-structures-2.html', 'html', true
FROM chapters WHERE slug = 'arrays-strings-hashing' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/dsa/ds-02-trees-heaps.html', 'html', true
FROM chapters WHERE slug = 'trees-bst' LIMIT 1
ON CONFLICT DO NOTHING;

-- EM
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/em/em-01-calculus-linear-algebra-probability-2.html', 'html', true
FROM chapters WHERE slug = 'calculus-linear-algebra' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/em/em-02-differential-equations-numerical-methods.html', 'html', true
FROM chapters WHERE slug = 'differential-equations' LIMIT 1
ON CONFLICT DO NOTHING;

-- OS
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/os/os-01-processes-scheduling-synchronization.html', 'html', true
FROM chapters WHERE slug = 'processes-scheduling' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/os/os-02-memory-filesystems-io.html', 'html', true
FROM chapters WHERE slug = 'memory-filesystems' LIMIT 1
ON CONFLICT DO NOTHING;

-- TOC
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/toc/toc-01-automata-grammars.html', 'html', true
FROM chapters WHERE slug = 'automata-grammars' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/toc/toc-02-turing-decidability.html', 'html', true
FROM chapters WHERE slug = 'turing-decidability' LIMIT 1
ON CONFLICT DO NOTHING;

-- GA
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/ga/aptitude-quantitative-master.html', 'html', true
FROM chapters WHERE slug = 'quantitative-aptitude' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/ga/aptitude-verbal-master.html', 'html', true
FROM chapters WHERE slug = 'verbal-aptitude' LIMIT 1
ON CONFLICT DO NOTHING;
"""

FLIP_SUBJECTS_SQL = """
UPDATE subjects
SET is_published = true
WHERE slug IN (
  'algo', 'cd', 'cn', 'coa', 'cprog',
  'dbms', 'dm', 'dsa', 'em', 'ga', 'os', 'toc'
);
"""


def get_db_conn():
    """Connect to Supabase Postgres directly."""
    return psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        connect_timeout=30,
        sslmode="require"
    )


def execute_sql_file(conn, filepath, filename):
    """Read and execute a SQL file. Returns (success, error_msg)."""
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            sql_content = f.read()
        
        with conn.cursor() as cur:
            cur.execute(sql_content)
        conn.commit()
        return True, None
    except Exception as e:
        conn.rollback()
        return False, str(e)


def upload_note_file(local_path, storage_path):
    """Upload an HTML file to Supabase Storage. Returns (success, error_msg)."""
    try:
        with open(local_path, "rb") as f:
            data = f.read()
        
        headers = {
            "Authorization": f"Bearer {SUPABASE_SERVICE_KEY}",
            "Content-Type": "text/html",
            "x-upsert": "true",
        }
        url = f"{SUPABASE_URL}/storage/v1/object/{STORAGE_BUCKET}/{storage_path}"
        resp = requests.post(url, headers=headers, data=data, timeout=60)
        
        if resp.status_code in (200, 201):
            return True, None
        else:
            return False, f"HTTP {resp.status_code}: {resp.text[:200]}"
    except Exception as e:
        return False, str(e)


def ensure_bucket_exists():
    """Create notes-content bucket if it doesn't exist."""
    headers = {
        "Authorization": f"Bearer {SUPABASE_SERVICE_KEY}",
        "Content-Type": "application/json",
    }
    # Check if bucket exists
    resp = requests.get(f"{SUPABASE_URL}/storage/v1/bucket/{STORAGE_BUCKET}", headers=headers)
    if resp.status_code == 200:
        print(f"  ✅ Bucket '{STORAGE_BUCKET}' exists (private)")
        return True
    
    # Create it
    payload = {"id": STORAGE_BUCKET, "name": STORAGE_BUCKET, "public": False}
    resp = requests.post(f"{SUPABASE_URL}/storage/v1/bucket", headers=headers, json=payload)
    if resp.status_code in (200, 201):
        print(f"  ✅ Bucket '{STORAGE_BUCKET}' created (private)")
        return True
    else:
        print(f"  ❌ Failed to create bucket: HTTP {resp.status_code}: {resp.text[:200]}")
        return False


def main():
    print("═" * 60)
    print("EXAMFORGE — SUPABASE SEED INJECTION")
    print("═" * 60)

    # ── PHASE 1: Pre-flight ───────────────────────────────────────
    print("\n📋 PHASE 1 — PRE-FLIGHT CHECKS")

    # 1A — Check / create storage bucket
    print("\n  1A — Storage bucket check:")
    bucket_ok = ensure_bucket_exists()

    # 1B — DB connection + schema check
    print("\n  1B — Database connection:")
    try:
        conn = get_db_conn()
        print("  ✅ Connected to Supabase PostgreSQL")
    except Exception as e:
        print(f"  ❌ FATAL: Cannot connect to DB: {e}")
        sys.exit(1)

    with conn.cursor() as cur:
        cur.execute("""
            SELECT table_name FROM information_schema.tables
            WHERE table_schema = 'public' ORDER BY table_name
        """)
        tables = [r[0] for r in cur.fetchall()]
    
    required = ['subjects','chapters','topics','questions','question_tags',
                'tags','flashcards','notes','quiz_sessions']
    missing = [t for t in required if t not in tables]
    if missing:
        print(f"  ❌ SCHEMA MISSING TABLES: {missing}")
        print("  STOP: Run schema migrations first.")
        conn.close()
        sys.exit(1)
    else:
        print(f"  ✅ Schema OK — {len(tables)} tables found")

    # 1C — Existing data check
    print("\n  1C — Existing data:")
    with conn.cursor() as cur:
        cur.execute("""
            SELECT
              (SELECT COUNT(*) FROM subjects)       AS subjects,
              (SELECT COUNT(*) FROM questions)      AS questions,
              (SELECT COUNT(*) FROM flashcards)     AS flashcards,
              (SELECT COUNT(*) FROM tags)           AS tags,
              (SELECT COUNT(*) FROM question_tags)  AS question_tags,
              (SELECT COUNT(*) FROM notes)          AS notes_rows
        """)
        row = cur.fetchone()
    
    subjects_cnt, questions_cnt, flashcards_cnt, tags_cnt, qt_cnt, notes_cnt = row
    print(f"  subjects={subjects_cnt}, questions={questions_cnt}, flashcards={flashcards_cnt}")
    print(f"  tags={tags_cnt}, question_tags={qt_cnt}, notes_rows={notes_cnt}")

    # Ensure exam_configs has gate-cse
    with conn.cursor() as cur:
        cur.execute("INSERT INTO exam_configs (slug, name) VALUES ('gate-cse', 'GATE Computer Science') ON CONFLICT (slug) DO NOTHING")
        cur.execute("INSERT INTO branches (name) VALUES ('cse') ON CONFLICT (name) DO NOTHING")
    conn.commit()
    print("  ✅ exam_configs and branches ensured")

    # Ensure flashcards table has subject_id, topic_id, tags columns
    with conn.cursor() as cur:
        cur.execute("ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS subject_id uuid REFERENCES subjects(id)")
        cur.execute("ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS topic_id uuid REFERENCES topics(id)")
        cur.execute("ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS tags text[]")
    conn.commit()
    print("  ✅ Flashcard schema extended")

    # ── PHASE 2: SQL Seeds ────────────────────────────────────────
    print(f"\n📦 PHASE 2 — INJECTING {len(SEED_ORDER)} SQL SEED FILES")
    
    succeeded = []
    failed = []
    
    for i, filename in enumerate(SEED_ORDER, 1):
        filepath = os.path.join(SEEDS_DIR, filename)
        
        if not os.path.exists(filepath):
            print(f"  ❌ [{i:03d}/{len(SEED_ORDER)}] {filename} — FILE NOT FOUND")
            failed.append((filename, "File not found"))
            continue
        
        is_base = not any(f"-p{n}" in filename for n in range(1, 20))
        ok, err = execute_sql_file(conn, filepath, filename)
        
        if ok:
            slug = filename.replace("-seed.sql","").replace(".sql","").split("-seed-p")[0]
            if is_base:
                print(f"  ✅ [{i:03d}/{len(SEED_ORDER)}] {filename}  ← BASE SEEDED")
            else:
                print(f"  ✅ [{i:03d}/{len(SEED_ORDER)}] {filename}")
            succeeded.append(filename)
        else:
            print(f"  ❌ [{i:03d}/{len(SEED_ORDER)}] {filename} — ERROR: {err[:120]}")
            failed.append((filename, err[:120]))
    
    print(f"\n  SEED INJECTION: {len(succeeded)}/{len(SEED_ORDER)} succeeded, {len(failed)} failed")
    if failed:
        print("  Failed files:")
        for fn, err in failed:
            print(f"    ❌ {fn}: {err}")

    # ── PHASE 3: Upload Notes ─────────────────────────────────────
    print(f"\n📄 PHASE 3 — UPLOADING {len(NOTES_UPLOADS)} NOTES HTML FILES")
    
    notes_succeeded = []
    notes_failed = []
    
    for local_name, storage_path in NOTES_UPLOADS:
        local_path = os.path.join(NOTES_DIR, local_name)
        
        if not os.path.exists(local_path):
            print(f"  ❌ {local_name} — FILE NOT FOUND at {local_path}")
            notes_failed.append((local_name, "File not found"))
            continue
        
        ok, err = upload_note_file(local_path, storage_path)
        if ok:
            print(f"  ✅ {storage_path}")
            notes_succeeded.append(storage_path)
        else:
            print(f"  ❌ {storage_path} — {err}")
            notes_failed.append((local_name, err))
    
    print(f"\n  NOTES UPLOAD: {len(notes_succeeded)}/25 succeeded, {len(notes_failed)} failed")
    if notes_failed:
        for fn, err in notes_failed:
            print(f"    ❌ {fn}: {err}")

    # ── PHASE 4: Binding SQL ──────────────────────────────────────
    print("\n🔗 PHASE 4 — BINDING SQL")
    
    # Run binding SQL
    print("  4A — Inserting notes table rows...")
    try:
        with conn.cursor() as cur:
            cur.execute(BINDING_SQL)
        conn.commit()
        print("  ✅ Binding SQL executed")
    except Exception as e:
        conn.rollback()
        print(f"  ❌ Binding SQL failed: {e}")
    
    # Check count
    with conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM notes")
        notes_count = cur.fetchone()[0]
    print(f"  Notes rows in DB: {notes_count}")
    
    # Run slug reconciliation check
    print("\n  4B — Slug reconciliation check:")
    with conn.cursor() as cur:
        cur.execute("""
            SELECT s.slug AS subject, c.slug AS chapter_slug, c.title
            FROM chapters c
            JOIN subjects s ON s.id = c.subject_id
            ORDER BY s.slug, c.order_index
        """)
        rows = cur.fetchall()
    
    print(f"  Found {len(rows)} chapters in DB:")
    for subject, ch_slug, ch_title in rows:
        print(f"    {subject} | {ch_slug} | {ch_title}")

    # 4C — Flip subjects live
    print("\n  4C — Flipping subjects live...")
    try:
        with conn.cursor() as cur:
            cur.execute(FLIP_SUBJECTS_SQL)
        conn.commit()
        print("  ✅ is_published = true for: algo, cd, cn, coa, cprog, dbms, dm, dsa, em, ga, os, toc")
        
        # Verify dl stays false
        with conn.cursor() as cur:
            cur.execute("SELECT slug, is_published FROM subjects WHERE slug = 'dl'")
            dl_row = cur.fetchone()
        if dl_row:
            print(f"  dl: is_published = {dl_row[1]}  ← expected false")
    except Exception as e:
        conn.rollback()
        print(f"  ❌ Flip failed: {e}")

    # ── PHASE 5: Health Verification ─────────────────────────────
    print("\n🏥 PHASE 5 — HEALTH VERIFICATION")
    
    print("\n  5A — System health per subject:")
    with conn.cursor() as cur:
        cur.execute("""
            SELECT
              s.slug,
              s.is_published,
              COUNT(DISTINCT q.id)   AS questions,
              COUNT(DISTINCT f.id)   AS flashcards,
              COUNT(DISTINCT n.id)   AS notes_chapters
            FROM subjects s
            LEFT JOIN questions q    ON q.subject_id = s.id
            LEFT JOIN flashcards f   ON f.subject_id = s.id
            LEFT JOIN chapters c     ON c.subject_id = s.id
            LEFT JOIN notes n        ON n.chapter_id = c.id
            WHERE s.category = 'GATE'
            GROUP BY s.slug, s.is_published
            ORDER BY s.slug
        """)
        health_rows = cur.fetchall()
    
    print(f"  {'Slug':<10} {'Published':<12} {'Questions':<12} {'Flashcards':<12} {'Notes'}")
    print(f"  {'-'*10} {'-'*12} {'-'*12} {'-'*12} {'-'*6}")
    for slug, published, q, f, n in health_rows:
        flag = "⚠️" if q < 50 else "✅"
        print(f"  {flag} {slug:<9} {str(published):<12} {q:<12} {f:<12} {n}")

    print("\n  5B — Orphan checks:")
    with conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM questions WHERE topic_id IS NULL")
        orphan_q = cur.fetchone()[0]
        cur.execute("""
            SELECT COUNT(*) FROM notes n
            LEFT JOIN chapters c ON c.id = n.chapter_id
            WHERE c.id IS NULL
        """)
        orphan_n = cur.fetchone()[0]
        cur.execute("""
            SELECT COUNT(*) FROM question_tags qt
            LEFT JOIN questions q ON q.id = qt.question_id
            LEFT JOIN tags t ON t.id = qt.tag_id
            WHERE q.id IS NULL OR t.id IS NULL
        """)
        orphan_qt = cur.fetchone()[0]
    
    print(f"  {'✅' if orphan_q == 0 else '❌'} Questions missing topic_id: {orphan_q}")
    print(f"  {'✅' if orphan_n == 0 else '❌'} Orphaned notes rows: {orphan_n}")
    print(f"  {'✅' if orphan_qt == 0 else '❌'} Orphaned question_tags: {orphan_qt}")

    print("\n  5C — Total counts:")
    with conn.cursor() as cur:
        cur.execute("""
            SELECT
              (SELECT COUNT(*) FROM subjects WHERE category = 'GATE') AS subjects,
              (SELECT COUNT(*) FROM chapters)                         AS chapters,
              (SELECT COUNT(*) FROM topics)                           AS topics,
              (SELECT COUNT(*) FROM questions)                        AS questions,
              (SELECT COUNT(*) FROM flashcards)                       AS flashcards,
              (SELECT COUNT(*) FROM tags)                             AS tags,
              (SELECT COUNT(*) FROM question_tags)                    AS question_tags,
              (SELECT COUNT(*) FROM notes)                            AS notes_rows
        """)
        totals = cur.fetchone()
    
    labels = ["subjects","chapters","topics","questions","flashcards","tags","question_tags","notes_rows"]
    minimums = [13, 40, 100, 1300, 520, 200, 1000, 25]
    for label, val, minimum in zip(labels, totals, minimums):
        flag = "✅" if val >= minimum else "⚠️"
        print(f"  {flag} {label}: {val}  (min: {minimum})")

    conn.close()

    # ── PHASE 6: Final Report ─────────────────────────────────────
    print("\n" + "═" * 60)
    print("EXAMFORGE DATABASE INJECTION — FINAL REPORT")
    print("═" * 60)
    print(f"\nPHASE 1 — Pre-flight")
    print(f"  Schema:  {'PASS' if not missing else 'FAIL'}")
    print(f"  Bucket:  {'PASS' if bucket_ok else 'FAIL'}")
    print(f"\nPHASE 2 — SQL Seeds ({len(SEED_ORDER)} files)")
    print(f"  Succeeded: {len(succeeded)}/{len(SEED_ORDER)}")
    print(f"  Failed:    {len(failed)}/{len(SEED_ORDER)}")
    if failed:
        print(f"  Failed files: {[f[0] for f in failed]}")
    print(f"\nPHASE 3 — Notes Upload (25 files)")
    print(f"  Succeeded: {len(notes_succeeded)}/25")
    print(f"  Failed:    {len(notes_failed)}/25")
    print(f"\nSTATUS: {'✅ COMPLETE' if not failed and not notes_failed else '⚠️ PARTIAL — check errors above'}")
    print("═" * 60)


if __name__ == "__main__":
    main()
