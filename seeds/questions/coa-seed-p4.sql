-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COA PYQ SEED v2  (Part 4 / 8)
-- MCQ Questions Q29–Q45 (Instruction Pipelining)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q29 — Pipelining ideal speedup (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pipeline-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In an ideal $k$-stage instruction pipeline with no hazards, what is the theoretical maximum speedup over a non-pipelined processor executing an infinite number of instructions?',
  '$k / 2$',
  '$k$',
  '$k^2$',
  '$1 / k$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> An ideal $k$-stage pipeline processes $k$ instructions simultaneously. As the number of instructions $n \to \infty$, the throughput approaches 1 instruction per clock cycle, yielding a maximum speedup equal to the number of stages $k$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('instruction-pipeline');

-- Q30 — Read-After-Write (RAW) hazard (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='data-hazards' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Consider the instruction sequence: (1) `ADD R1, R2, R3` (2) `SUB R4, R1, R5`. Which type of data hazard is present?',
  'Write-After-Write (WAW)',
  'Write-After-Read (WAR)',
  'Read-After-Write (RAW)',
  'Structural Hazard',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The SUB instruction must Read `R1` After the ADD instruction Writes to `R1`. This true dependency creates a RAW hazard if SUB tries to read `R1` before ADD has committed it to the register file.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hazards');

-- Q31 — Operand forwarding (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='data-hazards' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which hardware technique is most commonly used to resolve RAW data hazards without stalling the pipeline?',
  'Branch Prediction',
  'Operand Forwarding (Bypassing)',
  'Register Renaming',
  'Delayed Branching',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Operand forwarding uses multiplexers to route the result directly from the ALU output of one pipeline stage back to the ALU input of a previous stage, bypassing the register file and eliminating the stall.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hazards');

-- Q32 — Load-Use hazard stall (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='data-hazards' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a classic 5-stage RISC pipeline (IF, ID, EX, MEM, WB) with full forwarding, which instruction sequence will STILL require at least one stall cycle?',
  'ADD R1,R2,R3 followed by SUB R4,R1,R5',
  'SUB R1,R2,R3 followed by OR R4,R5,R1',
  'LOAD R1,(R2) followed by ADD R3,R1,R4',
  'LOAD R1,(R2) followed by STORE R1,(R3)',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> A LOAD instruction does not obtain its data until the end of the MEM stage. An ADD immediately following it needs the data at the beginning of the EX stage. Time travel is impossible, so a 1-cycle stall (Load-Use delay) is unavoidable even with forwarding.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hazards');

-- Q33 — Structural hazard definition (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pipeline-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A structural hazard occurs in an instruction pipeline when:',
  'An instruction depends on the result of a previous incomplete instruction',
  'A conditional branch jumps to an unexpected target address',
  'Two or more instructions in different stages attempt to use the same hardware resource simultaneously',
  'The cache memory encounters a page fault',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Structural hazards arise from resource limitations. For example, if both the Instruction Fetch (IF) and Memory Access (MEM) stages try to access a single unified memory simultaneously, they collide over the memory bus.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hazards');

-- Q34 — Control hazard branch penalty (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='control-hazards' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a pipeline where branch conditions are evaluated in the EX stage, a taken branch results in flushing instructions already fetched. This lost time is called:',
  'Data dependency stall',
  'Branch penalty',
  'Pipeline resonance',
  'Write-back delay',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The branch penalty is the number of clock cycles wasted because the pipeline fetched instructions from the wrong path (fall-through) before realizing the branch was actually taken.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hazards');

-- Q35 — Delayed branching (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='control-hazards' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What is the fundamental concept behind the "Delayed Branch" technique in RISC architectures?',
  'The CPU pauses execution until the branch target is retrieved from disk',
  'The compiler fills the slot immediately following the branch with an independent instruction that is always executed, regardless of the branch outcome',
  'The processor predicts the branch will not be taken and continues execution',
  'Branch instructions are moved to a separate parallel pipeline',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The compiler schedules a useful, independent instruction into the "delay slot" after the branch. The CPU executes this slot while resolving the branch condition, thus masking the control hazard stall without wasting cycles.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hazards');

-- Q36 — Superscalar definition (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='superscalar' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A superscalar processor achieves Instruction Level Parallelism (ILP) primarily by:',
  'Increasing the clock frequency to extreme limits',
  'Using a very long instruction word (VLIW) determined by the compiler',
  'Issuing and executing multiple independent instructions per clock cycle using redundant execution units',
  'Running multiple threads simultaneously using context switches',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> A superscalar architecture duplicates execution hardware (e.g., two ALUs, an FPU, and a Memory unit) and contains hardware scheduling logic to dynamically dispatch multiple independent instructions in the same clock cycle.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('instruction-pipeline');

-- Q37 — WAR and WAW naming (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='data-hazards' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Write-After-Read (WAR) and Write-After-Write (WAW) hazards do not occur in a standard 5-stage in-order RISC pipeline. Why?',
  'The compiler guarantees these patterns never exist in the source code',
  'Because instructions are scalar, they do not use registers',
  'Registers are only written in the final (WB) stage and reads only happen early in the ID stage, strictly preserving in-order completion',
  'Forwarding paths automatically resolve all WAR and WAW conflicts',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> In a strict in-order pipeline, an instruction issued later will always reach the Write-Back stage later. It cannot jump ahead to overwrite a register before an older instruction has read it (WAR) or written it (WAW). These hazards only appear in out-of-order execution engines.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hazards');

-- Q38 — Register Renaming (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='superscalar' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'In out-of-order execution, the hardware technique of "Register Renaming" is explicitly designed to eliminate which types of hazards?',
  'Read-After-Write (True Data Dependencies)',
  'Control Hazards (Branches)',
  'Structural Hazards (Resource conflicts)',
  'Write-After-Write (WAW) and Write-After-Read (WAR) (False Dependencies)',
  'D',
  '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> WAW and WAR are name dependencies (false dependencies) caused by reusing the same register name for unrelated data. Renaming maps architectural registers to a larger pool of physical registers, dynamically breaking these false links and exposing true ILP.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hazards');

-- Q39 — Branch Target Buffer (BTB) (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='control-hazards' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What is the primary function of a Branch Target Buffer (BTB) in a pipelined processor?',
  'To delay the branch instruction until the target is fetched from memory',
  'To cache the predicted destination address of branches previously executed to avoid target address calculation latency',
  'To store the return addresses for subroutine calls',
  'To evaluate the branch condition (taken/not-taken) using ALUs',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Even if a branch is correctly predicted "taken", the pipeline must know *where* to jump. A BTB caches the calculated target addresses of recent branches, allowing the IF stage to immediately fetch the target without waiting for the EX stage to do the math.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hazards');

-- Q40 — CPU execution time formula (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pipeline-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The total execution time of a program on a processor is calculated using which formula?',
  'Instruction Count × Clock Rate / CPI',
  'Instruction Count × CPI × Clock Cycle Time',
  'Instruction Count / (CPI × Clock Cycle Time)',
  'CPI × Clock Cycle Time / Instruction Count',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Time = (Number of Instructions) × (Cycles Per Instruction) × (Seconds Per Cycle). This is the fundamental "Iron Law" of processor performance.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('coa-performance');

-- Q41 — Pipeline clock cycle time constraint (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pipeline-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In a synchronous pipelined processor, the minimum clock cycle time is strictly determined by:',
  'The average delay of all pipeline stages',
  'The delay of the shortest pipeline stage plus latch delay',
  'The delay of the longest (bottleneck) pipeline stage plus the pipeline latch delay',
  'The sum of the delays of all stages combined',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Since all stages share a single clock, the clock cannot tick faster than the time required for the slowest stage to complete its combinational logic and store the result in the pipeline latch (buffer).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('coa-performance');

-- Q42 — Tomasulo's Algorithm (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='superscalar' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Tomasulo''s algorithm allows for dynamic scheduling and out-of-order execution mainly through the use of:',
  'Static software unrolling by the compiler',
  'Reservation Stations and a Common Data Bus (CDB)',
  'A huge centralized register file mapping everything',
  'Microcode loop unfolding',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Tomasulo''s algorithm uses Reservation Stations (acting as virtual registers to implement renaming) and broadcasts execution results globally over a Common Data Bus (CDB) to dependent instructions, avoiding centralized bottlenecks.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('instruction-pipeline');

-- Q43 — Little-Endian vs Big-Endian (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='instruction-formats' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In a Little-Endian memory organization, how is the 32-bit hex integer 0x12345678 stored across four consecutive byte addresses starting at address 100?',
  '100: 12, 101: 34, 102: 56, 103: 78',
  '100: 78, 101: 56, 102: 34, 103: 12',
  '100: 21, 101: 43, 102: 65, 103: 87',
  '100: 87, 101: 65, 102: 43, 103: 21',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Little-Endian stores the "Little End" (the least significant byte) at the lowest memory address. 0x78 is the LSB, so it goes to address 100. 0x12 is the MSB, going to address 103.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('addressing-modes');

-- Q44 — Memory mapped io vs port mapped IO (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following describes Isolated I/O (Port-mapped I/O) rather than Memory-mapped I/O?',
  'Device registers share address space with RAM',
  'Requires a separate control pin on the CPU (like M/IO#) to distinguish between memory and I/O bus cycles',
  'The processor can use standard LOAD and STORE instructions for I/O',
  'It consumes a portion of the main memory addressing limits',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Isolated I/O maintains separate physical or logical address spaces for memory and I/O. The CPU must assert a specific hardware control pin to indicate to the chipset whether the address on the bus targets memory or an I/O port, requiring special instructions like IN and OUT.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q45 — Amdahl's Law phrasing (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pipeline-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'According to Amdahl''s Law, the maximum overall speedup of a system when only a fraction $f$ of the code is parallelized is strictly limited by:',
  'The size of the cache memory',
  'The fraction $(1 - f)$ of the code that must remain strictly sequential',
  'The number of processors applied to the parallel fraction $f$',
  'The clock speed of the weakest processor',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Amdahl''s Law states $Speedup \le \frac{1}{(1-f) + \frac{f}{S}}$. As $S \to \infty$, the speedup hits a hard ceiling of $\frac{1}{1-f}$. The sequential bottleneck $(1-f)$ completely determines the theoretical upper limit.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('coa-performance');

-- Part 4 Complete.
