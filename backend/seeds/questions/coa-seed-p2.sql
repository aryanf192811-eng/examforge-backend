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
