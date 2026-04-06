-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DSA PYQ SEED v2  (Part 1 / 8)
-- Subject : Data Structures & Algorithms | Exam: gate-cse | Branch: cse
-- Schema  : v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- ═══════════════════════════════════════════════════════════════════════════
BEGIN;

-- ── Subject ───────────────────────────────────────────────────────────────
INSERT INTO subjects (slug,name,category,branch_slug,icon,order_index,is_published,exam_weight_pct)
VALUES ('dsa','Data Structures & Algorithms','GATE','cse','🌲',2,true,12)
ON CONFLICT (slug) DO NOTHING;

-- ── Chapters (7) ─────────────────────────────────────────────────────────
INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dsa'), 'Arrays, Strings & Hashing', 'arrays-strings-hashing', 1, 90, true, 'medium'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='arrays-strings-hashing');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dsa'), 'Linked Lists', 'linked-lists', 2, 60, true, 'medium'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='linked-lists');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dsa'), 'Stacks & Queues', 'stacks-queues', 3, 75, true, 'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='stacks-queues');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dsa'), 'Trees & BST', 'trees-bst', 4, 120, true, 'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='trees-bst');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dsa'), 'AVL & Heaps', 'avl-heaps', 5, 90, true, 'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='avl-heaps');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dsa'), 'Graphs', 'graphs', 6, 120, true, 'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='graphs');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='dsa'), 'Sorting & Divide and Conquer', 'sorting', 7, 90, true, 'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='sorting');

-- ── SECTION 0: TAGS ──────────────────────────────────────────────────────
INSERT INTO tags (slug,name) VALUES
  ('array',            'Arrays'),
  ('string',           'Strings'),
  ('hashing',          'Hashing'),
  ('linked-list',      'Linked Lists'),
  ('stack',            'Stacks'),
  ('queue',            'Queues'),
  ('recursion',        'Recursion'),
  ('tree',             'Trees'),
  ('bst',              'Binary Search Tree'),
  ('avl-tree',         'AVL Trees'),
  ('avl-rotations',    'AVL Rotations'),
  ('heap',             'Heaps'),
  ('graph',            'Graphs'),
  ('bfs',              'Breadth-First Search'),
  ('dfs',              'Depth-First Search'),
  ('dijkstra',         'Dijkstra Algorithm'),
  ('bellman-ford',     'Bellman-Ford Algorithm'),
  ('kruskal',          'Kruskal Algorithm'),
  ('prim',             'Prim Algorithm'),
  ('topological-sort', 'Topological Sort'),
  ('sorting',          'Sorting Algorithms'),
  ('master-theorem',   'Master Theorem'),
  ('divide-conquer',   'Divide and Conquer'),
  ('time-complexity',  'Time Complexity')
ON CONFLICT (slug) DO NOTHING;

-- ── SECTION 1: TOPICS ────────────────────────────────────────────────────
-- Chapter: arrays-strings-hashing (6 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),'1D and 2D Arrays','1d-2d-arrays',1),
  ((SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),'Row/Column Major Ordering','row-col-major',2),
  ((SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),'String Matching (Naive)','string-matching',3),
  ((SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),'Hash Functions & Collisions','hash-functions',4),
  ((SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),'Chaining vs Open Addressing','chaining-open-addressing',5),
  ((SELECT id FROM chapters WHERE slug='arrays-strings-hashing' LIMIT 1),'Hashing Complexity Analysis','hashing-analysis',6);

-- Chapter: linked-lists (6 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='linked-lists' LIMIT 1),'Singly Linked Lists','singly-ll',1),
  ((SELECT id FROM chapters WHERE slug='linked-lists' LIMIT 1),'Doubly & Circular Linked Lists','doubly-circular-ll',2),
  ((SELECT id FROM chapters WHERE slug='linked-lists' LIMIT 1),'Insert/Delete Operations','insert-delete-ll',3),
  ((SELECT id FROM chapters WHERE slug='linked-lists' LIMIT 1),'LL Traversal & Reversal','traversal-reversal-ll',4),
  ((SELECT id FROM chapters WHERE slug='linked-lists' LIMIT 1),'Cycle Detection','cycle-detection-ll',5),
  ((SELECT id FROM chapters WHERE slug='linked-lists' LIMIT 1),'Merging & Intersecting Lists','merging-intersecting-ll',6);

-- Chapter: stacks-queues (6 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),'Stack Operations & Array/LL Implementation','stack-implementation',1),
  ((SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),'Infix, Prefix, and Postfix Expressions','expressions-stack',2),
  ((SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),'Queue Operations & Linear/Circular Queue','queue-implementation',3),
  ((SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),'Double Ended Queues (Deq)','deque',4),
  ((SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),'Stack/Queue using Queues/Stacks','stack-queue-interconversion',5),
  ((SELECT id FROM chapters WHERE slug='stacks-queues' LIMIT 1),'Recursion & Call Stack','recursion-call-stack',6);

-- Chapter: trees-bst (6 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),'Binary Trees: Terminology & Properties','binary-tree-properties',1),
  ((SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),'Tree Traversals (In/Pre/Post/Level)','tree-traversals',2),
  ((SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),'Binary Search Trees (BST) Properties','bst-properties',3),
  ((SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),'BST Insert, Search, and Delete','bst-operations',4),
  ((SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),'Threaded Binary Trees','threaded-bt',5),
  ((SELECT id FROM chapters WHERE slug='trees-bst' LIMIT 1),'Constructing Trees from Traversals','tree-construction',6);

-- Chapter: avl-heaps (6 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),'AVL Tree Properties & Height Limits','avl-properties',1),
  ((SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),'AVL Rotations (LL, RR, LR, RL)','avl-rotations',2),
  ((SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),'Min & Max Heap Properties','heap-properties',3),
  ((SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),'Heap Insert & Extract (Up/Down Heapify)','heap-operations',4),
  ((SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),'Building a Heap (O(n))','build-heap',5),
  ((SELECT id FROM chapters WHERE slug='avl-heaps' LIMIT 1),'Priority Queues using Heaps','priority-queues',6);

-- Chapter: graphs (8 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),'Graph Representations (Adj Matrix/List)','graph-representations',1),
  ((SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),'Breadth-First Search (BFS)','bfs-topic',2),
  ((SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),'Depth-First Search (DFS) & Articulation Points','dfs-topic',3),
  ((SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),'Topological Sort','topological-sorting',4),
  ((SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),'Minimum Spanning Trees: Prim algorithm','prim-mst',5),
  ((SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),'Minimum Spanning Trees: Kruskal & Disjoint Sets','kruskal-mst',6),
  ((SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),'Shortest Path: Dijkstra algorithm','dijkstra-sp',7),
  ((SELECT id FROM chapters WHERE slug='graphs' LIMIT 1),'Shortest Path: Bellman-Ford algorithm','bellman-ford-sp',8);

-- Chapter: sorting (6 topics)
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),'Insertion, Selection, and Bubble Sort','elementary-sorting',1),
  ((SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),'Merge Sort & Quick Sort','divide-conquer-sorting',2),
  ((SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),'Heap Sort','heapsort',3),
  ((SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),'Complexity & Stability of Sorting algorithms','sorting-comparisons',4),
  ((SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),'Divide and Conquer Paradigm','divide-conquer-paradigm',5),
  ((SELECT id FROM chapters WHERE slug='sorting' LIMIT 1),'Master Theorem & Recurrence Relations','master-theorem',6);

-- Part 1 complete.
