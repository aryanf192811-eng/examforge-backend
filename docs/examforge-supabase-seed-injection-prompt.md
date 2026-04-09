# ══════════════════════════════════════════════════════════════════════════════
# EXAMFORGE — SUPABASE MCP SEED INJECTION PROMPT
# 126 SQL Seeds + 25 Notes HTML → Supabase DB + Storage
# Via Supabase MCP Server · Clean · Idempotent · Verified
# ══════════════════════════════════════════════════════════════════════════════

---

## MISSION

You are a senior database engineer. Inject the complete ExamForge dataset into
a live Supabase project using the Supabase MCP server.

Two things to inject:
1. **126 SQL seed files** → Supabase PostgreSQL (via MCP `execute_sql`)
2. **25 Notes HTML files** → Supabase Storage bucket `notes-content` (via MCP `upload_storage_object`)

Then run the **binding SQL** to wire notes files to chapters.
Then flip subjects live.
Then run a full health verification.

Everything is idempotent. Safe to re-run. No data will be lost.

---

## CONTEXT — WHAT EXISTS

```
Supabase project: connected via MCP server
Storage bucket:   notes-content (private — must exist before upload)
Seed files:       examforge-backend/db/seeds/  (126 .sql files)
Notes files:      Gate Cse notes/              (25 .html files)
```

### Subjects and their seed files (13 subjects):

| Subject | Slug | Base seed | Part files |
|---|---|---|---|
| Algorithms | `algo` | `algo-seed.sql` | `algo-seed-p1.sql` … `algo-seed-p8.sql` |
| Compiler Design | `cd` | `cd-seed.sql` | `cd-seed-p1.sql` … `cd-seed-p8.sql` |
| Computer Networks | `cn` | `cn-seed.sql` | `cn-seed-p1.sql` … `cn-seed-p8.sql` |
| COA | `coa` | `coa-seed.sql` | `coa-seed-p1.sql` … `coa-seed-p8.sql` |
| C Programming | `cprog` | `cprog-seed.sql` | `cprog-seed-p1.sql` … `cprog-seed-p8.sql` |
| DBMS | `dbms` | `dbms-seed.sql` | `dbms-seed-p1.sql` … `dbms-seed-p7.sql` |
| Digital Logic | `dl` | `dl-seed.sql` | `dl-seed-p1.sql` … `dl-seed-p8.sql` |
| Discrete Math | `dm` | `dm-seed.sql` | `dm-seed-p1.sql` … `dm-seed-p8.sql` |
| DSA | `dsa` | `dsa-seed.sql` | `dsa-seed-p1.sql` … `dsa-seed-p8.sql` |
| Engineering Math | `em` | `em-seed.sql` | `em-seed-p1.sql` … `em-seed-p8.sql` |
| General Aptitude | `ga` | `ga-seed.sql` | `ga-seed-p1.sql` … `ga-seed-p10.sql` |
| Operating Systems | `os` | `os-seed.sql` | `os-seed-p1.sql` … `os-seed-p8.sql` |
| Theory of Computation | `toc` | `toc-seed.sql` | `toc-seed-p1.sql` … `toc-seed-p8.sql` |

**Rule:** Always run the base `{slug}-seed.sql` FIRST, then parts in ascending
numerical order. The base file inserts the subject, chapters, topics, and tags.
Parts contain questions and flashcards that reference those parent rows.

### Notes HTML files and their storage paths (25 files):

| Local filename | Storage path |
|---|---|
| `algo-01-complexity-sorting-searching.html` | `notes/gate/algo/algo-01-complexity-sorting-searching.html` |
| `algo-02-graph-algorithms.html` | `notes/gate/algo/algo-02-graph-algorithms.html` |
| `algo-03-dp-greedy-divide-conquer.html` | `notes/gate/algo/algo-03-dp-greedy-divide-conquer.html` |
| `compiler-design-complete.html` | `notes/gate/cd/compiler-design-complete.html` |
| `cn-01-datalink-network-routing.html` | `notes/gate/cn/cn-01-datalink-network-routing.html` |
| `cn-02-transport-application-1.html` | `notes/gate/cn/cn-02-transport-application-1.html` |
| `coa-01-number-systems-boolean-circuits.html` | `notes/gate/coa/coa-01-number-systems-boolean-circuits.html` |
| `coa-02-cpu-isa-pipeline-memory.html` | `notes/gate/coa/coa-02-cpu-isa-pipeline-memory.html` |
| `c-programming-complete-1.html` | `notes/gate/cprog/c-programming-complete-1.html` |
| `dbms-gate-notes-v2-1.html` | `notes/gate/dbms/dbms-gate-notes-v2-1.html` |
| `dbms-02-sql-relational-algebra-3.html` | `notes/gate/dbms/dbms-02-sql-relational-algebra-3.html` |
| `dbms-03-transactions-concurrency-1.html` | `notes/gate/dbms/dbms-03-transactions-concurrency-1.html` |
| `dbms-04-er-indexing-relational-calculus.html` | `notes/gate/dbms/dbms-04-er-indexing-relational-calculus.html` |
| `dm-01-logic-sets-relations-functions-2.html` | `notes/gate/dm/dm-01-logic-sets-relations-functions-2.html` |
| `dm-02-graph-theory-combinatorics.html` | `notes/gate/dm/dm-02-graph-theory-combinatorics.html` |
| `ds-01-linear-data-structures-2.html` | `notes/gate/dsa/ds-01-linear-data-structures-2.html` |
| `ds-02-trees-heaps.html` | `notes/gate/dsa/ds-02-trees-heaps.html` |
| `em-01-calculus-linear-algebra-probability-2.html` | `notes/gate/em/em-01-calculus-linear-algebra-probability-2.html` |
| `em-02-differential-equations-numerical-methods.html` | `notes/gate/em/em-02-differential-equations-numerical-methods.html` |
| `os-01-processes-scheduling-synchronization.html` | `notes/gate/os/os-01-processes-scheduling-synchronization.html` |
| `os-02-memory-filesystems-io.html` | `notes/gate/os/os-02-memory-filesystems-io.html` |
| `toc-01-automata-grammars.html` | `notes/gate/toc/toc-01-automata-grammars.html` |
| `toc-02-turing-decidability.html` | `notes/gate/toc/toc-02-turing-decidability.html` |
| `aptitude-quantitative-master.html` | `notes/gate/ga/aptitude-quantitative-master.html` |
| `aptitude-verbal-master.html` | `notes/gate/ga/aptitude-verbal-master.html` |

**No `dl` notes exist.** Digital Logic has seed data but stays `is_published = false`.
Do NOT create or upload any `dl` notes file.

---

## PHASE 1 — PRE-FLIGHT CHECKS (run before touching any seed file)

### 1A — Confirm the storage bucket exists

Use the Supabase MCP tool to list storage buckets.

```
Expected: bucket named "notes-content" exists, public = false
```

If it does NOT exist — create it now before proceeding:
```
Bucket name:   notes-content
Public:        false  (private — backend generates signed URLs)
```

Do NOT make it public. The backend generates short-lived signed URLs on demand.

### 1B — Confirm the schema is live

Run this quick check via MCP `execute_sql`:

```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
```

Expected tables (minimum required before seeding):
```
subjects · chapters · topics · questions · question_tags · tags ·
flashcards · notes · quiz_sessions · quiz_answers · user_progress ·
leaderboard · bookmarks · user_notes
```

If tables are missing → the schema migration has not been run.
STOP and inform the developer. Do not attempt to seed without the schema.

### 1C — Check for existing data (detect partial runs)

```sql
SELECT
  (SELECT COUNT(*) FROM subjects)       AS subjects,
  (SELECT COUNT(*) FROM questions)      AS questions,
  (SELECT COUNT(*) FROM flashcards)     AS flashcards,
  (SELECT COUNT(*) FROM tags)           AS tags,
  (SELECT COUNT(*) FROM question_tags)  AS question_tags,
  (SELECT COUNT(*) FROM notes)          AS notes_rows;
```

- If all counts are 0 → clean slate, proceed normally
- If questions > 0 → partial data exists, seeds are idempotent (ON CONFLICT DO NOTHING), safe to continue
- If notes_rows = 25 → Phase 3 binding already done, skip Phase 3

Report these numbers before proceeding.

---

## PHASE 2 — INJECT 126 SQL SEED FILES

Inject subjects in this exact order. Base file first, then parts ascending.
Each seed file is independent — if one fails, report the error and continue
with the next one. Do not abort the entire run on a single failure.

Use MCP `execute_sql` for each file. Read the file content, then execute.

### Injection order (run EXACTLY in this sequence):

```
SUBJECT: algo (9 files)
  1.  algo-seed.sql          ← BASE: inserts subject, chapters, topics, tags
  2.  algo-seed-p1.sql
  3.  algo-seed-p2.sql
  4.  algo-seed-p3.sql
  5.  algo-seed-p4.sql
  6.  algo-seed-p5.sql
  7.  algo-seed-p6.sql
  8.  algo-seed-p7.sql
  9.  algo-seed-p8.sql

SUBJECT: cd (9 files)
  10. cd-seed.sql             ← BASE
  11. cd-seed-p1.sql
  12. cd-seed-p2.sql
  13. cd-seed-p3.sql
  14. cd-seed-p4.sql
  15. cd-seed-p5.sql
  16. cd-seed-p6.sql
  17. cd-seed-p7.sql
  18. cd-seed-p8.sql

SUBJECT: cn (9 files)
  19. cn-seed.sql             ← BASE
  20. cn-seed-p1.sql
  21. cn-seed-p2.sql
  22. cn-seed-p3.sql
  23. cn-seed-p4.sql
  24. cn-seed-p5.sql
  25. cn-seed-p6.sql
  26. cn-seed-p7.sql
  27. cn-seed-p8.sql

SUBJECT: coa (9 files)
  28. coa-seed.sql            ← BASE
  29. coa-seed-p1.sql
  30. coa-seed-p2.sql
  31. coa-seed-p3.sql
  32. coa-seed-p4.sql
  33. coa-seed-p5.sql
  34. coa-seed-p6.sql
  35. coa-seed-p7.sql
  36. coa-seed-p8.sql

SUBJECT: cprog (9 files)
  37. cprog-seed.sql          ← BASE
  38. cprog-seed-p1.sql
  39. cprog-seed-p2.sql
  40. cprog-seed-p3.sql
  41. cprog-seed-p4.sql
  42. cprog-seed-p5.sql
  43. cprog-seed-p6.sql
  44. cprog-seed-p7.sql
  45. cprog-seed-p8.sql

SUBJECT: dbms (8 files — p7 is last part, no p8)
  46. dbms-seed.sql           ← BASE
  47. dbms-seed-p1.sql
  48. dbms-seed-p2.sql
  49. dbms-seed-p3.sql
  50. dbms-seed-p4.sql
  51. dbms-seed-p5.sql
  52. dbms-seed-p6.sql
  53. dbms-seed-p7.sql

SUBJECT: dl (9 files — questions seeded but subject stays unpublished)
  54. dl-seed.sql             ← BASE
  55. dl-seed-p1.sql
  56. dl-seed-p2.sql
  57. dl-seed-p3.sql
  58. dl-seed-p4.sql
  59. dl-seed-p5.sql
  60. dl-seed-p6.sql
  61. dl-seed-p7.sql
  62. dl-seed-p8.sql

SUBJECT: dm (9 files)
  63. dm-seed.sql             ← BASE
  64. dm-seed-p1.sql
  65. dm-seed-p2.sql
  66. dm-seed-p3.sql
  67. dm-seed-p4.sql
  68. dm-seed-p5.sql
  69. dm-seed-p6.sql
  70. dm-seed-p7.sql
  71. dm-seed-p8.sql

SUBJECT: dsa (9 files)
  72. dsa-seed.sql            ← BASE
  73. dsa-seed-p1.sql
  74. dsa-seed-p2.sql
  75. dsa-seed-p3.sql
  76. dsa-seed-p4.sql
  77. dsa-seed-p5.sql
  78. dsa-seed-p6.sql
  79. dsa-seed-p7.sql
  80. dsa-seed-p8.sql

SUBJECT: em (9 files)
  81. em-seed.sql             ← BASE
  82. em-seed-p1.sql
  83. em-seed-p2.sql
  84. em-seed-p3.sql
  85. em-seed-p4.sql
  86. em-seed-p5.sql
  87. em-seed-p6.sql
  88. em-seed-p7.sql
  89. em-seed-p8.sql

SUBJECT: ga (11 files — p10 is last part)
  90. ga-seed.sql             ← BASE
  91. ga-seed-p1.sql
  92. ga-seed-p2.sql
  93. ga-seed-p3.sql
  94. ga-seed-p4.sql
  95. ga-seed-p5.sql
  96. ga-seed-p6.sql
  97. ga-seed-p7.sql
  98. ga-seed-p8.sql
  99. ga-seed-p9.sql
  100. ga-seed-p10.sql

SUBJECT: os (9 files)
  101. os-seed.sql            ← BASE
  102. os-seed-p1.sql
  103. os-seed-p2.sql
  104. os-seed-p3.sql
  105. os-seed-p4.sql
  106. os-seed-p5.sql
  107. os-seed-p6.sql
  108. os-seed-p7.sql
  109. os-seed-p8.sql

SUBJECT: toc (9 files)
  110. toc-seed.sql           ← BASE
  111. toc-seed-p1.sql
  112. toc-seed-p2.sql
  113. toc-seed-p3.sql
  114. toc-seed-p4.sql
  115. toc-seed-p5.sql
  116. toc-seed-p6.sql
  117. toc-seed-p7.sql
  118. toc-seed-p8.sql

TOTAL: 126 files
```

### Progress reporting during injection:

After every base file, print:
```
✅ [slug] base seeded — subject/chapters/topics/tags inserted
```

After every part file, print:
```
  ✅ [slug]-seed-p[n].sql
```

If a file fails, print:
```
  ❌ [filename] — ERROR: [error message]
```

Do NOT stop. Continue to the next file. Collect all errors and report at the end.

After ALL 126 files are done, print a summary:
```
═══════════════════════════════════════════════
SEED INJECTION COMPLETE
Succeeded: [n]/126
Failed:    [n]/126
Failed files: [list if any]
═══════════════════════════════════════════════
```

---

## PHASE 3 — UPLOAD 25 NOTES HTML FILES TO STORAGE

Upload each HTML file to the `notes-content` bucket using MCP storage upload.

Content-Type: `text/html` for all files.
Upsert mode: enabled (overwrite if already exists — idempotent).

Upload in this order:

```
ALGO (3 files):
  Local: Gate Cse notes/algo-01-complexity-sorting-searching.html
  Path:  notes/gate/algo/algo-01-complexity-sorting-searching.html

  Local: Gate Cse notes/algo-02-graph-algorithms.html
  Path:  notes/gate/algo/algo-02-graph-algorithms.html

  Local: Gate Cse notes/algo-03-dp-greedy-divide-conquer.html
  Path:  notes/gate/algo/algo-03-dp-greedy-divide-conquer.html

CD (1 file):
  Local: Gate Cse notes/compiler-design-complete.html
  Path:  notes/gate/cd/compiler-design-complete.html

CN (2 files):
  Local: Gate Cse notes/cn-01-datalink-network-routing.html
  Path:  notes/gate/cn/cn-01-datalink-network-routing.html

  Local: Gate Cse notes/cn-02-transport-application-1.html
  Path:  notes/gate/cn/cn-02-transport-application-1.html

COA (2 files):
  Local: Gate Cse notes/coa-01-number-systems-boolean-circuits.html
  Path:  notes/gate/coa/coa-01-number-systems-boolean-circuits.html

  Local: Gate Cse notes/coa-02-cpu-isa-pipeline-memory.html
  Path:  notes/gate/coa/coa-02-cpu-isa-pipeline-memory.html

CPROG (1 file):
  Local: Gate Cse notes/c-programming-complete-1.html
  Path:  notes/gate/cprog/c-programming-complete-1.html

DBMS (4 files):
  Local: Gate Cse notes/dbms-gate-notes-v2-1.html
  Path:  notes/gate/dbms/dbms-gate-notes-v2-1.html

  Local: Gate Cse notes/dbms-02-sql-relational-algebra-3.html
  Path:  notes/gate/dbms/dbms-02-sql-relational-algebra-3.html

  Local: Gate Cse notes/dbms-03-transactions-concurrency-1.html
  Path:  notes/gate/dbms/dbms-03-transactions-concurrency-1.html

  Local: Gate Cse notes/dbms-04-er-indexing-relational-calculus.html
  Path:  notes/gate/dbms/dbms-04-er-indexing-relational-calculus.html

DM (2 files):
  Local: Gate Cse notes/dm-01-logic-sets-relations-functions-2.html
  Path:  notes/gate/dm/dm-01-logic-sets-relations-functions-2.html

  Local: Gate Cse notes/dm-02-graph-theory-combinatorics.html
  Path:  notes/gate/dm/dm-02-graph-theory-combinatorics.html

DSA (2 files):
  Local: Gate Cse notes/ds-01-linear-data-structures-2.html
  Path:  notes/gate/dsa/ds-01-linear-data-structures-2.html

  Local: Gate Cse notes/ds-02-trees-heaps.html
  Path:  notes/gate/dsa/ds-02-trees-heaps.html

EM (2 files):
  Local: Gate Cse notes/em-01-calculus-linear-algebra-probability-2.html
  Path:  notes/gate/em/em-01-calculus-linear-algebra-probability-2.html

  Local: Gate Cse notes/em-02-differential-equations-numerical-methods.html
  Path:  notes/gate/em/em-02-differential-equations-numerical-methods.html

OS (2 files):
  Local: Gate Cse notes/os-01-processes-scheduling-synchronization.html
  Path:  notes/gate/os/os-01-processes-scheduling-synchronization.html

  Local: Gate Cse notes/os-02-memory-filesystems-io.html
  Path:  notes/gate/os/os-02-memory-filesystems-io.html

TOC (2 files):
  Local: Gate Cse notes/toc-01-automata-grammars.html
  Path:  notes/gate/toc/toc-01-automata-grammars.html

  Local: Gate Cse notes/toc-02-turing-decidability.html
  Path:  notes/gate/toc/toc-02-turing-decidability.html

GA (2 files):
  Local: Gate Cse notes/aptitude-quantitative-master.html
  Path:  notes/gate/ga/aptitude-quantitative-master.html

  Local: Gate Cse notes/aptitude-verbal-master.html
  Path:  notes/gate/ga/aptitude-verbal-master.html

DL: ← SKIP. No notes files exist for dl. Do NOT upload anything.
```

Print after each file:
```
✅ notes/gate/{slug}/{filename}
```

After all 25 files:
```
═══════════════════════════════════════════════
NOTES UPLOAD COMPLETE
Uploaded: [n]/25
Failed:   [n]/25
Failed:   [list if any]
═══════════════════════════════════════════════
```

---

## PHASE 4 — RUN BINDING SQL (notes table + is_published)

### 4A — Insert notes table rows

Run this as a SINGLE SQL block via MCP `execute_sql`.
This wires each storage path to its chapter in the database.
All statements use ON CONFLICT DO NOTHING — safe to re-run.

```sql
-- ════════════════════════════════════════════
-- EXAMFORGE — NOTES TABLE BINDING SQL
-- Wires storage paths → chapter IDs
-- Safe to re-run: ON CONFLICT DO NOTHING on all rows
-- ════════════════════════════════════════════

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

-- CD — single file covers ALL chapters of compiler design
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT id, 'notes/gate/cd/compiler-design-complete.html', 'html', true
FROM chapters WHERE subject_id = (SELECT id FROM subjects WHERE slug = 'cd')
ON CONFLICT DO NOTHING;

-- CPROG — single file covers ALL chapters of C programming
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

-- DL: NO notes rows — dl stays unpublished, no notes table entry
```

After running, check row count:
```sql
SELECT COUNT(*) FROM notes;
-- Expected: 25 rows minimum (cd and cprog may produce more if they have multiple chapters)
```

### 4B — CRITICAL: Slug reconciliation check

If any INSERT above returned 0 rows affected, the chapter slug doesn't match.
Run this diagnostic to see actual slugs in the database:

```sql
-- Run this if any notes INSERT returned 0 rows
SELECT s.slug AS subject, c.slug AS chapter_slug, c.title
FROM chapters c
JOIN subjects s ON s.id = c.subject_id
WHERE s.slug IN ('algo','cn','coa','dbms','dm','dsa','em','os','toc','ga')
ORDER BY s.slug, c.order_index;
```

Compare the `chapter_slug` column against the WHERE clauses in Phase 4A.
If a slug doesn't match — update the INSERT WHERE clause to use the actual slug.
Report any mismatches.

### 4C — Flip subjects live

```sql
-- Make 12 subjects visible to users
UPDATE subjects
SET is_published = true
WHERE slug IN (
  'algo', 'cd', 'cn', 'coa', 'cprog',
  'dbms', 'dm', 'dsa', 'em', 'ga', 'os', 'toc'
);

-- dl stays false — no notes HTML, not ready
-- Verify dl is still false:
SELECT slug, is_published FROM subjects WHERE slug = 'dl';
-- Expected: dl | false
```

---

## PHASE 5 — FULL HEALTH VERIFICATION

Run all queries. Report results for every one.

### 5A — System health (the master check)

```sql
SELECT
  s.slug,
  s.is_published,
  COUNT(DISTINCT q.id)   AS questions,
  COUNT(DISTINCT f.id)   AS flashcards,
  COUNT(DISTINCT n.id)   AS notes_chapters,
  COUNT(DISTINCT t.id)   AS tags
FROM subjects s
LEFT JOIN questions q    ON q.subject_id = s.id
LEFT JOIN flashcards f   ON f.subject_id = s.id
LEFT JOIN chapters c     ON c.subject_id = s.id
LEFT JOIN notes n        ON n.chapter_id = c.id
LEFT JOIN question_tags qt ON qt.question_id = q.id
LEFT JOIN tags t         ON t.id = qt.tag_id
WHERE s.category = 'GATE'
GROUP BY s.slug, s.is_published
ORDER BY s.slug;
```

Expected results:
```
algo  | true  | 100+ | 40+ | 3  | many
cd    | true  | 100+ | 40+ | 1+ | many
cn    | true  | 100+ | 40+ | 2  | many
coa   | true  | 100+ | 40+ | 2  | many
cprog | true  | 100+ | 40+ | 1+ | many
dbms  | true  | 100+ | 40+ | 4  | many
dl    | false | 100+ | 40+ | 0  | many   ← questions seeded but not published
dm    | true  | 100+ | 40+ | 2  | many
dsa   | true  | 100+ | 40+ | 2  | many
em    | true  | 100+ | 40+ | 2  | many
ga    | true  | 100+ | 40+ | 2  | many
os    | true  | 100+ | 40+ | 2  | many
toc   | true  | 100+ | 40+ | 2  | many
```

Flag any row where: questions < 50, notes_chapters = 0 (except dl), is_published is wrong.

### 5B — Orphan checks

```sql
-- Questions with no topic (violates seed rules)
SELECT COUNT(*) AS questions_missing_topic FROM questions WHERE topic_id IS NULL;
-- Expected: 0

-- Notes rows with no matching chapter (broken binding)
SELECT n.storage_path
FROM notes n
LEFT JOIN chapters c ON c.id = n.chapter_id
WHERE c.id IS NULL;
-- Expected: 0 rows

-- question_tags with no matching question or tag
SELECT COUNT(*) AS orphan_question_tags
FROM question_tags qt
LEFT JOIN questions q ON q.id = qt.question_id
LEFT JOIN tags t ON t.id = qt.tag_id
WHERE q.id IS NULL OR t.id IS NULL;
-- Expected: 0
```

### 5C — Count totals

```sql
SELECT
  (SELECT COUNT(*) FROM subjects WHERE category = 'GATE') AS subjects,
  (SELECT COUNT(*) FROM chapters)                          AS chapters,
  (SELECT COUNT(*) FROM topics)                            AS topics,
  (SELECT COUNT(*) FROM questions)                         AS questions,
  (SELECT COUNT(*) FROM flashcards)                        AS flashcards,
  (SELECT COUNT(*) FROM tags)                              AS tags,
  (SELECT COUNT(*) FROM question_tags)                     AS question_tags,
  (SELECT COUNT(*) FROM notes)                             AS notes_rows;
```

Expected minimums:
```
subjects:      13
chapters:      40+
topics:        100+
questions:     1300+ (100+ per subject × 13)
flashcards:    520+ (40+ per subject × 13)
tags:          200+
question_tags: 1000+
notes_rows:    25+
```

### 5D — Storage verification

List all objects in the `notes-content` bucket under the `notes/gate/` prefix.
Confirm all 25 files are present across their subject folders:
- `notes/gate/algo/` → 3 files
- `notes/gate/cd/` → 1 file
- `notes/gate/cn/` → 2 files
- `notes/gate/coa/` → 2 files
- `notes/gate/cprog/` → 1 file
- `notes/gate/dbms/` → 4 files
- `notes/gate/dm/` → 2 files
- `notes/gate/dsa/` → 2 files
- `notes/gate/em/` → 2 files
- `notes/gate/os/` → 2 files
- `notes/gate/toc/` → 2 files
- `notes/gate/ga/` → 2 files
- `notes/gate/dl/` → should NOT exist

Total: 25 files. Report any missing or extra.

---

## PHASE 6 — FINAL REPORT

After all phases complete, print this summary:

```
════════════════════════════════════════════════════════
EXAMFORGE DATABASE INJECTION — FINAL REPORT
════════════════════════════════════════════════════════

PHASE 1 — Pre-flight
  Schema:  [PASS/FAIL]
  Bucket:  [PASS/FAIL — exists as private notes-content]

PHASE 2 — SQL Seeds (126 files)
  Succeeded: [n]/126
  Failed:    [n]/126
  [List failed files if any]

PHASE 3 — Notes Upload (25 files)
  Succeeded: [n]/25
  Failed:    [n]/25
  [List failed files if any]

PHASE 4 — Binding SQL
  Notes rows inserted: [n]
  Slug mismatches: [none / list them]
  is_published flipped: algo, cd, cn, coa, cprog, dbms, dm, dsa, em, ga, os, toc
  dl stays unpublished: [confirmed]

PHASE 5 — Health Check
  All subjects have 100+ questions: [YES/NO]
  All published subjects have notes: [YES/NO]
  Orphaned questions (no topic_id):  [n] ← must be 0
  Orphaned notes rows:               [n] ← must be 0
  Total questions in DB:             [n]
  Total flashcards in DB:            [n]
  Total notes rows:                  [n]

STATUS: [✅ COMPLETE — ready for end-to-end frontend testing]
        [⚠️  PARTIAL — issues listed above need resolution]
════════════════════════════════════════════════════════
```

---

## ERROR RECOVERY REFERENCE

If a seed file fails with a foreign key error:
→ The base file for that subject did not run first.
→ Re-run `{slug}-seed.sql` (base), then retry the failing part.

If a seed file fails with "relation does not exist":
→ The schema is not migrated. STOP. Run migrations first.

If a notes upload fails with "bucket not found":
→ The `notes-content` bucket doesn't exist. Create it in Phase 1A first.

If a notes INSERT returns 0 rows:
→ Chapter slug mismatch. Run the diagnostic query in Phase 4B.
→ Get the real slug from the chapters table and update the INSERT.

If questions count is 0 for a subject after seeding:
→ The base file ran but parts failed silently.
→ Re-run each part file individually and check for errors.

---

*ExamForge Supabase MCP Seed Injection Prompt*
*126 SQL files → Supabase PostgreSQL · 25 HTML files → Supabase Storage*
*All phases idempotent · Safe to re-run · Fully verified*
*Subjects: algo · cd · cn · coa · cprog · dbms · dl · dm · dsa · em · ga · os · toc*
