-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — OS PYQ SEED v2 (Part 1 / 8)
-- Subject: Operating Systems (os)
-- ═══════════════════════════════════════════════════════════════════════════

BEGIN;

DO $$ 
DECLARE
 subj_id UUID;
 ch1_id UUID;
 ch2_id UUID;
 ch3_id UUID;
 ch4_id UUID;
BEGIN

 -- 1. Subject Insertion
 INSERT INTO subjects (title, slug, description, gradient_start, gradient_end, icon_type)
 VALUES (
 'Operating Systems', 
 'os', 
 'Process management, concurrency, memory translation, and file systems.', 
 '#3b82f6', '#1d4ed8', 'terminal'
 )
 ON CONFLICT (slug) DO UPDATE 
 SET title = EXCLUDED.title, description = EXCLUDED.description
 RETURNING id INTO subj_id;

 -- 2. Chapters Insertion
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES
 (subj_id, 'Process & Thread Management', 'process-management', 1) RETURNING id INTO ch1_id;
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES
 (subj_id, 'Concurrency & Deadlocks', 'concurrency', 2) RETURNING id INTO ch2_id;
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES
 (subj_id, 'Memory Management', 'memory-management', 3) RETURNING id INTO ch3_id;
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES
 (subj_id, 'Storage & File Systems', 'storage-io', 4) RETURNING id INTO ch4_id;

 -- 3. Topics Insertion
 -- Chapter 1: Process & Thread Management
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'concept', 'Process Concepts & States', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'scheduling', 'CPU Scheduling Algorithms', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'threads', 'User vs Kernel Threads', 3) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'system-calls', 'System Calls & Fork', 4) ON CONFLICT DO NOTHING;

 -- Chapter 2: Concurrency & Deadlocks
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'sync-tools', 'Semaphores & Mutex', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'classical-problems', 'Classical Sync Problems', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'deadlock-concept', 'Deadlock Characterization', 3) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'bankers', 'Banker''s Algorithm', 4) ON CONFLICT DO NOTHING;

 -- Chapter 3: Memory Management
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'paging', 'Paging & TLB', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'segmentation', 'Segmentation', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'virtual', 'Virtual Memory & Page Faults', 3) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'page-replacement', 'Page Replacement Algorithms', 4) ON CONFLICT DO NOTHING;

 -- Chapter 4: Storage & File Systems
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'disk', 'Disk Scheduling', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'file-alloc', 'File Allocation Methods', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'unix-inode', 'UNIX Inodes', 3) ON CONFLICT DO NOTHING;

 -- 4. Global Tags Insertion
 INSERT INTO tags (name, slug) VALUES ('Process', 'process') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Threads', 'threads') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Scheduling', 'scheduling') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Semaphores', 'semaphores') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Deadlock', 'deadlock') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Paging', 'paging') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('TLB', 'tlb') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Disk', 'disk') ON CONFLICT DO NOTHING;

END $$;
-- Part 1 Complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — OS PYQ SEED v2  (Part 2 / 8)
-- MCQ Questions Q1–Q14 (Process & Thread Management)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — Process Running→Ready transition (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='concept' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A process transitions from the Running state to the Ready state when which condition occurs?',
  'An I/O request is issued by the process',
  'The CPU time quantum expires (timer interrupt)',
  'The process finishes execution completely',
  'A software trap occurs',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In a preemptive scheduling environment, a timer interrupt forces the CPU to move the currently executing process from Running back to the Ready queue.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('process');

-- Q2 — fork() return value to parent (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='system-calls' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'When `fork()` executes in UNIX, what value is returned to the parent process?',
  '0',
  '-1 on success',
  'The PID of the newly created child process',
  'The PID of the parent itself',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> A successful `fork()` returns the child''s PID (a positive integer) to the parent, and returns 0 inside the newly created child process.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('process');

-- Q3 — Thread context switch shared data (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='threads' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'During a context switch between two threads of the same process, which component does NOT need to be saved or restored?',
  'Program Counter',
  'CPU Registers',
  'Stack Pointer',
  'Page Tables and Global Memory Space',
  'D',
  '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> Threads within the same process share the identical global memory and page tables. Thread context switches do not require reloading page table registers.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('threads');

-- Q4 — FCFS Convoy Effect (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='scheduling' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which critical limitation is commonly associated with the First-Come-First-Serve (FCFS) CPU scheduling algorithm?',
  'Belady''s Anomaly',
  'Convoy Effect',
  'Thrashing',
  'Starvation of short processes',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> FCFS suffers the Convoy Effect, where many short I/O-bound processes queue behind a single long CPU-bound process, degrading average wait time significantly.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('scheduling');

-- Q5 — SRTF starvation risk (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='scheduling' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The Shortest Remaining Time First (SRTF) scheduler preempts the running process upon arrival of a shorter job. What severe risk does this create?',
  'Total process failure on I/O completion',
  'Indefinite starvation of long CPU-burst processes',
  'Guaranteed system deadlocks',
  'Requirement of exact quantum values',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> SRTF continually preempts in favor of shorter tasks. If short jobs arrive continuously, a long job may wait indefinitely — this is starvation.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('scheduling');

-- Q6 — Round Robin → FCFS limit (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='scheduling' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'As the time quantum of a Round Robin (RR) scheduler approaches infinity, RR degenerates into:',
  'SRTF',
  'SJF (non-preemptive)',
  'First-Come-First-Serve (FCFS)',
  'Multilevel Queue Scheduling',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> An infinite quantum means no timer interruption ever fires. Each process runs to completion before the next, which is exactly FCFS behavior.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('scheduling');

-- Q7 — Many-to-one thread blocking (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='threads' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a Many-to-One thread model, what happens when one user-level thread makes a blocking system call?',
  'Only that specific thread blocks',
  'The OS instantly allocates a new kernel thread',
  'The entire process — including all its sibling user threads — blocks',
  'The thread''s priority is inverted',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> In Many-to-One, the kernel sees only a single OS-level process. A blocking call from any user-level thread causes the OS to block the entire process.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('threads');

-- Q8 — Zombie process definition (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='system-calls' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A process calls `exit()`, but its parent has not yet called `wait()`. What state is this process in?',
  'Orphan',
  'Zombie',
  'Runnable',
  'Blocked',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A zombie process has finished execution but its PCB entry remains in the process table until the parent reads its exit status via `wait()`.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('process');

-- Q9 — PCB purpose (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='concept' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which OS data structure stores the process state, program counter, and CPU register values for a specific process?',
  'File Descriptor Table',
  'Process Control Block (PCB)',
  'Translation Lookaside Buffer (TLB)',
  'Page Directory',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The PCB is the kernel data structure that uniquely characterizes each process, storing all state needed to pause and resume execution.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('process');

-- Q10 — SJF optimal average wait (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='scheduling' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which CPU scheduling algorithm provably minimizes average waiting time when all process burst times are known in advance?',
  'First-Come-First-Serve (FCFS)',
  'Round Robin',
  'Shortest Job First (SJF)',
  'Priority Scheduling with Preemption',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Placing the shortest bursts at the front of the queue minimizes accumulated waiting time for all processes. SJF is provably optimal for average wait time.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('scheduling');

-- Q11 — Dispatcher function (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='concept' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The OS module that physically hands CPU control to the process selected by the short-term scheduler is called the:',
  'Swapper',
  'Dispatcher',
  'Paging Daemon',
  'I/O Governor',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The short-term scheduler selects which process runs next. The Dispatcher does the actual context switch — loading registers, switching modes, and jumping to the correct program location.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('process');

-- Q12 — Priority Inversion remedy (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='scheduling' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Priority Inversion occurs when a low-priority process holds a lock needed by a high-priority process. Which protocol resolves this?',
  'Aging',
  'Priority Inheritance Protocol',
  'Round Robin preemption',
  'Banker''s Algorithm',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Priority Inheritance temporarily elevates the lock-holding low-priority process to the priority level of the waiting high-priority process, allowing it to finish and release the lock quickly.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('scheduling');

-- Q13 — Fork exponential process count (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='system-calls' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A program calls `fork()` exactly 4 times in sequence with no conditionals. How many total processes exist after all four forks complete?',
  '4',
  '8',
  '16',
  '32',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Each `fork()` doubles the process count. Starting with 1 process: after 4 forks = $2^4 = 16$ total processes (including the original parent).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('process');

-- Q14 — Kernel threads vs User threads overhead (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='threads' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Compared to user-level threads, kernel-level threads have which primary disadvantage?',
  'Faster creation and destruction',
  'Inability to run on multiple cores simultaneously',
  'Higher context-switch overhead due to kernel mode transitions',
  'Blocked by a single user-level blocking call',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Kernel threads require system calls (user→kernel mode transitions) for operations like context switching, increasing overhead compared to user-space thread libraries.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('threads');

-- Part 2 Complete.
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
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — OS PYQ SEED v2  (Part 4 / 8)
-- MCQ Questions Q29–Q45 (Memory Management & Storage/IO)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q29 — Internal Fragmentation in paging (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='paging' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A paged memory system suffers from which type of fragmentation?',
  'External Fragmentation only',
  'Internal Fragmentation only',
  'Both Internal and External Fragmentation',
  'Neither Internal nor External Fragmentation',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Paging uses fixed-size frames. If a process does not fill its last frame completely, the unused space within that frame is wasted — this is Internal Fragmentation.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q30 — Best-Fit vs First-Fit allocation (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='paging' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In contiguous variable-partition memory management, which allocation strategy produces the smallest leftover hole after each allocation?',
  'First-Fit',
  'Best-Fit',
  'Worst-Fit',
  'Next-Fit',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Best-Fit selects the smallest hole large enough to satisfy the request, minimizing the leftover fragment at that specific location. However, this tends to create many tiny unusable holes overall.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q31 — Belady's Anomaly (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='page-replacement' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which page replacement algorithm(s) are immune to Belady''s Anomaly?',
  'FIFO',
  'Random Replacement',
  'LRU and Optimal (OPT)',
  'Clock (Second-Chance)',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> LRU and OPT are "Stack Algorithms." For stack algorithms, adding more frames can never cause more page faults — immunity to Belady''s Anomaly is guaranteed.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q32 — Page size trade-offs (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='paging' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'If the OS decreases the page size (e.g., from 4KB to 1KB), what structural trade-off results?',
  'Page table grows larger; internal fragmentation decreases',
  'Page table shrinks; internal fragmentation increases',
  'Page table grows larger; internal fragmentation increases',
  'Page table shrinks; internal fragmentation decreases',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Smaller pages mean more pages exist for the same address space → page table grows. However, the last-page waste per process shrinks → internal fragmentation decreases.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q33 — Optimal (OPT) algorithm strategy (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='page-replacement' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The Optimal (OPT) page replacement algorithm evicts the page that:',
  'Was loaded longest ago',
  'Was used least recently',
  'Will not be used for the longest time in the future',
  'Has the largest page frame number',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> OPT has perfect future knowledge and always evicts the page with the furthest next-use time. It achieves the minimum possible page faults but is unrealizable in practice.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q34 — TLB miss memory accesses (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='virtual' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a paged system with single-level page tables, how many main memory accesses are needed to service a TLB miss and ultimately fetch the data word?',
  'Zero (the TLB handles it)',
  'One',
  'Two',
  'Three',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Access 1: Read the page table entry from main memory to translate the address. Access 2: Read the actual data from the resulting physical address. Total = 2.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tlb','paging');

-- Q35 — Demand paging concept (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='virtual' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Virtual memory systems allow programs larger than physical RAM to execute via which mechanism?',
  'Compressed in-memory caching',
  'Demand paging — loading only active pages into RAM as needed',
  'Compiler-level code size optimization',
  'CPU clock scaling to reduce memory bandwidth',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Demand paging keeps only the currently needed pages in physical frames, swapping in pages from disk on fault and swapping out idle pages to disk.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q36 — SSTF analogous CPU algorithm (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Disk scheduling via SSTF is analogous to which CPU scheduling algorithm?',
  'Priority Scheduling with Preemption',
  'Shortest Job First (SJF)',
  'Round Robin',
  'FCFS',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Both SSTF (disk) and SJF (CPU) always service the locally shortest pending request next. Both achieve lower average service times but suffer from starvation of distant/long requests.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q37 — Disk access time formula (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Total disk access time is the sum of which three components?',
  'Seek Time + File Size + OS Transfer Overhead',
  'Seek Time + Cache Latency + Swap Space Size',
  'Seek Time + Rotational Latency + Transfer Time',
  'Transfer Time + TLB Hit Ratio + Page Fault Rate',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Disk Access Time = Seek Time (head to correct track) + Rotational Latency (drum spin to correct sector) + Transfer Time (streaming bits off the platter).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q38 — SCAN Elevator Algorithm (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The disk scheduling algorithm nicknamed the "Elevator Algorithm" is formally known as:',
  'SSTF',
  'LOOK',
  'SCAN',
  'C-SCAN',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> SCAN moves the disk head from one end to the other, servicing requests on the way, then reverses — exactly like an elevator travelling between floors.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q39 — Unix inode indirect pointers (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='unix-inode' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the UNIX inode structure, which mechanism allows the filesystem to support files much larger than the 12 direct block pointers can address?',
  'Contiguous allocation extension tables',
  'FAT chaining at the end of the inode',
  'Single, Double, and Triple Indirect pointer blocks',
  'In-memory cache stacking only',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Beyond 12 direct blocks, an inode references single, double, and triple indirect blocks — each level adding another layer of indirection to support massive file sizes.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q40 — Contiguous allocation weakness (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='file-alloc' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Contiguous file allocation offers fast sequential access but suffers from which major drawback?',
  'High internal fragmentation',
  'Cannot support file deletion',
  'External fragmentation requiring periodic disk compaction',
  'TLB invalidation on every access',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Storing each file as a contiguous run results in external fragmentation — free space becomes scattered into non-contiguous gaps that cannot satisfy new large file requests.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q41 — FAT as linked allocation (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='file-alloc' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A File Allocation Table (FAT) implements which underlying disk allocation strategy?',
  'Contiguous allocation, stored inline',
  'Linked allocation — with the chain table stored separately in memory',
  'Indexed allocation using inodes',
  'Hashed bucket allocation',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> FAT is linked allocation where the chain of next-block pointers is stored in a centralized table (the FAT) in memory, rather than within each block itself.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q42 — LOOK vs SCAN difference (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What is the key difference between LOOK and SCAN disk scheduling?',
  'LOOK travels all the way to cylinder 0 before reversing; SCAN does not',
  'LOOK reverses direction as soon as there are no more pending requests in the current direction; SCAN always travels to the disk end',
  'LOOK only services requests in one direction',
  'SCAN is a version of LOOK that uses a priority queue',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> SCAN blindly travels to the physical disk end before reversing. LOOK checks whether any pending requests remain further out and reverses early if not, saving unnecessary head movement.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q43 — RAID 1 storage capacity (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'A RAID Level 1 (Mirroring) array uses N identical disks. What is the effective usable storage capacity?',
  'N × disk capacity (full sum)',
  '(N-1) × disk capacity',
  '1 × disk capacity (equivalent to one disk)',
  '(N/2) × disk capacity',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> RAID 1 mirrors every write to all N disks identically. The usable capacity equals only 1 disk''s worth of data, regardless of how many disks are in the mirror set.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q44 — Page fault interrupt trigger (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='virtual' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A Page Fault interrupt is triggered when a process attempts to access a page that:',
  'Is already resident in physical RAM',
  'Exceeds the maximum memory allocation for the process',
  'Is not currently loaded in physical memory (the valid bit is 0)',
  'Has been written to more than a threshold number of times',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The MMU checks the valid/invalid bit of each page table entry. If the bit indicates the page is absent from RAM, it generates a page fault trap, allowing the OS to load the page from disk.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q45 — Pure demand paging characteristic (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='virtual' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Under "pure" demand paging, how many pages are loaded into memory when a process first starts executing?',
  'All pages the process will ever access',
  'Zero pages — the first page fault loads the first needed page',
  'A fixed working set pre-loaded by the OS',
  'Exactly one page — the process entry point',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Pure demand paging loads no pages initially. The very first instruction access triggers a page fault, and from there the OS handles each fault lazily as references occur.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Part 4 Complete.
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
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — OS PYQ SEED v2 (Part 6 / 8)
-- MSQ Questions Q56–Q65 (OS Multi-Select Properties)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q56 — MSQ: Preemptive Schedulers (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='os'), (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1), (SELECT id FROM topics WHERE slug='scheduling' LIMIT 1), 'gate-cse',false,NULL,'MSQ','easy',1, 'Which of the following process scheduling algorithms support preemption? (Select all that apply)', 'Shortest Remaining Time First (SRTF)', 'Round Robin', 'First-Come-First-Serve (FCFS)', 'Shortest Job First (Classic SJF)', ARRAY['A','B'], '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> SRTF and Round Robin preempt running by design based on arrival of shorter jobs or timer expirations. FCFS and base SJF are non-preemptive.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('scheduling');

-- Q57 — MSQ: Deadlock prevention tactics (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='os'), (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1), (SELECT id FROM topics WHERE slug='deadlock-concept' LIMIT 1), 'gate-cse',false,NULL,'MSQ','medium',2, 'To prevent deadlocks, systems can deny standard Coffman conditions. Which designs actively break "Hold and Wait"? (Select all that apply)', 'A process must request and be allocated all necessary resources before beginning execution', 'A process requesting new resources must first release all currently held resources', 'Linearly ordering all resources numerically', 'Killing processes holding locks too long', ARRAY['A','B'], '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> Requesting all at once, or dropping everything before asking anew ensures a process never holds one item while waiting for another.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('deadlock');

-- Q58 — MSQ: Virtual Memory benefits (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='os'), (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1), (SELECT id FROM topics WHERE slug='virtual' LIMIT 1), 'gate-cse',false,NULL,'MSQ','medium',2, 'Implementing virtual memory by demand paging yields which practical advantages? (Select all that apply)', 'The degree of multiprogramming can be increased', 'Total physical memory capacity logical program sizes', 'Logical address spaces can significantly exceed physical RAM confines', 'Page sharing allows identical library code to load exactly once', ARRAY['A','C','D'], '<p><strong>✓ Answers: A, C, D.</strong></p><p><strong>Rationale:</strong> Virtual memory breaks standard RAM constraints allowing massive programs, code sharing, and a higher count of active running processes.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q59 — MSQ: Thread Sharing (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='os'), (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1), (SELECT id FROM topics WHERE slug='threads' LIMIT 1), 'gate-cse',false,NULL,'MSQ','hard',2, 'Peer threads operating within the exact same parent process intrinsically share which underlying components? (Select all that apply)', 'The Data Section', 'The Code (Text) Section', 'Open OS File Descriptors', 'The local Call Stack', ARRAY['A','B','C'], '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Threads share global states: code, global data, and OS handles. They maintain private stacks and private registers their unique execution .</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('threads');

-- Q60 — MSQ: Thrashing causes (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='os'), (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1), (SELECT id FROM topics WHERE slug='virtual' LIMIT 1), 'gate-cse',false,NULL,'MSQ','medium',2, 'Which trigger or worsen OS Thrashing? (Select all that apply)', 'The degree of multiprogramming exceeds active memory capacity ', 'Operating processes mapped with insufficient frame allocations', 'A low page-fault rate', 'Global page replacement algorithms stealing priority frames', ARRAY['A','B','D'], '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> Running too many programs, providing too few frames per process, and using aggressive global replacement policies cause chronic faults driving thrashing.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q61 — MSQ: Semaphores properties (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='os'), (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1), (SELECT id FROM topics WHERE slug='sync-tools' LIMIT 1), 'gate-cse',false,NULL,'MSQ','easy',1, 'Which characteristics validly define standard OS Counting Semaphores? (Select all that apply)', 'They integrate atomic P and V commands', 'They possess binary 0 or 1 boundaries', 'They regulate concurrent limit access without tying to lock owners', 'They function bypassing context switch penalties', ARRAY['A','C'], '<p><strong>✓ Answers: A, C.</strong></p><p><strong>Rationale:</strong> Counting semaphores differ from binary semaphores (mutexes); they scale mathematically protecting of multiple identical resources without specific ownership.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('semaphores');

-- Q62 — MSQ: Kernel thread vs User Thread (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='os'), (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1), (SELECT id FROM topics WHERE slug='threads' LIMIT 1), 'gate-cse',false,NULL,'MSQ','medium',2, 'Kernel-level threads maintain which technical advantages against User-level threads? (Select all that apply)', 'If one thread invokes a blocking system call, sibling threads continue freely', 'The OS routes distinct threads simultaneously across varying multicore CPUs', 'Creation and destruction metrics operate considerably faster', 'They do not require kernel mode traps invoking scheduling logic', ARRAY['A','B'], '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> User threads are invisible to the OS (causing total process blocks). Kernel threads natively allow true multiprocessor and isolate blocking .</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('threads');

-- Q63 — MSQ: Disk structure algorithms (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='os'), (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1), (SELECT id FROM topics WHERE slug='disk' LIMIT 1), 'gate-cse',false,NULL,'MSQ','medium',2, 'Which disk scheduling successfully solve starvation (i.e., every request is mathematically guaranteed servicing quickly)? (Select all that apply)', 'FCFS', 'C-SCAN', 'SSTF', 'Shortest Job First', ARRAY['A','B'], '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> FCFS processes in sequence. C-SCAN sweeps perfectly guaranteeing no request waits forever. Both SSTF and SJF suffer crippling starvation targets.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q64 — MSQ: Linked List File allocation (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='os'), (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1), (SELECT id FROM topics WHERE slug='file-alloc' LIMIT 1), 'gate-cse',false,NULL,'MSQ','easy',1, 'Linked Allocation methodologies file provide which benefits over Contiguous techniques? (Select all that apply)', 'zero External Fragmentation', 'Immediate $O(1)$ random accessibility calculating vectors', 'Dynamic file growth scaling endlessly', 'No need pre-declaring total sizes', ARRAY['A','C','D'], '<p><strong>✓ Answers: A, C, D.</strong></p><p><strong>Rationale:</strong> Linked connect arbitrarily scattered blocks ending external fragmentation. However, accessing the $N$th block demands linear scanning, failing $O(1)$ targets.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q65 — MSQ: Paging (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='os'), (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1), (SELECT id FROM topics WHERE slug='paging' LIMIT 1), 'gate-cse',false,NULL,'MSQ','hard',2, 'Multi-level paging frameworks replace massive scalar Page Tables memory aiming to:', 'Prevent holding unused empty occupying memory', 'Drop Translation Lookaside Buffers ', 'Establish logic allowing page tables themselves bounding to map onto disk swaps', 'Speed up absolute cache miss hardware fetches significantly', ARRAY['A','C'], '<p><strong>✓ Answers: A, C.</strong></p><p><strong>Rationale:</strong> Multi-level logic drops unused arrays (saving giant blocks of space) and allows outer page tables loading into RAM lazily. It does NOT speed up ; adding levels makes misses slower.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Part 6 complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — OS PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1: Process & Concurrency (11 Cards)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 1
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='concept' LIMIT 1),
  'What is the fundamental difference between a Program and a Process?',
  '<p>A program is a passive entity (a file containing instructions stored on disk). A process is an active entity, representing an execution context with a program counter, registers, and memory states.</p>',
  ARRAY['process']
),
-- Card 2
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='concept' LIMIT 1),
  'Explain the purpose of the Process Control Block (PCB).',
  '<p>The PCB is the data structure utilized by the OS to store all process-specific information, including process state, program counter, CPU registers, memory management logic, and I/O status.</p>',
  ARRAY['process']
),
-- Card 3
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='threads' LIMIT 1),
  'What key components are shared among multiple threads inside the same process?',
  '<p>Threads share the code section, data section (global variables), and OS resources like open files. However, each thread maintains its own private Stack and CPU register set.</p>',
  ARRAY['threads']
),
-- Card 4
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='system-calls' LIMIT 1),
  'Define a Zombie process.',
  '<p>A Zombie is a process that has completed execution (terminated) but its entry still exists in the process table because the parent process has not yet invoked `wait()` to read its exit status.</p>',
  ARRAY['process']
),
-- Card 5
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='scheduling' LIMIT 1),
  'What is Starvation in CPU scheduling?',
  '<p>Starvation occurs when a low-priority process is denied CPU time indefinitely because a constant stream of higher-priority processes arrive. "Aging" solves starvation by safely boosting priority over time.</p>',
  ARRAY['scheduling']
),
-- Card 6
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='process-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='scheduling' LIMIT 1),
  'Explain the Convoy Effect.',
  '<p>In FCFS logic, the Convoy Effect occurs when multiple short I/O-bound processes are forced to wait endlessly behind a single massive CPU-bound process, resulting in severely degraded average wait times.</p>',
  ARRAY['scheduling']
),
-- Card 7
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sync-tools' LIMIT 1),
  'What is a Race Condition?',
  '<p>A situation where multiple concurrent processes read and write shared data simultaneously, and the final output becomes corrupted depending on the exact timing/order of execution.</p>',
  ARRAY['semaphores']
),
-- Card 8
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sync-tools' LIMIT 1),
  'Compare Binary Semaphores (Mutexes) vs Counting Semaphores.',
  '<p>A Mutex (binary) allows only $1$ active owner in a critical section and verifies ownership during unlocks. A Counting Semaphore allows $N$ concurrent accesses and functions without identifying precise owners.</p>',
  ARRAY['semaphores']
),
-- Card 9
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='classical-problems' LIMIT 1),
  'In the Readers-Writers problem, which operation mandates exclusive access?',
  '<p>Readers can operate concurrently without conflict. Writers demand absolute exclusive access, blocking all other readers and writers to prevent data corruption.</p>',
  ARRAY['semaphores']
),
-- Card 10
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='deadlock-concept' LIMIT 1),
  'What are the four necessary Coffman conditions for Deadlock?',
  '<ol><li>Mutual Exclusion</li><li>Hold and Wait</li><li>No Preemption</li><li>Circular Wait</li></ol>',
  ARRAY['deadlock']
),
-- Card 11
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='concurrency' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bankers' LIMIT 1),
  'Differentiate Deadlock Prevention vs Avoidance.',
  '<p><strong>Prevention:</strong> Structurally breaking one of the Coffman conditions (e.g. denying Hold and Wait).<br><strong>Avoidance:</strong> Dynamically analyzing resource request trajectories using algorithms like Banker''s to guarantee the system remains in a Safe State.</p>',
  ARRAY['deadlock']
);

-- Part 7 complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — OS PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2: Memory & Storage (11 Cards) + COMMIT
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 12
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='paging' LIMIT 1),
  'What is the difference between Logical and Physical Addresses?',
  '<p>A Logical Address is generated by the CPU executing a program. A Physical Address represents the actual location inside the RAM hardware. The MMU handles mapping the former into the latter.</p>',
  ARRAY['paging']
),
-- Card 13
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='paging' LIMIT 1),
  'Differentiate Internal vs External Fragmentation.',
  '<p><strong>Internal:</strong> Wasted space inside an allocated block (e.g. fixed paging).<br><strong>External:</strong> Ample free memory exists across the system, but it is shattered into non-contiguous gaps prohibiting allocations.</p>',
  ARRAY['paging']
),
-- Card 14
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='segmentation' LIMIT 1),
  'How does Segmentation differ from Paging?',
  '<p>Paging splits memory into fixed-size mathematical blocks, causing internal fragmentation. Segmentation partitions memory based on logical user-defined blocks (like functions or structures), causing external fragmentation.</p>',
  ARRAY['paging']
),
-- Card 15
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tlb' LIMIT 1),
  'What is the role of the TLB?',
  '<p>The Translation Lookaside Buffer (TLB) acts as a high-speed associative hardware cache storing recent page-table operations. A TLB hit avoids an expensive secondary trip to main memory for address translation.</p>',
  ARRAY['tlb']
),
-- Card 16
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='virtual' LIMIT 1),
  'Define Thrashing.',
  '<p>Thrashing happens when active working sets surpass physical RAM frames. The OS stalls executing user code, spending virtually all CPU cycles continuously swapping pages in and out of the disk.</p>',
  ARRAY['paging']
),
-- Card 17
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='page-replacement' LIMIT 1),
  'What is Belady''s Anomaly?',
  '<p>A counter-intuitive phenomenon found in FIFO page algorithms where increasing the number of available physical memory frames mathematically results in an increased number of page faults.</p>',
  ARRAY['paging']
),
-- Card 18
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'What are the three components comprising Disk Access Time?',
  '<ol><li><strong>Seek Time:</strong> Moving the mechanical head to the target track.</li><li><strong>Rotational Latency:</strong> Waiting for the required sector to spin under the head.</li><li><strong>Transfer Time:</strong> Electronically copying the bytes.</li></ol>',
  ARRAY['disk']
),
-- Card 19
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'Why does SSTF scheduling suffer from Starvation?',
  '<p>Shortest Seek Time First continuously jumps to the closest pending request. If a constant stream of local requests arrives, requests stationed far off at disk edges will be starved infinitely.</p>',
  ARRAY['disk']
),
-- Card 20
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'What is the difference between SCAN and C-SCAN disk scheduling?',
  '<p>SCAN (Elevator) travels from $0 \rightarrow End$ servicing requests, then reverses direction servicing backward. C-SCAN strictly jumps back to 0 without servicing anything on the return voyage, preventing bias towards central tracks.</p>',
  ARRAY['disk']
),
-- Card 21
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='file-alloc' LIMIT 1),
  'What is the fatal drawback of Contiguous File Allocation?',
  '<p>While offering phenomenal sequential access speeds, contiguous arrays fall prey immediately to External Fragmentation, demanding slow disk compaction runs over time as memory deletes produce gaps.</p>',
  ARRAY['disk']
),
-- Card 22
(
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='unix-inode' LIMIT 1),
  'How do UNIX inodes support massive data structures?',
  '<p>Inodes balance accessing tiny and huge files by keeping 12 direct pointers initially, relying on cascading single, double, and triple-indirect structural blocks to multiply available logical bounds for massive payloads.</p>',
  ARRAY['disk']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing os-seed.sql to verify correctness:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='os'));
-- Expected: 15
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='os');
-- Expected: 65
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='os');
-- Expected: 22
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='os')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug: os
-- Schema version: v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- Chapters:     4 
-- Topics:       15
-- Questions:    65 total
--   MCQ:        45 (Q1–Q45)
--   NAT:        10 (Q46–Q55)
--   MSQ:        10 (Q56–Q65)
-- Flashcards:   22 concise OS structural cards
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF os-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
