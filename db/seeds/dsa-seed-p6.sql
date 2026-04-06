-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DSA PYQ SEED v2  (Part 6 / 8)
-- MSQ Questions Q56–Q65 (Graphs, Sorting, Trees, Arrays)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q56 — MSQ: Stack Applications (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),
  (SELECT id FROM topics WHERE slug='stack-implementation' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'Which of the following are standard applications of a Stack? (Select all that apply)',
  'Evaluation of Postfix expressions',
  'Undo mechanism in text editors',
  'Level-order traversal of a tree',
  'Syntax parsing (valid parenthesis checking)',
  ARRAY['A','B','D'],
  '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> Stacks (LIFO) are perfect for reversing operations or resolving nested structures.<br>- <strong>A:</strong> Postfix evaluation uses a stack to store operands until an operator arrives.<br>- <strong>B:</strong> Undo systems track operations; "Undo" pops the last action.<br>- <strong>D:</strong> Matching parenthesis requires checking the most-recently opened bracket. Stack strongly resolves nesting.</p><p><strong>Why C is FALSE:</strong> Level-order traversal implies exploring layer by layer (Breadth-First). This requires a Queue (FIFO).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('stack');

-- Q57 — MSQ: Stable Sorting algorithms (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sorting-comparisons' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following sorting algorithms are STABLE by nature? (Select all that apply)',
  'Merge Sort',
  'Counting Sort',
  'Selection Sort',
  'Heap Sort',
  ARRAY['A','B'],
  '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> Stability preserves the relative order of duplicate elements.<br>- <strong>A (Merge Sort):</strong> Stable if the merge step resolves equality by choosing the left element.<br>- <strong>B (Counting Sort):</strong> Stable if the cumulative array is traversed in reverse order when placing elements.</p><p><strong>Why C and D are FALSE:</strong> Both Selection Sort and Heap Sort swap elements across vast distances, indiscriminately skipping over duplicates and destroying initial relative ordering.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sorting');

-- Q58 — MSQ: BFS properties (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bfs-topic' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following statements about Breadth-First Search (BFS) on an unweighted, undirected graph are TRUE? (Select all that apply)',
  'It finds the shortest path from the source node to every other node',
  'A cross edge can exist between nodes at the same level of the BFS tree',
  'It uses a stack internally for traversal',
  'The maximum depth of the BFS tree is equal to the diameter of the graph',
  ARRAY['A','B'],
  '<p><strong>✓ Answers: A, B.</strong></p><p><strong>A is TRUE:</strong> BFS explores by expanding "ripples" equally in all directions, so it guarantees finding the shortest path (minimum edges) to all reachable nodes in unweighted graphs.<br><strong>B is TRUE:</strong> In an undirected graph, BFS classifies non-tree edges as "cross edges". These edges ONLY occur between nodes at the same level $d$, or adjacent levels ($d$ and $d+1$).</p><p><strong>Why C is FALSE:</strong> BFS uses a Queue (FIFO), not a Stack.<br><strong>Why D is FALSE:</strong> The depth of the BFS tree from an arbitrary root is not strictly the diameter. The diameter is the maximum shortest path between ANY two nodes. The BFS depth is the maximum shortest path from the SPECIFIC root. Sometimes running roughly 2 BFS passes can approximate/find the diameter (tree diameter algorithm), but one BFS depth does not equal the diameter generally.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bfs','graph');

-- Q59 — MSQ: Heap properties (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='heap-properties' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Let H be a standard Min-Heap of size N implemented as an array. Which of the following operations can be done in $\mathcal{O}(1)$ time? (Select all that apply)',
  'Finding the minimum element',
  'Finding the maximum element',
  'Inserting a new element',
  'Finding the parent of the node at index $i$',
  ARRAY['A','D'],
  '<p><strong>✓ Answers: A, D.</strong></p><p><strong>A is TRUE:</strong> The minimum element in a Min-Heap is always squarely at the root (index 1 for 1-indexed, index 0 for 0-indexed arrays). Time is $\mathcal{O}(1)$.<br><strong>D is TRUE:</strong> The parent of any node at index $i$ is calculated using a simple math operation (e.g., $\lfloor i/2 \rfloor$), taking $\mathcal{O}(1)$ time.</p><p><strong>Why others are FALSE:</strong><br>- Finding the Max element in a Min-Heap requires scanning ALL leaf nodes, which takes $\mathcal{O}(N)$.<br>- Inserting an element might require bubbling it up to the root, which takes $\mathcal{O}(\log N)$ worst-case time.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('heap','time-complexity');

-- Q60 — MSQ: Master Theorem Valid Cases (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='master-theorem' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','hard',2,
  'For which of the following recurrences can you directly apply the standard Master Theorem (without using generalized formulations/extensions) to find the asymptotic bound? (Select all that apply)',
  '$T(n) = 2T(n/2) + \mathcal{O}(n)$',
  '$T(n) = 3T(n/2) + \mathcal{O}(n^2)$',
  '$T(n) = 2T(n/2) + \mathcal{O}(n \log n)$',
  '$T(n) = 2T(n/2) + n/\log n$',
  ARRAY['A','B'],
  '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> The standard Master Theorem applies to $T(n) = aT(n/b) + f(n)$ where $f(n)$ can be polynomially bounded relative to $n^{\log_b a}$.<br>- <strong>A:</strong> $n^{\log_2 2} = n^1$. $f(n) = n$. This matches Case 2 exactly. (Valid)<br>- <strong>B:</strong> $n^{\log_2 3} \approx n^{1.58}$. $f(n) = n^2$. Here $n^2$ is polynomially strictly larger than $n^{1.58}$ (Case 3). Also satisfies regularity condition. (Valid)</p><p><strong>Why C and D are FALSE:</strong><br>- <strong>C:</strong> $f(n) = n \log n$, while $n^{\log_2 2} = n$. The difference between $f(n)$ and $n^{\log_b a}$ is exactly a $\log n$ factor. This is NOT polynomially larger. The standard theorem fails here (requires the extended case $k$ rule).<br>- <strong>D:</strong> $f(n) = n/\log n$. Similarly, it is not polynomially smaller than $n^1$. Standard theorem fails.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('master-theorem','divide-conquer');

-- Q61 — MSQ: Spanning Tree edge additions (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-representations' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Let T be a spanning tree of an undirected connected graph G. Which of the following statements are ALWAYS true if we add a new edge $e$ from G to T? (Select all that apply)',
  'Adding $e$ creates exactly one simple cycle',
  'The created cycle must contain the edge $e$',
  'Removing ANY edge from the created cycle will restore the graph to a spanning tree',
  'Adding $e$ increases the total number of connected components',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> A spanning tree holds the minimal edges to keep the graph connected without cycles. Its properties are rigorous:<br>- <strong>A:</strong> A tree is "maximally acyclic". Adding ANY edge exactly creates one fundamental cycle.<br>- <strong>B:</strong> Because the tree had no cycles before, the new cycle relies entirely on the newly added edge $e$.<br>- <strong>C:</strong> Since there is exactly one cycle, breaking it by removing ANY of its edges restores the tree property (connected, acyclic).</p><p><strong>Why D is FALSE:</strong> Adding an edge never increases components; if anything, in a disconnected graph it decreases them. Here it just adds a cycle without changing the component count (which remains 1).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graph');

-- Q62 — MSQ: Divide and Conquer Algorithms (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),
  (SELECT id FROM topics WHERE slug='divide-conquer-paradigm' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'Which of the following algorithms structurally employ the Divide and Conquer design paradigm? (Select all that apply)',
  'Binary Search',
  'Merge Sort',
  'Strassen’s Matrix Multiplication',
  'Dijkstra’s Algorithm',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Divide and Conquer involves breaking a problem into non-overlapping subproblems, solving them recursively, and combining the results.<br>- <strong>A:</strong> Binary Search divides the array in half and conquers one side.<br>- <strong>B:</strong> Merge Sort divides the array in half, sorts each, and merges.<br>- <strong>C:</strong> Strassen divides matrices into 4 quadrants and combines them recursively with 7 multiplications instead of 8.</p><p><strong>Why D is FALSE:</strong> Dijkstra’s algorithm uses the Greedy paradigm. It does not divide the graph into structural subproblems; it incrementally builds the solution.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('divide-conquer','sorting');

-- Q63 — MSQ: BST Search Time Limits (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bst-operations' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following conditions guarantee an $\mathcal{O}(\log n)$ worst-case search time in a Binary Search Tree of $n$ nodes? (Select all that apply)',
  'The tree is strictly a Full Binary Tree',
  'The tree enforces the AVL balance property',
  'The tree enforces the Red-Black balancing coloring rules',
  'Elements were inserted in strictly random order uniformly',
  ARRAY['B','C'],
  '<p><strong>✓ Answers: B, C.</strong></p><p><strong>Rationale:</strong> Search time in a BST depends entirely on its MAXIMUM height.<br>- <strong>B:</strong> AVL trees enforce $|height(left) - height(right)| \le 1$. Max height is bounded to $1.44 \log_2 n$. This guarantees $\mathcal{O}(\log n)$ searches.<br>- <strong>C:</strong> Red-Black trees enforce coloring rules that ensure the longest path is no more than twice the shortest path. Max height is bounded to $2 \log_2 (n+1)$. Guarantees $\mathcal{O}(\log n)$.</p><p><strong>Why A is FALSE:</strong> A Full BST (0 or 2 children) can still degenerate into a skewed zigzag if improperly loaded, taking $\mathcal{O}(n)$ height.<br><strong>Why D is FALSE:</strong> Random insertion gives an AVERAGE time of $\mathcal{O}(\log n)$, but the WORST CASE is still $\mathcal{O}(n)$ if by very bad luck the random sequence arrives sorted.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bst','avl-tree','time-complexity');

-- Q64 — MSQ: Hash Collision techniques (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='chaining-open-addressing' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'Which of the following are valid Open Addressing collision resolution techniques in Hash Tables? (Select all that apply)',
  'Linear Probing',
  'Quadratic Probing',
  'Separate Chaining',
  'Double Hashing',
  ARRAY['A','B','D'],
  '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> Open Addressing techniques resolve collisions by searching for the "next" open slot entirely within the bounds of the original array (i.e., all elements reside in the hash table itself).<br>Linear probing (+1, +2...), Quadratic probing (+1^2, +2^2...), and Double Hashing ($h_1 + i \times h_2$) all use this approach.</p><p><strong>Why C is FALSE:</strong> Separate Chaining relies on pointers and external data structures (Linked Lists) growing outside the array itself. It is explicitly the alternative to Open Addressing.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hashing');

-- Q65 — MSQ: Properties of linked lists vs arrays (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='linked-lists' LIMIT 1),
  (SELECT id FROM topics WHERE slug='singly-ll' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following operations are generally FASTER on a Singly Linked List (given a direct pointer to the target node) compared to an Array? (Select all that apply)',
  'Inserting an element exactly after the target node',
  'Deleting the target node itself',
  'Accessing the k-th element',
  'Swapping the first and last elements',
  ARRAY['A'],
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong><br>- <strong>A is TRUE:</strong> Given a pointer `target`, inserting a new node right after it involves just `newNode->next = target->next; target->next = newNode;`. Time: $\mathcal{O}(1)$. In an array, inserting inside the array requires shifting all subsequent elements, taking $\mathcal{O}(n)$.</p><p><strong>Why others are FALSE:</strong><br>- <strong>B:</strong> To delete the target node in a singly linked list, we must change its <em>predecessor''s</em> next pointer. Finding the predecessor takes $\mathcal{O}(n)$ from the head! So this is ironically slow. (Hack exception: copying data from successor and deleting successor, but standard structural deletion is $\mathcal{O}(n)$). Arrays take $\mathcal{O}(n)$ shift too.<br>- <strong>C:</strong> Arrays are $\mathcal{O}(1)$ random access. Lists are $\mathcal{O}(k)$ traversal.<br>- <strong>D:</strong> Finding the last element in a linked list without a tail pointer takes $\mathcal{O}(n)$. Array swaps take $\mathcal{O}(1)$ directly referencing `A[0]` and `A[n-1]`.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('linked-list','array','time-complexity');

-- Part 6 complete.
