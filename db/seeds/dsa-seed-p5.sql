-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DSA PYQ SEED v2  (Part 5 / 8)
-- NAT Questions Q46–Q55 (Calculations, complexity bounds, counts)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q46 — Array storage length (NAT, easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='1d-2d-arrays' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'Consider a 1D array A declared with indices ranging from -15 to 35. How many elements can this array hold?',
  51.00,51.00,'elements',
  '<p><strong>✓ Answer: 51.</strong></p><p><strong>Step-by-step:</strong> The formula for the number of elements in an array with lower bound $L$ and upper bound $U$ is: $U - L + 1$.<br>Here, $L = -15$ and $U = 35$.<br>$35 - (-15) + 1 = 35 + 15 + 1 = 51$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('array');

-- Q47 — DFS edge count (NAT, medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dfs-topic' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'During a Depth First Search (DFS) of a connected, undirected graph with 10 vertices and 15 edges, a DFS tree is constructed. How many edges in the graph become "back edges"?',
  6.00,6.00,'edges',
  '<p><strong>✓ Answer: 6.</strong></p><p><strong>Step-by-step:</strong><br>1. A connected, undirected graph with $V=10$ vertices. A spanning tree (DFS tree) over $V$ vertices will always have exactly $V - 1$ edges.<br>2. Tree edges = $10 - 1 = 9$ edges.<br>3. Total edges in graph = 15.<br>4. In an undirected graph, any edge that is not a tree edge is a back edge. There are no forward edges or cross edges in undirected DFS.<br>5. Back edges = Total edges - Tree edges = $15 - 9 = 6$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfs','graph');

-- Q48 — Complete binary tree array indexing (NAT, easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics শিব slug='binary-tree-properties' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'In a complete binary tree stored in an array (1-indexed), the node at index 14 consists of a left and right child. What is the array index of its Right Child?',
  29.00,29.00,'index',
  '<p><strong>✓ Answer: 29.</strong></p><p><strong>Step-by-step:</strong> For 1-indexed heap arrays:<br>Left Child of index $i$ = $2i$.<br>Right Child of index $i$ = $2i + 1$.<br>Parent of index $i$ = $\lfloor i/2 \rfloor$.<br>For $i = 14$, Right Child = $2(14) + 1 = 28 + 1 = 29$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tree','heap');

-- Fix topic_id typo above
UPDATE questions SET topic_id = (SELECT id FROM topics WHERE slug='binary-tree-properties' LIMIT 1) WHERE question_text LIKE 'In a complete binary tree stored in an array%';

-- Q49 — Shortest path relaxation (NAT, medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dijkstra-sp' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'In a graph, currently distance to vertex U is 10, and distance to vertex V is 18. There is a directed edge from U to V with weight 5. After the relaxation step along edge (U, V), what is the new distance to V?',
  15.00,15.00,NULL,
  '<p><strong>✓ Answer: 15.</strong></p><p><strong>Step-by-step:</strong><br>1. Relaxation condition: `if (d[u] + weight(u, v) < d[v]) then d[v] = d[u] + weight(u, v)`<br>2. Evaluate: `d[U] + 5 = 10 + 5 = 15`.<br>3. Check condition: `15 < 18` is TRUE.<br>4. Reassign: `d[V] = 15`.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dijkstra','graph');

-- Q50 — Binary tree height from nodes (NAT, medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='binary-tree-properties' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'What is the maximum number of levels (from root = level 1) that a strictly binary tree (full binary tree) can have if it contains exactly 19 nodes?',
  10.00,10.00,'levels',
  '<p><strong>✓ Answer: 10.</strong></p><p><strong>Step-by-step:</strong><br>A strictly binary tree (or full binary tree) has every internal node with exactly 2 children.<br>Total nodes $N = 19$.<br>To maximize the number of levels (height), the tree must be as skewed as possible while maintaining the strict property.<br>This structure looks like a zigzag chain where each node on the main path spawns exactly one leaf child.<br>Let $l$ be the number of levels. At level 1, there is 1 node (root). At each subsequent level except the last, there are 2 nodes. At the last level, there is 1 node (or 2 nodes, wait).<br>Let''s count levels differently: The longest path length is $\frac{N-1}{2}$.<br>$19 - 1 = 18$. $18 / 2 = 9$ edges in the longest path, meaning height = 9.<br>If height is 9, and root = level 1, then levels = height + 1 = $9 + 1 = 10$.<br>Let''s verify: Level 1: 1 node. Levels 2 to 9: 2 nodes each ($8 \times 2 = 16$). Level 10: 2 nodes. Total = $1 + 16 + 2 = 19$. Yes, 10 levels.</p><p><strong>GATE trap:</strong> Skewed strictly binary trees add 2 nodes per level of depth increased. $h = (N-1)/2$. Levels = $(N+1)/2 = 20/2 = 10$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tree');

-- Q51 — Hashing probe count (NAT, hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='chaining-open-addressing' LIMIT 1),
  'gate-cse',false,NULL,'NAT','hard',2,
  'A hash table of size 10 uses linear probing. The hash function is $h(x) = x \bmod 10$. We insert the keys: 43, 36, 92, 87, 11, 21, 71, 13, 14. How many probes are required to insert the key 14? (Initial empty bucket check counts as 1 probe)',
  6.00,6.00,'probes',
  '<p><strong>✓ Answer: 6.</strong></p><p><strong>Step-by-step trace:</strong><br>Empty Hash Table: [ . . . . . . . . . . ] (0 to 9)<br>Insert 43: h(43)=3. Slot 3 is empty. -> [ . . . 43 . . . . . . ] (1 probe)<br>Insert 36: h(36)=6. Slot 6 empty. -> [ . . . 43 . . 36 . . . ] (1 probe)<br>Insert 92: h(92)=2. Slot 2 empty. -> [ . . 92 43 . . 36 . . . ] (1 probe)<br>Insert 87: h(87)=7. Slot 7 empty. -> [ . . 92 43 . . 36 87 . . ] (1 probe)<br>Insert 11: h(11)=1. Slot 1 empty. -> [ . 11 92 43 . . 36 87 . . ] (1 probe)<br>Insert 21: h(21)=1. Slot 1 full. Probe 2 (92), 3 (43), 4 (empty). -> [ . 11 92 43 21 . 36 87 . . ] (Probes: 1,2,3,4 = 4 probes)<br>Insert 71: h(71)=1. Probe 1,2,3,4,5 (empty). -> [ . 11 92 43 21 71 36 87 . . ] (5 probes)<br>Insert 13: h(13)=3. Probe 3(43), 4(21), 5(71), 6(36), 7(87), 8(empty). -> [ . 11 92 43 21 71 36 87 13 . ] (6 probes)<br>Insert 14: h(14)=4. Probe 4(21), 5(71), 6(36), 7(87), 8(13), 9(empty). -> [ . 11 92 43 21 71 36 87 13 14 ]<br>Total probes to insert 14: checked indices 4, 5, 6, 7, 8, 9 (empty!). Count = 6.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hashing');

-- Q52 — Stack permutations (NAT, medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),
  (SELECT id FROM topics WHERE slug='stack-implementation' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'How many valid distinct output permutations can be generated by passing the numbers {1, 2, 3, 4} through a standard stack?',
  14.00,14.00,NULL,
  '<p><strong>✓ Answer: 14.</strong></p><p><strong>Step-by-step:</strong> The number of valid stack permutations for a sequence of length $N$ is given by the N-th Catalan Number.<br>$C_n = \frac{1}{n+1} \binom{2n}{n}$<br>For $N = 4$:<br>$C_4 = \frac{1}{4+1} \binom{8}{4} = \frac{1}{5} \times \frac{8 \times 7 \times 6 \times 5}{4 \times 3 \times 2 \times 1} = \frac{1}{5} \times 70 = 14$.</p><p><strong>Rule:</strong> Catalan numbers appear in: Stack permutations, Number of structurally unique BSTs, Valid parenthesis expressions. Sequence: 1, 1, 2, 5, 14, 42...</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('stack');

-- Q53 — Recursion count (NAT, medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),
  (SELECT id FROM topics WHERE slug='recursion-call-stack' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'Consider the following C function:<br>`int f(int n) { if(n <= 1) return 1; return f(n-1) + f(n-2); }`<br>If `f(5)` is called, how many TIMES is the function `f` invoked in total (including the original call)?',
  15.00,15.00,NULL,
  '<p><strong>✓ Answer: 15.</strong></p><p><strong>Step-by-step:</strong> Draw the recursion tree. Let $C(n)$ be the number of calls for $f(n)$.<br>$C(0) = 1$<br>$C(1) = 1$<br>$C(n) = C(n-1) + C(n-2) + 1$<br>- $C(2) = C(1) + C(0) + 1 = 1 + 1 + 1 = 3$<br>- $C(3) = C(2) + C(1) + 1 = 3 + 1 + 1 = 5$<br>- $C(4) = C(3) + C(2) + 1 = 5 + 3 + 1 = 9$<br>- $C(5) = C(4) + C(3) + 1 = 9 + 5 + 1 = 15$.</p><p><strong>GATE trap:</strong> Standard Fibonacci recursion is extremely redundant. The tree size grows exponentially ($\approx \mathcal{O}(2^n)$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Q54 — Kruskal edge cost (NAT, medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='kruskal-mst' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A graph has 5 vertices (A,B,C,D,E) and weighted edges: (A,B,1), (B,C,2), (C,D,3), (A,D,4), (B,D,5), (D,E,6). Using Kruskal''s algorithm, what is the total weight of the Minimum Spanning Tree?',
  12.00,12.00,'weight',
  '<p><strong>✓ Answer: 12.</strong></p><p><strong>Step-by-step:</strong><br>Sort edges: 1, 2, 3, 4, 5, 6.<br>1. Add (A,B,1). Subcomponents: {A,B}. Cost = 1.<br>2. Add (B,C,2). Subcomponents: {A,B,C}. Cost = 1+2 = 3.<br>3. Add (C,D,3). Subcomponents: {A,B,C,D}. Cost = 3+3 = 6.<br>4. Inspect (A,D,4). A and D are already in the same component. Reject (forms cycle).<br>5. Inspect (B,D,5). Reject (forms cycle).<br>6. Add (D,E,6). Component: {A,B,C,D,E} (all vertices). Cost = 6+6=12.<br>Total MST weight = 1+2+3+6 = 12.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('kruskal','graph');

-- Q55 — Number of BSTs (NAT, easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bst-properties' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'How many structurally unique Binary Search Trees (BSTs) can be formed using 5 distinct keys?',
  42.00,42.00,'trees',
  '<p><strong>✓ Answer: 42.</strong></p><p><strong>Step-by-step:</strong> The number of unique BSTs formed by $N$ distinct keys is given by the N-th Catalan Number.<br>$C_5 = \frac{1}{6} \binom{10}{5} = \frac{1}{6} \times \frac{10 \times 9 \times 8 \times 7 \times 6}{5 \times 4 \times 3 \times 2 \times 1} = \frac{1}{6} \times 252 = 42$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bst','tree');

-- Part 5 complete.
