-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DBMS PYQ SEED v2  (Part 1 / 7)
-- Subject : Database Management Systems | Exam: gate-cse | Branch: cse
-- Schema  : v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- ═══════════════════════════════════════════════════════════════════════════
BEGIN;

-- ── Branch ────────────────────────────────────────────────────────────────
INSERT INTO branches (slug, name, description, icon)
VALUES ('cse','Computer Science & Engineering','CS + IT combined','💻')
ON CONFLICT (slug) DO NOTHING;

-- ── Exam Config ───────────────────────────────────────────────────────────
INSERT INTO exam_configs (slug,name,description,total_questions,duration_mins,
  negative_marking,marking_scheme,sections,branch_slug,is_active)
VALUES ('gate-cse','GATE CSE',
  'Graduate Aptitude Test in Engineering — Computer Science & IT',
  65,180,true,
  '{"1-mark":{"correct":1,"wrong":-0.33},"2-mark":{"correct":2,"wrong":-0.67}}',
  '["General Aptitude","Computer Science & IT"]',
  'cse',true)
ON CONFLICT (slug) DO NOTHING;

-- ── Subject ───────────────────────────────────────────────────────────────
INSERT INTO subjects (slug,name,category,branch_slug,icon,order_index,is_published,exam_weight_pct)
VALUES ('dbms','Database Management Systems','GATE','cse','🗄️',1,true,11)
ON CONFLICT (slug) DO NOTHING;

-- ── Chapters (7) ─────────────────────────────────────────────────────────
INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dbms'),
  'ER Model & Schema Design','er-model',1,60,true,'medium'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='er-model');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dbms'),
  'Relational Model & Keys','relational-model',2,60,true,'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='relational-model');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dbms'),
  'Functional Dependencies & Normalization','normalization',3,90,true,'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='normalization');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dbms'),
  'SQL & Relational Algebra','sql-ra',4,90,true,'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='sql-ra');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dbms'),
  'Transactions & Concurrency Control','transactions',5,75,true,'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='transactions');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dbms'),
  'Indexing & Hashing','indexing-hashing',6,60,true,'medium'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='indexing-hashing');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dbms'),
  'Query Processing & Optimization','query-processing',7,45,true,'medium'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='query-processing');

-- ── SECTION 0: TAGS (30) ─────────────────────────────────────────────────
INSERT INTO tags (slug,name) VALUES
  ('er-model',              'ER Model'),
  ('weak-entity',           'Weak Entity'),
  ('isa-hierarchy',         'ISA Hierarchy'),
  ('relational-algebra',    'Relational Algebra'),
  ('relational-calculus',   'Relational Calculus'),
  ('sql-queries',           'SQL Queries'),
  ('sql-joins',             'SQL Joins'),
  ('subquery',              'Subqueries'),
  ('aggregation',           'Aggregation'),
  ('functional-dependency', 'Functional Dependencies'),
  ('closure',               'Attribute Closure'),
  ('minimal-cover',         'Minimal Cover'),
  ('normalization',         'Normalization'),
  ('bcnf',                  'BCNF'),
  ('3nf',                   '3NF'),
  ('2nf',                   '2NF'),
  ('4nf',                   '4NF & MVD'),
  ('candidate-key',         'Candidate Keys'),
  ('foreign-key',           'Foreign Keys'),
  ('transactions',          'Transactions'),
  ('acid',                  'ACID Properties'),
  ('serializability',       'Serializability'),
  ('conflict-serializability','Conflict Serializability'),
  ('view-serializability',  'View Serializability'),
  ('two-phase-locking',     'Two-Phase Locking'),
  ('deadlock',              'Deadlock'),
  ('timestamp-protocol',    'Timestamp Protocols'),
  ('indexing',              'Indexing'),
  ('b-plus-tree',           'B+ Tree'),
  ('hashing',               'Hashing')
ON CONFLICT (slug) DO NOTHING;

-- ── SECTION 1: TOPICS ────────────────────────────────────────────────────
-- Chapter: er-model (6 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='er-model' LIMIT 1),'Entities & Attributes','entities-attributes',1),
  ((SELECT id FROM chapters WHERE slug='er-model' LIMIT 1),'Relationships & Cardinality','relationships-cardinality',2),
  ((SELECT id FROM chapters WHERE slug='er-model' LIMIT 1),'Weak Entities & Identifying Keys','weak-entities-keys',3),
  ((SELECT id FROM chapters WHERE slug='er-model' LIMIT 1),'ISA Hierarchy & Aggregation','isa-aggregation',4),
  ((SELECT id FROM chapters WHERE slug='er-model' LIMIT 1),'ER to Relational Mapping','er-to-relational',5),
  ((SELECT id FROM chapters WHERE slug='er-model' LIMIT 1),'Extended ER Features','extended-er',6);

-- Chapter: relational-model (6 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='relational-model' LIMIT 1),'Domains, Tuples & Relations','domains-tuples',1),
  ((SELECT id FROM chapters WHERE slug='relational-model' LIMIT 1),'Keys: Super, Candidate, Primary','key-types',2),
  ((SELECT id FROM chapters WHERE slug='relational-model' LIMIT 1),'Foreign Keys & Referential Integrity','foreign-key-integrity',3),
  ((SELECT id FROM chapters WHERE slug='relational-model' LIMIT 1),'Relational Algebra Basics','ra-basics',4),
  ((SELECT id FROM chapters WHERE slug='relational-model' LIMIT 1),'Join Operations in RA','ra-joins',5),
  ((SELECT id FROM chapters WHERE slug='relational-model' LIMIT 1),'Relational Calculus','relational-calculus-topic',6);

-- Chapter: normalization (7 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),'Functional Dependencies & Axioms','fd-axioms',1),
  ((SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),'Attribute Closure & Key Finding','attr-closure',2),
  ((SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),'Minimal Cover & Canonical Cover','minimal-cover',3),
  ((SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),'1NF & 2NF','1nf-2nf',4),
  ((SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),'3NF & Synthesis Algorithm','3nf-synthesis',5),
  ((SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),'BCNF & Decomposition','bcnf-decomp',6),
  ((SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),'Multivalued Dependencies & 4NF','mvd-4nf',7);

-- Chapter: sql-ra (6 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),'Basic SQL: SELECT, WHERE, ORDER BY','basic-sql',1),
  ((SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),'SQL JOINs','sql-joins-topic',2),
  ((SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),'Subqueries & Correlated Subqueries','subqueries-topic',3),
  ((SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),'Aggregation: GROUP BY & HAVING','aggregation-sql',4),
  ((SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),'Views, Assertions & Triggers','views-triggers',5),
  ((SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),'Relational Algebra Expressions','ra-expressions',6);

-- Chapter: transactions (8 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),'ACID Properties','acid-props',1),
  ((SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),'Transaction States & Operations','txn-states',2),
  ((SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),'Schedules & Serializability','schedules',3),
  ((SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),'Conflict Serializability & Precedence Graphs','conflict-serial',4),
  ((SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),'View Serializability','view-serial',5),
  ((SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),'Two-Phase Locking','2pl-protocol',6),
  ((SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),'Deadlock Detection & Recovery','deadlock-recovery',7),
  ((SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),'Timestamp-Based Protocols','timestamp-protocols',8);

-- Chapter: indexing-hashing (6 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),'Index Types: Dense & Sparse','index-types',1),
  ((SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),'Clustering vs Non-Clustering Indexes','clustering-index',2),
  ((SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),'B-Tree Structure & Operations','b-tree',3),
  ((SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),'B+ Tree: Insertion & Deletion','b-plus-tree-topic',4),
  ((SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),'Static & Dynamic Hashing','hashing-topic',5),
  ((SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),'Extendible & Linear Hashing','extendible-hashing',6);

-- Chapter: query-processing (6 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='query-processing' LIMIT 1),'Query Cost Estimation','query-cost',1),
  ((SELECT id FROM chapters WHERE slug='query-processing' LIMIT 1),'Selection Algorithms','selection-algo',2),
  ((SELECT id FROM chapters WHERE slug='query-processing' LIMIT 1),'Join Algorithms (NLJ, Hash, Sort-Merge)','join-algorithms',3),
  ((SELECT id FROM chapters WHERE slug='query-processing' LIMIT 1),'Sort-Merge Join','sort-merge-join',4),
  ((SELECT id FROM chapters WHERE slug='query-processing' LIMIT 1),'Query Optimization','query-optimization',5),
  ((SELECT id FROM chapters WHERE slug='query-processing' LIMIT 1),'Pipelining & Materialization','pipelining',6);

-- Part 1 complete. Continue with dbms-seed-p2.sql
