-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COA PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1: Architecture & Pipelining (11 Cards)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES

-- Card 1
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='addressing-modes' LIMIT 1),
  'Compare Direct and Indirect Addressing modes.',
  '<p><strong>Direct:</strong> Instruction contains the exact memory address of the operand.<br><strong>Indirect:</strong> Instruction contains the address of a pointer in memory. The CPU must fetch the pointer, then fetch the actual operand (slower, but useful for pointers/arrays).</p>',
  ARRAY['addressing-modes']
),

-- Card 2
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='addressing-modes' LIMIT 1),
  'What is PC-Relative addressing and why is it useful?',
  '<p>Effective Address = Program Counter (PC) + Offset. This is primarily used for branch instructions. It makes the code <strong>Position Independent (relocatable)</strong> because it uses offsets rather than absolute memory locations.</p>',
  ARRAY['addressing-modes']
),

-- Card 3
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='floating-point' LIMIT 1),
  'What is the structure of an IEEE 754 Single-Precision float?',
  '<p>Total 32 bits:<br><strong>Sign:</strong> 1 bit<br><strong>Exponent:</strong> 8 bits (Bias = 127)<br><strong>Mantissa (Fraction):</strong> 23 bits (with an implicit leading 1.x)</p>',
  ARRAY['floating-point']
),

-- Card 4
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='datapath-control' LIMIT 1),
  (SELECT id FROM topics WHERE slug='hardwired-cu' LIMIT 1),
  'Compare Hardwired vs Microprogrammed Control Units.',
  '<table><tr><th>Feature</th><th>Hardwired</th><th>Microprogrammed</th></tr><tr><td>Speed</td><td>Very Fast</td><td>Slower</td></tr><tr><td>Flexibility</td><td>Difficult to change</td><td>Easy (rewrite ROM)</td></tr><tr><td>Implementation</td><td>Logic Gates</td><td>Control ROM</td></tr><tr><td>Use Case</td><td>RISC</td><td>CISC</td></tr></table>',
  ARRAY['microprogramming']
),

-- Card 5
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='datapath-control' LIMIT 1),
  (SELECT id FROM topics WHERE slug='microprogrammed-cu' LIMIT 1),
  'What is the difference between Horizontal and Vertical microcode?',
  '<p><strong>Horizontal:</strong> No decoding. 1 bit per control signal. Longer instruction word but faster execution.<br><strong>Vertical:</strong> Signals are grouped and encoded logic. Requires decoder hardware. Shorter instruction word but slower execution.</p>',
  ARRAY['microprogramming']
),

-- Card 6
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pipeline-basics' LIMIT 1),
  'State the formula for calculating total pipelined execution time.',
  '<p>For $n$ instructions in a $k$-stage pipeline:<br>Time = $(k + n - 1) \times t_{cycle}$<br>Where $t_{cycle}$ is determined by the slowest pipeline stage.</p>',
  ARRAY['instruction-pipeline','coa-performance']
),

-- Card 7
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='data-hazards' LIMIT 1),
  'What is a Read-After-Write (RAW) hazard and how is it resolved?',
  '<p><strong>RAW (True Dependency):</strong> An instruction needs to read a register that a preceding instruction has not yet finished writing. <br><strong>Resolution:</strong> Operand Forwarding (bypassing) routes the ALU output directly back to the ALU input, bypassing the register file.</p>',
  ARRAY['hazards']
),

-- Card 8
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='data-hazards' LIMIT 1),
  'Why do WAW and WAR hazards only occur in out-of-order execution?',
  '<p><strong>Write-After-Write</strong> and <strong>Write-After-Read</strong> are false/name dependencies. In a strictly in-order pipeline, registers are always accessed in program sequence. They only manifest when later instructions are allowed to execute and write before earlier ones finish. Resolved by <strong>Register Renaming</strong>.</p>',
  ARRAY['hazards']
),

-- Card 9
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='control-hazards' LIMIT 1),
  'What is Delayed Branching?',
  '<p>A compiler technique to hide branch penalty stalls. The compiler places an independent, useful instruction in the slot immediately following the branch. The CPU executes this "delay slot" instruction while evaluating the branch condition.</p>',
  ARRAY['hazards']
),

-- Card 10
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='pipelining' LIMIT 1),
  (SELECT id FROM topics WHERE slug='superscalar' LIMIT 1),
  'What defines a Superscalar processor architecture?',
  '<p>A processor that implements Instruction Level Parallelism (ILP) by combining pipelining with redundant execution units (multiple ALUs, FPUs). It fetches, decodes, and issues <em>multiple</em> instructions per clock cycle dynamically in hardware.</p>',
  ARRAY['instruction-pipeline']
),

-- Card 11
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='alu-design' LIMIT 1),
  'How does a Carry Look-Ahead Adder (CLA) improve speed?',
  '<p>Instead of waiting for the carry to ripple sequentially through each bit stage, a CLA calculates mathematical Generate ($G$) and Propagate ($P$) functions in parallel. This allows the carry-out for any bit to be computed in constant time.</p>',
  ARRAY['coa-performance']
);

-- Part 7 Complete.
