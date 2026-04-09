-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COA PYQ SEED v2  (Part 5 / 8)
-- NAT Questions Q46–Q55 (Numerical Calculations)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q46 — Cache Direct Mapping Tags (medium)
-- Cache = 64 KB = 2^16 B. Block size = 32 B = 2^5 B. Lines = 2^11.
-- Main memory = 16 MB = 2^24 B.
-- T + L + B = 24. B=5. L=11. T = 24 - 11 - 5 = 8 bits.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-mapping' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A computer has a 16 MB main memory and a 64 KB direct-mapped cache. The cache block size is 32 bytes. What is the size of the TAG field in bits?',
  8.00,8.00,NULL,
  '<p><strong>✓ Answer: 8.</strong></p><p><strong>Rationale:</strong> Memory = 16 MB ($2^{24}$ bytes) → Address = 24 bits. Block size = 32 bytes ($2^5$) → Offset = 5 bits. Cache size = 64 KB ($2^{16}$ bytes) → Number of lines = $2^{16} / 2^5 = 2^{11}$ → Line index = 11 bits. Tag = Address - Index - Offset = 24 - 11 - 5 = <strong>8 bits</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache-mapping');

-- Q47 — Expected Memory Access Time (EMAT) (medium)
-- Hit ratio h1 = 0.9. t1 = 2 ns. t2 = 50 ns.
-- EMAT = h1 * t1 + (1-h1) * (t1 + t2)  vs EMAT = t1 + miss_rate * miss_penalty
-- Usually EMAT = HitTime + MissRate * MissPenalty = 2 + 0.1 * 50 = 7 ns.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A cache memory has an access time of 2 ns and a hit rate of 90%. A main memory access takes 50 ns (miss penalty). What is the Average Memory Access Time (AMAT) in ns?',
  7.00,7.00,NULL,
  '<p><strong>✓ Answer: 7.</strong></p><p><strong>Rationale:</strong> AMAT = Cache_Hit_Time + (Miss_Rate × Miss_Penalty) = 2 + (0.10 × 50) = 2 + 5 = <strong>7 ns</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache','coa-performance');

-- Q48 — Speedup of Pipeline (medium)
-- k=5. Non-pipeline clock = 10 ns. Pipeline clock = 2 ns. n = 1000.
-- Tp = (k + n - 1) * tp = (5 + 999) * 2 = 2008 ns
-- Tn = n * k * tn ? Wait. Non-pipeline time Tn = n * tn. If tn = 10ns, Tn = 1000 * 10 = 10000 ns.
-- Speedup = 10000 / 2008 = 4.98
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pipeline-basics' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A non-pipelined processor executes an instruction in 10 ns. It is converted to a 5-stage pipeline with a cycle time of 2 ns (latch delay included). For a program with 1000 instructions and no hazards, calculate the absolute speedup factor (rounded to 2 decimal places).',
  4.97,4.99,NULL,
  '<p><strong>✓ Answer: 4.98</strong></p><p><strong>Rationale:</strong> Non-pipelined time $T_n = 1000 \times 10 = 10,000$ ns. Pipelined time $T_p = (k + n - 1) \times t_{cycle} = (5 + 1000 - 1) \times 2 = 1004 \times 2 = 2008$ ns. Speedup = $10000 / 2008 \approx 4.980$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('instruction-pipeline','coa-performance');

-- Q49 — Set Associative Cache block count (easy)
-- Cache = 128 blocks. 4-way set associative. Sets = 128 / 4 = 32.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-mapping' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'A cache memory contains a total of 128 cache blocks. If it is organized as a 4-way set-associative cache, how many unique "sets" does the cache contain?',
  32.00,32.00,NULL,
  '<p><strong>✓ Answer: 32.</strong></p><p><strong>Rationale:</strong> Number of Sets = Total Blocks / Set Associativity count (N-way) = 128 / 4 = <strong>32</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache-mapping');

-- Q50 — Interleaved Memory Bandwidth (medium)
-- 8-way interleaved. Access time = 40ns.
-- Max bandwidth in words per second. 8 words / 40ns = 8 / (40e-9) = 200,000,000 = 200 million.
-- Question asks in millions of words per sec. 200.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='main-memory' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A main memory uses 8-way low-order interleaving. The access time of each individual memory bank is 40 ns. What is the theoretical maximum memory bandwidth in millions of words per second?',
  200.00,200.00,NULL,
  '<p><strong>✓ Answer: 200.</strong></p><p><strong>Rationale:</strong> Low-order interleaving allows 8 consecutive words to be fetched simultaneously in one memory cycle (40 ns). Words per second = 8 / (40 × 10⁻⁹) = $2 \times 10^8$ = <strong>200 million words/sec</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('coa-performance');

-- Q51 — Effective CPI calculation (medium)
-- Base CPI = 1.2. Load/Store = 30%. Cache miss rate = 5%. Miss penalty = 40 cycles.
-- Extra CPI = 0.30 * 0.05 * 40 = 0.6. Total CPI = 1.2 + 0.6 = 1.8.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pipeline-basics' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A processor has a base CPI of 1.2 assuming perfect cache. 30% of all instructions are Load/Store. The data cache has a 5% miss rate, and the miss penalty is 40 clock cycles. Assuming a perfect instruction cache, what is the effective overall CPI?',
  1.80,1.80,NULL,
  '<p><strong>✓ Answer: 1.8.</strong></p><p><strong>Rationale:</strong> Additional CPI from memory stalls = (fraction of memory instructions) × (miss rate) × (miss penalty) = 0.30 × 0.05 × 40 = 0.6 cycles. Effective CPI = Base CPI + Stalls = 1.2 + 0.6 = <strong>1.8</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('coa-performance');

-- Q52 — Instruction format bounds limit (medium)
-- 32-bit instruction. Opcode = 8 bits. Rs = 5 bits. Rt = 5 bits. Immediate = ?
-- Imm = 32 - 8 - 5 - 5 = 14 bits.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='instruction-formats' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A 32-bit RISC instruction format allocates 8 bits for the opcode and 5 bits each for two source registers (Rs, Rt). The remaining bits are used for a 2''s complement immediate value. What is the MAXIMUM positive integer this immediate field can represent?',
  8191.00,8191.00,NULL,
  '<p><strong>✓ Answer: 8191.</strong></p><p><strong>Rationale:</strong> Immediate bits = 32 - 8 - 5 - 5 = 14 bits. In 2''s complement notation, a 14-bit field has 1 sign bit and 13 magnitude bits. Max positive value = $2^{13} - 1 = 8192 - 1 = <strong>8191</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('addressing-modes');

-- Q53 — DMA CPU blocking percentage (hard)
-- DMA transfers blocks of 1KB. Device speed 1 MB/s = 1000 KB/s. Bus cycle = 1 us.
-- Transfers 1000 bytes per second. Each byte takes 1 us.
-- Actually: 1MB = 10^6 bytes/s. CPU bus cycle = 1 us (10^6 cycles/sec).
-- If DMA uses burst mode, taking 1 cycle per byte. It steals 10^6 cycles out of 10^6 cycles? Wait.
-- Let's change numbers: Disk reads words. 1 word = 4 bytes. Transfer rate = 100,000 words/s. Cycle = 1us.
-- 100,000 words/sec means DMA steals 100,000 cycles out of 1,000,000 cycles (since 1us = 1M cycles).
-- Percentage = 10%.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'NAT','hard',2,
  'A DMA controller is operating in cycle-stealing mode to transfer data from a disk. The disk transfers at a rate of 100,000 words per second. The system bus clock cycle (memory cycle) is 1 µs. What percentage of the CPU''s time is blocked by the DMA controller?',
  10.00,10.00,NULL,
  '<p><strong>✓ Answer: 10.</strong></p><p><strong>Rationale:</strong> Total system bus cycles available per second = 1 / (1 µs) = 1,000,000 cycles. The disk transfers 100,000 words/sec, thus stealing 100,000 bus cycles. Percentage blocked = (100,000 / 1,000,000) × 100 = <strong>10%</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q54 — Pipelining execution time with hazard stalls (medium)
-- 5 stages. 100 instructions. 20% branch, taken probability 50%. Branch penalty = 2 cycles.
-- Stalls = 100 * 0.20 * 0.50 = 10 instructions cause penalty. Total penalty = 20 cycles.
-- Normal cycles = 5 + 100 - 1 = 104. Total = 104 + 20 = 124.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='control-hazards' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A 5-stage pipeline processes 100 instructions. 20% are branches, of which 50% are taken. The pipeline resolves branches in the EX stage, yielding a 2-cycle branch penalty for taken branches. How many clock cycles are needed to complete the program execution?',
  124.00,124.00,NULL,
  '<p><strong>✓ Answer: 124.</strong></p><p><strong>Rationale:</strong> Ideal pipelined cycles for $n$ instructions = $k + n - 1 = 5 + 100 - 1 = 104$. Of 100 instructions, 20 are branches. Half are taken (10 taken branches). Each adds a 2-cycle stall penalty. Extra cycles = $10 \times 2 = 20$. Total cycles = 104 + 20 = <strong>124</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('instruction-pipeline','hazards');

-- Q55 — Number of bits for Microprogrammed Control unit (hard)
-- Microinstruction: 20 control signals. 4 branch conditions. Next address field. ROM has 256 words.
-- Log2(256) = 8 bits for next address. Wait, horizontal format means 1 bit per control signal.
-- Control = 20 bits. Branch condition = log2(4) = 2 bits?
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='datapath-control' LIMIT 1),
  (SELECT id FROM topics WHERE slug='microprogrammed-cu' LIMIT 1),
  'gate-cse',false,NULL,'NAT','hard',2,
  'A horizontal microprogrammed control unit supports 32 independent control signals, 4 mutual-exclusive branch condition flags, and uses a Control Memory (ROM) of 512 words. What is the total length of a single microinstruction in bits?',
  43.00,43.00,NULL,
  '<p><strong>✓ Answer: 43.</strong></p><p><strong>Rationale:</strong> Format = Control Bits + Condition Mux Bits + Next Address Bits. Horizontal control mapping = 32 bits (1 bit per signal). 4 branch conditions require a 4-to-1 MUX = 2 bits (log₂ 4). 512 ROM words require = 9 bits (log₂ 512) for the address field. Total = 32 + 2 + 9 = <strong>43 bits</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('microprogramming');

-- Part 5 Complete.
