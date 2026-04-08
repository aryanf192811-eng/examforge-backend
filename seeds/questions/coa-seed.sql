-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COA PYQ SEED v2  (Part 1 / 8)
-- Subject: Computer Organization & Architecture (coa)
-- ═══════════════════════════════════════════════════════════════════════════

BEGIN;

DO $$
DECLARE
  subj_id UUID;
  ch1_id  UUID;
  ch2_id  UUID;
  ch3_id  UUID;
  ch4_id  UUID;
BEGIN

  -- 1. Subject
  INSERT INTO subjects (title, slug, description, gradient_start, gradient_end, icon_type)
  VALUES (
    'Computer Organization & Architecture', 'coa',
    'Machine instructions, addressing modes, ALU, data path, pipelining, and memory hierarchy.',
    '#f59e0b', '#d97706', 'hardware' -- amber
  )
  ON CONFLICT (slug) DO UPDATE
    SET title = EXCLUDED.title, description = EXCLUDED.description
  RETURNING id INTO subj_id;

  -- 2. Chapters
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Machine Instructions & ALU', 'instructions-alu', 1) RETURNING id INTO ch1_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Datapath & Control Unit', 'datapath-control', 2) RETURNING id INTO ch2_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Instruction Pipelining', 'pipelining', 3) RETURNING id INTO ch3_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Memory Hierarchy & I/O', 'memory-io', 4) RETURNING id INTO ch4_id;

  -- 3. Topics
  -- Chapter 1: Machine Instructions & ALU
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'instruction-formats', 'Instruction Formats',          1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'addressing-modes',  'Addressing Modes',               2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'alu-design',        'ALU & Number Representation',    3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'floating-point',    'Floating Point Arithmetic',      4) ON CONFLICT DO NOTHING;

  -- Chapter 2: Datapath & Control Unit
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'datapath',          'Datapath Design',                1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'hardwired-cu',      'Hardwired Control',              2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'microprogrammed-cu','Microprogrammed Control',        3) ON CONFLICT DO NOTHING;

  -- Chapter 3: Instruction Pipelining
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'pipeline-basics',   'Pipeline Concepts & Performance', 1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'data-hazards',      'Data Hazards & Forwarding',       2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'control-hazards',   'Control Hazards & Branching',     3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'superscalar',       'Superscalar & ILP Basics',        4) ON CONFLICT DO NOTHING;

  -- Chapter 4: Memory Hierarchy & I/O
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'cache-basics',      'Cache Memory Fundamentals',       1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'cache-mapping',     'Cache Mapping Techniques',        2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'main-memory',       'Main Memory & Interleaving',      3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'io-dma',            'I/O Interfaces, Interrupts & DMA',4) ON CONFLICT DO NOTHING;

  -- 4. Tags
  INSERT INTO tags (name, slug) VALUES ('Addressing Modes','addressing-modes') ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Instruction Pipeline','instruction-pipeline') ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Hazards',         'hazards')         ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Cache Memory',    'cache')           ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Cache Mapping',   'cache-mapping')   ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('DMA',             'dma')             ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Microprogramming','microprogramming') ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Floating Point',  'floating-point')  ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Performance',     'coa-performance') ON CONFLICT DO NOTHING;

END $$;

-- Part 1 Complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COA PYQ SEED v2  (Part 2 / 8)
-- MCQ Questions Q1–Q14 (Machine Instructions, ALU & Datapath)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — Addressing mode for local variables (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='addressing-modes' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which addressing mode is most suitable for accessing local variables stored on the stack during a function call?',
  'Base Register (or Indexed) Addressing',
  'Absolute Addressing',
  'Auto-increment Addressing',
  'Immediate Addressing',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Local variables exist at fixed offsets relative to the current stack pointer or frame pointer. Base register addressing computes the effective address as `Base_Register + Offset`, which perfectly matches this requirement.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('addressing-modes');

-- Q2 — Indexed addressing effective address (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='addressing-modes' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In Indexed Addressing mode, how is the Effective Address (EA) typically calculated?',
  'EA = Memory[Address_Field]',
  'EA = Content of Program Counter + Address_Field',
  'EA = Content of Index Register + Address_Field',
  'EA = Content of Accumulator',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Indexed addressing adds a constant value (the address field/offset) to the variable content of an index register to calculate the final memory address, making it ideal for array traversal.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('addressing-modes');

-- Q3 — Relocatable code addressing mode (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='addressing-modes' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which addressing mode is primarily used to facilitate the creation of position-independent (relocatable) code?',
  'PC-Relative Addressing',
  'Direct Addressing',
  'Register Indirect Addressing',
  'Implied Addressing',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> PC-relative addressing calculates addresses relative to the current Instruction Pointer. The code can be loaded anywhere in memory because jump targets are specified as offsets rather than absolute memory addresses.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('addressing-modes');

-- Q4 — Instruction length opcode expansion (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='instruction-formats' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A processor has a 16-bit instruction format. It supports 15 two-address instructions, where each address field is 6 bits long. How many one-address instructions can be supported using opcode expansion?',
  '15',
  '16',
  '64',
  '256',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Instruction = 16 bits. Address fields = 6 bits each. Two-address instruction uses 12 bits for addresses, leaving 4 bits for the opcode. Opcode space = $2^4 = 16$. 15 are used, so 1 opcode is left. This 1 opcode escapes to the next level. Since a one-address instruction frees up one 6-bit address field, we have $1 \times 2^6 = 64$ available one-address instructions.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('coa-performance');

-- Q5 — Subroutine call instructions (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='instruction-formats' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following operations MUST occur implicitly when a hardware CALL instruction is executed?',
  'The processor switches to kernel mode',
  'The return address (PC value) is pushed onto the call stack',
  'All general-purpose registers are saved to memory',
  'The Instruction Register is cleared',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A CALL instruction transfers control to a subroutine. To allow returning later, the hardware must automatically save the current Program Counter (the return address) onto the stack before jumping.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('addressing-modes');

-- Q6 — Zero-address architecture (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics 'instruction-formats' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a pure zero-address machine architecture, how are operands for arithmetic instructions provided?',
  'Operands are fetched sequentially from a designated array',
  'Operands are explicitly included in the instruction opcode',
  'Operands are implicitly popped from the top of the evaluation stack',
  'Operands are always read from specific I/O ports',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Zero-address architectures are stack machines. Arithmetic instructions like ADD take no operands explicitly; they implicitly pop the top two values from the stack, add them, and push the result back.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('addressing-modes');

-- Q7 — IEEE 754 precision (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='floating-point' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the IEEE 754 single-precision (32-bit) floating-point format, how many bits are allocated to the exponent and the mantissa (fraction), respectively?',
  'Exponent: 8, Mantissa: 23',
  'Exponent: 8, Mantissa: 24',
  'Exponent: 11, Mantissa: 52',
  'Exponent: 7, Mantissa: 24',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> IEEE 754 single-precision uses 1 sign bit, 8 exponent bits (with a bias of 127), and 23 fraction bits (which represent a 24-bit mantissa due to the implicit leading 1).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('floating-point');

-- Q8 — Floating point bias (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='floating-point' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Why does the IEEE 754 floating-point standard use a biased exponent representation rather than 2''s complement?',
  'It reduces the number of bits required to store the exponent',
  'It permits floating-point numbers to be correctly compared using standard integer comparison hardware',
  'It simplifies the hardware required to multiply mantissas',
  'It eliminates the need for a separate sign bit',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Biased exponents place the most negative exponent at 00...00 and the most positive at 11...11. This allows standard, fast integer comparators to perfectly compare floating-point numbers without needing specialized floating-point logic.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('floating-point');

-- Q9 — Microprogrammed CU concept (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='datapath-control' LIMIT 1),
  (SELECT id FROM topics WHERE slug='microprogrammed-cu' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In a microprogrammed control unit, what does a single microinstruction typically represent?',
  'An entire high-level language statement',
  'One complete machine instruction fetch-decode-execute cycle',
  'A set of control signals asserted simultaneously during one clock cycle to operate datapath components',
  'A memory-to-memory block transfer command',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> A microinstruction controls the hardware directly. It outputs the 1s and 0s needed for multiplexers, registers, and the ALU for exactly one datapath clock cycle. A sequence of microinstructions makes up one machine instruction.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('microprogramming');

-- Q10 — Hardwired vs Microprogrammed (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='datapath-control' LIMIT 1),
  (SELECT id FROM topics WHERE slug='hardwired-cu' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following is a primary advantage of a Hardwired Control Unit over a Microprogrammed Control Unit?',
  'It is much easier to modify or add new instructions later',
  'It operates significantly faster because it relies on combinational logic rather than ROM access loops',
  'It requires fewer logic gates for complex instruction sets (CISC)',
  'It supports dynamic microcode updates',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Hardwired control uses direct logic gates, finite state machines, and multiplexers, making it extremely fast. Microprogrammed control requires looking up microinstructions from a control memory, adding delays, but it is much easier to modify.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('microprogramming');

-- Q11 — Vertical vs Horizontal Microcode (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='datapath-control' LIMIT 1),
  (SELECT id FROM topics WHERE slug='microprogrammed-cu' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the context of microprogrammed control, what distinguishes Horizontal microprogramming from Vertical microprogramming?',
  'Horizontal microcode assigns one bit per control signal and is wider, while Vertical encodes groups of mutually exclusive signals into fewer bits and uses decoders',
  'Horizontal microcode supports branch instructions, whereas Vertical only executes sequentially',
  'Horizontal microcode is stored in RAM, whereas Vertical is stored in ROM',
  'Horizontal microcode is used solely for floating-point operations',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Horizontal microinstructions are long/wide because no decoding is needed — one bit directly drives one control line. Vertical compresses the microinstruction length by encoding independent groups of signals, requiring decoders but saving control ROM space.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('microprogramming');

-- Q12 — Carry Look-Ahead Adder (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='alu-design' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A Carry Look-Ahead Adder (CLA) significantly improves addition speed compared to a Ripple Carry Adder. Which fundamental concept does CLA use to achieve this?',
  'It uses shift registers instead of combinational logic for summation',
  'It computes the carry out for each bit position in parallel by evaluating Generate (G) and Propagate (P) functions, breaking the sequential carry chain',
  'It converts binary numbers to BCD before performing addition',
  'It relies on a microprogrammed ROM lookup table to find the sum',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A ripple carry adder waits for the carry to ripple through each bit sequentially. A CLA calculates if a bit stage will generate a carry ($G_i$) or propagate a carry ($P_i$), allowing the carry for any bit position to be computed in constant time.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('coa-performance');

-- Q13 — Instruction fetching sequence (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='datapath-control' LIMIT 1),
  (SELECT id FROM topics WHERE slug='datapath' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'During the instruction fetch phase of a CPU, which of the following sequences of register transfers correctly describes the action?',
  'MAR ← PC ; MBR ← Memory[MAR] ; IR ← MBR ; PC ← PC + 1',
  'PC ← MAR ; IR ← Memory[PC] ; MBR ← IR + 1',
  'MBR ← PC ; MAR ← Memory[MBR] ; PC ← IR + 1',
  'IR ← PC ; MAR ← Memory[IR] ; PC ← PC + 1',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The PC holds the address, which is placed in the Memory Address Register (MAR). The memory is read into the Memory Buffer Register (MBR/MDR). The instruction is moved from MBR to the Instruction Register (IR). Finally, the PC is incremented.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('addressing-modes');

-- Q14 — Sign extension purpose (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='instructions-alu' LIMIT 1),
  (SELECT id FROM topics WHERE slug='alu-design' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'When executing an I-type instruction (like ADDi) that contains a 16-bit 2''s complement immediate value, what must the ALU datapath do before adding it to a 32-bit register?',
  'Multiply the immediate by 4 to align it',
  'Pad the upper 16 bits with zeroes',
  'Sign-extend the immediate to 32 bits by copying its Most Significant Bit (MSB)',
  'Invert the immediate value',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> To maintain the correct mathematical value of a 2''s complement negative (or positive) number when expanding its bit width, the sign bit must be replicated across the newly added upper bits — this is sign extension.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('alu-design');

-- Part 2 Complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COA PYQ SEED v2  (Part 3 / 8)
-- MCQ Questions Q15–Q28 (Memory Hierarchy & I/O)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — Temporal locality concept (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Cache memory relies heavily on the Principle of Locality. Which of the following best describes "Temporal Locality"?',
  'Code that accesses memory addresses that are numerically close together',
  'Data items that are grouped in the same cache line',
  'If a memory location is referenced, it will likely be referenced again in the near future',
  'Instructions executing in sequential order without branching',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Temporal locality refers to time. If an item (like a loop variable) is accessed, it is highly probable it will be accessed again soon. Spatial locality refers to space (items nearby in memory will likely be accessed soon).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q16 — Direct Mapped Cache mapping (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-mapping' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a Direct-Mapped cache organization, how is a memory block assigned to a cache line?',
  'A block can be placed in any available cache line',
  'A block is placed based on its Least Recently Used (LRU) status',
  'A block $M$ can only be placed in cache line $L$ where $L = M \mod (\text{number of cache lines})$',
  'A block is stored in fully associative tags based on its page number',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Direct mapping uses the modulo operation to map every memory block to exactly one specific cache line. This makes lookups very fast, as only one tag needs to be checked, but increases conflict fault rates.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache-mapping');

-- Q17 — Cache replacement policy LRU (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-mapping' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which cache mapping technique absolutely requires a replacement policy (such as LRU or FIFO)?',
  'Direct-Mapped Cache',
  'Only Set-Associative Cache',
  'Fully-Associative and Set-Associative Caches',
  'Neither; cache hardware handles replacement automatically without policies',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> In a direct-mapped cache, a block maps to one specific line, so there is no choice of which line to evict. In fully-associative or set-associative caches, the new block can go into one of multiple lines within a set, thus requiring a replacement policy to choose the "victim."</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache-mapping');

-- Q18 — Write-through vs Write-back (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a cache memory system, what is the defining characteristic of a "Write-back" policy?',
  'Every write operation simultaneously updates the cache and the main memory',
  'Writes only update the cache; main memory is updated only when the modified cache block is evicted',
  'Writes are written directly to main memory bypassing the cache entirely',
  'Writes cause the cache line to be invalidated immediately',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Write-back keeps the modified data in cache without slowing down the CPU by writing to slow RAM. A "dirty bit" is used to track modification. The block is only written back to RAM when it must be replaced.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q19 — Memory interleaving (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='main-memory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Memory interleaving is primarily used to:',
  'Increase the maximum addressable memory space',
  'Provide virtual memory support for multiprogramming',
  'Increase the effective memory bandwidth by accessing multiple memory chips in parallel',
  'Reduce the power consumption of RAM',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> By dividing memory into $N$ independently accessible banks and distributing sequential addresses across them (low-order interleaving), the CPU can fetch $N$ consecutive words simultaneously, greatly multiplying bandwidth.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('coa-performance');

-- Q20 — DMA concept (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Direct Memory Access (DMA) allows which operation to occur without continuous CPU involvement?',
  'Floating point arithmetic operations',
  'Bulk data transfer directly between an I/O peripheral and Main Memory',
  'Instruction decoding and pipeline management',
  'Translation of logical addresses to physical addresses',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> DMA offloads the slow, tedious process of moving blocks of data (e.g., from a hard drive to RAM) to a dedicated DMA controller. The CPU initiates the transfer and can perform other tasks until the DMA issues an interrupt upon completion.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q21 — Cycle stealing in DMA (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the context of DMA, what is meant by "Cycle Stealing"?',
  'The CPU stealing clock cycles from the system timer',
  'The DMA controller taking control of the system bus for one memory cycle to transfer a single word, forcing the CPU to pause briefly',
  'The operating system prioritizing background tasks over active processes',
  'Two DMA controllers fighting for bus mastery',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In cycle stealing mode, the DMA controller transfers data one word at a time by requesting the bus. The CPU is delayed for just that one memory cycle ("stealing" it), allowing the CPU to execute instructions in parallel with the transfer.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q22 — Memory-Mapped I/O vs Isolated I/O (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following statements characterizes Memory-Mapped I/O?',
  'Special instructions like IN and OUT are required to access peripherals',
  'The same CPU instructions used to access memory (e.g., LOAD, STORE) are used to access I/O devices',
  'It provides a separate address space exclusively for I/O ports',
  'It cannot be used in systems with DMA controllers',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In Memory-Mapped I/O, device registers are assigned addresses within the single unified main memory address space. Any instruction capable of operating on memory can operate on an I/O device without needing specialized I/O instructions (unlike Isolated/Port-based I/O).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q23 — Interrupt acknowledge vector (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'When a vectored interrupt occurs, the interrupting device sends the CPU:',
  'The complete interrupt service routine code',
  'An address (or offset) pointing to the start of the interrupt service routine',
  'A special HALT signal',
  'A floating-point error code',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In a vectored interrupt system, the device identifies itself by providing an interrupt vector. The CPU uses this vector as an index into an Interrupt Vector Table to find the memory address of the specific ISR to execute.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q24 — TLB matching phase (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a system combining virtual memory and cache, checking the TLB occurs:',
  'Before the cache accesses the data',
  'After the cache access fails',
  'In parallel with the cache index lookup if the cache is virtually indexed and physically tagged',
  'Only when a disk page fault occurs',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> To maximize speed, Modern CPUs often use a VIPT (Virtually Indexed, Physically Tagged) cache. The virtual index bits are used to start retrieving the cache line simultaneously while the TLB translates the virtual tag into a physical tag. The tags are then compared.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q25 — Cache conflict miss (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A cache miss that occurs because too many active blocks map to the exact same cache set, even though there is still empty space elsewhere in the cache, is called a:',
  'Compulsory Miss',
  'Capacity Miss',
  'Conflict Miss',
  'Coherence Miss',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Conflict (or collision) misses happen in direct-mapped or set-associative caches when the specific mapped set fills up, forcing evictions, despite the cache as a whole not being full. Fully associative caches avoid conflict misses.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q26 — Flash memory wear leveling (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='main-memory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'SSDs use "wear leveling" algorithms primarily to solve which fundamental limitation of NAND flash memory?',
  'Flash memory is volatile and loses data without constant refreshing',
  'Flash memory cells endure physical degradation and can only sustain a limited number of erase/write cycles',
  'Flash memory has a significantly higher read latency than magnetic disks',
  'Flash memory suffers from destructive reads',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> NAND flash insulating oxide degrades with every high-voltage tunnel-release (erase cycle). Wear leveling continuously remaps logical addresses to different physical cells to ensure all cells degrade evenly, preventing premature drive failure.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q27 — Virtual Memory Page Table location (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='main-memory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Where is the complete Page Table for a process stored in a virtual memory system?',
  'In the CPU Translation Lookaside Buffer (TLB)',
  'In the L1 Cache',
  'In Main Memory (RAM)',
  'Hardcoded into the Memory Management Unit (MMU) hardware',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Page tables for modern operating systems are large (often megabytes). They are stored in Main Memory. The CPU hardware only contains a small register (like PTBR in x86) pointing to the table''s base address in RAM, and caches active entries in the TLB.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q28 — Bus Arbitration Daisy Chaining (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a daisy-chained bus arbitration scheme, how is priority determined among multiple requesting I/O devices?',
  'Priority is assigned randomly by the CPU every cycle',
  'Priority is determined solely by the physical proximity (electrical connection order) to the bus arbiter',
  'Devices use a token ring mechanism to pass fairness tickets',
  'The devices negotiate using priority priority-codes on a dedicated polling bus',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In daisy-chaining, the Bus Grant signal passes serially from the arbiter to the first device, then to the second, etc. The device physically closest to the arbiter intercepts the grant signal first, giving it inherently higher priority.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Part 3 Complete.
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
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COA PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2: Memory & I/O (11 Cards) + COMMIT
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES

-- Card 12
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'Explain Temporal vs Spatial Locality.',
  '<p><strong>Temporal:</strong> If a memory location is accessed, it will likely be accessed again soon (e.g., loops/variables). Exploited by caching.<br><strong>Spatial:</strong> If a location is accessed, nearby locations will likely be accessed soon (e.g., arrays). Exploited by larger cache block sizes.</p>',
  ARRAY['cache']
),

-- Card 13
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-mapping' LIMIT 1),
  'How is a physical address strictly partitioned for Direct-Mapped vs Set-Associative Cache?',
  '<ul><li><strong>Direct-Mapped:</strong> Tag | Line Index | Block Offset</li><li><strong>Set-Associative:</strong> Tag | Set Index | Block Offset</li></ul><p>Number of Index bits = log₂ of (Number of Lines or Sets). Offset bits = log₂ of (Block Size in Bytes).</p>',
  ARRAY['cache-mapping']
),

-- Card 14
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'Define AMAT (Average Memory Access Time).',
  '<p><strong>AMAT = Hit Time + (Miss Rate × Miss Penalty)</strong><br>Where hit time is the cache access time, and miss penalty is the time taken to fetch the block from lower-level memory.</p>',
  ARRAY['cache','coa-performance']
),

-- Card 15
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'What are the 3 C''s of Cache Misses?',
  '<p><strong>Compulsory (Cold):</strong> First-time access. Inevitable.<br><strong>Capacity:</strong> Cache is full. Solved by larger cache.<br><strong>Conflict (Collision):</strong> Set/Line is full due to mapping collisions, though cache has empty space elsewhere. Solved by higher associativity.</p>',
  ARRAY['cache']
),

-- Card 16
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'Compare Write-Through vs Write-Back cache policies.',
  '<p><strong>Write-Through:</strong> Updates cache and main memory simultaneously. Slower, but mathematically consistent.<br><strong>Write-Back:</strong> Updates only cache. Sets a "Dirty Bit". Main memory is updated only when the block is evicted. Faster, uses less bus bandwidth.</p>',
  ARRAY['cache']
),

-- Card 17
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='main-memory' LIMIT 1),
  'What is Memory Interleaving and why is High-Order vs Low-Order different?',
  '<p>Interleaving divides memory into multiple independently accessed banks to increase bandwidth.<br><strong>High-Order:</strong> MSBs select bank. Contiguous addresses are in the same bank (good for module isolation).<br><strong>Low-Order:</strong> LSBs select bank. Contiguous addresses are spread across banks (allows parallel fetching).</p>',
  ARRAY['coa-performance']
),

-- Card 18
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'Define Direct Memory Access (DMA).',
  '<p>A hardware controller that transfers blocks of data directly between an I/O device and Main Memory without CPU intervention, utilizing bus cycles only when the CPU doesn''t need them (or cycle-stealing).</p>',
  ARRAY['dma']
),

-- Card 19
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'What is the difference between Memory-Mapped I/O and Isolated I/O?',
  '<p><strong>Memory-Mapped:</strong> I/O registers share address space with RAM. Standard CPU instructions (LOAD/STORE) access them.<br><strong>Isolated (Port-Mapped):</strong> I/O uses a separate address space. Requires special instructions (IN/OUT) and a distinct control pin on the CPU.</p>',
  ARRAY['dma']
),

-- Card 20
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'What is a TLB and what does it cache?',
  '<p><strong>Translation Lookaside Buffer:</strong> A specialized, ultra-fast fully-associative hardware cache inside the CPU ''s MMU. It caches recent Virtual-to-Physical page table translations to speed up virtual memory execution.</p>',
  ARRAY['cache']
),

-- Card 21
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'What is a Vectored Interrupt?',
  '<p>An interrupt where the hardware device asserts an IRQ and simultaneously provides an ID (vector) on the data bus. The CPU uses this vector to index an Interrupt Vector Table and directly jump to the specific ISR, skipping polling.</p>',
  ARRAY['dma']
),

-- Card 22
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='main-memory' LIMIT 1),
  'Why do SSDs use Wear Leveling?',
  '<p>NAND flash cells degrade physically with each erase/write cycle. Wear leveling algorithms dynamically remap logical blocks to different physical cells to ensure all cells degrade evenly, maximizing the drive''s total lifespan.</p>',
  ARRAY['cache']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing coa-seed.sql to verify data integrity:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='coa'));
-- Expected: 15
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='coa');
-- Expected: 65
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='coa')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='coa');
-- Expected: 22

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug:  coa
-- Schema:        v2 (normalized tags, NUMERIC(10,2) NAT answers, topic enforcement)
-- Chapters:      4
-- Topics:        15
-- Questions:     65 total
--   MCQ:         45 (Q1–Q45)
--   NAT:         10 (Q46–Q55)
--   MSQ:         10 (Q56–Q65)
-- Flashcards:    22 (11 per batch)
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF coa-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
