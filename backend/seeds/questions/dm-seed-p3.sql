-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DM PYQ SEED v2  (Part 3 / 8)
-- MCQ Questions Q15–Q28 (Combinatorics & Graph Theory)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — Pigeonhole Principle (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pigeonhole-principle' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'How many uniformly identical socks must be drawn from a drawer containing 5 colors of socks to guarantee at least a pair of the same color?',
  '5',
  '6',
  '10',
  '11',
  'B',
  '<p><strong>✓ Answer: B — 6.</strong></p><p><strong>Rationale:</strong> According to the Pigeonhole Principle, if $n$ items are placed into $m$ containers and $n > m$, at least one container must contain more than one item. Here, containers are the 5 colors. To guarantee two of the same color, we need $n = 5 + 1 = 6$ socks.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q16 — Number of Derangements (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='permutations-combinations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'What is the number of derangements of 4 items (permutations where no element appears in its original position)?',
  '9',
  '12',
  '24',
  '15',
  'A',
  '<p><strong>✓ Answer: A — 9.</strong></p><p><strong>Step-by-step:</strong> The formula for derangements of $n$ elements is $D_n = n! (1 - 1/1! + 1/2! - 1/3! + ... + (-1)^n/n!)$.<br>For $n = 4$:<br>$D_4 = 24 \times (1 - 1 + 1/2 - 1/6 + 1/24) = 24 \times (12/24 - 4/24 + 1/24) = 24 \times (9/24) = 9$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q17 — Generating Functions (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='generating-functions' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following describes the generating function for the sequence $1, 1, 1, 1, ...$?',
  '$1 / (1-x)$',
  '$1 / (1+x)$',
  '$1 / (1-x)^2$',
  '$e^x$',
  'A',
  '<p><strong>✓ Answer: A — $1 / (1-x)$.</strong></p><p><strong>Rationale:</strong> The geometric series expansion is $1 + x + x^2 + x^3 + ... = \frac{1}{1 - x}$ for $|x| < 1$. The coefficients of the $x^k$ terms represent the sequence, which is $1, 1, 1, ...$</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q18 — Recurrence Relation Solution (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='recurrence-relations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The Master Theorem resolves recurrence relations of the form $T(n) = aT(n/b) + \theta(n^k)$. What is the time complexity if $a > b^k$?',
  '$\theta(n^k \log n)$',
  '$\theta(n^{\log_b a})$',
  '$\theta(n^k)$',
  '$\theta(a^n)$',
  'B',
  '<p><strong>✓ Answer: B — $\theta(n^{\log_b a})$.</strong></p><p><strong>Rationale:</strong> By the Master Theorem, if $a > b^k$, the work done at the leaves dominates the total tree depth work, resulting in a complexity described by the number of leaves: $\theta(n^{\log_b a})$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recurrence','combinatorics');

-- Q19 — Graph Basics: Handshaking Lemma (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'According to the Handshaking Lemma, the sum of the degrees of all vertices in a simple undirected graph is always equal to:',
  'The number of edges',
  'Twice the number of edges',
  'The number of vertices',
  'Twice the number of vertices',
  'B',
  '<p><strong>✓ Answer: B — Twice the number of edges.</strong></p><p><strong>Rationale:</strong> Each edge connects exactly two distinct vertices. When summing the degrees of all vertices, every single edge gets counted exactly twice (once for each of its endpoints). Thus, $\sum deg(V) = 2E$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q20 — Graph Coloring & Planarity (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-coloring' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What is the maximum chromatic number for any simple connected planar graph?',
  '3',
  '4',
  '5',
  '6',
  'B',
  '<p><strong>✓ Answer: B — 4.</strong></p><p><strong>Rationale:</strong> The famous Four Color Theorem states that the vertices of every planar graph can be colored using at most 4 different colors such that no two adjacent vertices share the exact same color.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Q21 — Planar Graphs: Euler's Formula (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='planar-graphs' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Euler''s formula defines the relationship between vertices ($V$), edges ($E$), and regions/faces ($f$) for connected planar graphs. What is the formula?',
  '$v - e + f = 2$',
  '$v + e - f = 2$',
  '$v - e - f = 2$',
  '$e - v + f = 2$',
  'A',
  '<p><strong>✓ Answer: A — $v - e + f = 2$.</strong></p><p><strong>Rationale:</strong> This core formula applies strictly to connected planar graphs. If disconnected with $k$ components, the formula adjusts to $v - e + f = 1 + k$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q22 — Complete Graph Edges (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'How many edges are present in a complete graph $K_n$?',
  '$n$',
  '$n(n-1) / 2$',
  '$n^2$',
  '$n(n+1) / 2$',
  'B',
  '<p><strong>✓ Answer: B — $n(n-1)/2$.</strong></p><p><strong>Step-by-step:</strong> In a Complete Graph $K_n$, every vertex is connected to every other vertex. We use combinations: picking 2 vertices from $n$ available vertices without concerning order. This gives $\binom{n}{2} = n(n-1)/2$ edges.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q23 — Trees vs Cycles (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='trees-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following statements about trees is false?',
  'Every tree is a connected bipartite graph',
  'Adding any new edge to a tree creates exactly one cycle',
  'A tree with $n$ vertices has exactly $n-1$ edges',
  'Every tree must contain at least one vertex of degree 3',
  'D',
  '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> Option D is false. A path graph is a tree (e.g., $A-B-C$), but the maximum degree in a path graph is 2. Therefore, a tree does not require any vertex of degree 3.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('trees','graphs');

-- Q24 — Euler vs Hamilton Paths (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'An Euler circuit exists in a connected, undirected graph if and only if:',
  'Every vertex has an even degree',
  'Every vertex has an odd degree',
  'The graph contains no cycles',
  'The graph is bipartite',
  'A',
  '<p><strong>✓ Answer: A — Every vertex has an even degree.</strong></p><p><strong>Rationale:</strong> An Euler circuit must traverse every single edge exactly once and return to the starting vertex. For every time a path enters a vertex via an edge, it must leave via an unused edge, requiring every vertex to naturally have an even degree pairing.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q25 — Inclusion-Exclusion (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='inclusion-exclusion' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'How many integers between 1 and 100 are divisible by either 2 or 5?',
  '50',
  '60',
  '70',
  '80',
  'B',
  '<p><strong>✓ Answer: B — 60.</strong></p><p><strong>Step-by-step:</strong> Let $A$ be multiples of 2, $B$ be multiples of 5.<br>$|A| = \lfloor 100/2 \rfloor = 50$<br>$|B| = \lfloor 100/5 \rfloor = 20$<br>$|A \cap B|$ (multiples of 10) $= \lfloor 100/10 \rfloor = 10$<br>$|A \cup B| = |A| + |B| - |A \cap B| = 50 + 20 - 10 = 60$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q26 — Bipartite Graph Chromatic Number (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-coloring' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the chromatic number of any non-empty bipartite graph?',
  '1',
  '2',
  '3',
  'Depends on vertices',
  'B',
  '<p><strong>✓ Answer: B — 2.</strong></p><p><strong>Rationale:</strong> A bipartite graph partitions vertices into two disjoint sets where edges only exist between the sets, not within them. You can color all nodes in the first set Color A, and all nodes in the second set Color B. Thus, it requires exactly 2 colors.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Q27 — Chromatic Number property (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-coloring' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'If the maximum degree of any vertex in a connected undirected graph is $\Delta$, what is the upper bound for the chromatic number $\chi(G)$ given by Brooks Theorem (assuming G is neither complete nor an odd cycle)?',
  '$\Delta$',
  '$\Delta + 1$',
  '$\Delta - 1$',
  'No upper limit',
  'A',
  '<p><strong>✓ Answer: A — $\Delta$.</strong></p><p><strong>Rationale:</strong> A greedy coloring algorithm usually requires $\Delta + 1$ colors. However, Brooks Theorem states that if the graph is neither a complete graph nor an odd cycle, the chromatic number $\chi(G)$ is bounded by $\Delta$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Q28 — Independent Sets (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='matching' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a graph $G$ with $n$ vertices, if the size of the maximum independent set is $\alpha$, what is the size of the minimum vertex cover $\beta$?',
  '$\alpha$',
  '$n - \alpha$',
  '$n / \alpha$',
  'Independent of $\alpha$',
  'B',
  '<p><strong>✓ Answer: B — $n - \alpha$.</strong></p><p><strong>Rationale:</strong> Gallai''s Theorem establishes that for any graph without isolated vertices, the sum of the independence number $\alpha$ and the vertex cover number $\beta$ equals the total number of vertices $n$. Hence, $\alpha + \beta = n$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Part 3 complete.
