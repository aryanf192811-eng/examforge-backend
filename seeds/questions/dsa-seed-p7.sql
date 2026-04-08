-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DSA PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1 (25 Cards: Arrays, LL, Stacks, Queues, Trees, Heaps)
-- ═══════════════════════════════════════════════════════════════════════════

-- ─── Section: Arrays, LL, Stacks, Queues (12 cards) ──────────────────────
INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='row-col-major' LIMIT 1),
  'What is the formula for the memory address of A[i][j] in a row-major 2D array?',
  '<p><strong>Row-Major Address:</strong><br><code>Address = Base + W × [(i - Lr) × cols + (j - Lc)]</code></p><p>Where:<br>- <code>W</code> = size of element in bytes<br>- <code>Lr</code>, <code>Lc</code> = lower bounds for row and col<br>- <code>cols</code> = total columns (Uc - Lc + 1)</p>',
  ARRAY['array']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='chaining-open-addressing' LIMIT 1),
  'Compare Primary Clustering and Secondary Clustering in Hash Tables.',
  '<p><strong>Primary Clustering:</strong> Long runs of occupied slots build up, increasing probe delays. Happens in <em>Linear Probing</em>.</p><p><strong>Secondary Clustering:</strong> Keys hashing to the same initial slot follow the exact same probe sequence. Happens in <em>Quadratic Probing</em>.</p><p><strong>Solution:</strong> <em>Double Hashing</em> solves both by using a second hash function to define the step size uniquely for each key.</p>',
  ARRAY['hashing']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='hashing-analysis' LIMIT 1),
  'Define the Load Factor ($\alpha$) of a Hash Table.',
  '<p><strong>Load factor ($\alpha$):</strong> $\alpha = \frac{n}{m}$</p><p>Where <code>n</code> = number of elements stored, and <code>m</code> = number of slots in the hash table.</p><p>In <strong>Separate Chaining</strong>, $\alpha$ is the average length of a chain, and can be $>1$.<br>In <strong>Open Addressing</strong>, $\alpha$ is the fraction of table filled, so $0 \le \alpha \le 1$.</p>',
  ARRAY['hashing','time-complexity']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='linked-lists' LIMIT 1),
  (SELECT id FROM topics WHERE slug='insert-delete-ll' LIMIT 1),
  'Why is deleting the *last* element of a Singly Linked List $\mathcal{O}(n)$, even if we have a Tail pointer?',
  '<p>To delete the last element, the new tail must become the second-to-last node. We need to set the second-to-last node''s <code>next</code> pointer to NULL.</p><p>In a singly linked list, there are no backward pointers, so we must traverse from the <code>head</code> all the way to the end to find that second-to-last node, taking <strong>$\mathcal{O}(n)$ time</strong>.</p>',
  ARRAY['linked-list','time-complexity']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='linked-lists' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cycle-detection-ll' LIMIT 1),
  'How does Floyd''s Cycle-Finding Algorithm (Tortoise and Hare) find the START node of a cycle?',
  '<p>1. Move <code>slow</code> exactly 1 step, and <code>fast</code> exactly 2 steps until they collide.<br>2. When they collide, place one pointer back at the <code>head</code> of the list, keeping the other at the collision point.<br>3. Move BOTH pointers 1 step at a time.<br>4. The node where they meet next is exactly the <strong>start of the cycle</strong>.</p>',
  ARRAY['linked-list']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),
  (SELECT id FROM topics WHERE slug='expressions-stack' LIMIT 1),
  'What is the structure of Infix, Prefix, and Postfix expressions?',
  '<p>Assume Operand A, Operand B, Operator +</p><ul><li><strong>Infix:</strong> <code>A + B</code> (Operator between operands. Requires parens/precedence).</li><li><strong>Prefix (Polish):</strong> <code>+ A B</code> (Operator before operands. Evaluated right-to-left usually).</li><li><strong>Postfix (Reverse Polish):</strong> <code>A B +</code> (Operator after operands. Evaluated left-to-right using a stack natively).</li></ul><p>Postfix and Prefix need NO parentheses!</p>',
  ARRAY['stack']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),
  (SELECT id FROM topics WHERE slug='stack-implementation' LIMIT 1),
  'What is the formula for calculating Catalan Numbers?',
  '<p>Catalan Number $C_n$:<br><strong>$C_n = \frac{1}{n+1} \binom{2n}{n}$</strong></p><p>Applications for $n$ items:<br>- Number of valid stack output permutations<br>- Number of structurally unique Binary Search Trees<br>- Number of balanced parenthesis sequences</p><p><em>Sequence for $n=0, 1, 2, 3, 4, 5$: 1, 1, 2, 5, 14, 42</em></p>',
  ARRAY['stack','tree','bst']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),
  (SELECT id FROM topics WHERE slug='queue-implementation' LIMIT 1),
  'In a Circular Queue implemented using an array of size N, what are the conditions for Empty and Full?',
  '<p>Assume pointers <code>front</code> and <code>rear</code> (where rear is the last inserted element).</p><ul><li><strong>Initial State:</strong> <code>front = -1, rear = -1</code></li><li><strong>Empty Condition:</strong> <code>front == -1</code></li><li><strong>Full Condition:</strong> <code>(rear + 1) % N == front</code></li></ul><p><em>Note: This inherently wastes exactly 1 array slot to definitively distinguish Full from Empty if we don''t use a separate counter.</em></p>',
  ARRAY['queue']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),
  (SELECT id FROM topics WHERE slug='stack-queue-interconversion' LIMIT 1),
  'How do you implement a Queue using 2 Stacks to achieve $\mathcal{O}(1)$ Amortized time?',
  '<p>Let Stacks be <code>S_in</code> and <code>S_out</code>.</p><p><strong>Enqueue(x):</strong> Push <code>x</code> onto <code>S_in</code>. ($\mathcal{O}(1)$)</p><p><strong>Dequeue():</strong><br>1. If <code>S_out</code> is empty, pop ALL elements from <code>S_in</code> and push them into <code>S_out</code>. ($\mathcal{O}(N)$ worst-case, $\mathcal{O}(1)$ amortized).<br>2. Pop and return top element from <code>S_out</code>. ($\mathcal{O}(1)$).</p>',
  ARRAY['queue','stack','time-complexity']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='chaining-open-addressing' LIMIT 1),
  'What is the formula for Open Addressing Double Hashing?',
  '<p>The probe sequence generated by Double Hashing is:</p><p><strong>$H(k, i) = (h_1(k) + i \times h_2(k)) \bmod m$</strong></p><p>Where <code>i</code> is the attempt number (0, 1, 2...).<br><em>Crucial Rule:</em> To ensure the probe sequence visits every table slot, $h_2(k)$ MUST be relatively prime to the table size $m$.</p>',
  ARRAY['hashing']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='linked-lists' LIMIT 1),
  (SELECT id FROM topics WHERE slug='doubly-circular-ll' LIMIT 1),
  'What are the advantages of a Doubly Linked List over a Singly Linked List?',
  '<p><strong>Pros of Doubly LL:</strong><br>- Can traverse in both directions (forward and backward).<br>- Deleting a specific node pointer is $\mathcal{O}(1)$ because you have direct access to its predecessor (via <code>prev</code>), unlike Singly LL which takes $\mathcal{O}(N)$ to find the predecessor.<br>- Insertions before a given node are $\mathcal{O}(1)$.</p><p><strong>Cons:</strong><br>- Extra memory per node for the <code>prev</code> pointer.</p>',
  ARRAY['linked-list','time-complexity']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),
  (SELECT id FROM topics WHERE slug='deque' LIMIT 1),
  'What is an Input Restricted Deque?',
  '<p>A standard <strong>Double-Ended Queue (Deque)</strong> allows insertions and deletions at both the <code>front</code> and the <code>rear</code>.</p><p>An <strong>Input-Restricted Deque</strong> restricts insertion to only ONE end, but still allows deletion from BOTH ends.</p><p>An <strong>Output-Restricted Deque</strong> allows insertion at BOTH ends, but restricts deletion to only ONE end.</p>',
  ARRAY['queue']
);

-- ─── Section: Trees, BST, AVL, Heaps (13 cards) ────────────────────────
INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='binary-tree-properties' LIMIT 1),
  'Compare Full, Complete, and Perfect Binary Trees.',
  '<p><strong>Full (Strictly Binary):</strong> Every node has exactly 0 or 2 children.</p><p><strong>Complete:</strong> Every level except possibly the last is fully filled, and all nodes are as far left as possible (e.g., standard Heaps).</p><p><strong>Perfect:</strong> All interior nodes have 2 children, and all leaves are exactly at the same level depth. Total nodes = $2^{h+1} - 1$.</p>',
  ARRAY['tree']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tree-traversals' LIMIT 1),
  'Given an expression tree, how do you extract the Prefix, Infix, and Postfix expressions?',
  '<p>Traverse the tree!<br>- <strong>Preorder Traversal:</strong> Yields the <em>Prefix</em> expression.<br>- <strong>Inorder Traversal:</strong> Yields the <em>Infix</em> expression.<br>- <strong>Postorder Traversal:</strong> Yields the <em>Postfix</em> expression.</p>',
  ARRAY['tree','stack']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tree-construction' LIMIT 1),
  'How many unique binary trees can be constructed given ONLY a preorder traversal sequence of N nodes?',
  '<p>A pre/in/post order traversal string alone can map to multiple valid binary shape structures. The number of strictly unique unlabeled binary tree shapes for N nodes is the <strong>N-th Catalan Number</strong>.</p><p>Because the preorder sequence forces only one node arrangement into each shape layout, there are exactly <strong>$C_n = \frac{1}{n+1} \binom{2n}{n}$</strong> unique binary trees that yield that exact preorder (or postorder, or inorder) sequence.</p>',
  ARRAY['tree','recursion']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bst-operations' LIMIT 1),
  'How do you delete a node with TWO children in a Binary Search Tree (BST)?',
  '<p>1. Find the node''s <strong>Inorder Successor</strong> (the minimum value in its right subtree).<br>2. Replace the data of the doomed node with the data of the successor.<br>3. Recursively delete the successor node.</p><p><em>(Alternatively, use the Inorder Predecessor: max value in the left subtree. Both maintain the BST property.)</em></p>',
  ARRAY['bst','tree']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='threaded-bt' LIMIT 1),
  'What are Threaded Binary Trees solving?',
  '<p>In a standard binary tree of <code>N</code> nodes, there are exactly <code>N+1</code> wasted (NULL) pointers at the leaves.</p><p><strong>Explicit Threaded BT:</strong> Replaces those NULL pointers with direct "threads" pointing to the node''s Inorder Predecessor (left thread) or Inorder Successor (right thread).</p><p><strong>Advantage:</strong> Allows fast, non-recursive Inorder traversal without requiring a stack memory overhead.</p>',
  ARRAY['tree']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='avl-properties' LIMIT 1),
  'What is the Balance Factor in an AVL Tree and what are the allowed values?',
  '<p><strong>Balance Factor (BF) = Height(Left Subtree) - Height(Right Subtree)</strong><br><em>(or vice versa depending on convention, just be consistent).</em></p><p>For a node to be AVL balanced, its BF must be strictly <strong>$-1, 0, or +1$</strong>.</p><p>If insertion or deletion pushes BF to $+2$ or $-2$, the tree is unbalanced and requires Rotations.</p>',
  ARRAY['avl-tree']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='avl-rotations' LIMIT 1),
  'What are the 4 cases of AVL Imbalance and their corresponding rotations?',
  '<ol><li><strong>LL Imbalance:</strong> Node inserted into Left subtree of Left child. <em>Fix: exactly ONE Right Rotation (LL Rotation).</em></li><li><strong>RR Imbalance:</strong> Node inserted into Right subtree of Right child. <em>Fix: exactly ONE Left Rotation.</em></li><li><strong>LR Imbalance:</strong> Left subtree, Right child. <em>Fix: Left rotate child, then Right rotate parent.</em></li><li><strong>RL Imbalance:</strong> Right subtree, Left child. <em>Fix: Right rotate child, then Left rotate parent.</em></li></ol>',
  ARRAY['avl-rotations','avl-tree']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='avl-properties' LIMIT 1),
  'What is the Minimum number of nodes $N(h)$ in an AVL tree of height $h$ (max skew)?',
  '<p>The minimum nodes recurrence limits the worst-case depth:</p><p><strong>$N(h) = N(h-1) + N(h-2) + 1$</strong></p><p><em>Values (assuming $h=0$ is 1 node):</em><br>h=0 => 1<br>h=1 => 2<br>h=2 => 4<br>h=3 => 7<br>h=4 => 12<br>This guarantees that AVL max height is tightly bounded to $\approx 1.44 \log_2 N$.</p>',
  ARRAY['avl-tree']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='heap-properties' LIMIT 1),
  'What are the two intrinsic properties defining a Binary Max-Heap?',
  '<p>1. <strong>Structural Property:</strong> It is a <em>Complete Binary Tree</em> (all levels full except possibly the last, filled left-to-right).<br>2. <strong>Ordering Property:</strong> For every node <code>i</code> excluding the root, the value of the node is $\le$ the value of its Parent. (Thus, the Root is the absolute Maximum).</p>',
  ARRAY['heap']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='heap-properties' LIMIT 1),
  'In a 1-indexed array representation of a Heap, how do you find the Parent and Children of index `i`?',
  '<ul><li><strong>Left Child:</strong> <code>2i</code></li><li><strong>Right Child:</strong> <code>2i + 1</code></li><li><strong>Parent:</strong> <code>floor(i / 2)</code></li></ul><p><em>If 0-indexed:</em> Left = <code>2i+1</code>, Right = <code>2i+2</code>, Parent = <code>floor((i-1)/2)</code>.</p>',
  ARRAY['heap']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='heap-operations' LIMIT 1),
  'What are the steps to execute `Extract-Max()` in a Max-Heap?',
  '<p>1. The max element is at the root ($A[1]$). Save it to return.<br>2. Take the very last element in the array ($A[n]$) and move it to the root ($A[1]$). Decrease heap size $n$.<br>3. This corrupts the max-heap property at the root. Call <strong>Max-Heapify(1)</strong> (bubble-down).<br>4. Re-establish balance in $\mathcal{O}(\log n)$ time by swapping with the maximum child repetitively down the tree.</p>',
  ARRAY['heap']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),
  (SELECT id FROM topics WHERE slug='heap-operations' LIMIT 1),
  'What is the difference between `Build-Heap` and repetitive insertions?',
  '<p>Building an entire heap from $N$ unsorted elements:</p><p><strong>Method 1 (Insertions):</strong> Insert $N$ items one-by-one into an empty heap. Each takes $\mathcal{O}(\log N)$. Total time: <strong>$\mathcal{O}(N \log N)$</strong>.</p><p><strong>Method 2 (Build-Heap):</strong> Dump all elements into an array. Loop from node $\lfloor N/2 \rfloor$ down to 1, calling `Max-Heapify(i)` (bottom-up down-heapify). Math proves the total steps converge. Total time: <strong>Strictly $\mathcal{O}(N)$</strong>.</p>',
  ARRAY['heap','time-complexity']
),
(
  (SELECT id FROM subjects WHERE slug='dsa'),
  (SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tree-traversals' LIMIT 1),
  'Which traversal of a Binary Search Tree (BST) visits nodes in Sorted Order?',
  '<p><strong>Inorder Traversal (Left-Root-Right)</strong> of a BST naturally iterates the keys in strictly ascending sorted order.</p><p><em>Reverse-Inorder (Right-Root-Left)</em> iterates them in strictly descending order (very useful to find the k-th largest element).</p>',
  ARRAY['bst','tree']
);

-- Part 7 complete.
