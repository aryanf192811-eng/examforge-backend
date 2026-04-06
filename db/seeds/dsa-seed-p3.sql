-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DSA PYQ SEED v2  (Part 3 / 8)
-- MCQ Questions Q16–Q30 (Trees, BST, AVL, Heaps)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q16 — Full Binary Tree Leaves (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='binary-tree-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In a strictly binary tree (full binary tree) where every internal node has exactly 2 children, if there are $I$ internal nodes, how many leaf nodes ($L$) does the tree have?',
  '$I - 1$',
  '$I$',
  '$I + 1$',
  '$2I$',
  'C',
  '<p><strong>✓ Answer: C — $I + 1$.</strong></p><p><strong>Step-by-step:</strong> Let''s verify with examples.<br>- 1 root node (internal, $2$ children): $I=1$, Leaf nodes = $2$. $2 = 1 + 1$.<br>- 1 root + 2 children. If one child gets 2 children: Total nodes = 5. Internal $I = 2$. Leaves $L = 3$. $3 = 2 + 1$.<br>In any strictly full binary tree, the number of leaf nodes is always exactly one more than the number of internal nodes.</p><p><strong>Rule:</strong> For a full binary tree (every node has 0 or 2 children), $L = I + 1$. Total nodes $N = 2I + 1$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tree');

-- Q17 — Binary Tree Traversals (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tree-construction' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following pairs of traversals is SUFFICIENT to uniquely reconstruct a strictly binary tree (full binary tree with unlabelled internal nodes) but NOT an arbitrary binary tree?',
  'Preorder and Postorder',
  'Inorder and Preorder',
  'Inorder and Postorder',
  'Levelorder and Inorder',
  'A',
  '<p><strong>✓ Answer: A — Preorder and Postorder.</strong></p><p><strong>Rationale:</strong> Normally, to uniquely reconstruct *any* arbitrary binary tree, you absolutely need Inorder + (Preorder OR Postorder). Preorder + Postorder is NOT sufficient for arbitrary trees because you cannot tell if a single child is a left child or a right child.<br>HOWEVER, in a strictly binary tree (full binary tree), every internal node has exactly TWO children. There are no "single child" ambiguities. Thus, Preorder + Postorder *is* sufficient to uniquely reconstruct a full binary tree.</p><p><strong>GATE trap:</strong> Usually, Pre+Post cannot build a tree. But if the tree is full/strict (every node has 0 or 2 children), Pre+Post CAN uniquely build it!</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tree');

-- Q18 — BST Sequence property (medium, GATE PYQ pattern)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bst-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'When searching for the key 35 in a Binary Search Tree (BST), which of the following sequences could NOT be the sequence of nodes visited?',
  '10, 40, 20, 38, 30, 35',
  '45, 10, 40, 15, 30, 35',
  '15, 45, 20, 40, 38, 35',
  '40, 10, 38, 20, 35',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Step-by-step:</strong> In a BST, finding a sequence means maintaining a valid (min, max) boundary as we descend.<br>- Let''s trace A: Start at 10. 35 > 10, so go Right. Boundary is (10, +inf). Next is 40. 35 < 40, go Left. Boundary (10, 40). Next is 20. 35 > 20, go Right. Boundary (20, 40). Next is 38. 35 < 38, go Left. Boundary (20, 38). Next is 30. 35 > 30, go Right. Boundary (30, 38). Next is 35 (Found). Wait, is A valid? Let''s recheck.<br>If we are at 20 (and moving Right towards 38), it means 38 > 20. Correct.<br>Let me trace exactly: A node sequence $N$ is invalid if there exist $i < j < k$ such that $N[i] < N[k] < N[j]$ (going right then left out of bounds) or similar. The "Min-Max" test:<br>- Option A: 10(R)->40(L)->20(R)->38(L)->30(R)->35. Valid range at 30 is (20, 38). 30 is inside. Valid!<br>- Option B: 45(L)->10(R)->40(L)->15(R)->30(R)->35. Valid range at 15 is (10, 40). 15 inside. Valid range at 30 is (15,40). 30 inside. Valid!<br>- Option C: 15(R)->45(L)->20(R)->40(L)->38(L)->35. Valid range at 20 is (15, 45). Valid range at 40 is (20,45). Valid range at 38 is (20,40). 38 inside. Valid!<br>Let me re-read the sequence trap.<br>Wait, sequence A: 10, 40, 20, 38, 30, ... If we are at 20, we took Left from 40. True. Then from 20 we take Right to 38. True. From 38 we take Left to 30. True. From 30 we take Right to 35. True.<br>Let''s test C: 15(R)->45(L)->20. Since we took L from 45, the elements must be < 45. We are at 20. From 20 we take R to 40. Since we took L from 45, this 40 MUST be < 45. Okay. From 40 we take L to 38. 38 < 40 and > 20. Okay. Valid.<br>Let me look for the classic violator. What if D: 40(L)->10(R)->38(L)->20. At 38, we take Left to 20. The range at 38 is (10, 40). 20 is inside! From 20 we take R to 35. Range is (20, 38). 35 is inside.<br>Wait! Is one of them really invalid? Let me check A again: 10, 40, 20... at 20, boundary is (10, 40). At 38, boundary is (20, 40). At 30: boundary is (20, 38). YES, 30 is in (20,38).<br>Let''s check B: 45, 10, 40, 15... From 40(L), boundary is (10, 40). 15 is basically inside. Then from 15(R), boundary is (15, 40). 30 inside. Then 30(R) -> boundary (30,40). 35 inside. Valid!<br>Let me rethink the classic GATE PYQ options. Let me change option C to force an invalid sequence for educational clarity. If C was: 15, 45, 20, 10, ... 10 is invalid because it took Right from 15 (so must be > 15).<br>I will adjust Option C to: 15, 45, 20, 40, 12, 35.</p><p><strong>Modified Option C:</strong> 15, 45, 20, 40, 12, 35.<br><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> In sequence C, we start at 15 and go RIGHT to 45 (this means all subsequent nodes MUST be > 15). Later in the sequence we visit 12. Since $12 < 15$, and we had already branched right from 15, the node 12 could NOT possibly exist in that subtree. Thus, the sequence is impossible for a BST.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bst');

-- Update Q18 option C to match the explanation
UPDATE questions SET option_c = '15, 45, 20, 40, 12, 35', correct_option = 'C' WHERE question_text LIKE 'When searching for the key 35%';

-- Q19 — BST Inorder property (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tree-traversals' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which traversal of a Binary Search Tree (BST) visits the nodes in strictly increasing order?',
  'Preorder',
  'Inorder',
  'Postorder',
  'Levelorder',
  'B',
  '<p><strong>✓ Answer: B — Inorder.</strong></p><p><strong>Rationale:</strong> The Inorder traversal (Left, Root, Right) of a valid BST will uniquely list the keys in strictly increasing (sorted) order. This property is often used to sort an array: insert all elements into a BST, then do an inorder traversal (called Tree Sort).</p><p><strong>GATE trap:</strong> If a question asks to find the elements in DESCENDING order, you do a Reverse Inorder traversal (Right, Root, Left). This is highly useful for finding the K-th largest element.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bst','tree');

-- Q20 — AVL Rotations (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='avl-rotations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'An AVL tree is formed by inserting the numbers 1, 2, 3, 4, 5, 6 into an initially empty tree. Following the insertions, what is the root node of the resulting AVL tree?',
  '3',
  '4',
  '2',
  '5',
  'B',
  '<p><strong>✓ Answer: B — 4.</strong></p><p><strong>Step-by-step:</strong><br>1. Insert 1, 2: Root=1, child=2. (Balance ok)<br>2. Insert 3: Right-Right imbalance at 1. Rotate Left. Root=2, L=1, R=3.<br>3. Insert 4: R=3 gets R-child 4. (Balance ok)<br>4. Insert 5: R-R imbalance at 3 (3-4-5). Rotate left at 3. Tree: Root=2, L=1, R=4(L=3, R=5). Balance ok for root 2 (Left height 1, Right height 2: BF=1).<br>5. Insert 6: R-R imbalance at root 2! Right subtree height path is 4->5->6 (imbalance at 4? No, 4 is balanced. 2 is unbalanced). <br>Wait, let''s trace at step 5 carefully:<br>Nodes: 2(L:1, R:4). 4(L:3, R:5). Insert 6 as R-child of 5.<br>Heights: 5 has height 2 (L:nil, R:6). 3 has height 1. 4 has BF = 1 - 2 = -1 (ok).<br>2 has left tree 1 (height 1). Right tree 4 (height 3). BF of 2 = 1 - 3 = -2! Imbalance at 2.<br>The heavy path is Right-Right (from 2 to 4 to 5).<br>Rotation: Left rotation at 2. Node 4 becomes the new root! <br>Node 2 becomes Left child of 4. Node 3 (old left of 4) becomes right child of 2.<br>Final tree: Root=4; L=2(L=1, R=3), R=5(R=6). Completely balanced.<br>Resulting root is 4.</p><p><strong>Rule:</strong> In successive ascending insertions into an AVL tree, the newly promoted root shifts as rotations balance the right-skewed tree. Tracing step by step is essential.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('avl-tree','avl-rotations');

-- Q21 — Max Heap property (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='heap-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a Max-Heap represented as an array (1-indexed), which of the following is NOT a guaranteed property?',
  'The maximum element is at index 1',
  'For any internal node at index i, $A[i] \geq A[2i]$ and $A[i] \geq A[2i+1]$',
  'The array is sorted in strictly descending order',
  'All leaves are at the last or second-to-last level',
  'C',
  '<p><strong>✓ Answer: C — The array is sorted in strictly descending order.</strong></p><p><strong>Rationale:</strong> A Max-Heap only guarantees the partial ordering that a parent is greater than or equal to BOTH of its children. It does NOT guarantee that the entire array is sorted. For example, the array `[10, 5, 8, 3, 4]` is a valid max heap, but 8 is after 5, so it''s not strictly descending.</p><p><strong>Why others are true:</strong> A — Root is always Max. B — Definition of Max-Heap. D — Heaps are Complete Binary Trees, so leaves are only at the bottom two levels.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('heap');

-- Q22 — Heap Insert Time Complexity (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='heap-operations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the worst-case time complexity to insert a new element into a binary Max-Heap of size $n$?',
  '$\mathcal{O}(1)$',
  '$\mathcal{O}(\log n)$',
  '$\mathcal{O}(n)$',
  '$\mathcal{O}(n \log n)$',
  'B',
  '<p><strong>✓ Answer: B — $\mathcal{O}(\log n)$.</strong></p><p><strong>Rationale:</strong> To insert, you place the new element at the bottom-most, right-most leaf (maintaining the Complete Binary Tree property). Then, you perform an <strong>Up-Heapify (Bubble Up)</strong> operation to restore the heap property, swapping the node with its parent if it is larger. Since the height of the tree is strictly $\log_2(n)$, the maximum number of swaps is $\mathcal{O}(\log n)$.</p><p><strong>GATE trap:</strong> Inserting one element: $\mathcal{O}(\log n)$. BUT, building a heap from $n$ unsorted elements (Build-Heap operation) takes $\mathcal{O}(n)$ time, not $\mathcal{O}(n \log n)$!</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('heap','time-complexity');

-- Q23 — Tree from Traversals (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tree-construction' LIMIT 1),
  'gate-cse',true,2017,'MCQ','medium',2,
  'Let T be a binary tree. The preorder traversal of T gives: A B D E C F. The inorder traversal of T gives: D B E A F C. What is the postorder traversal of T?',
  'D E B F C A',
  'E D B F C A',
  'D E B C F A',
  'E D B C F A',
  'A',
  '<p><strong>✓ Answer: A — D E B F C A.</strong></p><p><strong>Step-by-step construction:</strong><br>1. Preorder (A B D E C F): Root is <strong>A</strong>.<br>2. Inorder tells us left/right subtrees: (D B E) <strong>A</strong> (F C). Left child is B, Right child is C.<br>3. Look at left subtree (D B E). Preorder is B D E. Root is <strong>B</strong>. Inorder is D <strong>B</strong> E. Left child is D, right child is E.<br>4. Look at right subtree (F C). Preorder is C F. Root is <strong>C</strong>. Inorder is F <strong>C</strong> (nothing after C). So F is Left child of C.<br>5. Final tree: Root A. L-child B (L:D, R:E). R-child C (L:F, R:None).<br>6. Postorder (Left, Right, Root): D E B F C A.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tree');

-- Q24 — Threaded binary trees (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='threaded-bt' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In an explicitly threaded binary tree, a NULL right child pointer of a node is replaced by a thread pointing to:',
  'Its inorder predecessor',
  'Its inorder successor',
  'Its parent node',
  'The root of the tree',
  'B',
  '<p><strong>✓ Answer: B — Its inorder successor.</strong></p><p><strong>Rationale:</strong> In threaded binary trees, wasted NULL pointers at leaves are repurposed to facilitate faster traversal without recursion or a stack. specifically, a right NULL pointer is replaced by a thread pointing to the <strong>inorder successor</strong> of the node. A left NULL pointer points to the inorder predecessor.</p><p><strong>Rule:</strong> Right-thread = Inorder Successor. Left-thread = Inorder Predecessor.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tree');

-- Q25 — AVL max height (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='avl-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'What is the minimum number of nodes ($N_h$) in an AVL tree of height $h=4$? (Assume a tree with a single node has height $h=0$)',
  '7',
  '12',
  '14',
  '20',
  'B',
  '<p><strong>✓ Answer: B — 12.</strong></p><p><strong>Step-by-step:</strong> The minimum number of nodes for an AVL tree of height $h$ follows the Fibonacci-like recurrence: $N_h = N_{h-1} + N_{h-2} + 1$.<br>- $h=0$: 1 node<br>- $h=1$: 2 nodes (root + 1 child)<br>- $h=2$: $N_1 + N_0 + 1 = 2 + 1 + 1 = 4$<br>- $h=3$: $N_2 + N_1 + 1 = 4 + 2 + 1 = 7$<br>- $h=4$: $N_3 + N_2 + 1 = 7 + 4 + 1 = 12$<br>So an AVL tree of height 4 needs exactly 12 nodes to be minimally populated (which maximizes height for a given number of nodes).</p><p><strong>GATE trap:</strong> Always clarify if height 0 means 1 node or 0 nodes. In GATE, usually an empty tree has height -1, and a single root has height 0. The progression is 1, 2, 4, 7, 12, 20...</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('avl-tree');

-- Q26 — O(n) Build Heap (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='build-heap' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The `Build-Heap` function converts an unsorted array of size $n$ into a Max-Heap. What is its time complexity, and which heapify direction does it use?',
  '$\mathcal{O}(n \log n)$ using Up-Heapify',
  '$\mathcal{O}(n \log n)$ using Down-Heapify',
  '$\mathcal{O}(n)$ using Up-Heapify',
  '$\mathcal{O}(n)$ using Down-Heapify',
  'D',
  '<p><strong>✓ Answer: D — $\mathcal{O}(n)$ using Down-Heapify.</strong></p><p><strong>Step-by-step:</strong> `Build-Heap` is highly optimized. It starts from the last internal node (index $\lfloor n/2 \rfloor$) and goes down to 1, calling `Down-Heapify` (or `Max-Heapify`) on each node. <br>Because nodes at the bottom have height 0, they take no work. Nodes at height 1 take 1 step, etc. The sum $\sum_{h=0}^{\log n} \frac{n}{2^{h+1}} h$ converges to $\mathcal{O}(n)$, heavily leveraging the fact that most nodes are at the bottom of the tree.</p><p><strong>Why wrong:</strong> Using `Up-Heapify` (successive insertions) from an empty heap takes $\mathcal{O}(n \log n)$ because most nodes are inserted at the bottom where up-heapify takes maximum $\mathcal{O}(\log n)$ time.</p><p><strong>Rule:</strong> Bottom-up Build-Heap = $\mathcal{O}(n)$. Successive Insertions = $\mathcal{O}(n \log n)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('heap','time-complexity');

-- Q27 — Maximum number of nodes in a Binary Tree (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='binary-tree-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the maximum number of nodes in a binary tree of height $h$ (where root is at height 0)?',
  '$2^h$',
  '$2^h - 1$',
  '$2^{h+1} - 1$',
  '$2^{h+1}$',
  'C',
  '<p><strong>✓ Answer: C — $2^{h+1} - 1$.</strong></p><p><strong>Rationale:</strong><br>Level 0 (height 0) has 1 node ($2^0$).<br>Level 1 has 2 nodes ($2^1$).<br>... Level $h$ has $2^h$ nodes.<br>The sum of the geometric series $1 + 2 + 4 + ... + 2^h = 2^{h+1} - 1$. This defines a Perfect Binary Tree.</p><p><strong>GATE trap:</strong> Be very careful if the question states "Assume root is at height 1". If height 1, then the max nodes is $2^h - 1$. Always check the base convention first.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tree');

-- Q28 — Priority Queue implementation (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='priority-queues' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'When implementing a Priority Queue, which underlying data structure provides the optimal balance of $\mathcal{O}(\log n)$ for BOTH Insertion and Extract-Max/Min operations?',
  'Unsorted Array',
  'Sorted Array',
  'Binary Heap',
  'Binary Search Tree',
  'C',
  '<p><strong>✓ Answer: C — Binary Heap.</strong></p><p><strong>Rationale:</strong><br>- Unsorted Array: Insert $\mathcal{O}(1)$, Extract $\mathcal{O}(n)$.<br>- Sorted Array: Insert $\mathcal{O}(n)$, Extract $\mathcal{O}(1)$.<br>- BST: Insert/Extract $\mathcal{O}(\log n)$ average, but $\mathcal{O}(n)$ worst-case if the tree becomes skewed.<br>- Binary Heap (or AVL/Red-Black tree): guarantees $\mathcal{O}(\log n)$ worst-case for both. A Heap is preferred over AVL because it requires fewer pointers, uses contiguous memory (array-backed), and has a lower constant factor (no rotations).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('heap','time-complexity');

-- Q29 — Heap Extract Min (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='heap-operations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'During an <code>Extract-Min()</code> operation on a Min-Heap of size $n$, after removing the root, how is the hole filled?',
  'The second smallest element is artificially pulled to the root',
  'The last leaf element is moved to the root, and then Down-Heapified',
  'The heap is fully rebuilt in $\mathcal{O}(n)$ time',
  'The hole is bubbled down, and then filled with the last element',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Step-by-step:</strong><br>1. Store the root value (to return it).<br>2. Take the very last element in the array (bottom right-most leaf) and place it at the root.<br>3. This violates the heap property at the root. Call `Min-Heapify(root)` (also called bubble-down or sift-down).<br>4. The element swaps with its SMALLEST child repeatedly until it finds a valid spot, completing in $\mathcal{O}(\log n)$ time. The array size is decremented by 1.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('heap');

-- Q30 — BST deletion (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bst-operations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'When deleting a node with TWO children in a Binary Search Tree, what is the standard replacement procedure?',
  'Replace the node with its Left Child and attach the Right Child to the bottom',
  'Replace the node with its Inorder Predecessor or Inorder Successor',
  'Promote the larger of its two children to its position',
  'The tree must be completely rebalanced using rotations',
  'B',
  '<p><strong>✓ Answer: B — Replace the node with its Inorder Predecessor or Successor.</strong></p><p><strong>Step-by-step:</strong> To delete a node X with two children, you cannot just pull one child up without violating structural completeness or BST properties. Instead:<br>1. Find X''s inorder successor (the smallest node in the right subtree) OR inorder predecessor (largest in left subtree).<br>2. Copy the value of that successor over X''s value.<br>3. Recursively delete the successor node. (Since the successor is the smallest in a right subtree, it is guaranteed to have NO left child, making its deletion trivial (case 0 or 1 child)).</p><p><strong>GATE trap:</strong> Replacing a node with its successor does not require moving pointers of X, just replacing its data, then deleting the easy-to-delete successor node.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bst');

-- Part 3 complete.
