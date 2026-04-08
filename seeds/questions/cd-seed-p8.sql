-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CD PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2: SDT, Optimization & Runtime (11 Cards) + COMMIT
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 12
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1),
  (SELECT id FROM topics WHERE slug='attributes' LIMIT 1),
  'Distinguish between Synthesized and Inherited Attributes.',
  '<ul><li><strong>Synthesized:</strong> Computed from children to parent (flows bottom-up).</li><li><strong>Inherited:</strong> Received from parent or left siblings (flows top-down and left-to-right).</li></ul>',
  ARRAY['sdt']
),
-- Card 13
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1),
  (SELECT id FROM topics WHERE slug='att-types' LIMIT 1),
  'What is an S-Attributed Grammar?',
  '<p>A Syntax-Directed Translation definition that uses only Synthesized attributes. It can be easily evaluated bottom-up alongside an LR parser.</p>',
  ARRAY['sdt']
),
-- Card 14
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1),
  (SELECT id FROM topics WHERE slug='att-types' LIMIT 1),
  'What is an L-Attributed Grammar?',
  '<p>A grammar where inherited attributes depend only on the parent and left siblings. It evaluates attributes left-to-right, making it perfect for top-down parsing.</p>',
  ARRAY['sdt']
),
-- Card 15
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ast' LIMIT 1),
  'Compare Parse Tree vs Abstract Syntax Tree (AST).',
  '<p>A Parse Tree contains all grammatical structures, non-terminals, and punctuation. An AST drops the structural artifacts and leaves only the meaningful operators (internal nodes) and operands (leaves).</p>',
  ARRAY['ast','parsing']
),
-- Card 16
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dag-topic' LIMIT 1),
  'What is the purpose of a Directed Acyclic Graph (DAG) in compilation?',
  '<p>A DAG represents expressions where common subexpressions are merged into shared nodes. It is used heavily in local optimization to prevent redundant calculations.</p>',
  ARRAY['optimization','dag']
),
-- Card 17
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='basic-blocks' LIMIT 1),
  'What defines a Basic Block?',
  '<p>A sequence of continuous instructions with exactly one entry point and one exit point. There are no branches going into the middle, and no branches going out except at the very end.</p>',
  ARRAY['optimization']
),
-- Card 18
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1),
  'What is Loop Invariant Code Motion?',
  '<p>An optimization technique that identifies computations inside a loop that produce the exact same value on every iteration, and moves them outside to the loop''s pre-header.</p>',
  ARRAY['optimization']
),
-- Card 19
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1),
  'Explain Strength Reduction.',
  '<p>Replacing an expensive hardware operation with a cheaper equivalent. For example, replacing $A * 2$ with $A + A$ or $A \ll 1$. Often applied to loop induction variables.</p>',
  ARRAY['optimization']
),
-- Card 20
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='peephole' LIMIT 1),
  'What is Peephole Optimization?',
  '<p>A localized optimization pass operating over a small sliding window (peephole) of target machine instructions, used to eliminate redundant loads/stores and compact branch jumps.</p>',
  ARRAY['optimization']
),
-- Card 21
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='runtime' LIMIT 1),
  'What resides inside an Activation Record (Stack Frame)?',
  '<p>It stores function call state: function parameters, local variables, return memory address, saved machine registers, and access links to enclosing scopes.</p>',
  ARRAY['runtime-env']
),
-- Card 22
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='data-flow' LIMIT 1),
  'Why is Live Variable Analysis important?',
  '<p>By computing which variables will be read in the future without being overwritten (Liveness), the compiler can efficiently allocate physical CPU registers via Graph Coloring techniques.</p>',
  ARRAY['liveness','optimization']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing cd-seed.sql to verify correctness:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='cd'));
-- Expected: 19
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='cd');
-- Expected: 65
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='cd');
-- Expected: 22
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='cd')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug: cd
-- Schema version: v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- Chapters:     4 
-- Topics:       19
-- Questions:    65 total
--   MCQ:        45 (Q1–Q45)
--   NAT:        10 (Q46–Q55)
--   MSQ:        10 (Q56–Q65)
-- Flashcards:   22 concise mathematical theory cards
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF cd-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
