-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COA PYQ SEED v2  (Part 6 / 8)
-- MSQ Questions Q56–Q65 (Multi-Select)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q56 — MSQ: RISC architecture characteristics (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='instruction-formats' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'Which of the following are hallmark characteristics of a classic RISC (Reduced Instruction Set Computer) architecture? (Select all that apply)',
  'Variable-length instructions that optimize memory usage',
  'Load/Store architecture where memory is only accessed via LOAD and STORE instructions',
  'A large number of general-purpose registers',
  'Extensive use of complex addressing modes like Memory-Indirect',
  ARRAY['B','C'],
  '<p><strong>✓ Answers: B, C.</strong></p><p><strong>Rationale:</strong> RISC relies on fixed-length instructions (which enables clean pipelining), a strict Load/Store architecture (B), many registers to minimize memory access (C), and few, simple addressing modes. CISC features variable-length instructions and complex addressing (such as memory-to-memory).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('addressing-modes');

-- Q57 — MSQ: Cache write policies (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Identify the valid statements regarding cache memory write policies. (Select all that apply)',
  'Write-Through caches ensure main memory and cache are always perfectly consistent (synchronized)',
  'Write-Back caches generate less bus traffic than Write-Through caches for blocks that are written to multiple times',
  'Write-Allocate is typically paired with Write-Through to update memory immediately',
  'In a Write-Back cache, a "dirty bit" is required to track whether a cache block has been modified',
  ARRAY['A','B','D'],
  '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> Write-through updates RAM immediately, ensuring strict consistency (A). Write-back delays writing to RAM until eviction, saving bandwidth if a block is modified many times (B), but requires a dirty bit (D). Write-Allocate is usually paired with Write-Back to pull blocks into cache on a write miss; Write-Through usually pairs with No-Write-Allocate.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q58 — MSQ: Pipeline hazards resolution (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='data-hazards' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which techniques can a compiler or hardware use to mitigate pipeline data hazards? (Select all that apply)',
  'Inserting NOP (No-Operation) instructions to force stalls',
  'Instruction scheduling/reordering to separate dependent instructions',
  'Operand forwarding (bypassing) using specialized datapath multiplexers',
  'Splitting the instruction memory into separate data and instruction caches (Harvard Architecture)',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Data hazards are resolved via forwarding (C), stalling/NOPs (A), and compiler scheduling (B). Splitting caches (Harvard architecture) resolves <em>Structural Hazards</em> (specifically memory access bottlenecks), not Data hazards.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('instruction-pipeline','hazards');

-- Q59 — MSQ: Types of interrupts (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following are strictly classified as "Exceptions" (Internal synchronous interrupts generated by CPU execution)? (Select all that apply)',
  'Division by zero',
  'A network card receiving a packet',
  'A software trap or syscall instruction',
  'Page fault generated by the MMU',
  ARRAY['A','C','D'],
  '<p><strong>✓ Answers: A, C, D.</strong></p><p><strong>Rationale:</strong> Exceptions are synchronous events caused by instruction execution: div-by-zero (A), software traps (C), and page faults (D). A network card interrupt (B) is an asynchronous hardware interrupt triggered by an external device, unrelated to the currently executing instruction.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q60 — MSQ: Floating point special values (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='floating-point' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','hard',2,
  'In the IEEE 754 floating-point standard, how are the boundary conditions defined? (Select all that apply)',
  'An exponent of all zeroes with a zero fraction represents $\pm0$',
  'An exponent of all ones with a non-zero fraction represents NaN (Not a Number)',
  'An exponent of all ones with a zero fraction represents $\pm$Infinity',
  'Denormalized numbers use an exponent of all ones',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> IEEE 754 reserves specific bit patterns. Exp=0, Frac=0 is zero (A). Exp=255, Frac=0 is infinity (C). Exp=255, Frac!=0 is NaN (B). Denormalized (subnormal) numbers use an exponent of <em>all zeroes</em>, not all ones, making D incorrect.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('floating-point');

-- Q61 — MSQ: Microprogramming advantages (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='datapath-control' LIMIT 1),
  (SELECT id FROM topics WHERE slug='microprogrammed-cu' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'What are the distinct advantages of using a Microprogrammed Control Unit over a Hardwired one? (Select all that apply)',
  'It executes instructions much faster than hardwired logic',
  'It allows for easy modification of the instruction set by simply flashing the control ROM',
  'It provides an elegant, structured way to handle complex CISC instructions',
  'It eliminates the need for any clock signals in the CPU',
  ARRAY['B','C'],
  '<p><strong>✓ Answers: B, C.</strong></p><p><strong>Rationale:</strong> Microprogramming turns hardware control into a software problem (firmware), making changes easy and allowing massive CISC instruction sets without an explosion of logic gate complexity (B, C). It is inherently <em>slower</em> than hardwired logic (making A incorrect) and certainly requires a clock (making D incorrect).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('microprogramming');

-- Q62 — MSQ: DMA controllers constraints (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'When a DMA controller operates on the system bus, which statements are true? (Select all that apply)',
  'The CPU must grant control of the bus using the Bus Grant (BG) signal',
  'The CPU remains completely idle for the entire duration of a Block Transfer DMA operation',
  'The DMA controller must provide the memory addresses and control signals (read/write) during the transfer',
  'The DMA controller executes standard x86/ARM machine instructions to move the data',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> The DMA controller acts as bus master, supplying addresses and read/write signals (C) after receiving permission via Bus Grant (A). In Burst/Block transfer mode, the CPU is completely locked out of the bus (blocking execution if it needs memory) until the block finishes (B). DMA controllers use hardwired state machines, not CPU instructions (D is false).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q63 — MSQ: Branch prediction strategies (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='control-hazards' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following are valid branch prediction techniques used in modern processors? (Select all that apply)',
  'Static prediction assuming all standard forward branches are NOT taken',
  'Dynamic prediction using a 1-bit or 2-bit history state machine (Bimodal predictor)',
  'Branch Target Buffers (BTB) storing past destination addresses',
  'Delaying all pipeline stages purely in hardware until the branch is resolved',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Processors use static methods like "forward not taken, backward taken" (A), dynamic history predictors (B), and BTBs to cache target addresses (C). Delaying the pipeline (stalling) is exactly what prediction seeks to avoid — it is a hazard resolution fallback, not a prediction technique (D).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hazards');

-- Q64 — MSQ: Cache performance factors (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'What generally happens when the block size of a cache is moderately increased? (Select all that apply)',
  'The spatial locality exploitation improves, often increasing the hit rate',
  'The miss penalty time increases because pulling a larger block from RAM takes longer',
  'The number of tag bits required decreases (assuming cache size is unchanged)',
  'Internal fragmentation within the CPU registers increases drastically',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Larger blocks capture more neighboring data, improving spatial locality (A). However, fetching more bytes takes more bus cycles, increasing miss penalty (B). Larger blocks mean fewer total blocks, meaning fewer bits are needed for the index/tag calculation, dropping the tag size (C). Internal fragmentation applies to OS paging, not CPU registers.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache','coa-performance');

-- Q65 — MSQ: Superscalar processor features (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='superscalar' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','hard',2,
  'Which hardware features are strictly necessary to implement a dynamically scheduled, out-of-order superscalar processor? (Select all that apply)',
  'Multiple parallel execution units (ALUs, FPUs)',
  'An instruction Dispatch/Issue unit capable of checking dependencies at runtime',
  'A Reorder Buffer (ROB) to ensure instructions commit their results in original program order',
  'Programmer-inserted explicit parallelism vectors (like OpenMP tags)',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Superscalar architectures dispatch multiple instructions to multiple functional units (A) dynamically checking dependencies in hardware (B). Although they execute out of order, they must retire/commit perfectly in order to maintain correct architectural state and exception handling, which requires a Reorder Buffer (C). Explicit vectors are for VLIW or SIMD, while superscalar extracts ILP transparently from standard sequential binaries.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('instruction-pipeline');

-- Part 6 Complete.
