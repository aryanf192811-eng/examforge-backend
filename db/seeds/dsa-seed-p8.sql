-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DSA PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2 (15 Cards: Graphs & Sorting), COMMIT + Stats
-- ═══════════════════════════════════════════════════════════════════════════

-- ─── Section: Graphs & Sorting (15 cards) ────────────────────────────────
INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bfs-topic' LIMIT 1),
  'When is Breadth-First Search (BFS) guaranteed to find the absolute Shortest Path?',
  '<p>BFS guarantees finding the shortest path (minimum number of edges) strictly in <strong>Unweighted Graphs</strong> (or graphs where every edge has the exact same uniform weight).</p><p>For weighted graphs with positive edge weights, Dijkstra''s Algorithm must be used.</p>',
  ARRAY['bfs','graph']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='topological-sorting' LIMIT 1),
  'What graph property is verified if a Topological Sort is successfully completed?',
  '<p>A successful Topological Sort verifies absolutely that the graph is a <strong>Directed Acyclic Graph (DAG)</strong>.</p><p>If the algorithm completes but hasn''t placed all vertices in the sorted output, it detected a <strong>Cycle</strong>.</p>',
  ARRAY['topological-sort','graph']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='kruskal-mst' LIMIT 1),
  'Briefly summarize Kruskal''s Algorithm for finding an MST.',
  '<ol><li><strong>Sort</strong> all edges in ascending order of their weights.</li><li>Initialize an empty MST structure.</li><li>Iterate over the sorted edges: if adding the edge does NOT form a <strong>cycle</strong> with already included edges, add it to the MST.</li><li>Repeat until $V-1$ edges are added.</li></ol><p><em>Cycle detection is efficiently handled using the Disjoint Set (Union-Find) data structure.</em></p>',
  ARRAY['kruskal','graph']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='prim-mst' LIMIT 1),
  'Briefly summarize Prim''s Algorithm for finding an MST.',
  '<ol><li>Start with an arbitrary initial node in the MST.</li><li>Maintain a <strong>Min-Priority Queue</strong> of all edges connecting the current MST to nodes outside it.</li><li>Extract the minimum edge. If its destination is outside the MST, add the edge and the node to the MST.</li><li>Populate the PQ with new edges from the newly added node. Repeat until all nodes are in.</li></ol>',
  ARRAY['prim','graph']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dijkstra-sp' LIMIT 1),
  'Why does Dijkstra’s algorithm fail on Negative Weight Edges?',
  '<p>Dijkstra is a <strong>Greedy</strong> algorithm that extracts the closest node and <strong>finalizes</strong> its shortest path immediately.</p><p>It makes the strict assumption that all subsequent paths added will only INCREASE in weight (since all weights are non-negative). A negative edge breaks this assumption, allowing a later path to mysteriously drop below an already finalized node''s distance. Dijkstra cannot go back and fix it.</p>',
  ARRAY['dijkstra','graph']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bellman-ford-sp' LIMIT 1),
  'How does Bellman-Ford handle negative edges and detect negative cycles?',
  '<p><strong>Handling Negative Edges:</strong> It relaxes EVERY edge <code>V-1</code> times. Since the longest simple path in a graph has <code>V-1</code> edges, this guarantees the shortest path is fully propagated, regardless of negatives.</p><p><strong>Cycle Detection:</strong> It performs a final <code>V</code>-th relaxation pass. If ANY distance gets updated/lowered on this pass, it means distances are infinitely decreasing, proving a <strong>Negative Weight Cycle</strong> exists.</p>',
  ARRAY['bellman-ford','graph']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sorting-comparisons' LIMIT 1),
  'What are the Time Complexities of Merge Sort?',
  '<p><strong>Best Case:</strong> $\mathcal{O}(N \log N)$</p><p><strong>Average Case:</strong> $\mathcal{O}(N \log N)$</p><p><strong>Worst Case:</strong> $\mathcal{O}(N \log N)$</p><p>Merge sort strictly divides by 2 and merges. The tree depth is strictly $\log N$, and merging all subproblems on a level takes $\mathcal{O}(N)$. It is incredibly consistent, but requires $\mathcal{O}(N)$ extra space.</p>',
  ARRAY['sorting','time-complexity']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='divide-conquer-sorting' LIMIT 1),
  'What induces the Worst-Case $\mathcal{O}(N^2)$ in Quick Sort and how is it mitigated?',
  '<p><strong>Worst-case Condition:</strong> Unbalanced partitioning (e.g., $N-1$ and $0$). This happens consistently if the array is already sorted (ascending or descending) and the pivot is strictly taken from the end.</p><p><strong>Mitigation:</strong><br>- <strong>Randomized Pivot:</strong> Pick a pivot at random to probabilistically guarantee $\log N$ height.<br>- <strong>Median-of-Three:</strong> Pivot is the median of First, Middle, and Last elements.</p>',
  ARRAY['sorting','time-complexity']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='elementary-sorting' LIMIT 1),
  'Which $\mathcal{O}(N^2)$ algorithm performs the MINIMUM number of swaps?',
  '<p><strong>Selection Sort</strong></p><p>It searches the entire unsorted array to find the exact minimum element, and then performs exactly ONE swap to put it in place.</p><p>For $N$ elements, it strictly does a maximum of <strong>$N-1$ swaps (write operations)</strong> in all cases, making it useful in systems with extremely expensive memory-write costs (e.g., EEPROM).</p>',
  ARRAY['sorting']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics  WHERE slug='elementary-sorting' LIMIT 1),
  'Why is Insertion Sort generally preferred over Bubble Sort and Selection Sort for small datasets?',
  '<p>1. <strong>Adaptive:</strong> If the array is already mostly sorted, its time complexity drops towards strictly $\mathcal{O}(N)$.<br>2. <strong>Low overhead:</strong> The inner loop is a simple while-check that breaks early, causing very fast constant factors.<br>3. <strong>Stable:</strong> Preserves original order of duplicates.<br>4. <strong>Online:</strong> Can sort data efficiently as it receives it live.</p>',
  ARRAY['sorting','time-complexity']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='master-theorem' LIMIT 1),
  'State the exact form of the Recurrence Relation solved by the Master Theorem.',
  '<p><strong>$T(n) = aT\left(\frac{n}{b}\right) + f(n)$</strong></p><p>Where:<br>- <code>a</code> $\ge 1$ (number of subproblems)<br>- <code>b</code> $> 1$ (factor by which subproblem size is divided)<br>- <code>f(n)</code> is the cost of dividing and combining (must be asymptotically positive).</p>',
  ARRAY['master-theorem','divide-conquer']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='master-theorem' LIMIT 1),
  'What is the Critical Value ($c_{crit}$) in the Master Theorem comparison?',
  '<p>The critical value is the exponent: <strong>$\log_b a$</strong></p><p>You must compare the growth rate of $f(n)$ against the polynomial <strong>$n^{\log_b a}$</strong>.<br>- If $f(n)$ is polynomially <em>smaller</em>, leaves dominate: $T(n) = \Theta(n^{\log_b a})$.<br>- If $f(n)$ is <em>equal</em> (with possible logs), all levels equal: $T(n) = \Theta(n^{\log_b a} \log n)$.<br>- If $f(n)$ is polynomially <em>larger</em>, root dominates: $T(n) = \Theta(f(n))$.</p>',
  ARRAY['master-theorem','divide-conquer']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dfs-topic' LIMIT 1),
  'In a DFS traversal, what defines a "Back Edge" and what is its significance?',
  '<p>A <strong>Back Edge</strong> points from a node $u$ to an ancestor $v$ in the DFS tree (meaning $v$ is still "open" / on the discovery stack when the edge $u \to v$ is explored).</p><p><strong>Significance:</strong> A graph contains a back edge if and only if it contains a <strong>cycle</strong>. DFS uses this explicitly for Cycle Detection.</p>',
  ARRAY['dfs','graph']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-representations' LIMIT 1),
  'Compare Adjacency Matrix and Adjacency List Space Complexities.',
  '<p><strong>Adjacency Matrix:</strong> Requires a 2D array. Space is strictly <strong>$\mathcal{O}(V^2)$</strong>, bad for sparse graphs. Fast $\mathcal{O}(1)$ edge lookup.</p><p><strong>Adjacency List:</strong> Array of pointers to linked lists. Space is <strong>$\mathcal{O}(V + E)$</strong>, highly efficient for sparse graphs. Edge lookup requires traversing the list $\mathcal{O}(\text{degree})$.</p>',
  ARRAY['graph']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='topological-sorting' LIMIT 1),
  'There is more than one valid Topological Sort for a given DAG. When is the Topological Sort UNIQUE?',
  '<p>A Topological Sort is absolutely unique if and only if the DAG contains an exact <strong>Hamiltonian Path</strong> (a path visiting every vertex exactly once).</p><p>If a Hamiltonian Path exists, the linear ordering is completely forced by that path with no degrees of freedom.</p>',
  ARRAY['topological-sort','graph']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing dsa-seed.sql to verify correctness:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='dsa'));
-- Expected: 44
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dsa');
-- Expected: 65
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dsa');
-- Expected: 40
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dsa')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug: dsa
-- Schema version: v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- Chapters:     7 (Arrays/Hashing, LL, Stacks/Queues, Trees/BST, AVL/Heaps, Graphs, Sorting)
-- Topics:       44 (~6 per chapter)
-- Questions:    65 total
--   MCQ:        45 (Q1–Q45)
--   NAT:        10 (Q46–Q55)
--   MSQ:        10 (Q56–Q65)
--   Difficulty: easy: 26 | medium: 33 | hard: 6
-- Flashcards:   40 comprehensive algorithmic theory cards
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF dsa-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
