-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — OS PYQ SEED v2  (Part 3 / 8)
-- MCQ Questions Q15–Q28 (Concurrency & Deadlocks)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — Semaphore atomic operations (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sync-tools' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A counting semaphore is manipulated exclusively through which two atomic operations?',
  'Wait (P) and Signal (V)',
  'Push and Pop',
  'Lock and Unlock',
  'Read and Write',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Semaphores expose only two atomic primitives: wait/P (decrement; block if negative) and signal/V (increment; wake a blocked process).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('semaphores');

-- Q16 — Mutex ownership property (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sync-tools' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What key property does a Mutex lock have that a general counting semaphore does NOT?',
  'A different process can release the semaphore than the one that acquired it',
  'The lock can only be released by the same thread/process that acquired it (ownership)',
  'Mutex supports integer values greater than 1',
  'Mutex does not require atomic operations',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A Mutex enforces ownership — only the entity that locked it may unlock it. A counting semaphore has no such constraint; any process may call signal/V.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('semaphores');

-- Q17 — Coffman conditions (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='deadlock-concept' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Deadlock requires all four Coffman conditions to hold simultaneously. Which of the following is NOT one of the four Coffman conditions?',
  'Mutual Exclusion',
  'Hold and Wait',
  'Aging',
  'Circular Wait',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The four Coffman conditions are: Mutual Exclusion, Hold and Wait, No Preemption, and Circular Wait. Aging is a scheduling anti-starvation technique, not a deadlock condition.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('deadlock');

-- Q18 — Banker's Algorithm goal (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bankers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The Banker''s Algorithm is a classic OS technique used to achieve:',
  'Deadlock Prevention',
  'Deadlock Avoidance',
  'Deadlock Detection and Recovery',
  'Priority Inversion resolution',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Banker''s Algorithm avoids deadlock by checking whether granting a resource request would leave the system in a safe state before actually allocating the resource.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('deadlock');

-- Q19 — Monitor abstraction (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sync-tools' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A high-level programming language construct that encapsulates shared data with guaranteed mutual exclusion is called a:',
  'Semaphore',
  'Mutex',
  'Monitor',
  'Condition Variable',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> A Monitor wraps shared variables inside a structured construct (like Java''s `synchronized` block) ensuring at most one thread executes inside at any time.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('semaphores');

-- Q20 — Readers-Writers problem rule (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='classical-problems' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the Classical Readers-Writers problem, which concurrency rule preserves database integrity?',
  'Multiple writers may write to the database simultaneously',
  'Multiple readers may read concurrently only when no writer is active',
  'A reader always preempts an active writer',
  'Writers do not need to acquire any locks',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Concurrent reads are safe (no data changes). However, a write operation requires exclusive access — blocking all other readers and writers to prevent data corruption.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('semaphores');

-- Q21 — Negative semaphore meaning (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sync-tools' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'In a counting semaphore implementation that allows negative values, what does a value of $S = -N$ signify?',
  'N additional resources are currently available',
  'N processes are currently blocked waiting on this semaphore',
  'A kernel panic has occurred',
  'The semaphore has been corrupted',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> When $S < 0$, its absolute value $|S|$ gives the count of processes blocked in the semaphore''s waiting queue.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('semaphores');

-- Q22 — Circular Wait prevention (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='deadlock-concept' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Requiring all processes to request resources in a fixed global ordering (e.g., always acquire R1 before R2) eliminates which Coffman condition?',
  'Mutual Exclusion',
  'Hold and Wait',
  'No Preemption',
  'Circular Wait',
  'D',
  '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> A strict global acquisition ordering ensures no circular dependency can form, directly eliminating the Circular Wait condition.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('deadlock');

-- Q23 — Thrashing definition (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='virtual' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A system that spends more time swapping pages in and out of disk than executing actual user instructions is experiencing:',
  'Deadlock',
  'Thrashing',
  'Belady''s Anomaly',
  'Cache pollution',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Thrashing occurs when processes lack sufficient frames for their working sets, causing constant page faults that consume all CPU bandwidth.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q24 — TLB purpose (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='paging' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The Translation Lookaside Buffer (TLB) is a hardware cache that accelerates which operation?',
  'Disk block to memory transfer',
  'Logical address to physical address translation',
  'CPU register file access',
  'Semaphore queue management',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The TLB stores recently used page table entries, enabling fast logical→physical address translation without accessing the main memory page table on every reference.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tlb');

-- Q25 — Segmentation vs Paging (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='segmentation' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Unlike paging which uses fixed-size blocks, segmentation divides memory into:',
  'Fixed 4KB pages',
  'Variable-size logical units based on program structure',
  'Linear byte-addressable vectors',
  'Circular linked lists',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Segmentation reflects the programmer''s view of memory — code, stack, heap — each with a different size. This causes external but not internal fragmentation.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q26 — Safe State in Banker's (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bankers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the Banker''s Algorithm, a system is in a "Safe State" if:',
  'All processes have zero remaining resource needs',
  'There exists at least one execution sequence where all processes can complete using available resources',
  'The available resource pool is larger than the maximum demand of any process',
  'No process is currently waiting for a resource',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A safe state guarantees existence of a safe sequence — an ordering $P_1, P_2, ..., P_n$ in which each process can obtain its remaining needs from the current available pool.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('deadlock');

-- Q27 — Spinlock best use case (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sync-tools' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Spinlocks use busy-waiting instead of blocking. They are most beneficial in which scenario?',
  'Uniprocessor systems with long critical sections',
  'Multiprocessor systems where the critical section is very short',
  'Systems with deeply nested lock hierarchies',
  'Situations requiring priority inheritance',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> On multiprocessors, a short critical section may finish before a context switch completes. Spinning for microseconds is cheaper than the overhead of a full block/wake cycle.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('semaphores');

-- Q28 — Dining Philosophers purpose (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='classical-problems' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The Dining Philosophers problem is a classical OS synchronization problem that models:',
  'Memory fragmentation scenarios',
  'Disk scheduling fairness',
  'Resource allocation that avoids both deadlock and starvation among competing processes',
  'Cache coherency in multiprocessor systems',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Five philosophers share five forks — a model for designing protocols that correctly handle concurrent resource acquisition without deadlock or starvation.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('deadlock');

-- Part 3 Complete.
