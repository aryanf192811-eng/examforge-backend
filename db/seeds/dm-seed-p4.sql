-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DM PYQ SEED v2  (Part 4 / 8)
-- MCQ Questions Q29–Q45 (Logic, Combinatorics, Advanced Graphs)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q29 — Propositional Logic Converse (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='propositional-logic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the converse of the implication "If it rains, then the ground is wet"?',
  'If it does not rain, then the ground is not wet',
  'If the ground is not wet, then it does not rain',
  'If the ground is wet, then it rains',
  'It rains and the ground is not wet',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> For an implication $p \rightarrow q$:<br>- Converse is $q \rightarrow p$.<br>- Inverse is $\neg p \rightarrow \neg q$.<br>- Contrapositive is $\neg q \rightarrow \neg p$.<br>Option C reverses the condition to $q \rightarrow p$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic');

-- Q30 — Lattices (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='lattices-boolean' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A POSET is considered a Lattice if and only if:',
  'Every pair of elements has a Greatest Lower Bound (GLB)',
  'Every pair of elements has a Least Upper Bound (LUB)',
  'Every pair of elements has both a GLB and LUB',
  'It has a unique maximal and minimal element',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The defining property of a Lattice is that any two elements within the poset must have both a unique supremum (LUB, join) and a unique infimum (GLB, meet).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lattices');

-- Q31 — Combinations with Repetition (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='permutations-combinations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'How many non-negative integer solutions exist for the equation $x_1 + x_2 + x_3 = 10$?',
  '66',
  '45',
  '55',
  '120',
  'A',
  '<p><strong>✓ Answer: A — 66.</strong></p><p><strong>Step-by-step:</strong> This is solved using the "Stars and Bars" method for distributing $n$ identical items into $r$ distinct bins. The formula is $\binom{n + r - 1}{r - 1}$.<br>Here $n=10$ and $r=3$.<br>Result: $\binom{10 + 3 - 1}{3 - 1} = \binom{12}{2}$.<br>$\frac{12 \times 11}{2} = 66$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q32 — Graph Connectivity (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In an undirected graph, a connected component is:',
  'A subgraph containing only vertices of even degree',
  'A maximal connected subgraph',
  'A subgraph that forms a cycle',
  'A path between the two furthest vertices',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> By definition, a connected component is a maximal set of vertices connected to each other by paths. Adding any extra vertex to this component would break the connectivity.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q33 — Eulerian Graph definition (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which condition guarantees an undirected graph $G$ has an Eulerian path but NOT an Eulerian circuit?',
  'All vertices have even degree',
  'Exactly two vertices have odd degree',
  'All vertices have odd degree',
  'Exactly one vertex has an odd degree',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong><br>- All even degrees $\implies$ Eulerian Circuit.<br>- Exactly two odd degrees $\implies$ Eulerian Path (starts at one odd vertex, ends at the other).<br>- Graphs cannot have exactly one odd-degree vertex due to the Handshaking Lemma.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q34 — Cartesian Product of Sets (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics,'set-theory') LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'If Set A has 4 elements and Set B has 5 elements, how many elements are in the power set of Cartesian product $A \times B$?',
  '$2^9$',
  '$20$',
  '$9$',
  '$2^{20}$',
  'D',
  '<p><strong>✓ Answer: D — $2^{20}$.</strong></p><p><strong>Step-by-step:</strong><br>- Number of elements in $A \times B$ is $|A| \times |B| = 4 \times 5 = 20$.<br>- The power set of a set with $n$ elements contains $2^n$ elements.<br>- Therefore, the power set contains $2^{20}$ elements.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sets');

-- Q35 — Complete Bipartite Edges (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'How many edges are present in a Complete Bipartite Graph $K_{m,n}$?',
  '$m + n$',
  '$m \times n$',
  '$m^2 + n^2$',
  '$(m+n)(m+n-1)/2$',
  'B',
  '<p><strong>✓ Answer: B — $m \times n$.</strong></p><p><strong>Rationale:</strong> In $K_{m,n}$, the vertex set is partitioned into two sets of sizes $m$ and $n$. Since it is complete, every vertex in the first set is connected to every vertex in the second set. The total edges is the product: $m \times n$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q36 — Walk, Path, Trail (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In graph theory, a walk in which no edge is repeated is specifically called a:',
  'Path',
  'Cycle',
  'Trail',
  'Tour',
  'C',
  '<p><strong>✓ Answer: C — Trail.</strong></p><p><strong>Rationale:</strong><br>- <strong>Walk:</strong> Anything goes.<br>- <strong>Trail:</strong> No repeated edges (vertices can be repeated).<br>- <strong>Path:</strong> No repeated vertices (which enforces no repeated edges).<br>- <strong>Cycle:</strong> A path that starts and ends at the same vertex.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q37 — Planar Graph Regions (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='planar-graphs' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'For a planar graph with 6 vertices and 9 edges, how many faces (regions) are created in its planar embedding?',
  '4',
  '5',
  '6',
  '7',
  'B',
  '<p><strong>✓ Answer: B — 5.</strong></p><p><strong>Step-by-step:</strong> Use Euler''s Formula $V - E + F = 2$.<br>$6 - 9 + F = 2$<br>$-3 + F = 2$<br>$F = 5$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q38 — Hamilton Cycle bound (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Dirac''s Theorem guarantees a Hamilton Cycle in a simple graph with $n$ vertices ($n \ge 3$) if every vertex has a degree of at least:',
  '$n-1$',
  '$n/2$',
  '$\sqrt{n}$',
  '2',
  'B',
  '<p><strong>✓ Answer: B — $n/2$.</strong></p><p><strong>Rationale:</strong> Dirac''s Theorem states that if $n \ge 3$ and $deg(v) \ge n/2$ for every vertex $v$, then the graph has a Hamilton cycle.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q39 — Group Theory Identiy (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='group-theory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In the mathematical group consisting of Integers under Addition ($\mathbb{Z}, +$), what is the identity element?',
  '0',
  '1',
  '-1',
  'It does not exist',
  'A',
  '<p><strong>✓ Answer: A — 0.</strong></p><p><strong>Rationale:</strong> The identity element $e$ in a group is defined such that $a + e = e + a = a$. Under addition, adding 0 leaves any integer unchanged.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('groups');

-- Q40 — Transitive Closure (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relations-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Warshall''s Algorithm is typically used to efficiently compute which property of a relation graph?',
  'Reflexive Closure',
  'Symmetric Closure',
  'Transitive Closure',
  'Equivalence Closure',
  'C',
  '<p><strong>✓ Answer: C — Transitive Closure.</strong></p><p><strong>Rationale:</strong> Warshall''s Algorithm $O(n^3)$ computes the boolean reachability matrix of a graph, which is mathematically identical to finding the transitive closure of a relation.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations','graphs');

-- Q41 — De Morgan's Law for sets (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='set-theory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'According to De Morgan''s Laws for Sets, the complement of the union $(A \cup B)^c$ is equal to:',
  '$A^c \cup B^c$',
  '$A^c \cap B^c$',
  '$A \cap B$',
  '$A \cup B$',
  'B',
  '<p><strong>✓ Answer: B — $A^c \cap B^c$.</strong></p><p><strong>Rationale:</strong> De Morgan''s laws distribute the complement while flipping the operator: $(A \cup B)^c = A^c \cap B^c$ and $(A \cap B)^c = A^c \cup B^c$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sets');

-- Q42 — Composition of Functions (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='functions-types' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Let $f(x) = 2x + 1$ and $g(x) = x^2$. What is the composition $(f \circ g)(x)$?',
  '$4x^2 + 4x + 1$',
  '$2x^2 + 1$',
  '$2x^3 + x^2$',
  '$x^2 + 2x + 1$',
  'B',
  '<p><strong>✓ Answer: B — $2x^2 + 1$.</strong></p><p><strong>Step-by-step:</strong> Composition means passing the output of $g$ into $f$.<br>$(f \circ g)(x) = f(g(x)) = f(x^2)$.<br>Substitute $x^2$ into $f$: $2(x^2) + 1 = 2x^2 + 1$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions');

-- Q43 — First Order Logic Valid Inference (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='first-order-logic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Consider the statements: "All dogs bark", "Fido does not bark". What is the valid conclusion?',
  'Fido is a dog',
  'Some dogs do not bark',
  'Fido is not a dog',
  'All options are invalid',
  'C',
  '<p><strong>✓ Answer: C — Fido is not a dog.</strong></p><p><strong>Step-by-step:</strong> This is a Modus Tollens argument.<br>Premise 1: $\forall x (D(x) \rightarrow B(x))$ (If $x$ is a dog, it barks).<br>Premise 2: $\neg B(F)$ (Fido does not bark).<br>Substituting Fido into P1: $D(F) \rightarrow B(F)$.<br>Applying Modus Tollens with $\neg B(F)$ gives $\neg D(F)$ : Fido is not a dog.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','first-order');

-- Q44 — Equivalence Class Size (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relations-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'If a relation $R$ partitions a set $S$ into distinct equivalence classes, the union of all these classes is:',
  'The empty set $\emptyset$',
  'Set $S$',
  'A proper subset of $S$',
  'The Cartesian product $S \times S$',
  'B',
  '<p><strong>✓ Answer: B — Set $S$.</strong></p><p><strong>Rationale:</strong> The fundamental theorem of equivalence relations dictates that any equivalence relation on a set $S$ partitions $S$ into disjoint subsets (classes). By partition definition, their union covers the original set $S$ entirely.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations','sets');

-- Q45 — Complete Graph Coloring (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-coloring' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the chromatic number of the complete graph $K_n$?',
  '$2$',
  '$n$',
  '$n-1$',
  '$n/2$',
  'B',
  '<p><strong>✓ Answer: B — $n$.</strong></p><p><strong>Rationale:</strong> In a complete graph, every vertex is connected to every other vertex. Consequently, no two vertices can share the same color. Thus, $n$ distinct vertices require $n$ different colors.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Part 4 complete.
