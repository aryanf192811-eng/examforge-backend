-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COMPILER DESIGN (CD) PYQ SEED v2 (Part 1 / 8)
-- Master Initialization: Subject, Chapters, Topics, Tags
-- ═══════════════════════════════════════════════════════════════════════════

BEGIN;

-- 1. Insert Subject: Compiler Design
INSERT INTO subjects (name, slug, description, gradient_start, gradient_end, icon)
VALUES (
 'Compiler Design',
 'cd',
 'Lexical analysis, parsing techniques, semantic analysis, code optimization, and runtime environments.',
 '#4ade80', -- Green-400
 '#22c55e', -- Green-500
 'Terminal'
) ON CONFLICT (slug) DO NOTHING;

-- 2. Insert Chapters
WITH cd AS (SELECT id FROM subjects WHERE slug = 'cd')
INSERT INTO chapters (subject_id, name, slug, description, sequence)
VALUES
 ((SELECT id FROM cd), 'Lexical Analysis', 'lexical-analysis', 'Tokenization, regex to DFA mappings, buffer management.', 1),
 ((SELECT id FROM cd), 'Syntax Analysis', 'syntax-analysis', 'LL, LR, SLR, LALR parsers, and grammar properties.', 2),
 ((SELECT id FROM cd), 'Syntax Directed Translation', 'sdt-icg', 'SDT implementations, abstract syntax trees, and intermediate code.', 3),
 ((SELECT id FROM cd), 'Optimization & Runtime', 'optimization-runtime', 'Data-flow analysis, peephole optimization, and activation records.', 4)
ON CONFLICT (subject_id, slug) DO NOTHING;

-- 3. Insert Common Tags
INSERT INTO tags (name, slug) VALUES
('Lexical Analysis', 'lexical-analysis'),
('DFA', 'dfa-regex'),
('Tokens', 'tokens'),
('Parsing', 'parsing'),
('Top-Down Parsing', 'll-parsing'),
('Bottom-Up Parsing', 'lr-parsing'),
('First & Follow', 'first-follow'),
('SDT', 'sdt'),
('Intermediate Code', 'icg'),
('DAG', 'dag'),
('Code Optimization', 'optimization'),
('Liveness Analysis', 'liveness'),
('Runtime Environment', 'runtime-env'),
('Activation Records', 'activation')
ON CONFLICT (slug) DO NOTHING;

-- 4. Insert Topics
WITH chap_lex AS (SELECT id FROM chapters WHERE slug = 'lexical-analysis' AND subject_id = (SELECT id FROM subjects WHERE slug = 'cd')),
 chap_syn AS (SELECT id FROM chapters WHERE slug = 'syntax-analysis' AND subject_id = (SELECT id FROM subjects WHERE slug = 'cd')),
 chap_sdt AS (SELECT id FROM chapters WHERE slug = 'sdt-icg' AND subject_id = (SELECT id FROM subjects WHERE slug = 'cd')),
 chap_opt AS (SELECT id FROM chapters WHERE slug = 'optimization-runtime' AND subject_id = (SELECT id FROM subjects WHERE slug = 'cd'))
INSERT INTO topics (chapter_id, name, slug, sequence) VALUES
 -- Lexical
 ((SELECT id FROM chap_lex), 'Token Identification', 'token-identification', 1),
 ((SELECT id FROM chap_lex), 'Regex to DFA', 'regex-dfa', 2),
 ((SELECT id FROM chap_lex), 'Lexical Errors', 'lexical-errors', 3),

 -- Syntax Analysis
 ((SELECT id FROM chap_syn), 'Grammar Modifications', 'grammar-modifications', 4),
 ((SELECT id FROM chap_syn), 'First and Follow Sets', 'first-follow-sets', 5),
 ((SELECT id FROM chap_syn), 'LL(1) Parsing', 'll1-parsing', 6),
 ((SELECT id FROM chap_syn), 'LR(0) and SLR(1)', 'lr0-slr1', 7),
 ((SELECT id FROM chap_syn), 'LALR(1) and CLR(1)', 'lalr-clr', 8),
 ((SELECT id FROM chap_syn), 'Shift-Reduce Conflicts', 'shift-reduce', 9),

 -- SDT & Intermediate Code
 ((SELECT id FROM chap_sdt), 'Synthesized & Inherited Attributes', 'attributes', 10),
 ((SELECT id FROM chap_sdt), 'L-Attributed and S-Attributed', 'att-types', 11),
 ((SELECT id FROM chap_sdt), 'Three-Address Code (TAC)', 'tac', 12),
 ((SELECT id FROM chap_sdt), 'Abstract Syntax Trees', 'ast', 13),
 ((SELECT id FROM chap_sdt), 'Directed Acyclic Graphs (DAG)', 'dag-topic', 14),

 -- Optimization & Runtime
 ((SELECT id FROM chap_opt), 'Basic Blocks & Control Flow', 'basic-blocks', 15),
 ((SELECT id FROM chap_opt), 'Data-Flow Analysis', 'data-flow', 16),
 ((SELECT id FROM chap_opt), 'Machine Independent Optimization', 'code-opt', 17),
 ((SELECT id FROM chap_opt), 'Peephole Optimization', 'peephole', 18),
 ((SELECT id FROM chap_opt), 'Activation Records & Parameter Passing', 'runtime', 19)
ON CONFLICT (chapter_id, slug) DO NOTHING;

-- Part 1 complete.
