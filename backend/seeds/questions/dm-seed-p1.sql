-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DM PYQ SEED v2  (Part 1 / 8)
-- Subject: Discrete Mathematics (DM)
-- Scope: Initialization, Chapters, Tags, Topics
-- ═══════════════════════════════════════════════════════════════════════════

-- ─── Subject ─────────────────────────────────────────────────────────────
INSERT INTO subjects (slug, name, description, color, icon)
VALUES (
  'dm',
  'Discrete Mathematics',
  'Propositional logic, set theory, combinatorics, and graph theory fundamental to theoretical computer science.',
  '#9c27b0', -- Purple
  '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-infinity"><path d="M12 12c-2-2.67-4-4-6-4a4 4 0 1 0 0 8c2 0 4-1.33 6-4Zm0 0c2 2.67 4 4 6 4a4 4 0 1 0 0-8c-2 0-4 1.33-6 4Z"/></svg>'
) ON CONFLICT (slug) DO NOTHING;

-- ─── Chapters ────────────────────────────────────────────────────────────
WITH s AS (SELECT id FROM subjects WHERE slug='dm')
INSERT INTO chapters (subject_id, slug, name, description, "order") VALUES
((SELECT id FROM s), 'logic-proofs', 'Logic and Proofs', 'Propositional logic, First-order logic, and Proof techniques.', 1),
((SELECT id FROM s), 'sets-relations-functions', 'Sets, Relations & Functions', 'Set theory, Posets, Lattices, Functions, and Group Theory.', 2),
((SELECT id FROM s), 'combinatorics', 'Combinatorics', 'Permutations, Combinations, Generating functions, and Recurrence relations.', 3),
((SELECT id FROM s), 'graph-theory', 'Graph Theory', 'Connectivity, Matching, Coloring, Trees, and Graph traversal.', 4)
ON CONFLICT (subject_id, slug) DO NOTHING;

-- ─── Tags ────────────────────────────────────────────────────────────────
INSERT INTO tags (slug, name) VALUES
('logic', 'Logic'),
('propositional', 'Propositional Calculus'),
('first-order', 'First-Order Logic'),
('sets', 'Sets'),
('relations', 'Relations'),
('functions', 'Functions'),
('groups', 'Group Theory'),
('lattices', 'Lattices & Posets'),
('combinatorics', 'Combinatorics'),
('recurrence', 'Recurrence Relations'),
('graphs', 'Graphs'),
('trees', 'Trees'),
('matching', 'Matching & Coloring')
ON CONFLICT (slug) DO NOTHING;

-- ─── Topics ──────────────────────────────────────────────────────────────
WITH c1 AS (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
     c2 AS (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
     c3 AS (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
     c4 AS (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1)
INSERT INTO topics (chapter_id, slug, name, "order") VALUES
-- Chapter 1: Logic & Proofs
((SELECT id FROM c1), 'propositional-logic', 'Propositional Logic', 1),
((SELECT id FROM c1), 'first-order-logic', 'First-Order Logic', 2),
((SELECT id FROM c1), 'proof-techniques', 'Proof Techniques', 3),

-- Chapter 2: Sets, Relations & Functions
((SELECT id FROM c2), 'set-theory', 'Set Theory', 1),
((SELECT id FROM c2), 'relations-properties', 'Relations and Properties', 2),
((SELECT id FROM c2), 'equivalence-posets', 'Equivalence Relations & Posets', 3),
((SELECT id FROM c2), 'lattices-boolean', 'Lattices & Boolean Algebra', 4),
((SELECT id FROM c2), 'functions-types', 'Types of Functions', 5),
((SELECT id FROM c2), 'group-theory', 'Group Theory', 6),

-- Chapter 3: Combinatorics
((SELECT id FROM c3), 'permutations-combinations', 'Permutations & Combinations', 1),
((SELECT id FROM c3), 'pigeonhole-principle', 'Pigeonhole Principle', 2),
((SELECT id FROM c3), 'inclusion-exclusion', 'Inclusion-Exclusion Principle', 3),
((SELECT id FROM c3), 'generating-functions', 'Generating Functions', 4),
((SELECT id FROM c3), 'recurrence-relations', 'Recurrence Relations', 5),

-- Chapter 4: Graph Theory
((SELECT id FROM c4), 'graph-basics', 'Graph Basics & Properties', 1),
((SELECT id FROM c4), 'connectivity-paths', 'Connectivity, Euler & Hamilton Paths', 2),
((SELECT id FROM c4), 'planar-graphs', 'Planar Graphs', 3),
((SELECT id FROM c4), 'graph-coloring', 'Graph Coloring', 4),
((SELECT id FROM c4), 'matching', 'Matching & Independent Sets', 5),
((SELECT id FROM c4), 'trees-properties', 'Trees & Their Properties', 6)
ON CONFLICT (chapter_id, slug) DO NOTHING;

-- Part 1 complete.
