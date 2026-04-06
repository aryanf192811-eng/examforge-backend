-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — C PROGRAMMING PYQ SEED v2 (Part 1 / 8)
-- Subject, Chapters, Topics, & Base Tags
-- ═══════════════════════════════════════════════════════════════════════════

-- 1. Subject Insert (Idempotent)
INSERT INTO subjects (name, description, difficulty, is_published, slug)
VALUES (
 'C Programming',
 'Core mechanics, memory , recursion, and pointer arithmetic based on GATE curriculum .',
 'medium',
 false,
 'cprog'
) ON CONFLICT (slug) DO NOTHING;

-- 2. Chapters Insert
WITH s AS (SELECT id FROM subjects WHERE slug='cprog')
INSERT INTO chapters (subject_id, name, order_index, is_published, slug)
VALUES
 ((SELECT id FROM s), 'Basics & Control Flow', 1, false, 'c-basics-flow'),
 ((SELECT id FROM s), 'Functions & Recursion', 2, false, 'c-functions-recursion'),
 ((SELECT id FROM s), 'Pointers & Arrays', 3, false, 'c-pointers-arrays'),
 ((SELECT id FROM s), 'Structs & Memory Allocation', 4, false, 'c-structs-memory')
ON CONFLICT (slug) DO NOTHING;

-- 3. Topics Insert
WITH 
 c1 AS (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 c2 AS (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 c3 AS (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 c4 AS (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1)
INSERT INTO topics (chapter_id, name, order_index, is_published, slug)
VALUES
 -- Chapter 1 Topics
 ((SELECT id FROM c1), 'Data Types & Operators', 1, false, 'data-types-operators'),
 ((SELECT id FROM c1), 'Control Flow (if, loops)', 2, false, 'control-flow'),
 ((SELECT id FROM c1), 'Macros & Scope', 3, false, 'macros-scope'),
 
 -- Chapter 2 Topics
 ((SELECT id FROM c2), 'Function Calls & ', 1, false, 'function-params'),
 ((SELECT id FROM c2), 'Recursion Mechanics', 2, false, 'recursion-mechanics'),
 
 -- Chapter 3 Topics
 ((SELECT id FROM c3), 'Pointer Arithmetic', 1, false, 'pointer-arithmetic'),
 ((SELECT id FROM c3), '1D and Matrix Arrays', 2, false, 'arrays-matrices'),
 ((SELECT id FROM c3), 'Strings handling', 3, false, 'strings-handling'),
 
 -- Chapter 4 Topics
 ((SELECT id FROM c4), 'Structures & Unions', 1, false, 'structs-unions'),
 ((SELECT id FROM c4), 'Dynamic Memory (malloc/free)', 2, false, 'dynamic-memory')
ON CONFLICT (slug) DO NOTHING;

-- 4. Tags Insert
INSERT INTO tags (name, slug)
VALUES
 ('C Basics', 'c-basics'),
 ('Control Flow', 'control-flow'),
 ('Pointers', 'pointers'),
 ('Arrays', 'arrays'),
 ('Functions', 'functions'),
 ('Recursion', 'recursion'),
 ('Structures', 'structs'),
 ('Memory Management', 'memory-management'),
 ('Macros', 'macros'),
 ('Pointer Arithmetic', 'pointer-arithmetic')
ON CONFLICT (slug) DO NOTHING;

-- End of Part 1.
