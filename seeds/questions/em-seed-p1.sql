-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — EM PYQ SEED v2  (Part 1 / 8)
-- Subject : Engineering Mathematics | Exam: gate-cse | Branch: cse
-- Schema  : v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- ═══════════════════════════════════════════════════════════════════════════
BEGIN;

-- ── Subject ───────────────────────────────────────────────────────────────
INSERT INTO subjects (slug,name,category,branch_slug,icon,order_index,is_published,exam_weight_pct)
VALUES ('em','Engineering Mathematics','GATE','cse','📐',3,true,13)
ON CONFLICT (slug) DO NOTHING;

-- ── Chapters (4) ─────────────────────────────────────────────────────────
-- GATE CSE EM has 3 main chapters but let's break it down logically.
INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='em'), 'Linear Algebra', 'linear-algebra', 1, 180, true, 'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='linear-algebra');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='em'), 'Calculus', 'calculus', 2, 180, true, 'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='calculus');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='em'), 'Probability & Statistics', 'probability-statistics', 3, 240, true, 'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='probability-statistics');

-- ── SECTION 0: TAGS ──────────────────────────────────────────────────────
INSERT INTO tags (slug,name) VALUES
  ('matrix',            'Matrices'),
  ('determinant',       'Determinants'),
  ('eigenvalues',       'Eigenvalues & Eigenvectors'),
  ('system-of-equations','System of Equations'),
  ('limits',            'Limits & Continuity'),
  ('derivatives',       'Derivatives'),
  ('maxima-minima',     'Maxima & Minima'),
  ('integration',       'Integration'),
  ('mean-value-theorem','Mean Value Theorem'),
  ('probability',       'Probability'),
  ('bayes-theorem',     'Bayes Theorem'),
  ('random-variable',   'Random Variables'),
  ('distributions',     'Probability Distributions'),
  ('statistics',        'Statistics (Mean, Variance)')
ON CONFLICT (slug) DO NOTHING;

-- ── SECTION 1: TOPICS ────────────────────────────────────────────────────
-- Chapter: linear-algebra
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'Matrix Operations & Types','matrix-operations',1),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'Determinants & Properties','determinants',2),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'Inverse & Rank of a Matrix','matrix-inverse-rank',3),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'System of Linear Equations (Consistency)','linear-equations',4),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'Eigenvalues & Eigenvectors','eigenvalues-eigenvectors',5),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'Cayley-Hamilton Theorem','cayley-hamilton',6),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'LU Decomposition','lu-decomposition',7);

-- Chapter: calculus
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Limits & L''Hopital''s Rule','limits',1),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Continuity & Differentiability','continuity',2),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Mean Value Theorems (Rolle''s, Lagrange)','mean-value-theorems',3),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Maxima & Minima (Single Variable)','maxima-minima',4),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Partial Derivatives & Multivariable Extrema','partial-derivatives',5),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Definite Integrals & Properties','integration',6),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Evaluation of Series via Integrals','series-integration',7);

-- Chapter: probability-statistics
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Basic Probability & Combinatorics','basic-probability',1),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Conditional Probability','conditional-prob',2),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Total Probability & Bayes'' Theorem','bayes-theorem-topic',3),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Random Variables (Discrete & Continuous)','random-variables',4),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Expectation, Variance & Standard Deviation','statistics-basics',5),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Binomial & Poisson Distributions','discrete-distributions',6),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Uniform & Exponential Distributions','continuous-distributions',7),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Normal Distribution','normal-distribution',8);

-- Part 1 complete.
