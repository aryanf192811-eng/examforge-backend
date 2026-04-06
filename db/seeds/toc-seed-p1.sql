-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — TOC PYQ SEED v2  (Part 1 / 8)
-- Subject: Theory of Computation (TOC)
-- Scope: Initialization, Chapters, Tags, Topics
-- ═══════════════════════════════════════════════════════════════════════════

-- ─── Subject ─────────────────────────────────────────────────────────────
INSERT INTO subjects (slug, name, description, color, icon)
VALUES (
  'toc',
  'Theory of Computation',
  'Automata theory, regular languages, context-free grammars, Turing machines, and decidability.',
  '#f57c00', -- Orange
  '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-cpu"><rect width="16" height="16" x="4" y="4" rx="2" ry="2"/><rect width="6" height="6" x="9" y="9" rx="1" ry="1"/><path d="M15 2v2"/><path d="M15 20v2"/><path d="M2 15h2"/><path d="M20 15h2"/><path d="M2 9h2"/><path d="M20 9h2"/><path d="M9 2v2"/><path d="M9 20v2"/></svg>'
) ON CONFLICT (slug) DO NOTHING;

-- ─── Chapters ────────────────────────────────────────────────────────────
WITH s AS (SELECT id FROM subjects WHERE slug='toc')
INSERT INTO chapters (subject_id, slug, name, description, "order") VALUES
((SELECT id FROM s), 'regular-languages', 'Regular Languages & Finite Automata', 'DFA, NFA, Regular Expressions, and Pumping Lemma for Regular Languages.', 1),
((SELECT id FROM s), 'context-free-languages', 'Context-Free Languages & PDA', 'CFG, Pushdown Automata, Chomsky Normal Form, and properties of Context-Free Languages.', 2),
((SELECT id FROM s), 'turing-machines', 'Turing Machines & Computability', 'Turing Machines, Recursive Enumerable languages, and Unrestricted grammars.', 3),
((SELECT id FROM s), 'decidability', 'Undecidability & Complexity', 'Halting Problem, Rice''s Theorem, Decidability properties, and Reducibility.', 4)
ON CONFLICT (subject_id, slug) DO NOTHING;

-- ─── Tags ────────────────────────────────────────────────────────────────
INSERT INTO tags (slug, name) VALUES
('dfa', 'DFA & NFA'),
('regular-expressions', 'Regular Expressions'),
('closure-properties', 'Closure Properties'),
('cfg', 'Context-Free Grammars'),
('pda', 'Pushdown Automata'),
('pumping-lemma', 'Pumping Lemma'),
('turing-machine', 'Turing Machines'),
('decidability', 'Decidability'),
('undecidability', 'Undecidability'),
('rices-theorem', 'Rice''s Theorem'),
('hierarchy', 'Chomsky Hierarchy')
ON CONFLICT (slug) DO NOTHING;

-- ─── Topics ──────────────────────────────────────────────────────────────
WITH c1 AS (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
     c2 AS (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
     c3 AS (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
     c4 AS (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1)
INSERT INTO topics (chapter_id, slug, name, "order") VALUES
-- Chapter 1: Regular Languages
((SELECT id FROM c1), 'dfa-basics', 'Deterministic Finite Automata (DFA)', 1),
((SELECT id FROM c1), 'nfa-to-dfa', 'NFA and DFA Equivalence', 2),
((SELECT id FROM c1), 'regular-expressions', 'Regular Expressions & Identities', 3),
((SELECT id FROM c1), 'dfa-minimization', 'DFA Minimization', 4),
((SELECT id FROM c1), 'mealy-moore', 'Mealy & Moore Machines', 5),
((SELECT id FROM c1), 'regular-pumping', 'Pumping Lemma for Regular Languages', 6),
((SELECT id FROM c1), 'regular-closure', 'Closure Properties of Regular Languages', 7),

-- Chapter 2: Context-Free Languages
((SELECT id FROM c2), 'cfg-ambiguity', 'CFG & Ambiguity', 1),
((SELECT id FROM c2), 'chomsky-normal', 'Chomsky & Greibach Normal Forms', 2),
((SELECT id FROM c2), 'pda-basics', 'Pushdown Automata (PDA)', 3),
((SELECT id FROM c2), 'cfl-closure', 'Closure Properties of CFL & DCFL', 4),
((SELECT id FROM c2), 'cfl-pumping', 'Pumping Lemma for CFLs', 5),

-- Chapter 3: Turing Machines
((SELECT id FROM c3), 'tm-basics', 'Turing Machines Architecture', 1),
((SELECT id FROM c3), 'recursive-languages', 'Recursive vs Recursive Enumerable', 2),
((SELECT id FROM c3), 'chomsky-hierarchy', 'Chomsky Hierarchy Overview', 3),

-- Chapter 4: Decidability
((SELECT id FROM c4), 'halting-problem', 'The Halting Problem', 1),
((SELECT id FROM c4), 'decidable-problems', 'Decidable Properties of Languages', 2),
((SELECT id FROM c4), 'rices-theorem-topic', 'Rice''s Theorem', 3),
((SELECT id FROM c4), 'reducibility', 'Reducibility Concepts', 4)
ON CONFLICT (chapter_id, slug) DO NOTHING;

-- Part 1 complete.
