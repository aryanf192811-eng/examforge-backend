-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — GENERAL APTITUDE PYQ SEED v2 (Part 1 / 10)
-- Subject : General Aptitude | Exam: gate-cse | Branch: cse
-- Schema : v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- ═══════════════════════════════════════════════════════════════════════════
BEGIN;

-- ── Subject ───────────────────────────────────────────────────────────────
INSERT INTO subjects (slug,name,category,branch_slug,icon,order_index,is_published,exam_weight_pct)
VALUES ('ga','General Aptitude','GATE','cse','🧠',0,true,15)
ON CONFLICT (slug) DO NOTHING;

-- ── Chapters (6) ─────────────────────────────────────────────────────────
INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='ga'),
 'English Grammar & Usage','ga-grammar',1,45,true,'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='ga-grammar');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='ga'),
 'Vocabulary & Sentence Construction','ga-vocabulary',2,40,true,'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='ga-vocabulary');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='ga'),
 'Reading Comprehension & Critical Reasoning','ga-reading',3,50,true,'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='ga-reading');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='ga'),
 'Arithmetic & Number Theory','ga-arithmetic',4,60,true,'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='ga-arithmetic');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='ga'),
 'Advanced Quantitative Aptitude','ga-quant',5,60,true,'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='ga-quant');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='ga'),
 'Data Interpretation & Logical Reasoning','ga-di-logic',6,50,true,'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='ga-di-logic');

-- ── Tags (30) ─────────────────────────────────────────────────────────────
INSERT INTO tags (slug,name) VALUES
 ('grammar', 'Grammar'),
 ('prepositions', 'Prepositions'),
 ('articles', 'Articles'),
 ('tenses', 'Tenses'),
 ('subject-verb', 'Subject-Verb Agreement'),
 ('vocabulary', 'Vocabulary'),
 ('synonyms-antonyms', 'Synonyms & Antonyms'),
 ('analogies', 'Verbal Analogies'),
 ('idioms', 'Idioms & Phrases'),
 ('sentence-completion', 'Sentence Completion'),
 ('para-jumbles', 'Para Jumbles'),
 ('reading-comprehension','Reading Comprehension'),
 ('critical-reasoning', 'Critical Reasoning'),
 ('logical-deduction', 'Logical Deduction'),
 ('number-systems', 'Number Systems'),
 ('percentages', 'Percentages'),
 ('profit-loss', 'Profit & Loss'),
 ('si-ci', 'Simple & Compound Interest'),
 ('ratio-proportion', 'Ratio & Proportion'),
 ('averages', 'Averages'),
 ('time-work', 'Time & Work'),
 ('time-speed-distance', 'Time, Speed & Distance'),
 ('permutation-combination','Permutations & '),
 ('probability', 'Probability'),
 ('data-interpretation', 'Data Interpretation'),
 ('series-sequences', 'Series & Sequences'),
 ('algebra', 'Algebra'),
 ('geometry-mensuration','Geometry & Mensuration'),
 ('clocks-calendars', 'Clocks & Calendars'),
 ('venn-diagrams', 'Venn Diagrams & Sets')
ON CONFLICT (slug) DO NOTHING;

-- ── Topics ────────────────────────────────────────────────────────────────
-- Chapter: ga-grammar (4 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
 ((SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),'Articles & Prepositions','articles-prepositions',1),
 ((SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),'Tenses & Voice','tenses-voice',2),
 ((SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),'Subject-Verb Agreement','subject-verb-agreement',3),
 ((SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),'Error Correction & Sentence Improvement','error-correction',4)
ON CONFLICT (slug) DO NOTHING;

-- Chapter: ga-vocabulary (4 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
 ((SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),'Synonyms, Antonyms & Word Meaning','word-meaning',1),
 ((SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),'Sentence Completion & Fill in Blanks','sentence-fill',2),
 ((SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),'Verbal Analogies & Word Relationships','verbal-analogies',3),
 ((SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),'Idioms, Phrases & One-Word Substitution','idioms-phrases',4)
ON CONFLICT (slug) DO NOTHING;

-- Chapter: ga-reading (4 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
 ((SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),'Short Passage Comprehension','passage-comprehension',1),
 ((SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),'Inference & Assumption Identification','inference-assumption',2),
 ((SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),'Para Jumbles & Sentence Rearrangement','para-rearrangement',3),
 ((SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),'Critical Reasoning & Logical Arguments','critical-arguments',4)
ON CONFLICT (slug) DO NOTHING;

-- Chapter: ga-arithmetic (4 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
 ((SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),'Number Systems, Divisibility, LCM & HCF','number-divisibility',1),
 ((SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),'Percentages, Profit & Loss','pct-profit-loss',2),
 ((SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),'Ratio, Proportion & Mixtures','ratio-mixtures',3),
 ((SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),'Simple & Compound Interest','interest-calc',4)
ON CONFLICT (slug) DO NOTHING;

-- Chapter: ga-quant (4 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
 ((SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),'Time & Work, Pipes & Cisterns','time-work-pipes',1),
 ((SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),'Time, Speed & Distance','speed-distance',2),
 ((SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),'Permutations, & Probability','pnc-probability',3),
 ((SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),'Algebra, Sequences & Geometry','algebra-geometry',4)
ON CONFLICT (slug) DO NOTHING;

-- Chapter: ga-di-logic (4 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
 ((SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),'Data Tables & Chart Interpretation','chart-interpretation',1),
 ((SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),'Venn Diagrams & Set Theory','venn-sets',2),
 ((SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),'Clocks, Calendars & Logical Puzzles','clocks-puzzles',3),
 ((SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),'Data Sufficiency','data-sufficiency',4)
ON CONFLICT (slug) DO NOTHING;

COMMIT;
-- Part 1 complete.
