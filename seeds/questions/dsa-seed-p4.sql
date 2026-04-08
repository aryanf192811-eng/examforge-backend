-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DSA PYQ SEED v2  (Part 4 / 8)
-- MCQ Questions Q31–Q45 (Graphs, Sorting)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q31 — BFS vs DFS usage (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bfs-topic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following problems is best solved using a Breadth-First Search (BFS) rather than a Depth-First Search (DFS)?',
  'Finding the shortest path in an unweighted graph',
  'Detecting a cycle in a directed graph',
  'Topological sorting of a Directed Acyclic Graph (DAG)',
  'Finding Articulation Points and Bridges',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> BFS explores the graph layer by layer, expanding outward equally in all directions. Because of this property, the first time it reaches a target node in an <em>unweighted</em> graph, it is guaranteed to have found the shortest path (minimum number of edges). DFS has no such guarantee and may stumble upon a long, winding path first.</p><p><strong>Why others use DFS:</strong> Cycle detection via back-edges, Topological sort via departure times (postorder), and Articulation points (Tarjan''s/Hopcroft''s) rely intimately on the depth-first tree structure and discovery/low times.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bfs','graph');

-- Q32 — Graph Traversal Time Complexity (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-representations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What is the time complexity of Breadth-First Search (BFS) when the graph is represented using an Adjacency Matrix?',
  '$\mathcal{O}(V + E)$',
  '$\mathcal{O}(E^2)$',
  '$\mathcal{O}(V^2)$',
  '$\mathcal{O}(V \log V)$',
  'C',
  '<p><strong>✓ Answer: C — $\mathcal{O}(V^2)$.</strong></p><p><strong>Step-by-step:</strong> In BFS, we process each vertex once. When at vertex $u$, we must find all its neighbors. In an adjacency matrix, finding neighbors requires inspecting the entire row $u$, taking $\mathcal{O}(V)$ time. Since we do this for all $V$ vertices, the total time is $V \times \mathcal{O}(V) = \mathcal{O}(V^2)$.</p><p><strong>GATE trap:</strong> The standard $\mathcal{O}(V + E)$ complexity for BFS/DFS assumes an <strong>Adjacency List</strong> representation, where you only iterate over actual edges. If Matrix is specified, it degrades to $\mathcal{O}(V^2)$ even if the graph is sparse.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bfs','time-complexity');

-- Q33 — Topological sort condition (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='topological-sorting' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A Topological Sort over a graph $G$ is possible strictly if and only if:',
  '$G$ is a Directed Acyclic Graph (DAG)',
  '$G$ is an Undirected Graph',
  '$G$ has at least one source and one sink',
  '$G$ contains no disconnected components',
  'A',
  '<p><strong>✓ Answer: A — $G$ is a Directed Acyclic Graph (DAG).</strong></p><p><strong>Rationale:</strong> Topological sorting intrinsically models dependencies (task A must finish before task B). Therefore, edges must be <em>directed</em>. If there is a cycle (A depends on B, B depends on C, C depends on A), there is no valid linear ordering. Thus, the graph MUST be acyclic.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('topological-sort','graph');

-- Q34 — Prim''s vs Kruskal''s MST (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='kruskal-mst' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following data structures is the most crucial for the efficient $\mathcal{O}(E \log V)$ implementation of Kruskal''s Minimum Spanning Tree algorithm?',
  'Min-Priority Queue (Binary Heap)',
  'Disjoint Set (Union-Find) with Path Compression',
  'Stack',
  'Adjacency Matrix',
  'B',
  '<p><strong>✓ Answer: B — Disjoint Set (Union-Find).</strong></p><p><strong>Rationale:</strong> Kruskal''s algorithm sorts edges by weight, then iteratively adds them to the MST if they don''t form a cycle. Efficiently checking for cycles and merging components requires the Disjoint Set (Union-Find) structure. Using Path Compression and Union by Rank, these checks take near $\mathcal{O}(1)$ time ($\alpha(V)$). The $\mathcal{O}(E \log E)$ time is dominated by the initial sorting of edges.</p><p><strong>GATE trap:</strong> Prim''s algorithm relies on a Min-Priority Queue to pick the smallest edge extending from the current MST tree. Kruskal relies on Sorting + Disjoint Set.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('kruskal','graph');

-- Q35 — Dijkstra Negative Edges (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dijkstra-sp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Why can Dijkstra''s algorithm fail to find the shortest path in a graph with negative edge weights?',
  'It cannot process edge weights less than zero structurally due to the priority queue',
  'It is a selfish algorithm that assumes edge weights form a metric space (triangle inequality)',
  'It finalizes a node''s distance when it is extracted from the Min-Heap, assuming all future paths will only add positive weight',
  'It throws an infinite loop trying to lower the distances continuously',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Dijkstra is a Greedy Algorithm. Once it extracts a vertex $u$ from the priority queue, it declares the shortest path to $u$ as "final". This relies on the assumption that any other indirect path to $u$ via unvisited vertices will have a weight $\ge d(u)$, because all edge weights are non-negative. A negative edge breaks this assumption: a later path might suddenly drop below $d(u)$, but Dijkstra has already finalized $u$ and will not re-evaluate it safely.</p><p><strong>Why wrong:</strong> If there is a negative cycle, algorithms can loop, but Dijkstra specifically fails even on simple negative edges without cycles because of its greedy finalization. Bellman-Ford solves this by relaxing all edges $V-1$ times.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dijkstra','graph');

-- Q36 — Bellman-Ford Negative Cycle (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bellman-ford-sp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The Bellman-Ford algorithm finds shortest paths from a single source. How many times must it relax all edges to successfully detect a reachable negative-weight cycle in a graph with $V$ vertices?',
  '$V - 1$',
  '$V$',
  '$\log V$',
  'It cannot detect negative cycles',
  'B',
  '<p><strong>✓ Answer: B — $V$ times.</strong></p><p><strong>Step-by-step:</strong> In a graph with $V$ vertices, any simple path (no cycles) can have at most $V-1$ edges. Bellman-Ford relaxes all edges $V-1$ times, which guarantees it finds the absolute shortest paths if no negative cycle exists. To <em>detect</em> a negative cycle, you run the relaxation exactly ONE more time (the $V$-th time). If any distance is reduced on this $V$-th iteration, it proves a negative cycle exists.</p><p><strong>GATE trap:</strong> $V-1$ iterations to find the shortest path. $V$ iterations total to detect the cycle.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bellman-ford','graph');

-- Q37 — Counting strongly connected components (hard, pyq concept)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dfs-topic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Kosaraju’s algorithm for finding Strongly Connected Components (SCCs) requires which of the following sequences of operations?',
  'Run BFS on G, reverse edges, run BFS on $G^R$',
  'Run DFS on G (compute finishing times), reverse edges, run DFS on $G^R$ in decreasing order of finishing times',
  'Assign low-link values using a single DFS pass',
  'Run Dijkstra from all sources, connect symmetric pairs',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Kosaraju''s Two-Pass Algorithm for SCCs consists of:<br>1. Run DFS on the original graph $G$ and push vertices to a stack based on their <strong>finishing times</strong>.<br>2. Compute the transpose graph $G^R$ by reversing all edges.<br>3. Pop vertices from the stack (highest finishing time first) and perform DFS on $G^R$. Each resulting DFS tree is one Strongly Connected Component.</p><p><strong>Why wrong:</strong> Option C describes Tarjan''s Algorithm for SCCs, which is a single-pass DFS using discovery and low-link values.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfs','graph');

-- Q38 — Bubble sort comparisons (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='elementary-sorting' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In the standard (unoptimized) Bubble Sort algorithm on an array of $n$ elements, what is the exact number of key comparisons made in the worst, average, AND best cases?',
  '$n(n-1)/2$ in all cases',
  '$O(n)$ best case, $n(n-1)/2$ worst case',
  '$n \log n$ average case',
  '$n^2 / 4$ average case',
  'A',
  '<p><strong>✓ Answer: A — $n(n-1)/2$ in all cases.</strong></p><p><strong>Rationale:</strong> The STRICTLY standard (unoptimized) Bubble Sort consists of two nested loops: $i$ from 0 to $n-1$, and $j$ from 0 to $n-i-1$. It makes the comparison regardless of the array''s sorted state. The sum of $1 + 2 + ... + (n-1)$ is exactly $n(n-1)/2$ comparisons.</p><p><strong>GATE trap:</strong> An *optimized* Bubble Sort uses a boolean flag (e.g., `swapped`) to break early if no swaps occur in a pass. For the OPTIMIZED version, Best Case comparisons = $\mathcal{O}(n)$. If the question says "unoptimized" or "standard nested loops", it''s always $n(n-1)/2$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sorting','time-complexity');

-- Q39 — Stable Sorting (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sorting-comparisons' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following pairs contains <strong>ONLY</strong> stable sorting algorithms? (A sort is stable if it preserves the relative order of equal elements).',
  'Merge Sort and Quick Sort',
  'Insertion Sort and Merge Sort',
  'Heap Sort and Selection Sort',
  'Quick Sort and Heap Sort',
  'B',
  '<p><strong>✓ Answer: B — Insertion Sort and Merge Sort.</strong></p><p><strong>Rationale:</strong><br>- <strong>Insertion Sort:</strong> Stable. We only shift elements strictly greater than the key, preserving order of equals.<br>- <strong>Merge Sort:</strong> Stable. During the merge step, if $A[i] == B[j]$, we prefer the element from the left half ($A[i]$), preserving original order.<br>- <strong>Heap Sort:</strong> Unstable. Heap operations (up/down heapify) wildly swap elements across large distances.<br>- <strong>Selection Sort:</strong> Unstable. Searching for the minimum and swapping it to the front can jump over equal elements.<br>- <strong>Quick Sort:</strong> Unstable. The partitioning step swaps elements across the pivot boundary without preserving initial relative order.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sorting');

-- Q40 — Sorting algorithm best case (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='elementary-sorting' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which sorting algorithm is uniquely known for having a Best-Case time complexity of $\mathcal{O}(n)$ when the array is ALREADY sorted?',
  'Insertion Sort',
  'Selection Sort',
  'Merge Sort',
  'Heap Sort',
  'A',
  '<p><strong>✓ Answer: A — Insertion Sort.</strong></p><p><strong>Rationale:</strong> In Insertion Sort, the inner `while` loop checks if the key is smaller than the previous element. If the array is already sorted, this loop condition fails immediately on the first check. Thus, it only takes 1 comparison per element, making exactly $N-1$ comparisons. Time complexity: $\mathcal{O}(N)$.</p><p><strong>Why wrong:</strong> Selection Sort always searches the entire unsorted portion for the minimum $\mathcal{O}(N^2)$. Merge Sort always splits and merges $\mathcal{O}(N \log N)$. Heap Sort always builds the heap and extracts $\mathcal{O}(N \log N)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sorting','time-complexity');

-- Q41 — Quick Sort Worst Case (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='divide-conquer-sorting' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the classic Quick Sort algorithm using the last element as the pivot, what input induces the $\mathcal{O}(n^2)$ worst-case time complexity?',
  'An array with randomly distributed elements',
  'An array containing only identical elements (e.g., all 5s)',
  'An array already strictly sorted in ascending or descending order',
  'Both B and C',
  'D',
  '<p><strong>✓ Answer: D — Both B and C.</strong></p><p><strong>Step-by-step:</strong> Quick Sort degrades to $\mathcal{O}(n^2)$ when the pivot partitions the array into highly unbalanced halves (e.g., size $n-1$ and size $0$).<br>- <strong>Sorted array:</strong> The last element is the absolute max/min. All $n-1$ elements go to one side. This recurses $n$ times.<br>- <strong>Identical elements:</strong> Standard partition algorithms (like Lomuto) will put all equal elements on one side of the pivot, leading again to partitions of size $n-1$ and $0$, causing $\mathcal{O}(n^2)$.</p><p><strong>GATE trap:</strong> Identical arrays ALSO cause worst-case performance in standard unoptimized quicksort implementations. Optimized implementations like 3-way partitioning (Dutch National Flag) solve this.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sorting','time-complexity');

-- Q42 — Master Theorem basics (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='master-theorem' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Solve the recurrence relation $T(n) = 3T(n/2) + \mathcal{O}(n)$ using the Master Theorem.',
  '$\mathcal{O}(n \log n)$',
  '$\mathcal{O}(n^{\log_2 3})$',
  '$\mathcal{O}(n^{1.5})$',
  '$\Theta(n^{\log_2 3})$',
  'D',
  '<p><strong>✓ Answer: D — $\Theta(n^{\log_2 3})$.</strong></p><p><strong>Step-by-step:</strong> Form: $T(n) = a T(n/b) + f(n)$. Here $a=3, b=2, f(n) = \mathcal{O}(n)$.<br>1. Calculate $c_{crit} = \log_b a = \log_2 3 \approx 1.58$.<br>2. Compare $f(n) = n^1$ to $n^{1.58}$.<br>3. Since $1 < \log_2 3$, $f(n)$ is polynomially smaller than $n^{\log_b a}$.<br>4. This corresponds to Case 1 of the Master Theorem. The recursion tree leaves dominate the cost.<br>5. Result: $T(n) = \Theta(n^{\log_b a}) = \Theta(n^{\log_2 3})$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('master-theorem','divide-conquer','time-complexity');

-- Q43 — Master theorem exceptions (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='master-theorem' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Consider the recurrence $T(n) = 2T(n/2) + n \log n$. What is its time complexity?',
  '$\Theta(n \log n)$',
  '$\Theta(n \log^2 n)$',
  '$\Theta(n^2)$',
  'Cannot be solved using standard Master Theorem directly',
  'B',
  '<p><strong>✓ Answer: B — $\Theta(n \log^2 n)$.</strong></p><p><strong>Step-by-step:</strong> $a=2, b=2, f(n) = n \log n$.<br>1. $c_{crit} = \log_b a = \log_2 2 = 1$.<br>2. $f(n) = n \log n$. Compare to $n^1$. They are "equal" up to a log factor.<br>3. This is an extension of Case 2 of the Master Theorem. If $f(n) = \Theta(n^{\log_b a} \log^k n)$, then $T(n) = \Theta(n^{\log_b a} \log^{k+1} n)$.<br>4. Here $k=1$. Thus, $T(n) = \Theta(n^1 \log^2 n)$.</p><p><strong>GATE trap:</strong> While strictly speaking this is an extension formula (which many consider part of the "generalized" Master theorem), it universally yields $\Theta(n \log^2 n)$. This is heavily tested in GATE.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('master-theorem','divide-conquer','time-complexity');

-- Q44 — Selection Algorithm (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='divide-conquer-paradigm' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The "Median of Medians" deterministic selection algorithm finds the $k$-th smallest element in an unsorted array of size $n$. What is its worst-case time complexity?',
  '$\mathcal{O}(n)$',
  '$\mathcal{O}(n \log n)$',
  '$\mathcal{O}(n^2)$',
  '$\mathcal{O}(\log n)$',
  'A',
  '<p><strong>✓ Answer: A — $\mathcal{O}(n)$.</strong></p><p><strong>Rationale:</strong> Normally, randomized QuickSelect has an expected time of $\mathcal{O}(n)$, but a worst-case of $\mathcal{O}(n^2)$ if bad pivots are chosen. The "Median of Medians" variant (Blum-Floyd-Pratt-Rivest-Tarjan algorithm) guarantees a good pivot by dividing elements into groups of 5, finding their medians, and then recursively finding the median of those medians. This strict $\mathcal{O}(n)$ pivoting mechanism guarantees a worst-case time bound of strictly $\mathcal{O}(n)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('divide-conquer','time-complexity');

-- Q45 — Graph Path Max edges (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-representations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In a simple undirected graph with $V$ vertices, what is the maximum number of edges $E$ possible?',
  '$V^2$',
  '$V(V-1)$',
  '$V(V-1)/2$',
  '$2^V$',
  'C',
  '<p><strong>✓ Answer: C — $V(V-1)/2$.</strong></p><p><strong>Rationale:</strong> A simple graph has no loops and no parallel edges. Each vertex can connect to at most $V-1$ other vertices. Total edges = $V(V-1) / 2$ (divided by 2 because it is undirected, so edge A-B is the same as edge B-A). This forms a Complete Graph ($K_V$).</p><p><strong>GATE trap:</strong> If the graph is DIRECTED, the answer is $V(V-1)$ because A->B and B->A are distinct. If undirected, it is $V(V-1)/2$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graph');

-- Part 4 complete.
