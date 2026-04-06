-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — TOC PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2: Turing Machines & Decidability (11 Cards) + COMMIT
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 12
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='chomsky-hierarchy' LIMIT 1),
  'Outline the Chomsky Hierarchy from highest power to lowest.',
  '<p>Type-0 (Recursively Enumerable / Turing Machine) $\supset$ Type-1 (Context Sensitive / LBA) $\supset$ Type-2 (Context-Free / PDA) $\supset$ Type-3 (Regular / DFA).</p>',
  ARRAY['hierarchy']
),
-- Card 13
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tm-basics' LIMIT 1),
  'Does a multi-tape Turing Machine increase computational power?',
  '<p>No. Multi-tape, non-deterministic, and multi-dimensional Turing Machines merely increase speed or efficiency. They possess the exact same theoretical computational power as a standard single-tape Turing Machine.</p>',
  ARRAY['turing-machine']
),
-- Card 14
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='chomsky-hierarchy' LIMIT 1),
  'What characterizes a Linear Bounded Automaton (LBA)?',
  '<p>A Turing Machine whose tape head is strictly restricted to the precise segments spanning the original input string. It operates within Type-1 Context-Sensitive languages.</p>',
  ARRAY['hierarchy','turing-machine']
),
-- Card 15
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='recursive-languages' LIMIT 1),
  'Distinguish between Recursive and Recursively Enumerable Languages.',
  '<ul><li><strong>Recursive (Decidable):</strong> Turing Machine halts and accepts valid strings, halts and rejects invalid strings.</li><li><strong>Recursively Enumerable:</strong> Turing Machine halts and accepts valid strings, but may loop infinitely on invalid strings.</li></ul>',
  ARRAY['turing-machine']
),
-- Card 16
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='recursive-languages' LIMIT 1),
  'What does Post''s Theorem fundamentally state?',
  '<p>If a language $L$ is Recursively Enumerable, and its complement $\overline{L}$ is also Recursively Enumerable, then both $L$ and $\overline{L}$ must be inherently Recursive (Decidable).</p>',
  ARRAY['decidability']
),
-- Card 17
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='halting-problem' LIMIT 1),
  'Explain the Halting Problem.',
  '<p>Given a description of an arbitrary Turing Machine and any specified input, it is definitively Undecidable to deterministically predict whether the machine will eventually halt or run forever across all potential cases.</p>',
  ARRAY['undecidability']
),
-- Card 18
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='rices-theorem-topic' LIMIT 1),
  'Summarize Rice''s Theorem.',
  '<p>Any non-trivial semantic property regarding the language recognized by a Turing Machine is universally Undecidable.</p>',
  ARRAY['rices-theorem']
),
-- Card 19
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='decidable-problems' LIMIT 1),
  'List the operations that are Decidable for Context-Free Grammars.',
  '<p>Emptiness (Does it accept anything?), Finiteness (Is the language finite?), and Membership (Does it generate string W? via CYK algorithm).</p>',
  ARRAY['decidability','cfg']
),
-- Card 20
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='decidable-problems' LIMIT 1),
  'List operations strictly Undecidable for Context-Free Grammars.',
  '<p>Equivalence ($L(G_1) = L(G_2)$), Universality ($L(G) = \Sigma^*$), Ambiguity, and determining whether $L(G_1) \cap L(G_2)$ is empty.</p>',
  ARRAY['decidability','cfg']
),
-- Card 21
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='reducibility' LIMIT 1),
  'What is the fundamental logic of Reducibility?',
  '<p>If solving Problem X automatically gives you the power to solve Problem Y, we say Y reduces to X. If Y is a known Undecidable problem (like Halting), then X must also be Undecidable.</p>',
  ARRAY['decidability']
),
-- Card 22
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='reducibility' LIMIT 1),
  'What is the Post Correspondence Problem (PCP)?',
  '<p>Given dominos with strings on top and bottom, can you align them so the top string equals the bottom string? Modified PCP requires starting with a specific first domino. Both are known to be definitively Undecidable.</p>',
  ARRAY['undecidability']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing toc-seed.sql to verify correctness:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='toc'));
-- Expected: 19
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='toc');
-- Expected: 65
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='toc');
-- Expected: 22
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='toc')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug: toc
-- Schema version: v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- Chapters:     4 (Regular, CFG, Turing, Decidability)
-- Topics:       19
-- Questions:    65 total
--   MCQ:        45 (Q1–Q45)
--   NAT:        10 (Q46–Q55)
--   MSQ:        10 (Q56–Q65)
-- Flashcards:   22 concise mathematical theory cards
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF toc-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
