-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — ALGORITHMS PYQ SEED v2 (Part 3 / 8)
-- MCQ Questions Q15–Q28 (Greedy Algorithms & Graphs)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — Greedy Choice Property (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='greedy-basics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'A rigorous algorithmic problem can exclusively be solved and optimally using a Greedy approach if it exhibits which two fundamental mathematical structures?',
 'Overlapping subproblems and an exponential search space',
 'Greedy choice property and optimal substructure',
 'Optimal substructure and memoization capabilities',
 'Recursive depth and tail-call optimization',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <em>Optimal substructure</em> dictates that an optimal global solution contains optimal solutions to subproblems. The <em>Greedy choice property</em> mandates that accumulating locally optimal choices successively without rethinking leads directly and to the globally optimal solution.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('greedy');

-- Q16 — Fractional Knapsack (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='fractional-knapsack' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Why can the Fractional Knapsack problem be solved optimally in polynomial time using a Greedy algorithm, whereas the 0/1 Knapsack cannot?',
 'Because Fractional Knapsack allows breaking items, ensuring the exact capacity is utilized by filling any remaining space with the highest value-to-weight ratio fragment available',
 'Because 0/1 Knapsack has a practically infinite number of items to check',
 'Because the mathematical bounds of Fractional Knapsack evaluate using Kruskal algorithm',
 'Because 0/1 Knapsack requires explicit negative weights which greedy avoids',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The greedy strategy for knapsack is fundamentally sorting by value-to-weight ratio. The fractional allowance guarantees that no unused capacity is wasted; you can shear off a slice of the absolute best item. 0/1 Knapsack bans fractions, so rigidly choosing the highest ratio might inadvertently leave unreachable holes in capacity, missing better denser .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('greedy','knapsack');

-- Q17 — Huffman Coding prefix (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='huffman-coding' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'In the context of standard Huffman Coding applied to data compression, what exactly constitutes a "Prefix Code"?',
 'All codewords enforce uniform ',
 'No physically generated codeword forms the initial prefix substring of any other generated codeword',
 'The mathematically most frequent character receives a starting prefix bit of 1',
 'All encoded files insert a predefined header prefix indexing the tree depth',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The essence of a Prefix Code evaluates that no single character''s encoding visually acts as the starting sequence of another character''s encoding (e.g., if ''A'' is `10`, no other code starts with `10`). This physically eliminates ambiguity during sequential decoding, rendering look-ahead overhead unnecessary.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('greedy');

-- Q18 — Kruskal algorithm structure (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='mst-shortest-path' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Kruskal''s algorithm computationally constructs a Minimum Spanning Tree (MST) by greedly individual edges. Which specific abstract data structure fundamentally prevents the fatal formation of graph cycles during this procedure?',
 'A Min-Heap priority queue',
 'A Union-Find (Disjoint-Set) data structure',
 'A strict Last-In-First-Out (LIFO) stack',
 'A balanced AVL Tree storing completed vertices',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Kruskal''s processes edges sorted directly un-ordered by increasing weight. Before admitting an edge, it must verify the two vertices belong to distinct trees. The Disjoint-Set (Union-Find) data structure optimally maintains disjoint tree components; if both vertices share the exact identical `find()` root parent, adding the edge violates acyclicity by forming a cycle.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('greedy');

-- Q19 — Prim vs Kruskal (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='mst-shortest-path' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'When operating on a fully connected undirected graph containing densely massive edge populations ($E \approx V^2$), which Minimum Spanning Tree configuration generally operates asymptotically faster?',
 'Prim''s Algorithm configured traversing a Fibonacci Heap',
 'Kruskal''s Algorithm sorting via standard comparison sort',
 'Dijkstra''s Algorithm configured without a min-queue',
 'Bellman-Ford evaluated on absolute values',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Kruskal sorts practically all edges requiring $O(E \log E)$. For incredibly dense graphs where $E = V^2$, this balloons severely. Prim''s algorithm utilizing a highly optimized Fibonacci Heap specifically drives down `decrease_key` latency, an MST accurately in $O(E + V \log V)$, which drastically outperforms Kruskal numerically on dense topologies.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('greedy');

-- Q20 — Dijkstra edge constraints (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='mst-shortest-path' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Dijkstra''s shortest path algorithm operates and only if the graph meets which constraint condition?',
 'The graph must be acyclic',
 'The graph must evaluate with non-negative edge weight values',
 'The graph must physically implement directed edges ',
 'The source node must contain zero outgoing links',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Dijkstra relies on a greedy presumption: once a vertex distance officially marks as finalized from the min-heap, no future discovered path can be shorter. Negative edges catastrophically break this absolute presumption, allowing paths to deceptively decrease in length later, invalidating finalized checkpoints.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('shortest-path');

-- Q21 — Bellman Ford purpose (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='bellman-ford-floyd' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Besides calculating shortest paths dynamically in graphs containing isolated negative-weight edges, what critical topological hazard does the Bellman-Ford algorithm detect that Dijkstra suppresses?',
 'Disconnected isolated graph components',
 'Eulerian traversable cycle pathways',
 'Negative-weight cycles dynamically dragging path sums asymptotically to negative infinity',
 'Bipartite graph lacking odd edge counts',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The standard algorithm fully relaxes all $E$ edges $V-1$ sequential iterations guaranteeing propagation. A negative cycle means passing through continuously lowers total distance boundlessly. Bellman-Ford detects this specifically by initiating one final $V^{th}$ sweep; if any theoretical path shrinks further, a catastrophic negative cycle exists.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('shortest-path','dp');

-- Q22 — Optimal Substructure (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dp-basics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'In the context of Dynamic Programming methodologies, what does the term "Overlapping Subproblems" refer to?',
 'A scenario where the identical smaller recursive subproblem is computed repeatedly multiple distinct times',
 'A structural requirement where disjoint sections of data mathematically contradict optimization',
 'A structural feature proving the problem is NP-Hard analytically',
 'A programmatic situation risking infinite recursion leading directly to stack overflow',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Solving something recursively (like Fibonacci) mathematically expands into a massive tree calculating the exact same branches repeatedly. "Overlapping subproblems" states these branches merge/share tasks. DP caches these calculated tasks in tables (memoization) preventing redundant re-computing.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dp');

-- Q23 — Floyd Warshall algorithm (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='bellman-ford-floyd' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'The Floyd-Warshall algorithm evaluates All-Pairs Shortest Path distances across a network matrix. It utilizes a dynamic programming triple nested loop schema. What is the fundamental asymptotic complexity of this approach?',
 '$O(V^2)$',
 '$O(V^3)$',
 '$O(V^2 \log V)$',
 '$O(V \cdot E)$',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The DP mathematical recurrence loops over all pairs of nodes $i, j$ and tests if routing specifically straight through an intermediate junction node $k$ accelerates the path configuration. Testing $k$ loops $V$ times encapsulating coordinates $i \to j$ spanning $V \times V$. Ergo, total computational cost evaluates to $O(V^3)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('shortest-path','dp');

-- Q24 — Matrix Chain Multiplication dimensions (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='mcm' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Consider optimally computing $A_1 \times A_2 \times A_3$. $A_1$ is $10 \times 100$, $A_2$ is $100 \times 5$, and $A_3$ is $5 \times 50$. How many scalar multiplications calculate via optimal parenthesization $(A_1 \times (A_2 \times A_3))$ versus parenthesizing $((A_1 \times A_2) \times A_3)$ respectively?',
 '(7500 compared to 75000)',
 '(25000 compared to 75000)',
 '(25000 compared to 5000)',
 '(75000 compared to 7500)',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Matrix math evaluates scaling. $((A_1 \times A_2) \times A_3)$: Step 1 costs $10 \times 100 \times 5 = 5000$. Produces a $10 \times 5$ payload. Step 2 costs $10 \times 5 \times 50 = 2500$. Total 7500 .<br>$(A_1 \times (A_2 \times A_3))$: Step 1 costs $100 \times 5 \times 50 = 25000$. Produces a $100 \times 50$ payload. Step 2 costs $10 \times 100 \times 50 = 50000$. Total 75000 .<br>DP algorithms methodically pinpoint the 7500 route bypassing the catastrophic 75000 payload .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dp');

-- Q25 — Longest Common Subsequence (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='lcs' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'When calculating the Longest Common Subsequence (LCS) traversing dynamically between strings $X$ of length $m$ and $Y$ of length $n$, the length of establishing table matrix $C[i,j]$ determines completion. What asymptotic time and space logic fundamentally binds this dynamic method?',
 '$O(m+n)$ spatial',
 '$O(m \times n)$ temporally all strict coordinate intersections',
 '$O(n \log m)$ recursive tree bifurcations ',
 '$O(n^m)$ recursively spanning disjoint intersections ',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> LCS establishes a $m \times n$ table matrix sequentially. Traversing cell coordinates dictates mathematical branching exactly once per intersection. Since each array box mathematically pulls results adjacently taking specifically $O(1)$ evaluations, fully computing evaluates exactly to proportional matrix dimensions $O(m \times n)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dp');

-- Q26 — Dijkstra vs Bellman ford applicability (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='bellman-ford-floyd' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'What defines the absolute mathematical necessity for configuring a network utilizing Bellman-Ford optimization rather than defaulting directly to Dijkstra''s quicker paradigm?',
 'The network physically represents positive integers mathematically bounding infinite edges',
 'The network intentionally utilizes directed edges that compute sub-zero (negative) payload values affecting sum traversal',
 'The network topology exhibits massive unstructured spanning cycles connecting independent branches',
 'The optimal path calculation limits output bounding isolated acyclic components mathematically',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Dijkstra and ignores the negative feedback characteristics due to absolute greedy assumptions distances iteratively unyielding. Bellman-Ford mathematically digests networks incorporating negative edges successfully accurate shortest sequences utilizing structured, rigorous DP relaxation protocols.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('shortest-path');

-- Q27 — 0/1 Knapsack DP properties (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='01-knapsack' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'The classic 0/1 Knapsack DP solution requires constructing a table $w[i, w]$. If there are exactly $n$ items and the knapsack capacity exactly matches $W$, what describes its defined pseudo-polynomial time complexity?',
 '$O(n \log W)$ computationally bitwise operations iteratively',
 '$O(nW)$ temporally computing bounded limits total values individual weight capacity columns proportionally',
 '$O(W)$ bounded sequentially bypassing items ',
 '$O(2^n)$ spanning exhaustive geometrically unyielding ',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The standard dynamic paradigm iterates computationally across each structural item index $n$, specifically up calculating capacities up exactly $W$. Because the algorithm time binds magnitude integer $W$ rather than explicit input length logarithmically, computationally constitutes $O(nW)$ pseudo-polynomial logic .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dp','knapsack');

-- Q28 — Graph Algorithms Paradigms (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='mst-shortest-path' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Which explicit algorithmic design paradigm classifies specifically mathematically both Kruskal and Prim Minimum Spanning Trees computationally?',
 'Dynamic Programming calculating mathematically independent recursion',
 'Divide and Conquer physically bisecting structures iteratively independent',
 'Greedy Algorithms traversing iteratively adopting locally strict bounding optimal choices continuously immediately',
 'Backtracking algorithm backtracking nodes search space randomly conditionally',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Kruskal directly selects edges greedily ascending bounds minimizing sequentially immediately. Prim greedily expands actively spanning specifically directly adjacent connecting nodes mathematically extracting min structures . Neither fundamentally reconsiders past logical assumptions indicating absolute Greedy classification.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('greedy');

-- Part 3 Complete.
