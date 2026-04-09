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
