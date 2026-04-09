-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — OS PYQ SEED v2  (Part 5 / 8)
-- NAT Questions Q46–Q55 (Numerical Calculations)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q46 — SRTF waiting time for P1 (medium)
-- SRTF trace: P1 runs [0-1]. P2 (burst=2) preempts at t=1. P2 runs [1-3].
-- At t=3: P1 remaining=4, P3 remaining=4 (tie → FCFS → P1 first).
-- P1 runs [3-7], P3 runs [7-11].
-- P1: Turnaround = 7-0 = 7. Waiting = 7 - 5 = 2.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='scheduling' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'Processes P1, P2, P3 arrive at times t=0, t=1, t=2 respectively, with CPU burst times 5, 2, 4. Using SRTF (preemptive SJF), what is the waiting time of process P1?',
  2.00,2.00,NULL,
  '<p><strong>✓ Answer: 2.</strong></p><p><strong>Rationale:</strong> P1 runs [0-1]. At t=1, P2 (burst=2) preempts P1 (remaining=4). P2 runs [1-3]. At t=3, tie between P1 and P3 (both remaining=4) — FCFS breaks tie in P1''s favour. P1 runs [3-7], P3 runs [7-11]. P1 Turnaround = 7 - 0 = 7. P1 Waiting = 7 - 5 = <strong>2</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('scheduling');

-- Q47 — Single-level page table entry count (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='paging' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A system uses 32-bit logical addresses with a page size of 4 KB. How many entries does the single-level page table contain?',
  1048576.00,1048576.00,NULL,
  '<p><strong>✓ Answer: 1,048,576.</strong></p><p><strong>Rationale:</strong> Page offset = log₂(4KB) = 12 bits. Page number bits = 32 - 12 = 20 bits. Number of entries = 2²⁰ = 1,048,576.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q48 — Semaphore final value (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sync-tools' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'A counting semaphore is initialized to 8. Subsequently, 12 P (wait) operations and 5 V (signal) operations are executed. What is the final semaphore value?',
  1.00,1.00,NULL,
  '<p><strong>✓ Answer: 1.</strong></p><p><strong>Rationale:</strong> S = Initial + V_count - P_count = 8 + 5 - 12 = 1.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('semaphores');

-- Q49 — FCFS disk head movement (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'Disk request queue (in order): [98, 183, 37, 122, 14, 124, 65, 67]. Initial head position: 53. Using FCFS, calculate the total head movement in cylinders.',
  640.00,640.00,NULL,
  '<p><strong>✓ Answer: 640.</strong></p><p><strong>Rationale:</strong> |98-53|=45, |183-98|=85, |37-183|=146, |122-37|=85, |14-122|=108, |124-14|=110, |65-124|=59, |67-65|=2. Total = 45+85+146+85+108+110+59+2 = <strong>640</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q50 — Banker's available resources (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bankers' LIMIT 1),
  'gate-cse',false,NULL,'NAT','hard',2,
  'A system has 10 total units of resource R. Process allocations: P1 holds 3, P2 holds 2, P3 holds 2. How many units of R are currently available?',
  3.00,3.00,NULL,
  '<p><strong>✓ Answer: 3.</strong></p><p><strong>Rationale:</strong> Total allocated = 3 + 2 + 2 = 7. Available = 10 - 7 = <strong>3</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('deadlock');

-- Q51 — Max N processes deadlock-free (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='deadlock-concept' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A system has 13 tape drives. Each process needs a maximum of 3 tape drives. What is the maximum number of processes N that guarantees the system is deadlock-free?',
  6.00,6.00,NULL,
  '<p><strong>✓ Answer: 6.</strong></p><p><strong>Rationale:</strong> Worst case: each process holds (max-1) = 2 drives. With N processes: 2N drives held. Need at least 1 free to guarantee progress: 2N + 1 ≤ 13 → N ≤ 6.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('deadlock');

-- Q52 — Effective Memory Access Time with TLB (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='paging' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'TLB access time = 20 ns. Memory access time = 100 ns. TLB hit ratio = 80%. What is the Effective Memory Access Time (EMAT) in nanoseconds?',
  140.00,140.00,NULL,
  '<p><strong>✓ Answer: 140 ns.</strong></p><p><strong>Rationale:</strong> TLB Hit path: 20 + 100 = 120 ns. TLB Miss path: 20 + 100 (PT) + 100 (data) = 220 ns. EMAT = 0.8×120 + 0.2×220 = 96 + 44 = <strong>140 ns</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tlb');

-- Q53 — FIFO page faults (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='page-replacement' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'Reference string: 1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5. With 3 frames (initially empty), how many page faults occur using FIFO?',
  9.00,9.00,NULL,
  '<p><strong>✓ Answer: 9.</strong></p><p><strong>Rationale:</strong> Trace: 1(F), 2(F), 3(F), 4(F,evict 1), 1(F,evict 2), 2(F,evict 3), 5(F,evict 4), 1(H), 2(H), 3(F,evict 5), 4(F,evict 1), 5(F,evict 2). Total faults = <strong>9</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q54 — fork() return in child (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='system-calls' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'A C program executes `pid_t x = fork();`. The parent PID is 4050; the child''s PID is 4051. What is the value of variable `x` inside the child process?',
  0.00,0.00,NULL,
  '<p><strong>✓ Answer: 0.</strong></p><p><strong>Rationale:</strong> `fork()` always returns 0 to the child process, and returns the child''s PID to the parent process.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('process');

-- Q55 — FCFS completion time (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='scheduling' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'Three processes P1, P2, P3 all arrive at t=0 (in FCFS order). CPU burst times: P1=10, P2=5, P3=8. What is the completion time (turnaround time) of P2?',
  15.00,15.00,NULL,
  '<p><strong>✓ Answer: 15.</strong></p><p><strong>Rationale:</strong> FCFS order: P1 runs [0-10], P2 runs [10-15]. P2 completes at t=<strong>15</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('scheduling');

-- Part 5 Complete.
