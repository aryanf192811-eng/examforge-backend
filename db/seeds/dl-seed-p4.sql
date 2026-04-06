-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DL PYQ SEED v2  (Part 4 / 8)
-- MCQ Questions Q29–Q45 (Number Systems, Converters, Advanced Combinational)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q29 — 2's Complement Overflow (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='signed-numbers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'When adding two $n$-bit 2''s complement numbers, Arithmetic Overflow is strictly defined to have occurred if:',
  'There is a carry out from the Most Significant Bit (MSB)',
  'There is no carry out from the MSB',
  'The carry into the MSB differs from the carry out from the MSB',
  'The result is purely negative',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> In 2''s complement, a carry out of the MSB does not inherently mean overflow (it is often normal when negative numbers are involved). Overflow uniquely occurs when adding two numbers of the same sign produces a result of the opposite sign. Hardware detects this by checking if $C_{in}$ to the MSB $\neq C_{out}$ of the MSB ($C_{in} \oplus C_{out} = 1$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Q30 — Sign Extension in 2's Complement (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='signed-numbers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'How do you properly extend the 4-bit 2''s complement number `1010` (-6) into an 8-bit equivalent number without changing its mathematical value?',
  'Add four zeroes to the right: `10100000`',
  'Add four zeroes to the left: `00001010`',
  'Duplicate the sign bit into the new leftmost bits: `11111010`',
  'Invert all the bits: `01010101`',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Sign extension requires copying the Most Significant Bit (the sign bit) into all the new, higher-order bit positions to mathematically preserve both the sign and the magnitude in 2''s complement base-2 arithmetic.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Q31 — ADC Resolution calculation concept (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adc-dac' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In an $n$-bit Analog-to-Digital Converter (ADC), what does "resolution" theoretically determine?',
  'The maximum continuous input voltage the ADC can handle before burning out',
  'The smallest incremental change in the analog input voltage that will cause a 1 LSB change in the digital output',
  'The speed at which the conversion occurs (Sample rate)',
  'The clock frequency required for the converting capacitors',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Resolution defines the granularity or step size of the converter. It is calculated as $V_{Ref} / 2^n$. Any analog change smaller than this resolution cannot be distinguished by the digital output.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Q32 — Successive Approximation ADC (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adc-dac' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'How many clock cycles does a Successive Approximation Register (SAR) ADC require to convert an analog sample into an $n$-bit digital value?',
  '$n$',
  '$2^n$',
  '$2^n - 1$',
  '$1$ cycle',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> A SAR ADC uses a binary search algorithm, testing each bit from MSB to LSB one by one. Therefore, converting an $n$-bit value takes exactly $n$ iterations/clock cycles, making it a highly consistent and relatively fast converter.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Q33 — Flash ADC (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adc-dac' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A Flash ADC is the fastest type of Analog-to-Digital Converter. However, its primary drawback is that for an $n$-bit resolution, it explicitly requires:',
  'An external CPU to perform floating-point math',
  '$2^n - 1$ precision comparators running in parallel',
  'An elaborate temperature control system due to radiation',
  '$n$ clock cycles to process',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A Flash ADC compares the input voltage against a resistor ladder containing $2^n - 1$ distinct voltage thresholds simultaneously. While making it blazingly fast (1 clock cycle), the hardware cost ($2^n - 1$ comparators) scales exponentially, making high bit-depth Flash ADCs impractical.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Q34 — Shift Register types (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='registers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which type of shift register configuration is specifically required to convert serialized transmission data into a parallel format for a CPU bus?',
  'SISO (Serial-In, Serial-Out)',
  'SIPO (Serial-In, Parallel-Out)',
  'PISO (Parallel-In, Serial-Out)',
  'PIPO (Parallel-In, Parallel-Out)',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A SIPO (Serial-In, Parallel-Out) shift register receives data sequentially one bit at a time. Once the register is full, all bits can be read simultaneously across parallel output lines.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('counter');

-- Q35 — Frequency division flip flop (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='counters' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A T flip-flop has its T input permanently tied to logic HIGH (1). If a clock signal with frequency $f$ is applied, what is the frequency of the output signal $Q$?',
  '$f$',
  '$2f$',
  '$f / 2$',
  '$f / 4$',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> With $T=1$, the flip flop toggles its state on every active clock edge. It takes two clock edges (one to toggle HIGH, one to toggle LOW) to complete one full cycle of the output $Q$. Thus, the output frequency is strictly halved ($f / 2$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('flip-flop');

-- Q36 — Decoder vs Demultiplexer (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='decoders' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'How is a standard $n$-to-$2^n$ Decoder physically converted to operate as a 1-to-$2^n$ Demultiplexer (DeMUX)?',
  'By disconnecting all select lines',
  'By utilizing the Decoder''s Enable (EN) pin as the single Data Input, and the decoder inputs as Select Lines',
  'By replacing the internal AND gates with XOR gates',
  'By looping the outputs back to the inputs',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A Demultiplexer routes one input to one of many outputs. A decoder activates one output based on select lines. If the data to be transmitted is piped into the decoder''s global Enable pin, the selected output line will mirror the Enable data, effectively achieving Demultiplexing.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('multiplexer');

-- Q37 — Carry-Save Adder purpose (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adders-sub' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'In digital arithmetic, what is the primary structural application of a Carry-Save Adder (CSA)?',
  'It is used to add exactly two $n$-bit numbers faster than a Carry Look-Ahead Adder',
  'It is used exclusively for floating-point division algorithms',
  'It is used to add three or more binary numbers simultaneously by deferring carry propagation to the very last step',
  'It stores the final carry bit internally to be read by the software flags register',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Adding multiple numbers normally requires severe carry propagation delays. A Carry-Save Adder takes three operands and adds them positionally using full adders without linking the carries horizontally. It outputs two arrays (a "sum" array and a shifted "carry" array), which are then resolved in one final fast adder stage. This is a staple in high-speed hardware multipliers (like Wallace Trees).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q38 — Min/Max terms representation (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='boolean-laws' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'If a boolean function of three variables is defined in Sum of Minterms format as $F(A,B,C) = \sum m(1, 3, 5, 7)$, what is its equivalent representation in Product of Maxterms format?',
  '$F(A,B,C) = \prod M(1, 3, 5, 7)$',
  '$F(A,B,C) = \prod M(0, 2, 4, 6)$',
  '$F(A,B,C) = \sum m(0, 2, 4, 6)$',
  '$F(A,B,C) = \prod M(0, 1, 2, 3)$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The minterms represent where the function evaluates to 1. The maxterms represent where the function evaluates to 0. A 3-variable function has $2^3=8$ total indices (0 through 7). The maxterms are simply the mathematical complement of the minterm indices: $\prod M(0, 2, 4, 6)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('k-map');

-- Q39 — Asynchronous active low inputs (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Many commercial flip-flops contain asynchronous PRESET and CLEAR input pins, often indicated with a bubble or an over-bar (e.g., $\overline{CLR}$). What does the asynchronous label structurally imply?',
  'They operate identically to the D or JK inputs but use inverted logic',
  'They immediately force the flip-flop to a specific state (1 or 0) regardless of the clock signal or other inputs',
  'They only function properly during the negative edge of the clock',
  'They are used specifically to generate asynchronous ripple delays',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> "Asynchronous" control pins bypass the clock mechanism entirely. If an active-low $\overline{CLR}$ is pulled LOW (0), the flip-flop instantly clears to $Q=0$ without waiting for a clock edge. They are used for global system resets.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('flip-flop');

-- Q40 — Glitches/Hazards in combinational circuits (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='circuit-delay' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What causes a "Static Hazard" (a momentary glitch) in a purely combinational arithmetic logic circuit?',
  'Unequal propagation delays along different convergent logic paths causing a temporary mismatch at the output gate',
  'The clock frequency being set too high for the flip-flops',
  'A short-circuit induced by race-around conditions',
  'Incorrect boolean minimization using Karnaugh maps',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Static hazards (glitches) occur when a single input change causes multiple internal signals to switch, but these signals travel through paths with different lengths/delays. If they arrive at the final gate at slightly different times, they can cause the output to momentarily spike or dip (glitch) before settling.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dl-delay');

-- Q41 — Eliminating static hazards (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics 'circuit-delay' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'How can Static-1 hazards in a two-level Sum of Products (SOP) circuit be theoretically eliminated?',
  'By ensuring the clock pulse is wide enough',
  'By strictly using the minimum number of prime implicants',
  'By adding redundant consensus terms in the K-map to bridge adjacent essential prime implicant groupings',
  'By placing inverter gates on all output lines',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> A Static-1 hazard occurs when switching between two adjacent minterm groups in a K-map. During the transition, if the product terms turn off/on at different speeds, the OR gate dips to 0. Adding a redundant geometric grouping (the consensus term) that overlaps the two adjacent prime implicants ensures the OR gate receives a solid ''1'' throughout the transition.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dl-delay','k-map');

-- Q42 — Floating Point vs Fixed Point (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='number-systems' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'When comparing floating-point representation to fixed-point representation for a given 32-bit width, which of the following statements is mathematically true?',
  'Floating-point provides infinite precision for fractional values',
  'Floating-point represents a dramatically wider dynamic range of values but sacrifices absolute precision',
  'Fixed-point is solely used for purely integer data, while floating point handles all fractions',
  'Fixed-point representations require complex exponent calculation hardware',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Fixed-point maintains a constant, uniform gap (precision) between every representable number. Floating-point allocates bits to an exponent, allowing it to represent extremely massive and infinitesimally small numbers (high dynamic range). The tradeoff is that the gap between representable numbers widens as the numbers get larger, sacrificing uniform precision.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Q43 — Dual of a Boolean Expression (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='boolean-laws' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'To completely derive the "Dual" of a Boolean logic expression, what exact substitutions must be made?',
  'Interchange AND ($\cdot$) with OR ($+$), and interchange $1$s with $0$s. Literals ($A$) are NOT complemented.',
  'Interchange AND with OR, and complement all literals (replace $A$ with $\bar{A}$)',
  'Invert the entire expression using a giant over-bar',
  'Replace every XOR with XNOR',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The principle of duality in Boolean algebra states that an expression remains structurally valid if you swap all AND operators with OR operators (and vice versa) and swap all strictly defined 0s with 1s. Unlike the Complement (De Morgan), you <em>do not</em> invert the variable variables themselves.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q44 — J-K flip flop characteristic equation (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The characteristic equation outlining the next-state $Q_{t+1}$ behavior of a JK Flip-Flop is:',
  '$Q_{t+1} = J\bar{K} + \bar{J}K$',
  '$Q_{t+1} = J\bar{Q}_t + \bar{K}Q_t$',
  '$Q_{t+1} = JQ_t + K\bar{Q}_t$',
  '$Q_{t+1} = \bar{J}\bar{K}Q_t$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The JK characteristic equation is $Q_{t+1} = J\bar{Q}_t + \bar{K}Q_t$. If $J=1, K=0$: $Q_{t+1} = 1\cdot\bar{Q}_t + 1\cdot Q_t = 1$ (Set). If $J=0, K=1$: $Q_{t+1} = 0 + 0 = 0$ (Reset). If $J=1, K=1$: $Q_{t+1} = 1\cdot\bar{Q}_t + 0 = \bar{Q}_t$ (Toggle).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('flip-flop');

-- Q45 — BCD Representation (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='number-systems' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In Binary Coded Decimal (BCD - 8421 code), what is the valid binary limit for a single decimal digit representation?',
  'From 0000 to 1111',
  'From 0000 to 1001',
  'From 0000 to 0111',
  'From 0001 to 1010',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> BCD strictly maps each singular decimal digit (0 through 9) into its 4-bit binary equivalent. The binary sequences from `1010` (10) through `1111` (15) are mathematically invalid in BCD.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Part 4 Complete.
