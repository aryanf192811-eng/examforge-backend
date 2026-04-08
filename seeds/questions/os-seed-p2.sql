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
