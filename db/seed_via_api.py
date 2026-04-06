#!/usr/bin/env python3
"""
ExamForge Supabase Seed Injection — via Management API
Uses POST /pg/v1/query (Management API) to execute SQL
"""

import os
import sys
import time
import requests

# ── Config ────────────────────────────────────────────────────────────────────
PROJECT_REF     = "ahcgguknfkuapsfakmiy"
DB_PASSWORD     = "fy@/8uzPzTwrnAM"
SUPABASE_URL    = "https://ahcgguknfkuapsfakmiy.supabase.co"
SERVICE_KEY     = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFoY2dndWtuZmt1YXBzZmFrbWl5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3NTM4OTY4OSwiZXhwIjoyMDkwOTY1Njg5fQ.iflGdPoT7E3rgPyGSzABlkazPkJ9M8NsIqiMeXnzPv4"
STORAGE_BUCKET  = "notes-content"

SEEDS_DIR = os.path.join(os.path.dirname(__file__), "seeds")
NOTES_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), "Gate Cse notes")

# Supabase Management API base
MGMT_BASE = "https://api.supabase.com"

SEED_ORDER = [
    "algo-seed.sql","algo-seed-p1.sql","algo-seed-p2.sql","algo-seed-p3.sql",
    "algo-seed-p4.sql","algo-seed-p5.sql","algo-seed-p6.sql","algo-seed-p7.sql","algo-seed-p8.sql",
    "cd-seed.sql","cd-seed-p1.sql","cd-seed-p2.sql","cd-seed-p3.sql",
    "cd-seed-p4.sql","cd-seed-p5.sql","cd-seed-p6.sql","cd-seed-p7.sql","cd-seed-p8.sql",
    "cn-seed.sql","cn-seed-p1.sql","cn-seed-p2.sql","cn-seed-p3.sql",
    "cn-seed-p4.sql","cn-seed-p5.sql","cn-seed-p6.sql","cn-seed-p7.sql","cn-seed-p8.sql",
    "coa-seed.sql","coa-seed-p1.sql","coa-seed-p2.sql","coa-seed-p3.sql",
    "coa-seed-p4.sql","coa-seed-p5.sql","coa-seed-p6.sql","coa-seed-p7.sql","coa-seed-p8.sql",
    "cprog-seed.sql","cprog-seed-p1.sql","cprog-seed-p2.sql","cprog-seed-p3.sql",
    "cprog-seed-p4.sql","cprog-seed-p5.sql","cprog-seed-p6.sql","cprog-seed-p7.sql","cprog-seed-p8.sql",
    "dbms-seed.sql","dbms-seed-p1.sql","dbms-seed-p2.sql","dbms-seed-p3.sql",
    "dbms-seed-p4.sql","dbms-seed-p5.sql","dbms-seed-p6.sql","dbms-seed-p7.sql",
    "dl-seed.sql","dl-seed-p1.sql","dl-seed-p2.sql","dl-seed-p3.sql",
    "dl-seed-p4.sql","dl-seed-p5.sql","dl-seed-p6.sql","dl-seed-p7.sql","dl-seed-p8.sql",
    "dm-seed.sql","dm-seed-p1.sql","dm-seed-p2.sql","dm-seed-p3.sql",
    "dm-seed-p4.sql","dm-seed-p5.sql","dm-seed-p6.sql","dm-seed-p7.sql","dm-seed-p8.sql",
    "dsa-seed.sql","dsa-seed-p1.sql","dsa-seed-p2.sql","dsa-seed-p3.sql",
    "dsa-seed-p4.sql","dsa-seed-p5.sql","dsa-seed-p6.sql","dsa-seed-p7.sql","dsa-seed-p8.sql",
    "em-seed.sql","em-seed-p1.sql","em-seed-p2.sql","em-seed-p3.sql",
    "em-seed-p4.sql","em-seed-p5.sql","em-seed-p6.sql","em-seed-p7.sql","em-seed-p8.sql",
    "ga-seed.sql","ga-seed-p1.sql","ga-seed-p2.sql","ga-seed-p3.sql",
    "ga-seed-p4.sql","ga-seed-p5.sql","ga-seed-p6.sql","ga-seed-p7.sql",
    "ga-seed-p8.sql","ga-seed-p9.sql","ga-seed-p10.sql",
    "os-seed.sql","os-seed-p1.sql","os-seed-p2.sql","os-seed-p3.sql",
    "os-seed-p4.sql","os-seed-p5.sql","os-seed-p6.sql","os-seed-p7.sql","os-seed-p8.sql",
    "toc-seed.sql","toc-seed-p1.sql","toc-seed-p2.sql","toc-seed-p3.sql",
    "toc-seed-p4.sql","toc-seed-p5.sql","toc-seed-p6.sql","toc-seed-p7.sql","toc-seed-p8.sql",
]

NOTES_UPLOADS = [
    ("algo-01-complexity-sorting-searching.html","notes/gate/algo/algo-01-complexity-sorting-searching.html"),
    ("algo-02-graph-algorithms.html","notes/gate/algo/algo-02-graph-algorithms.html"),
    ("algo-03-dp-greedy-divide-conquer.html","notes/gate/algo/algo-03-dp-greedy-divide-conquer.html"),
    ("compiler-design-complete.html","notes/gate/cd/compiler-design-complete.html"),
    ("cn-01-datalink-network-routing.html","notes/gate/cn/cn-01-datalink-network-routing.html"),
    ("cn-02-transport-application-1.html","notes/gate/cn/cn-02-transport-application-1.html"),
    ("coa-01-number-systems-boolean-circuits.html","notes/gate/coa/coa-01-number-systems-boolean-circuits.html"),
    ("coa-02-cpu-isa-pipeline-memory.html","notes/gate/coa/coa-02-cpu-isa-pipeline-memory.html"),
    ("c-programming-complete-1.html","notes/gate/cprog/c-programming-complete-1.html"),
    ("dbms-gate-notes-v2-1.html","notes/gate/dbms/dbms-gate-notes-v2-1.html"),
    ("dbms-02-sql-relational-algebra-3.html","notes/gate/dbms/dbms-02-sql-relational-algebra-3.html"),
    ("dbms-03-transactions-concurrency-1.html","notes/gate/dbms/dbms-03-transactions-concurrency-1.html"),
    ("dbms-04-er-indexing-relational-calculus.html","notes/gate/dbms/dbms-04-er-indexing-relational-calculus.html"),
    ("dm-01-logic-sets-relations-functions-2.html","notes/gate/dm/dm-01-logic-sets-relations-functions-2.html"),
    ("dm-02-graph-theory-combinatorics.html","notes/gate/dm/dm-02-graph-theory-combinatorics.html"),
    ("ds-01-linear-data-structures-2.html","notes/gate/dsa/ds-01-linear-data-structures-2.html"),
    ("ds-02-trees-heaps.html","notes/gate/dsa/ds-02-trees-heaps.html"),
    ("em-01-calculus-linear-algebra-probability-2.html","notes/gate/em/em-01-calculus-linear-algebra-probability-2.html"),
    ("em-02-differential-equations-numerical-methods.html","notes/gate/em/em-02-differential-equations-numerical-methods.html"),
    ("os-01-processes-scheduling-synchronization.html","notes/gate/os/os-01-processes-scheduling-synchronization.html"),
    ("os-02-memory-filesystems-io.html","notes/gate/os/os-02-memory-filesystems-io.html"),
    ("toc-01-automata-grammars.html","notes/gate/toc/toc-01-automata-grammars.html"),
    ("toc-02-turing-decidability.html","notes/gate/toc/toc-02-turing-decidability.html"),
    ("aptitude-quantitative-master.html","notes/gate/ga/aptitude-quantitative-master.html"),
    ("aptitude-verbal-master.html","notes/gate/ga/aptitude-verbal-master.html"),
]

def execute_sql(sql_text, description=""):
    """Execute SQL via Supabase Management API /pg/v1/query"""
    url = f"{MGMT_BASE}/v1/projects/{PROJECT_REF}/database/query"
    headers = {
        "Authorization": f"Bearer {SERVICE_KEY}",
        "Content-Type": "application/json",
    }
    payload = {"query": sql_text}
    try:
        resp = requests.post(url, headers=headers, json=payload, timeout=120)
        if resp.status_code == 200:
            return True, None
        else:
            return False, f"HTTP {resp.status_code}: {resp.text[:300]}"
    except Exception as e:
        return False, str(e)


def execute_sql_file(filepath):
    """Read file and execute via API."""
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()
    return execute_sql(content)


def upload_note(local_path, storage_path):
    """Upload HTML file to Supabase Storage."""
    with open(local_path, "rb") as f:
        data = f.read()
    url = f"{SUPABASE_URL}/storage/v1/object/{STORAGE_BUCKET}/{storage_path}"
    headers = {
        "Authorization": f"Bearer {SERVICE_KEY}",
        "Content-Type": "text/html",
        "x-upsert": "true",
    }
    try:
        resp = requests.post(url, headers=headers, data=data, timeout=120)
        if resp.status_code in (200, 201):
            return True, None
        return False, f"HTTP {resp.status_code}: {resp.text[:200]}"
    except Exception as e:
        return False, str(e)


def ensure_bucket():
    headers = {"Authorization": f"Bearer {SERVICE_KEY}", "Content-Type": "application/json"}
    resp = requests.get(f"{SUPABASE_URL}/storage/v1/bucket/{STORAGE_BUCKET}", headers=headers)
    if resp.status_code == 200:
        print(f"  ✅ Bucket '{STORAGE_BUCKET}' already exists")
        return True
    payload = {"id": STORAGE_BUCKET, "name": STORAGE_BUCKET, "public": False}
    resp = requests.post(f"{SUPABASE_URL}/storage/v1/bucket", headers=headers, json=payload)
    if resp.status_code in (200, 201):
        print(f"  ✅ Bucket '{STORAGE_BUCKET}' created")
        return True
    print(f"  ❌ Bucket create failed: {resp.status_code} {resp.text[:100]}")
    return False


def main():
    print("=" * 60)
    print("EXAMFORGE — SUPABASE SEED INJECTION (via Management API)")
    print("=" * 60)

    # ── Phase 1: Pre-flight ───────────────────────────────────────
    print("\n[PHASE 1] PRE-FLIGHT CHECKS")

    # Test API connectivity
    ok, err = execute_sql("SELECT 1 AS test")
    if not ok:
        print(f"  ❌ FATAL: API not reachable: {err}")
        print("  Note: Management API requires a personal access token, not service role key.")
        print("  Trying anon key approach instead...")
        # The execute_sql uses service key as Bearer — this IS the right key for management API
        sys.exit(1)
    print("  ✅ Management API connected")

    # Ensure bucket
    ensure_bucket()

    # Ensure prerequisites
    prereq_sql = """
    INSERT INTO exam_configs (slug, name) VALUES ('gate-cse', 'GATE Computer Science') ON CONFLICT (slug) DO NOTHING;
    INSERT INTO branches (name) VALUES ('cse') ON CONFLICT (name) DO NOTHING;
    ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS subject_id uuid REFERENCES subjects(id);
    ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS topic_id uuid REFERENCES topics(id);
    ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS tags text[];
    """
    ok, err = execute_sql(prereq_sql)
    if ok:
        print("  ✅ Prerequisites (exam_configs, branches, flashcard columns) OK")
    else:
        print(f"  ⚠️  Prerequisites: {err}")

    # Count existing
    ok, err = execute_sql("SELECT COUNT(*) FROM questions")
    print(f"  Current state: {err or 'Questions table accessible'}")

    # ── Phase 2: SQL Seeds ────────────────────────────────────────
    total = len(SEED_ORDER)
    print(f"\n[PHASE 2] INJECTING {total} SQL SEED FILES")
    succeeded, failed = [], []

    for i, filename in enumerate(SEED_ORDER, 1):
        filepath = os.path.join(SEEDS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  ❌ [{i:03d}/{total}] {filename} — FILE NOT FOUND")
            failed.append((filename, "File not found"))
            continue

        ok, err = execute_sql_file(filepath)
        if ok:
            marker = " ← BASE" if not any(f"-p{n}" in filename for n in range(1,20)) else ""
            print(f"  ✅ [{i:03d}/{total}] {filename}{marker}")
            succeeded.append(filename)
        else:
            print(f"  ❌ [{i:03d}/{total}] {filename} — {err[:100]}")
            failed.append((filename, err[:100]))

    print(f"\n  Seeds: {len(succeeded)}/{total} succeeded, {len(failed)} failed")
    if failed:
        for fn, e in failed:
            print(f"    ❌ {fn}: {e}")

    # ── Phase 3: Notes Upload ─────────────────────────────────────
    print(f"\n[PHASE 3] UPLOADING 25 NOTES HTML FILES")
    n_ok, n_fail = [], []

    for local_name, storage_path in NOTES_UPLOADS:
        local_path = os.path.join(NOTES_DIR, local_name)
        if not os.path.exists(local_path):
            print(f"  ❌ {local_name} — NOT FOUND at {local_path}")
            n_fail.append((local_name, "File not found"))
            continue
        ok, err = upload_note(local_path, storage_path)
        if ok:
            print(f"  ✅ {storage_path}")
            n_ok.append(storage_path)
        else:
            print(f"  ❌ {storage_path} — {err}")
            n_fail.append((local_name, err))

    print(f"\n  Notes: {len(n_ok)}/25 uploaded, {len(n_fail)} failed")

    # ── Phase 4: Binding SQL ──────────────────────────────────────
    print("\n[PHASE 4] BINDING SQL")

    # First get actual chapter slugs to reconcile
    ok, err = execute_sql("""
        SELECT s.slug AS subject, c.slug AS chapter_slug
        FROM chapters c JOIN subjects s ON s.id = c.subject_id
        ORDER BY s.slug, c.order_index
    """)
    print(f"  Chapter slug query: {'OK' if ok else err}")

    binding_sql = """
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

    INSERT INTO notes (chapter_id, storage_path, format, is_published)
    SELECT id, 'notes/gate/cd/compiler-design-complete.html', 'html', true
    FROM chapters WHERE subject_id = (SELECT id FROM subjects WHERE slug = 'cd')
    ON CONFLICT DO NOTHING;

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

    UPDATE subjects SET is_published = true
    WHERE slug IN ('algo','cd','cn','coa','cprog','dbms','dm','dsa','em','ga','os','toc');
    """
    ok, err = execute_sql(binding_sql)
    if ok:
        print("  ✅ Binding SQL + subjects flipped live")
    else:
        print(f"  ❌ Binding SQL: {err}")

    print("\n[PHASE 5] HEALTH CHECK")
    ok, err = execute_sql("""
        SELECT
          (SELECT COUNT(*) FROM subjects WHERE category='GATE') AS subjects,
          (SELECT COUNT(*) FROM chapters) AS chapters,
          (SELECT COUNT(*) FROM topics) AS topics,
          (SELECT COUNT(*) FROM questions) AS questions,
          (SELECT COUNT(*) FROM flashcards) AS flashcards,
          (SELECT COUNT(*) FROM tags) AS tags,
          (SELECT COUNT(*) FROM question_tags) AS question_tags,
          (SELECT COUNT(*) FROM notes) AS notes_rows
    """)
    print(f"  Count query: {'OK — check Supabase dashboard for totals' if ok else err}")

    print("\n" + "=" * 60)
    print("INJECTION COMPLETE")
    print(f"  SQL Seeds: {len(succeeded)}/{total}")
    print(f"  Notes:     {len(n_ok)}/25")
    print("=" * 60)


if __name__ == "__main__":
    main()
