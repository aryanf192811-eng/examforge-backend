-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DM PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2 (11 Cards) + COMMIT block
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 12
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pigeonhole-principle' LIMIT 1),
  'What is the Pigeonhole Principle?',
  '<p>If $N$ items are placed into $M$ containers and $N > M$, then at least one container must contain more than one item.</p><p>Formula for minimum items in worst bucket: $\lceil N/M \rceil$.</p>',
  ARRAY['combinatorics']
),
-- Card 13
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='permutations-combinations' LIMIT 1),
  'What is the formula for Derangements $D_n$?',
  '<p>A permutation where no element is in its original position.</p><p>$D_n = n! (1 - 1/1! + 1/2! - 1/3! + ... + (-1)^n/n!)$</p>',
  ARRAY['combinatorics']
),
-- Card 14
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='inclusion-exclusion' LIMIT 1),
  'State the Principle of Inclusion-Exclusion for 3 sets.',
  '<p>$|A \cup B \cup C| = |A| + |B| + |C|$<br>$- |A \cap B| - |A \cap C| - |B \cap C|$<br>$+ |A \cap B \cap C|$</p>',
  ARRAY['combinatorics']
),
-- Card 15
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'What is the Handshaking Lemma?',
  '<p>In any undirected graph, the sum of all vertex degrees equals twice the number of edges: $\sum deg(V) = 2E$.</p><p>Corollary: The number of vertices with an odd degree must be even.</p>',
  ARRAY['graphs']
),
-- Card 16
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'Compare Eulerian and Hamiltonian graphs.',
  '<ul><li><strong>Eulerian Circuit:</strong> Visits every edge exactly once. Requires all vertices to have an even degree.</li><li><strong>Hamiltonian Cycle:</strong> Visits every vertex exactly once. More complex to prove (Dirac''s or Ore''s theorem).</li></ul>',
  ARRAY['graphs']
),
-- Card 17
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='planar-graphs' LIMIT 1),
  'State Euler''s Formula for connected Planar Graphs.',
  '<p><strong>$V - E + F = 2$</strong></p><p>Where $V$ is vertices, $E$ is edges, and $F$ is faces/regions (including the infinite outer region).</p>',
  ARRAY['graphs']
),
-- Card 18
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='trees-properties' LIMIT 1),
  'What are the core properties defining a Tree?',
  '<ul><li>An undirected, connected, acyclic graph.</li><li>Has $N$ vertices and exactly $N-1$ edges.</li><li>Adding any edge creates exactly one cycle.</li><li>Exactly one path exists between any two vertices.</li></ul>',
  ARRAY['trees','graphs']
),
-- Card 19
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-coloring' LIMIT 1),
  'What is the Chromatic Number of a Bipartite Graphic?',
  '<p><strong>Exactly 2.</strong></p><p>A graph is bipartite if and only if it does not contain any odd-length cycles. The vertices can be partitioned into two independent sets with no edges inside the sets.</p>',
  ARRAY['graphs','matching']
),
-- Card 20
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'How many edges are in $K_N$ and $K_{M,N}$?',
  '<ul><li><strong>Complete Graph $K_N$:</strong> $\frac{N(N-1)}{2}$ edges.</li><li><strong>Complete Bipartite Graph $K_{M,N}$:</strong> $M \times N$ edges.</li></ul>',
  ARRAY['graphs']
),
-- Card 21
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='planar-graphs' LIMIT 1),
  'What is Kuratowski''s Theorem?',
  '<p>A graph is planar if and only if it does not contain any subgraph that is homeomorphic (edge subdivision) to $K_5$ (complete graph on 5 vertices) or $K_{3,3}$ (complete bipartite graph on 3+3 vertices).</p>',
  ARRAY['graphs']
),
-- Card 22
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='matching' LIMIT 1),
  'What is the relationship between Maximum Independent Set ($\alpha$) and Minimum Vertex Cover ($\beta$)?',
  '<p><strong>Gallai''s Theorem:</strong> For a graph without isolated vertices, the sum of the independence number and the vertex cover number equals the total number of vertices.</p><p>$\alpha + \beta = |V|$</p>',
  ARRAY['matching','graphs']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing dm-seed.sql to verify correctness:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='dm'));
-- Expected: 20
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dm');
-- Expected: 65
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dm');
-- Expected: 22
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dm')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug: dm
-- Schema version: v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- Chapters:     4 (Logic, Sets, Combinatorics, Graphs)
-- Topics:       20
-- Questions:    65 total
--   MCQ:        45 (Q1–Q45)
--   NAT:        10 (Q46–Q55)
--   MSQ:        10 (Q56–Q65)
-- Flashcards:   22 concise mathematical theory cards
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF dm-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
