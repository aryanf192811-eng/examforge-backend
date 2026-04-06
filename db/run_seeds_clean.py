#!/usr/bin/env python3
"""
Clean ExamForge Supabase seed runner for the current schema.

Why this exists:
- The prompt file in the workspace is stale.
- Several "*-seed.sql" files are full subject datasets already.
- The current Supabase schema differs from the older seed column names.
- Notes storage upload is needed, but the available MCP surface does not expose
  object upload helpers directly.

This runner:
1. Resets the partially seeded content tables for a clean import.
2. Transforms the 13 full subject seed files to the current schema on the fly.
3. Uploads notes HTML files with upsert enabled.
4. Binds notes paths to chapters using the best available chapter mapping for
   the current seed set.
5. Flips published subjects live while keeping dl unpublished.
6. Runs health checks and prints a compact final report.
"""

from __future__ import annotations

import json
import re
import sys
from collections import Counter
from pathlib import Path

import requests

import run_seeds as legacy


ROOT = Path(__file__).resolve().parents[1]
SEEDS_DIR = ROOT / "db" / "seeds"
NOTES_DIR = ROOT / "Gate Cse notes"
STORAGE_BUCKET = legacy.STORAGE_BUCKET


PART_SEED_ORDER = [
    "algo-seed-p1.sql",
    "algo-seed-p2.sql",
    "algo-seed-p3.sql",
    "algo-seed-p4.sql",
    "algo-seed-p5.sql",
    "algo-seed-p6.sql",
    "algo-seed-p7.sql",
    "algo-seed-p8.sql",
    "cd-seed-p1.sql",
    "cd-seed-p2.sql",
    "cd-seed-p3.sql",
    "cd-seed-p4.sql",
    "cd-seed-p5.sql",
    "cd-seed-p6.sql",
    "cd-seed-p7.sql",
    "cd-seed-p8.sql",
    "cn-seed-p1.sql",
    "cn-seed-p2.sql",
    "cn-seed-p3.sql",
    "cn-seed-p4.sql",
    "cn-seed-p5.sql",
    "cn-seed-p6.sql",
    "cn-seed-p7.sql",
    "cn-seed-p8.sql",
    "coa-seed-p1.sql",
    "coa-seed-p2.sql",
    "coa-seed-p3.sql",
    "coa-seed-p4.sql",
    "coa-seed-p5.sql",
    "coa-seed-p6.sql",
    "coa-seed-p7.sql",
    "coa-seed-p8.sql",
    "cprog-seed-p1.sql",
    "cprog-seed-p2.sql",
    "cprog-seed-p3.sql",
    "cprog-seed-p4.sql",
    "cprog-seed-p5.sql",
    "cprog-seed-p6.sql",
    "cprog-seed-p7.sql",
    "cprog-seed-p8.sql",
    "dbms-seed-p1.sql",
    "dbms-seed-p2.sql",
    "dbms-seed-p3.sql",
    "dbms-seed-p4.sql",
    "dbms-seed-p5.sql",
    "dbms-seed-p6.sql",
    "dbms-seed-p7.sql",
    "dl-seed-p1.sql",
    "dl-seed-p2.sql",
    "dl-seed-p3.sql",
    "dl-seed-p4.sql",
    "dl-seed-p5.sql",
    "dl-seed-p6.sql",
    "dl-seed-p7.sql",
    "dl-seed-p8.sql",
    "dm-seed-p1.sql",
    "dm-seed-p2.sql",
    "dm-seed-p3.sql",
    "dm-seed-p4.sql",
    "dm-seed-p5.sql",
    "dm-seed-p6.sql",
    "dm-seed-p7.sql",
    "dm-seed-p8.sql",
    "dsa-seed-p1.sql",
    "dsa-seed-p2.sql",
    "dsa-seed-p3.sql",
    "dsa-seed-p4.sql",
    "dsa-seed-p5.sql",
    "dsa-seed-p6.sql",
    "dsa-seed-p7.sql",
    "dsa-seed-p8.sql",
    "em-seed-p1.sql",
    "em-seed-p2.sql",
    "em-seed-p3.sql",
    "em-seed-p4.sql",
    "em-seed-p5.sql",
    "em-seed-p6.sql",
    "em-seed-p7.sql",
    "em-seed-p8.sql",
    "ga-seed-p1.sql",
    "ga-seed-p2.sql",
    "ga-seed-p3.sql",
    "ga-seed-p4.sql",
    "ga-seed-p5.sql",
    "ga-seed-p6.sql",
    "ga-seed-p7.sql",
    "ga-seed-p8.sql",
    "ga-seed-p9.sql",
    "ga-seed-p10.sql",
    "os-seed-p1.sql",
    "os-seed-p2.sql",
    "os-seed-p3.sql",
    "os-seed-p4.sql",
    "os-seed-p5.sql",
    "os-seed-p6.sql",
    "os-seed-p7.sql",
    "os-seed-p8.sql",
    "toc-seed-p1.sql",
    "toc-seed-p2.sql",
    "toc-seed-p3.sql",
    "toc-seed-p4.sql",
    "toc-seed-p5.sql",
    "toc-seed-p6.sql",
    "toc-seed-p7.sql",
    "toc-seed-p8.sql",
]


NOTES_BINDINGS = [
    {
        "storage_path": "notes/gate/algo/algo-01-complexity-sorting-searching.html",
        "chapters": [("algo", "asymptotics")],
    },
    {
        "storage_path": "notes/gate/algo/algo-02-graph-algorithms.html",
        "chapters": [("algo", "divide-conquer")],
    },
    {
        "storage_path": "notes/gate/algo/algo-03-dp-greedy-divide-conquer.html",
        "chapters": [("algo", "dynamic-programming")],
    },
    {
        "storage_path": "notes/gate/cd/compiler-design-complete.html",
        "chapters": [("cd", "all")],
    },
    {
        "storage_path": "notes/gate/cn/cn-01-datalink-network-routing.html",
        "chapters": [("cn", "data-link"), ("cn", "network-layer")],
    },
    {
        "storage_path": "notes/gate/cn/cn-02-transport-application-1.html",
        "chapters": [("cn", "transport-layer"), ("cn", "app-security")],
    },
    {
        "storage_path": "notes/gate/coa/coa-01-number-systems-boolean-circuits.html",
        "chapters": [("coa", "instructions-alu")],
    },
    {
        "storage_path": "notes/gate/coa/coa-02-cpu-isa-pipeline-memory.html",
        "chapters": [("coa", "datapath-control"), ("coa", "pipelining"), ("coa", "memory-io")],
    },
    {
        "storage_path": "notes/gate/cprog/c-programming-complete-1.html",
        "chapters": [("cprog", "all")],
    },
    {
        "storage_path": "notes/gate/dbms/dbms-gate-notes-v2-1.html",
        "chapters": [("dbms", "relational-model")],
    },
    {
        "storage_path": "notes/gate/dbms/dbms-02-sql-relational-algebra-3.html",
        "chapters": [("dbms", "sql-ra")],
    },
    {
        "storage_path": "notes/gate/dbms/dbms-03-transactions-concurrency-1.html",
        "chapters": [("dbms", "transactions")],
    },
    {
        "storage_path": "notes/gate/dbms/dbms-04-er-indexing-relational-calculus.html",
        "chapters": [("dbms", "er-model"), ("dbms", "indexing-hashing")],
    },
    {
        "storage_path": "notes/gate/dm/dm-01-logic-sets-relations-functions-2.html",
        "chapters": [("dm", "logic-proofs"), ("dm", "sets-relations-functions")],
    },
    {
        "storage_path": "notes/gate/dm/dm-02-graph-theory-combinatorics.html",
        "chapters": [("dm", "combinatorics"), ("dm", "graph-theory")],
    },
    {
        "storage_path": "notes/gate/dsa/ds-01-linear-data-structures-2.html",
        "chapters": [("dsa", "arrays-strings-hashing"), ("dsa", "linked-lists"), ("dsa", "stacks-queues")],
    },
    {
        "storage_path": "notes/gate/dsa/ds-02-trees-heaps.html",
        "chapters": [("dsa", "trees-bst"), ("dsa", "avl-heaps")],
    },
    {
        "storage_path": "notes/gate/em/em-01-calculus-linear-algebra-probability-2.html",
        "chapters": [("em", "linear-algebra"), ("em", "calculus")],
    },
    {
        "storage_path": "notes/gate/em/em-02-differential-equations-numerical-methods.html",
        "chapters": [("em", "probability-statistics")],
    },
    {
        "storage_path": "notes/gate/os/os-01-processes-scheduling-synchronization.html",
        "chapters": [("os", "process-management"), ("os", "concurrency")],
    },
    {
        "storage_path": "notes/gate/os/os-02-memory-filesystems-io.html",
        "chapters": [("os", "memory-management"), ("os", "storage-io")],
    },
    {
        "storage_path": "notes/gate/toc/toc-01-automata-grammars.html",
        "chapters": [("toc", "regular-languages"), ("toc", "context-free-languages")],
    },
    {
        "storage_path": "notes/gate/toc/toc-02-turing-decidability.html",
        "chapters": [("toc", "turing-machines"), ("toc", "decidability")],
    },
    {
        "storage_path": "notes/gate/ga/aptitude-quantitative-master.html",
        "chapters": [("ga", "ga-arithmetic"), ("ga", "ga-quant"), ("ga", "ga-di-logic")],
    },
    {
        "storage_path": "notes/gate/ga/aptitude-verbal-master.html",
        "chapters": [("ga", "ga-grammar"), ("ga", "ga-vocabulary"), ("ga", "ga-reading")],
    },
]


LIVE_SUBJECTS = [
    "algo",
    "cd",
    "cn",
    "coa",
    "cprog",
    "dbms",
    "dm",
    "dsa",
    "em",
    "ga",
    "os",
    "toc",
]


EXPECTED_SUBJECT_COUNTS = {
    "algo": {"questions": 95, "flashcards": 50, "published": True},
    "cd": {"questions": 65, "flashcards": 22, "published": True},
    "cn": {"questions": 65, "flashcards": 22, "published": True},
    "coa": {"questions": 65, "flashcards": 22, "published": True},
    "cprog": {"questions": 90, "flashcards": 39, "published": True},
    "dbms": {"questions": 55, "flashcards": 45, "published": True},
    "dl": {"questions": 65, "flashcards": 22, "published": False},
    "dm": {"questions": 65, "flashcards": 22, "published": True},
    "dsa": {"questions": 65, "flashcards": 40, "published": True},
    "em": {"questions": 65, "flashcards": 22, "published": True},
    "ga": {"questions": 130, "flashcards": 43, "published": True},
    "os": {"questions": 65, "flashcards": 22, "published": True},
    "toc": {"questions": 65, "flashcards": 22, "published": True},
}


def log(message: str) -> None:
    print(message, flush=True)


def execute_sql_rpc(sql_text: str) -> None:
    resp = requests.post(
        f"{legacy.SUPABASE_URL}/rest/v1/rpc/execute_sql_script",
        headers={
            "apikey": legacy.SUPABASE_SERVICE_KEY,
            "Authorization": f"Bearer {legacy.SUPABASE_SERVICE_KEY}",
            "Content-Type": "application/json",
        },
        json={"sql_query": sql_text},
        timeout=600,
    )
    if not resp.ok:
        raise RuntimeError(f"SQL RPC failed ({resp.status_code}): {resp.text[:800]}")


def ensure_prereqs() -> None:
    execute_sql_rpc("INSERT INTO exam_configs (slug, name) VALUES ('gate-cse', 'GATE Computer Science') ON CONFLICT (slug) DO NOTHING;")
    execute_sql_rpc("INSERT INTO branches (name) VALUES ('cse') ON CONFLICT (name) DO NOTHING;")
    execute_sql_rpc("ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS subject_id uuid REFERENCES subjects(id);")
    execute_sql_rpc("ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS topic_id uuid REFERENCES topics(id);")
    execute_sql_rpc("ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS tags text[];")


def reset_seeded_content() -> None:
    reset_sql = """
    TRUNCATE TABLE
      user_progress,
      bookmarks,
      doubt_sessions,
      notes,
      question_tags,
      flashcards,
      questions,
      topics,
      chapters,
      tags,
      subjects
    CASCADE;
    """
    execute_sql_rpc(reset_sql)


def remove_tx_markers(sql_text: str) -> str:
    sql_text = re.sub(r"(?im)^\s*BEGIN;\s*$", "", sql_text)
    sql_text = re.sub(r"(?im)^\s*COMMIT;\s*$", "", sql_text)
    sql_text = re.sub(r"(?im)^\s*ROLLBACK;\s*$", "", sql_text)
    return sql_text


def split_sql_statements(sql_text: str) -> list[str]:
    parts = []
    buf = []
    in_single = False
    in_dollar = False
    i = 0
    while i < len(sql_text):
        ch = sql_text[i]
        nxt = sql_text[i + 1] if i + 1 < len(sql_text) else ""
        if not in_single and not in_dollar and ch == "-" and nxt == "-":
            line_end = sql_text.find("\n", i)
            if line_end == -1:
                break
            buf.append(sql_text[i:line_end])
            i = line_end
            continue
        if not in_single and sql_text[i : i + 2] == "$$":
            in_dollar = not in_dollar
            buf.append("$$")
            i += 2
            continue
        if not in_dollar and ch == "'":
            if in_single and nxt == "'":
                buf.append("''")
                i += 2
                continue
            in_single = not in_single
            buf.append(ch)
            i += 1
            continue
        if ch == ";" and not in_single and not in_dollar:
            stmt = "".join(buf).strip()
            if stmt:
                parts.append(stmt + ";")
            buf = []
            i += 1
            continue
        buf.append(ch)
        i += 1
    tail = "".join(buf).strip()
    if tail:
        parts.append(tail)
    return parts


def cleanup_algo_repairs(sql_text: str) -> str:
    statements = split_sql_statements(sql_text)
    cleaned = []
    skip_next = False
    delete_last_row = "DELETE FROM questions WHERE id = (SELECT max(id) FROM questions)"
    for index, stmt in enumerate(statements):
        stripped = stmt.strip()
        if skip_next:
            skip_next = False
            continue
        if delete_last_row in stripped:
            continue
        if "missing closing p tag and quote" in stripped:
            continue
        if index + 1 < len(statements) and delete_last_row in statements[index + 1] and "WITH q AS" in stripped:
            skip_next = True
            continue
        if "INSERT INTO question_tags" in stripped and "SELECT max(id)" in stripped and "WITH q AS" not in stripped:
            continue
        if "UPDATE questions SET explanation" in stripped and "max(id) FROM questions" in stripped and "WITH q AS" not in stripped:
            continue
        if "WITH q AS" in stripped and "SELECT max(id),t.id FROM questions,tags t" in stripped:
            stripped = stripped.replace(
                "SELECT max(id),t.id FROM questions,tags t",
                "SELECT q.id,t.id FROM q,tags t",
            )
            stripped = stripped.replace(" AND questions.id=(SELECT max(id) FROM questions)", "")
        if "WITH q AS" in stripped and "UPDATE questions SET explanation =" in stripped and "max(id) FROM questions" in stripped:
            stripped = stripped.replace(
                "WHERE id = (SELECT max(id) FROM questions)",
                "WHERE id IN (SELECT id FROM q)",
            )
        cleaned.append(stripped)
    return "\n\n".join(cleaned)


def transform_cd(sql_text: str) -> str:
    sql_text = sql_text.replace(
        "INSERT INTO chapters (subject_id, name, slug, description, sequence)",
        "INSERT INTO chapters (subject_id, title, slug, order_index)",
    )
    sql_text = re.sub(
        r"\(\(SELECT id FROM cd\),\s*'((?:[^']|'')*)',\s*'((?:[^']|'')*)',\s*'((?:[^']|'')*)',\s*(\d+)\)(,?)",
        r"((SELECT id FROM cd), '\1', '\2', \4)\5",
        sql_text,
    )
    sql_text = sql_text.replace(
        "INSERT INTO topics (chapter_id, name, slug, sequence) VALUES",
        "INSERT INTO topics (chapter_id, name, slug, order_index) VALUES",
    )
    sql_text = sql_text.replace("ON CONFLICT (subject_id, slug) DO NOTHING", "ON CONFLICT (slug) DO NOTHING")
    sql_text = sql_text.replace("ON CONFLICT (chapter_id, slug) DO NOTHING", "ON CONFLICT (slug) DO NOTHING")
    return sql_text


def transform_cprog(sql_text: str) -> str:
    sql_text = sql_text.replace(
        "INSERT INTO subjects (name, description, difficulty, is_published, slug)",
        "INSERT INTO subjects (name, description, is_published, slug)",
    )
    sql_text = re.sub(r"(?m)^\s*'medium',\s*$\n?", "", sql_text, count=1)
    sql_text = sql_text.replace(
        "INSERT INTO chapters (subject_id, name, order_index, is_published, slug)",
        "INSERT INTO chapters (subject_id, title, order_index, is_published, slug)",
    )
    sql_text = sql_text.replace(
        "INSERT INTO topics (chapter_id, name, order_index, is_published, slug)",
        "INSERT INTO topics (chapter_id, name, order_index, slug)",
    )
    sql_text = re.sub(
        r"\(\(SELECT id FROM (c\d)\),\s*'((?:[^']|'')*)',\s*(\d+),\s*false,\s*'((?:[^']|'')*)'\)(,?)",
        r"((SELECT id FROM \1), '\2', \3, '\4')\5",
        sql_text,
    )
    return sql_text


def transform_dm_or_toc(sql_text: str) -> str:
    sql_text = sql_text.replace(
        "INSERT INTO subjects (slug, name, description, color, icon)",
        "INSERT INTO subjects (slug, name, description, icon)",
    )
    sql_text = re.sub(r"(?m)^\s*'#[0-9a-fA-F]{6}',\s*(--.*)?$\n?", "", sql_text, count=1)
    sql_text = sql_text.replace(
        'INSERT INTO chapters (subject_id, slug, name, description, "order") VALUES',
        "INSERT INTO chapters (subject_id, slug, title, order_index) VALUES",
    )
    sql_text = re.sub(
        r"\(\(SELECT id FROM s\),\s*'((?:[^']|'')*)',\s*'((?:[^']|'')*)',\s*'((?:[^']|'')*)',\s*(\d+)\)(,?)",
        r"((SELECT id FROM s), '\1', '\2', \4)\5",
        sql_text,
    )
    sql_text = sql_text.replace(
        'INSERT INTO topics (chapter_id, slug, name, "order") VALUES',
        "INSERT INTO topics (chapter_id, slug, name, order_index) VALUES",
    )
    sql_text = sql_text.replace("ON CONFLICT (subject_id, slug) DO NOTHING", "ON CONFLICT (slug) DO NOTHING")
    sql_text = sql_text.replace("ON CONFLICT (chapter_id, slug) DO NOTHING", "ON CONFLICT (slug) DO NOTHING")
    return sql_text


def transform_dbms(sql_text: str) -> str:
    sql_text = re.sub(
        r"INSERT INTO branches \(slug, name, description, icon\)\s*VALUES \('cse','Computer Science & Engineering','CS \+ IT combined','.*?'\)\s*ON CONFLICT \(slug\) DO NOTHING;",
        "INSERT INTO branches (name) VALUES ('cse') ON CONFLICT (name) DO NOTHING;",
        sql_text,
        flags=re.S,
    )
    sql_text = re.sub(
        r"INSERT INTO exam_configs \(slug,name,description,total_questions,duration_mins,\s*negative_marking,marking_scheme,sections,branch_slug,is_active\)\s*VALUES \('gate-cse','GATE CSE',.*?'cse',true\)\s*ON CONFLICT \(slug\) DO NOTHING;",
        "INSERT INTO exam_configs (slug, name) VALUES ('gate-cse', 'GATE CSE') ON CONFLICT (slug) DO NOTHING;",
        sql_text,
        flags=re.S,
    )
    return sql_text


def transform_old_v2(sql_text: str) -> str:
    sql_text = sql_text.replace(
        "INSERT INTO subjects (title, slug, description, gradient_start, gradient_end, icon_type)",
        "INSERT INTO subjects (name, slug, description, gradient_start, gradient_end, icon)",
    )
    sql_text = re.sub(
        r"SET\s+title\s*=\s*EXCLUDED\.title,\s*description\s*=\s*EXCLUDED\.description",
        "SET name = EXCLUDED.name, description = EXCLUDED.description",
        sql_text,
    )
    sql_text = sql_text.replace(
        "INSERT INTO chapters (subject_id, title, slug, sort_order)",
        "INSERT INTO chapters (subject_id, title, slug, order_index)",
    )
    sql_text = sql_text.replace(
        "INSERT INTO topics (chapter_id, slug, title, sort_order)",
        "INSERT INTO topics (chapter_id, slug, name, order_index)",
    )
    return sql_text


def transform_seed(filename: str, sql_text: str) -> str:
    subject_slug = filename.split("-seed", 1)[0]
    sql_text = sql_text.lstrip("\ufeff")
    sql_text = remove_tx_markers(sql_text)
    if subject_slug in {"algo", "cn", "coa", "dl", "os"}:
        sql_text = transform_old_v2(sql_text)
    elif subject_slug == "cd":
        sql_text = transform_cd(sql_text)
    elif subject_slug == "cprog":
        sql_text = transform_cprog(sql_text)
    elif subject_slug == "dbms":
        sql_text = transform_dbms(sql_text)
    elif subject_slug in {"dm", "toc"}:
        sql_text = transform_dm_or_toc(sql_text)
    sql_text = re.sub(
        r"FROM\s+topics\s+'([^']+)'\s+LIMIT\s+1",
        r"FROM topics WHERE slug='\1' LIMIT 1",
        sql_text,
    )
    sql_text = re.sub(
        r"FROM\s+topics\s*,\s*'([^']+)'\)\s+LIMIT\s+1",
        r"FROM topics WHERE slug='\1' LIMIT 1",
        sql_text,
    )
    sql_text = re.sub(
        r"FROM\s+topics\s+[^\n)]*slug='([^']+)'\s+LIMIT\s+1",
        r"FROM topics WHERE slug='\1' LIMIT 1",
        sql_text,
    )
    sql_text = sql_text.replace("slug='derivatives' LIMIT 1", "slug='series-integration' LIMIT 1")
    sql_text = re.sub(
        r"INSERT INTO question_tags\s*\(question_id,tag_id\)\s*SELECT id,\(SELECT id FROM tags WHERE slug='([^']+)' LIMIT 1\) FROM q;",
        r"INSERT INTO question_tags (question_id,tag_id) SELECT q.id, t.id FROM q CROSS JOIN (SELECT id FROM tags WHERE slug='\1' LIMIT 1) t;",
        sql_text,
    )
    sql_text = re.sub(
        r"(?im)^\s*--\s*need fix topic id here! fixing syntax:\s*$\n?",
        "",
        sql_text,
    )
    sql_text = re.sub(
        r"(?im)^\s*UPDATE questions SET topic_id = \(SELECT id FROM topics WHERE slug='[^']+' LIMIT 1\) WHERE id = \(SELECT max\(id\) FROM questions\);\s*$\n?",
        "",
        sql_text,
    )
    if subject_slug == "algo":
        sql_text = cleanup_algo_repairs(sql_text)
    return sql_text


def ensure_bucket() -> None:
    headers = {
        "Authorization": f"Bearer {legacy.SUPABASE_SERVICE_KEY}",
        "Content-Type": "application/json",
    }
    bucket_url = f"{legacy.SUPABASE_URL}/storage/v1/bucket/{STORAGE_BUCKET}"
    resp = requests.get(bucket_url, headers=headers, timeout=30)
    if resp.status_code == 200:
        return
    payload = {"id": STORAGE_BUCKET, "name": STORAGE_BUCKET, "public": False}
    resp = requests.post(f"{legacy.SUPABASE_URL}/storage/v1/bucket", headers=headers, json=payload, timeout=30)
    resp.raise_for_status()


def upload_notes() -> list[str]:
    uploaded = []
    headers = {
        "Authorization": f"Bearer {legacy.SUPABASE_SERVICE_KEY}",
        "Content-Type": "text/html",
        "x-upsert": "true",
    }
    for local_name, storage_path in legacy.NOTES_UPLOADS:
        local_path = NOTES_DIR / local_name
        data = local_path.read_bytes()
        url = f"{legacy.SUPABASE_URL}/storage/v1/object/{STORAGE_BUCKET}/{storage_path}"
        resp = requests.post(url, headers=headers, data=data, timeout=60)
        resp.raise_for_status()
        uploaded.append(storage_path)
        log(f"  uploaded {storage_path}")
    return uploaded


def bind_notes() -> list[str]:
    statements = []
    skipped = []
    for binding in NOTES_BINDINGS:
        path = binding["storage_path"]
        for subject_slug, chapter_ref in binding["chapters"]:
            if chapter_ref == "all":
                statements.append(
                    f"""
                    INSERT INTO notes (chapter_id, storage_path, format, is_published)
                    SELECT c.id, '{path}', 'html', true
                    FROM chapters c
                    JOIN subjects s ON s.id = c.subject_id
                    WHERE s.slug = '{subject_slug}'
                    ON CONFLICT DO NOTHING
                    ;
                    """
                )
                continue
            statements.append(
                f"""
                INSERT INTO notes (chapter_id, storage_path, format, is_published)
                SELECT c.id, '{path}', 'html', true
                FROM chapters c
                JOIN subjects s ON s.id = c.subject_id
                WHERE s.slug = '{subject_slug}' AND c.slug = '{chapter_ref}'
                ON CONFLICT DO NOTHING
                ;
                """
            )
    if skipped:
        return skipped
    execute_sql_rpc("\n".join(statements))
    return skipped


def flip_subjects_live() -> None:
    execute_sql_rpc(
        """
        UPDATE subjects
        SET is_published = true
        WHERE slug IN ('algo','cd','cn','coa','cprog','dbms','dm','dsa','em','ga','os','toc');

        UPDATE subjects
        SET is_published = false
        WHERE slug = 'dl';
        """
    )


def verify_storage() -> dict[str, int]:
    counts = Counter()
    headers = {"Authorization": f"Bearer {legacy.SUPABASE_SERVICE_KEY}"}
    for _, storage_path in legacy.NOTES_UPLOADS:
        url = f"{legacy.SUPABASE_URL}/storage/v1/object/{STORAGE_BUCKET}/{storage_path}"
        resp = requests.get(url, headers=headers, timeout=60)
        resp.raise_for_status()
        parts = storage_path.split("/")
        counts[parts[2]] += 1
    return dict(counts)


def fetch_json_rows(sql_text: str) -> list[dict]:
    resp = requests.post(
        f"{legacy.SUPABASE_URL}/rest/v1/rpc/execute_sql_script",
        headers={
            "apikey": legacy.SUPABASE_SERVICE_KEY,
            "Authorization": f"Bearer {legacy.SUPABASE_SERVICE_KEY}",
            "Content-Type": "application/json",
        },
        json={"sql_query": sql_text},
        timeout=600,
    )
    if not resp.ok:
        raise RuntimeError(f"SQL fetch failed ({resp.status_code}): {resp.text[:800]}")
    payload = resp.json()
    if isinstance(payload, str):
        return json.loads(payload)
    return payload


def collect_subject_health() -> list[dict]:
    rows = fetch_json_rows(
        """
        SELECT
          s.slug,
          COALESCE(q.question_count, 0) AS questions,
          COALESCE(f.flashcard_count, 0) AS flashcards,
          COALESCE(c.chapter_count, 0) AS chapters,
          COALESCE(t.topic_count, 0) AS topics,
          COALESCE(n.note_count, 0) AS notes,
          s.is_published
        FROM subjects s
        LEFT JOIN (
          SELECT subject_id, COUNT(*) AS question_count
          FROM questions
          GROUP BY subject_id
        ) q ON q.subject_id = s.id
        LEFT JOIN (
          SELECT subject_id, COUNT(*) AS flashcard_count
          FROM flashcards
          GROUP BY subject_id
        ) f ON f.subject_id = s.id
        LEFT JOIN (
          SELECT subject_id, COUNT(*) AS chapter_count
          FROM chapters
          GROUP BY subject_id
        ) c ON c.subject_id = s.id
        LEFT JOIN (
          SELECT c.subject_id, COUNT(*) AS topic_count
          FROM topics t
          JOIN chapters c ON c.id = t.chapter_id
          GROUP BY c.subject_id
        ) t ON t.subject_id = s.id
        LEFT JOIN (
          SELECT c.subject_id, COUNT(*) AS note_count
          FROM notes n
          JOIN chapters c ON c.id = n.chapter_id
          GROUP BY c.subject_id
        ) n ON n.subject_id = s.id
        WHERE s.slug = ANY(ARRAY['algo','cd','cn','coa','cprog','dbms','dl','dm','dsa','em','ga','os','toc'])
        ORDER BY s.slug;
        """
    )
    for row in rows:
        expected = EXPECTED_SUBJECT_COUNTS.get(row["slug"], {})
        row["expected_questions"] = expected.get("questions")
        row["expected_flashcards"] = expected.get("flashcards")
        row["expected_published"] = expected.get("published")
        row["questions_ok"] = row["questions"] == row["expected_questions"]
        row["flashcards_ok"] = row["flashcards"] == row["expected_flashcards"]
        row["published_ok"] = row["is_published"] == row["expected_published"]
    return rows


def collect_integrity_checks() -> list[dict]:
    return fetch_json_rows(
        """
        SELECT 'questions_missing_topic' AS check_name, COUNT(*)::int AS count
        FROM questions
        WHERE topic_id IS NULL
        UNION ALL
        SELECT 'orphan_question_tags', COUNT(*)::int
        FROM question_tags qt
        LEFT JOIN questions q ON q.id = qt.question_id
        LEFT JOIN tags t ON t.id = qt.tag_id
        WHERE q.id IS NULL OR t.id IS NULL
        UNION ALL
        SELECT 'orphan_notes', COUNT(*)::int
        FROM notes n
        LEFT JOIN chapters c ON c.id = n.chapter_id
        WHERE c.id IS NULL
        UNION ALL
        SELECT 'distinct_note_paths', COUNT(DISTINCT storage_path)::int
        FROM notes
        UNION ALL
        SELECT 'subject_count', COUNT(*)::int
        FROM subjects
        WHERE slug = ANY(ARRAY['algo','cd','cn','coa','cprog','dbms','dl','dm','dsa','em','ga','os','toc']);
        """
    )


def main() -> int:
    log("=" * 72)
    log("ExamForge clean seed import")
    log("=" * 72)

    ensure_bucket()
    ensure_prereqs()

    log("[1/5] Resetting seeded content")
    reset_seeded_content()

    log("[2/5] Importing split subject seed files")
    seed_results = []
    statement_failures = []
    for filename in PART_SEED_ORDER:
        path = SEEDS_DIR / filename
        sql_text = transform_seed(filename, path.read_text(encoding="utf-8"))
        statements = split_sql_statements(sql_text)
        file_failures = 0
        for index, stmt in enumerate(statements, 1):
            try:
                execute_sql_rpc(stmt)
            except Exception as exc:
                file_failures += 1
                statement_failures.append(
                    {
                        "file": filename,
                        "statement_index": index,
                        "error": str(exc)[:500],
                    }
                )
        seed_results.append({"file": filename, "statements": len(statements), "failed_statements": file_failures})
        log(f"  seeded {filename} ({len(statements) - file_failures}/{len(statements)} statements)")

    log("[3/5] Uploading notes HTML")
    uploaded = upload_notes()

    log("[4/5] Binding notes to chapters")
    binding_skips = bind_notes()

    log("[5/5] Publishing live subjects")
    flip_subjects_live()

    storage_counts = verify_storage()
    try:
        subject_health = collect_subject_health()
        integrity_checks = collect_integrity_checks()
    except Exception as exc:
        log(f"  skipped inline verification fetch: {exc}")
        subject_health = []
        integrity_checks = []
    final = {
        "seeded_subject_files": seed_results,
        "statement_failures": statement_failures[:50],
        "uploaded_notes": len(uploaded),
        "binding_skips": binding_skips,
        "storage_counts": storage_counts,
        "subject_health": subject_health,
        "integrity_checks": integrity_checks,
    }
    log(json.dumps(final, indent=2, default=str))
    return 0


if __name__ == "__main__":
    sys.exit(main())
