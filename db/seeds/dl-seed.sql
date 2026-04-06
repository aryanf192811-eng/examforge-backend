-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DL PYQ SEED v2  (Part 1 / 8)
-- Subject: Digital Logic (dl)
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
    'Digital Logic', 'dl',
    'Boolean algebra, K-maps, combinational & sequential circuits, and number representations.',
    '#10b981', '#059669', 'cpu' -- emerald
  )
  ON CONFLICT (slug) DO UPDATE
    SET title = EXCLUDED.title, description = EXCLUDED.description
  RETURNING id INTO subj_id;

  -- 2. Chapters
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Boolean Algebra & Logic Gates', 'boolean-logic', 1) RETURNING id INTO ch1_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Combinational Circuits', 'combinational', 2) RETURNING id INTO ch2_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Sequential Circuits & Counters', 'sequential', 3) RETURNING id INTO ch3_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Number Systems & Converters', 'numbers-converters', 4) RETURNING id INTO ch4_id;

  -- 3. Topics
  -- Chapter 1: Boolean Algebra & Logic Gates
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'logic-gates',     'Basic & Universal Logic Gates',     1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'boolean-laws',    'Boolean Laws & Theorems',           2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'k-maps',          'Karnaugh Maps & Minimization',      3) ON CONFLICT DO NOTHING;

  -- Chapter 2: Combinational Circuits
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'adders-sub',      'Adders & Subtractors',              1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'multiplexers',    'Multiplexers & Demultiplexers',     2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'decoders',        'Decoders & Encoders',               3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'circuit-delay',   'Combinational Circuit Delays',      4) ON CONFLICT DO NOTHING;

  -- Chapter 3: Sequential Circuits & Counters
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'flip-flops',      'Latches & Flip-Flops',              1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'state-machines',  'Finite State Machines (Mealy/Moore)',2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'counters',        'Synchronous & Asynchronous Counters',3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'registers',       'Shift Registers',                   4) ON CONFLICT DO NOTHING;

  -- Chapter 4: Number Systems & Converters
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'number-systems',  'Base Conversions & Number Systems', 1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'signed-numbers',  'Signed Numbers & 2s Complement',    2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'adc-dac',         'ADC & DAC Converters',              3) ON CONFLICT DO NOTHING;

  -- 4. Tags
  INSERT INTO tags (name, slug) VALUES ('Boolean Algebra', 'boolean-algebra') ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('K-Map',           'k-map')           ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Multiplexer',     'multiplexer')     ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Flip-Flop',       'flip-flop')       ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Counter',         'counter')         ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('State Machine',   'state-machine')   ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Delay',           'dl-delay')        ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Number System',   'number-system')   ON CONFLICT DO NOTHING;

END $$;

-- Part 1 Complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DL PYQ SEED v2  (Part 2 / 8)
-- MCQ Questions Q1–Q14 (Boolean Algebra & Combinational Circuits)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — NAND Universal Gate property (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='logic-gates' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Why is the NAND gate considered a universal gate?',
  'It has the fastest switching time of all logic gates',
  'It consumes the least power among all boolean gates',
  'Any boolean logic expression can be implemented using only NAND gates',
  'It is the only gate that can inherently store state',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> A universal gate (NAND or NOR) can be combined to implement the fundamental operations of AND, OR, and NOT. Consequently, any arbitrary combinational boolean function can be built exclusively from NAND gates.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q2 — Boolean Identity Consensus theorem (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='boolean-laws' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The boolean expression $AB + \bar{A}C + BC$ can be simplified using the Consensus Theorem to:',
  '$AB + AC$',
  '$AB + \bar{A}C$',
  '$A + B + C$',
  '$B + C$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The Consensus Theorem states that $AB + \bar{A}C + BC = AB + \bar{A}C$. The term $BC$ is redundant (the consensus of $AB$ and $\bar{A}C$) and can be eliminated because whenever $B=1$ and $C=1$, $A$ must be either $1$ (making $AB=1$) or $0$ (making $\bar{A}C=1$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q3 — XOR gate properties (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='logic-gates' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'For a 2-input XOR gate, the output is TRUE (1) strictly when:',
  'Both inputs are TRUE',
  'Exactly one input is TRUE',
  'At least one input is TRUE',
  'Both inputs are FALSE',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The Exclusive-OR (XOR) gate performs modulo-2 addition. It outputs 1 if and only if the inputs are different (e.g., exactly one input is 1). If both inputs are the same (0,0 or 1,1), the output is 0.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q4 — Function of half adder (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adders-sub' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What logic gates are required to construct a standard Half Adder circuit that computes the Sum ($S$) and Carry ($C$) of two bits $A$ and $B$?',
  'One AND gate, One OR gate',
  'One XOR gate, One AND gate',
  'Two XOR gates',
  'One NOR gate, One NAND gate',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In purely binary addition, $Sum = A \oplus B$ (XOR gate) and $Carry = A \cdot B$ (AND gate). A Half Adder does not process a carry-in from a previous stage.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q5 — K-Map grouping size (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='k-maps' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In a Karnaugh Map (K-map), grouping $2^n$ adjacent cells containing 1s helps in logic minimization. What is the effect of grouping exactly 8 cells?',
  'It eliminates 1 variable from the boolean product term',
  'It eliminates 2 variables from the boolean product term',
  'It eliminates 3 variables from the boolean product term',
  'It eliminates 4 variables from the boolean product term',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Grouping $2^k$ adjacent cells in a K-map eliminates exactly $k$ variables. An octet (8 cells = $2^3$) eliminates 3 variables, leaving a much simpler product term.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('k-map');

-- Q6 — Prime Implicants definition (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='k-maps' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In boolean logic minimization, what defines an Essential Prime Implicant?',
  'It is a prime implicant that covers the maximum number of minterms in the K-Map',
  'It is a prime implicant that covers at least one minterm which is not covered by any other prime implicant',
  'It is the prime implicant generated solely by grouping Don''t Care (X) conditions',
  'It is a prime implicant containing exactly two literals',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A prime implicant is "essential" if it uniquely covers a minterm. If a minterm is covered by only one prime implicant, that prime implicant must fundamentally be included in the minimal Sum of Products (SOP) expression.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('k-map');

-- Q7 — Multiplexer function (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='multiplexers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following phrases best describes the function of a standard Multiplexer (MUX)?',
  'A logic circuit that activates one of its many outputs based on an input binary code',
  'A data selector that routes data from one of many input lines to a single output line based on select lines',
  'A circuit that temporarily stores binary data',
  'A hardware operator that adds two binary arrays',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A Multiplexer is a "many-to-one" combinatorial circuit. It uses control/select inputs to choose exactly one of its multiple data inputs and routes it to the single output.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('multiplexer');

-- Q8 — Subtractor using borrow in (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adders-sub' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a Full Subtractor that computes $A - B - B_{in}$, where $B_{in}$ is the borrow from the previous stage, the Boolean expression for the output Difference ($D$) is given by:',
  '$A \cdot B \cdot B_{in}$',
  '$A \oplus B \oplus B_{in}$',
  '$(A \oplus B) \cdot B_{in} + A \cdot B$',
  '$A + B + B_{in}$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The Difference output of a full subtractor is mathematically identical to the Sum output of a full adder. Taking the parity of three bits is done using XOR operations: $Difference = A \oplus B \oplus B_{in}$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q9 — Building larger MUX (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='multiplexers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'How many 4-to-1 Multiplexers are strictly required to construct a single 16-to-1 Multiplexer?',
  '4',
  '5',
  '8',
  '16',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A 16-to-1 MUX requires 16 inputs. We use four 4-to-1 MUXes at the first level to handle the 16 inputs. This gives 4 intermediate outputs. We feed these 4 outputs into a fifth 4-to-1 MUX at the second level. Total = 4 + 1 = <strong>5</strong> MUXes.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('multiplexer');

-- Q10 — Decoder properties (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='decoders' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'An $n$-to-$2^n$ line Decoder can be used to directly implement any combinational logic function of $n$ variables. How is this achieved?',
  'By connecting the inputs to a clock signal',
  'The decoder generates all $2^n$ minterms of $n$ variables, and an OR gate is used to sum the minterms corresponding to the function',
  'By using the decoder as a sequential counter machine',
  'A decoder cannot implement logic functions without additional XOR gates',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> An $n$-to-$2^n$ decoder perfectly decodes every possible $n$-bit binary input into exactly one active output line representing that specific minterm. An external OR gate simply collects the specific minterms where the logic function should be 1.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q11 — Propagation Delay definition (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='circuit-delay' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In digital logic, what does "Propagation Delay" of a logic gate refer to?',
  'The time between the rising edge and the falling edge of the clock signal',
  'The time required for an input signal change to cause a change in the output signal',
  'The minimum voltage required to trigger a gate switch',
  'The maximum time a value can be held in a latch',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Propagation delay (or gate delay) is the measure of time it takes for a newly applied input signal level to propagate through the transistor logic and produce a valid, stable response at the gate''s output.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dl-delay');

-- Q12 — Parity generator XOR cascade (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adders-sub' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A 4-bit Even Parity generator circuit evaluates inputs $A, B, C, D$. Which boolean expression best describes its minimal logic block?',
  '$P = A \cdot B \cdot C \cdot D$',
  '$P = A + B + C + D$',
  '$P = A \oplus B \oplus C \oplus D$',
  '$P = \bar{A} \cdot \bar{B} \cdot \bar{C} \cdot \bar{D}$',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Even parity requires the parity bit to be 1 if there is an odd number of 1s in the data bits (so the total number of 1s becomes even). A cascaded XOR tree ($A \oplus B \oplus C \oplus D$) mathematically computes modulo-2 addition, perfectly counting odd/even 1s.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q13 — De Morgan's Law (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='boolean-laws' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'According to De Morgan''s Theorem, the complement of a sum $\overline{(A + B)}$ is logically equivalent to:',
  '$\bar{A} + \bar{B}$',
  '$\bar{A} \cdot \bar{B}$',
  '$A \cdot B$',
  '$A \oplus B$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> De Morgan''s law dictates that the complement of a logical OR is the logical AND of the complements: $\overline{(A + B)} = \bar{A} \cdot \bar{B}$. This is the fundamental equivalency linking NOR and AND gates.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q14 — Binary to Gray Code conversion (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='number-systems' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'How is a specific bit $G_i$ determined when converting an $n$-bit binary number $B_{n-1} \dots B_0$ (where $B_{n-1}$ is the MSB) to Gray Code?',
  '$G_i = B_i$',
  '$G_{MSB} = B_{MSB}$, and $G_i = B_{i+1} \oplus B_i$ for subsequent bits',
  '$G_i = \bar{B_i}$',
  '$G_{MSB} = B_{MSB}$, and $G_i = B_{i+1} \cdot B_i$ for subsequent bits',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In Binary-to-Gray conversion, the most significant bit (MSB) remains identical. Every following Gray bit is obtained by XOR-ing the corresponding binary bit with the binary bit to its immediate left (higher significance).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Part 2 Complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DL PYQ SEED v2  (Part 3 / 8)
-- MCQ Questions Q15–Q28 (Sequential Logic, Counters, and Registers)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — Combinational vs Sequential (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the fundamental engineering distinction between Combinational and Sequential logic circuits?',
  'Combinational circuits use a clock signal, whereas sequential circuits operate asynchronously',
  'Sequential circuits possess memory (state) that depends on past inputs, while combinational outputs depend strictly on present inputs',
  'Combinational circuits are built with flip-flops, whereas sequential circuits use only logic gates',
  'Combinational circuits exclusively handle analog signals',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Combinational logic evaluates instantly (subject to propagation delay) based purely on current input. Sequential logic incorporates feedback loops to store state/memory, meaning its next output relies on both current inputs and its historical past state.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('flip-flop');

-- Q16 — Race Around Condition (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a fundamental level-triggered SR or JK flip-flop, the "Race Around Condition" occurs when:',
  'The inputs change at precisely the same moment as the clock edge',
  'The clock pulse width is significantly larger than the propagation delay of the flip-flop, and the toggle condition is active',
  'Two different flip-flops try to drive the same bus line simultaneously',
  'The power supply voltage dips below the threshold rating',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The Race Around Condition happens in level-triggered JK flip-flops when $J=1, K=1$ (Toggle mode). If the clock pulse stays HIGH longer than the gate delay, the output toggles repeatedly and unpredictably before the pulse ends.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('flip-flop');

-- Q17 — Master-Slave to prevent race-around (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which architectural modification is explicitly designed to eliminate the race-around condition in flip-flops?',
  'Adding an extra asynchronous RESET pin',
  'Using a Master-Slave arrangement',
  'Replacing all NAND gates with NOR gates',
  'Increasing the clock frequency drastically',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A Master-Slave configuration cascades two latches driven by inverted clock phases. The master accepts data when the clock is HIGH, while the slave is isolated. When the clock goes LOW, the master locks and the slave updates. This creates edge-triggered behaviour, preventing continuous toggling within a single clock pulse.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('flip-flop');

-- Q18 — D flip flop characteristic equation (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the characteristic equation for a D (Data) Flip-Flop, defining the next state $Q_{t+1}$?',
  '$Q_{t+1} = \bar{D}$',
  '$Q_{t+1} = D \oplus Q_t$',
  '$Q_{t+1} = D$',
  '$Q_{t+1} = D \cdot Q_t + \bar{D} \cdot \bar{Q}_t$',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The Data (Delay) flip-flop transparently passes its input $D$ to the output $Q$ on the active clock edge. Therefore, its next state is simply whatever the $D$ input is at that moment: $Q_{t+1} = D$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('flip-flop');

-- Q19 — Mealy vs Moore machine (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='state-machines' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the design of Finite State Machines, what is the primary defining distinction of a Moore machine compared to a Mealy machine?',
  'A Moore machine has fewer total states than a Mealy machine',
  'A Moore machine''s outputs depend strictly on its current internal state, independent of current external inputs',
  'A Moore machine can only be implemented using T flip-flops',
  'A Moore machine responds instantly to asynchronous input changes without waiting for a clock edge',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In a Moore machine, the combinational logic generating the output uses only the current State Register as its input. In a Mealy machine, the outputs depend on both the current State and the current external Inputs, often resulting in quicker outputs but risking asynchronous input glitches.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('state-machine');

-- Q20 — Setup time definition (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In sequential timing analysis, what does the parameter "Setup Time" ($T_{setup}$) define?',
  'The time required for an output to stabilize after a clock edge',
  'The minimum duration a clock pulse must remain HIGH',
  'The strict minimum time interval that data inputs must remain stable and unchanged BEFORE the active clock edge arrives',
  'The time it takes to reset a flip-flop to $Q=0$',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Setup time is the critical window before the triggering clock edge during which the data input must remain perfectly stable. If data changes within this window, the flip-flop may violate timing and enter metastability.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dl-delay');

-- Q21 — Modulo-N counter states (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='counters' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'How many distinct states can be theoretically represented by a generic Modulo-$N$ ($MOD\text{-}N$) counter?',
  '$2^N$',
  '$N$',
  '$N - 1$',
  '$N \div 2$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The modulus (MOD number) of a counter defines exactly how many unique, distinct states it sequences through before restarting the cycle. A MOD-10 counter has 10 states (e.g., 0 through 9).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('counter');

-- Q22 — Ring counter states (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='registers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'An $n$-bit standard Ring Counter is constructed by looping the output of an $n$-bit shift register back to its input. How many valid states will this counter cycle through in one complete sequence?',
  '$1$',
  '$n$',
  '$2n$',
  '$2^n - 1$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A standard Ring Counter preloads a single ''1'' bit and loops it circularly through the $n$ flip-flops. Therefore, the 1 bit appears in $n$ distinct positions, yielding exactly $n$ valid sequential states.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('counter');

-- Q23 — Johnson counter states (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='registers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A Johnson Counter (Twisted Ring Counter) is constructed similarly to a Ring Counter, but the inverted output $\bar{Q}$ of the last flip-flop is fed back. For an $n$-bit Johnson counter, how many states are in its sequence?',
  '$n$',
  '$2n$',
  '$2^n$',
  '$2^n - 1$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Because the inverted output is fed back, the shift register first fills with 1s from left to right, and then subsequently fills with 0s. This expanding and contracting sequence inherently yields exactly $2n$ unique states.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('counter');

-- Q24 — Ripple counter delay (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='counters' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'An Asynchronous (Ripple) Counter is fundamentally different from a Synchronous Counter because:',
  'It cannot be built using T flip-flops',
  'All its flip-flops do not share a common clock signal; instead, the output of one triggers the clock of the next',
  'It counts downwards instead of upwards',
  'It requires a complex combinatorial logic network to calculate its next state',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In a ripple counter, only the first flip-flop is driven by the external clock. Subsequent flip-flops are clocked by the $Q$ or $\bar{Q}$ outputs of the preceding stages. This creates an accumulating "ripple" propagation delay, making it significantly slower than a synchronous counter.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('counter');

-- Q25 — T-flip flop creation (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'How can a universal JK flip-flop be easily physically configured to operate purely as a T (Toggle) flip-flop?',
  'Connect the J and K pins together and apply the T input to both',
  'Tie J to Vcc (HIGH) and K to GND (LOW) permanently',
  'Connect the output Q back into the K input',
  'Leave the J and K pins floating to induce toggling',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> When $J$ and $K$ are tied together ($J=K=T$), applying $T=0$ means ($J=0, K=0$) causing "No Change". Applying $T=1$ means ($J=1, K=1$) causing a "Toggle". This exactly replicates T flip-flop behaviour.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('flip-flop');

-- Q26 — Metablity definition (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics 'flip-flops' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'In a flip-flop experiencing a timing violation (e.g., input data changing within the set-up/hold window), the device may enter a state known as Metastability. What characterizes this condition?',
  'The flip-flop permanently burns out due to excess current',
  'The flip-flop output begins functioning as a perfect sinusoidal oscillator',
  'The output voltage hovers unpredictably between valid logic HIGH and LOW states for a random period before eventually settling',
  'The flip-flop instantly and permanently locks into a logic 0 state',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> When setup/hold timing is violated, the internal feedback latches may balance on an unstable equilibrium (metastability) akin to a ball on a hill. The output voltage hovers randomly in a middle zone before ambient noise finally tips it into either 0 or 1. This can completely destabilise subsequent synchronous logic.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dl-delay');

-- Q27 — Multiplexer as function generator (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='multiplexers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A 4-to-1 Multiplexer has select lines $S_1$ and $S_0$. If the data inputs are $I_0 = 0$, $I_1 = 1$, $I_2 = 1$, and $I_3 = 0$, what Boolean logic gate function does the MUX implement with respect to inputs $S_1, S_0$?',
  'AND',
  'OR',
  'XOR',
  'XNOR',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The MUX output is $Y = \bar{S_1}\bar{S_0}I_0 + \bar{S_1}S_0I_1 + S_1\bar{S_0}I_2 + S_1S_0I_3$. Plugging in the inputs: $Y = \bar{S_1}S_0(1) + S_1\bar{S_0}(1) = S_1 \oplus S_0$. This is the exact truth table definition of an XOR gate.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('multiplexer');

-- Q28 — 2's Complement range (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='signed-numbers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the mathematical range of signed integer values that can be represented using an $n$-bit 2''s complement architecture?',
  '$-(2^{n-1} - 1)$ to $+(2^{n-1} - 1)$',
  '$-(2^{n-1})$ to $+(2^{n-1} - 1)$',
  '$0$ to $+(2^n - 1)$',
  '$-(2^{n-1} - 1)$ to $+(2^{n-1})$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> 2''s complement uses one bit for the sign. The positive half spans $0$ to $2^{n-1}-1$. Because 0 is technically "positive" (sign bit is 0), the negative half can accommodate one extra value, reaching exactly $-(2^{n-1})$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Part 3 Complete.
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
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DL PYQ SEED v2  (Part 5 / 8)
-- NAT Questions Q46–Q55 (Numerical Calculations)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q46 — Max Minterms (easy)
-- Variables = 5. Minterms = 2^5 = 32
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='k-maps' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'A Boolean function consists of exactly 5 independent variables. What is the maximum number of distinct minterms that can be generated for this function?',
  32.00,32.00,NULL,
  '<p><strong>✓ Answer: 32.</strong></p><p><strong>Rationale:</strong> The number of minterms for an $n$-variable Boolean function is strictly defined as $2^n$. For $n=5$, we have $2^5 = <strong>32</strong>$ unique combinations row-entries in the truth table, thus 32 minterms.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('k-map');

-- Q47 — Base conversion (medium)
-- Convert (123)_5 to Decimal
-- 1*25 + 2*5 + 3*1 = 25 + 10 + 3 = 38
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='number-systems' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'Consider the number $N = (123)_5$, which is represented in base 5. What is the equivalent decimal (base 10) value of this number?',
  38.00,38.00,NULL,
  '<p><strong>✓ Answer: 38.</strong></p><p><strong>Rationale:</strong> Value = $1 \times 5^2 + 2 \times 5^1 + 3 \times 5^0$ = $25 + 10 + 3$ = <strong>38</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Q48 — Modulo counter flip-flops required (easy)
-- Mod-100 counter requires log2(100) -> 7 flip flops (2^6=64, 2^7=128)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='counters' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'What is the absolutely minimum number of flip-flops required to construct a MOD-100 discrete state counter?',
  7.00,7.00,NULL,
  '<p><strong>✓ Answer: 7.</strong></p><p><strong>Rationale:</strong> We need $n$ flip-flops such that $2^n \ge \text{MOD}$. For MOD-100, $2^6 = 64$ (too small), but $2^7 = 128$ (sufficient). Therefore, exactly <strong>7</strong> flip-flops are needed.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('flip-flop','counter');

-- Q49 — Propagation delay of ripple counter (medium)
-- 8 bit ripple counter. Each flip flop delay = 10ns.
-- Total max delay to settle = 8 * 10 = 80 ns.
-- Max freq = 1 / 80ns = 12.5 MHz
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='counters' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'An 8-bit asynchronous ripple counter is built from flip-flops that each have a propagation delay of 10 ns. What is the theoretical maximum clock frequency (in MHz) that can be applied to this counter ensuring it stabilizes before the next pulse?',
  12.50,12.50,NULL,
  '<p><strong>✓ Answer: 12.5.</strong></p><p><strong>Rationale:</strong> In a ripple counter, the clock ripples sequentially through every flip-flop. Maximum total settling delay $T = n \times t_{pd} = 8 \times 10\text{ns} = 80\text{ns}$. Maximum Frequency $f = 1 / T = 1 / (80 \times 10^{-9})$ = $12.5 \times 10^6\text{Hz}$ = <strong>12.5 MHz</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('counter','dl-delay');

-- Q50 — ADC Step Size (medium)
-- 10-bit ADC. Vref = 5V.
-- Step size (resolution) = 5 / (2^10 - 1)? Or 5 / 2^10
-- Technically resolution is Vref / 2^n in standard problems.
-- 5 / 1024 = 0.0048828 V = 4.88 mV.
-- Gate usually uses (2^n - 1) or 2^n depending on wording. If asking for step size = Vref / 2^n = 5 / 1024 = 4.88
-- Let's define Vref / (2^n - 1) which is also common: 5/1023 = 4.88. Both round to roughly 4.88. Let's provide range 4.87 to 4.89.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adc-dac' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A 10-bit Analog-to-Digital Converter algorithm has a full-scale voltage range of 0V to 5V. Calculate its resolution (step size) in millivolts (mV). (Provide answer rounded to 2 decimal places).',
  4.87,4.89,NULL,
  '<p><strong>✓ Answer: 4.88.</strong></p><p><strong>Rationale:</strong> Resolution = $V_{ref} / 2^n = 5\text{V} / 1024 = 0.0048828\text{V} = 4.8828\text{mV}$. (Using the $2^n-1$ convention yields $5 / 1023 = 4.887\text{mV}$. Both safely round within the 4.88 range).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Q51 — Number of MUXes for a boolean function (medium)
-- 4 variable function f(A,B,C,D). Implemented using an 8-to-1 MUX.
-- A,B,C are select lines. Inputs to MUX are D, D', 0, 1.
-- Need exactly 1 8-to-1 MUX.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='multiplexers' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'What is the minimum number of 8-to-1 Multiplexers strictly required to implement any completely arbitrary 4-variable boolean logic function $F(A,B,C,D)$, assuming you have access to un-complemented and complemented external input variables?',
  1.00,1.00,NULL,
  '<p><strong>✓ Answer: 1.</strong></p><p><strong>Rationale:</strong> An $n$-variable boolean function can always be implemented using a single $2^{n-1}$-to-1 MUX. For $n=4$, we need a $2^3$-to-1 (8-to-1) MUX. Variables A, B, C map to the select lines, and we program the 8 input lines with logical $0$, $1$, $D$, or $\bar{D}$ depending on the truth table.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('multiplexer');

-- Q52 — Propagation delay addition (medium)
-- 4-bit Ripple Carry Adder. Full adder sum delay = 20ns, carry delay = 15ns.
-- Delay for C4 = 4 * carry delay = 60ns.
-- Delay for S4 = 3 * carry delay + SUM delay = 45 + 20 = 65ns. Total delay = 65ns.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='circuit-delay' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A 4-bit ripple carry adder is constructed from four full adders. Each full adder has a Carry logic propagation delay of 15 ns and a Sum logic propagation delay of 20 ns. Assuming all inputs arrive simultaneously at $t=0$, at what time (in ns) will the final Sum bit ($S_3$) become completely stable?',
  65.00,65.00,NULL,
  '<p><strong>✓ Answer: 65.</strong></p><p><strong>Rationale:</strong> To compute $S_3$ (the 4th sum bit), the carry must ripple through the first three full adders: $C_1, C_2, C_3$. This takes $3 \times 15\text{ns} = 45\text{ns}$. Once $C_3$ arrives at the final adder, it takes another $20\text{ns}$ for the Sum logic of that stage to compute $S_3$. Total = $45 + 20 = <strong>65\text{ns}</strong>$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dl-delay');

-- Q53 — Radix mathematical solving (hard)
-- (73)_x = (54)_y
-- Minimum possible value of x + y?
-- 7x + 3 = 5y + 4 -> 7x - 5y = 1
-- Since digits are 7, x >= 8. Since digits are 5, y >= 6.
-- Try x=8: 7(8) - 5y = 56 - 5y = 1 -> 5y = 55 -> y = 11.
-- x=8, y=11. x+y = 19.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='number-systems' LIMIT 1),
  'gate-cse',false,NULL,'NAT','hard',2,
  'Consider the mathematical equation representing two numbers in different bases: $(73)_x = (54)_y$. What is the absolute minimum possible integer value for the sum of the bases $(x + y)$?',
  19.00,19.00,NULL,
  '<p><strong>✓ Answer: 19.</strong></p><p><strong>Rationale:</strong> Expand to polynomials: $7x + 3 = 5y + 4 \implies 7x - 5y = 1$. The digits explicitly constrain the bases: $x \ge 8$ (due to digit 7) and $y \ge 6$. Test $x=8$: $7(8) - 5y = 1 \implies 5y = 55 \implies y=11$. Both bases are valid. The sum is $8 + 11 = <strong>19</strong>$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Q54 — State changes in synchronous counter (medium)
-- How many flip-flops toggle when transitioning from 0111 to 1000? All 4 toggle.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='counters' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A 4-bit synchronous UP counter sequences through standard binary. When the counter transitions from the state `0111` to the state `1000`, exactly how many individual flip-flops undergo a state toggle?',
  4.00,4.00,NULL,
  '<p><strong>✓ Answer: 4.</strong></p><p><strong>Rationale:</strong> The transition is from $0111_2$ (7) to $1000_2$ (8). <br>Bit 0 changes $1 \to 0$ (toggles).<br>Bit 1 changes $1 \to 0$ (toggles).<br>Bit 2 changes $1 \to 0$ (toggles).<br>Bit 3 changes $0 \to 1$ (toggles).<br>Therefore, exactly <strong>4</strong> flip-flops toggle state.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('counter');

-- Q55 — Number of NAND gates to make XOR (hard)
-- Standard optimization: 4 NAND gates.
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='logic-gates' LIMIT 1),
  'gate-cse',false,NULL,'NAT','hard',2,
  'What is the absolute minimum number of two-input NAND gates strictly required to construct a functionally equivalent two-input XOR gate?',
  4.00,4.00,NULL,
  '<p><strong>✓ Answer: 4.</strong></p><p><strong>Rationale:</strong> The optimized mapping of $A \oplus B$ using only NAND gates requires a distinct cross-coupled architecture utilizing exactly <strong>4</strong> gates. (Gate 1: $X = \overline{A \cdot B}$. Gate 2: $\overline{A \cdot X}$. Gate 3: $\overline{B \cdot X}$. Gate 4 mathematically NANDs responses 2 and 3).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Part 5 Complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DL PYQ SEED v2  (Part 6 / 8)
-- MSQ Questions Q56–Q65 (Multi-Select)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q56 — MSQ: Universal Gates (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='logic-gates' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'Which of the following logic gates are strictly classified as "Universal Gates"? (Select all that apply)',
  'NOR',
  'XOR',
  'NAND',
  'XNOR',
  ARRAY['A','C'],
  '<p><strong>✓ Answers: A, C.</strong></p><p><strong>Rationale:</strong> A universal gate can singularly construct any arbitrary boolean logic function without requiring any other gate type. Only NAND (C) and NOR (A) possess this property. XOR and XNOR cannot implement functionally complete sets on their own.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q57 — MSQ: Multiplexer combinations (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='multiplexers' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following circuits can theoretically be explicitly implemented using a single 4-to-1 Multiplexer? (Select all that apply)',
  'Any arbitrary 2-variable boolean function',
  'A 1-to-4 Demultiplexer',
  'Any arbitrary 3-variable boolean function',
  'A 2-bit parallel adder',
  ARRAY['A','C'],
  '<p><strong>✓ Answers: A, C.</strong></p><p><strong>Rationale:</strong> A 4-to-1 MUX naturally implements any 2-variable function directly using just the select lines (A). By applying either logic 0, 1, the 3rd variable, or its complement to the data inputs, it can securely implement any 3-variable function as well (C). A Demultiplexer inverses connection direction (B is false). A generic parallel adder requires more structural complexity (D is false).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('multiplexer');

-- Q58 — MSQ: Flip Flop conversion (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following physical input wirings will successfully convert a standard J-K flip-flop into a D (Data) flip-flop? (Select all that apply)',
  'Connect $J = D$ and $K = \bar{D}$',
  'Connect $J = D$ and tie $K$ permanently to 1',
  'Connect $J$ to the output of a NOT gate fed by $D$, and $K$ directly to $D$',
  'Connect $K = \bar{J}$ and label $J$ as the input $D$',
  ARRAY['A','D'],
  '<p><strong>✓ Answers: A, D.</strong></p><p><strong>Rationale:</strong> A D flip-flop passes the input directly. For a JK to do this, we ensure $J$ and $K$ are always logical complements. If $D=1$, then $J=1$ and $K=0$ (Set mode). If $D=0$, then $J=0$ and $K=1$ (Reset mode). Options A and D articulate identical wiring structures.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('flip-flop');

-- Q59 — MSQ: 2's Complement properties (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='signed-numbers' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following are distinct mathematical advantages of the 2''s complement representation over identical bit-width Sign-Magnitude representation? (Select all that apply)',
  'It avoids the ambiguity of having "positive zero" and "negative zero"',
  'Addition and subtraction hardware is simpler because the sign bit can be treated as part of the magnitude during calculations',
  'It can represent numbers of infinitely large magnitude',
  'It simplifies fractional conversion to standard decimal',
  ARRAY['A','B'],
  '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> 2''s complement maps exactly one unique binary string to zero (eliminating $\pm 0$) (A). It allows standard binary adders to compute arithmetic operations uniformly without checking the sign bits first (B). It does not magically permit infinite magnitude (C), nor does it change how fractional bases are handled (D).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Q60 — MSQ: ADC features (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adc-dac' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','hard',2,
  'Which of the following statements accurately compare a Flash ADC and a Dual-Slope Integrating ADC? (Select all that apply)',
  'Flash ADCs have significantly faster conversion times than Dual-Slope ADCs',
  'Dual-Slope ADCs offer significantly higher precision and noise immunity than Flash ADCs',
  'Flash ADCs require exponentially more comparators as the bit-resolution scales up',
  'Dual-Slope ADCs explicitly require a Sample and Hold (S/H) circuit to function',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Flash ADCs are lightning-fast (1 cycle) but require unscalable hardware ($2^n-1$ comparators) (A, C). Dual-Slope ADCs use an integrator over time, making them very slow but providing exceptional precision and noise rejection (B). Dual-slopes integrate continuously and generally do NOT require an S/H circuit (D is false).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-system');

-- Q61 — MSQ: Synchronous Counter architecture (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='counters' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'Which of the following characterize a Synchronous Counter compared to an Asynchronous (Ripple) Counter? (Select all that apply)',
  'All flip-flops are triggered simultaneously by a single global clock signal',
  'It operates at a significantly higher maximum frequency due to mitigated propagation delay',
  'It requires less combinational logic hardware to determine the next state',
  'It suffers from worse decoding glitches',
  ARRAY['A','B'],
  '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> In synchronous counters, every flip-flop correctly shares the same master clock (A), resulting in simultaneous state updates and allowing drastically higher operational frequencies (B). Because of this concurrent triggering, it avoids intermediate transient states (glitches), meaning D is false. Furthermore, the tradeoff for speed is increased combinational complexity to predict the next state, meaning C is false.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('counter');

-- Q62 — MSQ: Hazard identification (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='circuit-delay' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Regarding physical combinational delays, which types of logical hazards are theoretically possible in a standard two-level combinatorial circuit? (Select all that apply)',
  'Static-1 Hazard',
  'Static-0 Hazard',
  'Dynamic Hazard',
  'Metastable Hazard',
  ARRAY['A','B'],
  '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> A two-level circuit (Sum-of-Products or Product-of-Sums) can exhibit Static-1 (glitching 1-0-1) or Static-0 (glitching 0-1-0) hazards. Dynamic hazards (bouncing multiple times, e.g., 1-0-1-0) strictly require circuits with 3 or more levels. Metastability is an exclusive property of sequential flip-flops.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dl-delay');

-- Q63 — MSQ: SR Flip flop invalid states (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'In a fundamental NOR-based SR (Set-Reset) flip-flop or latch, what conditions or outcomes correspond to the input $S=1, R=1$? (Select all that apply)',
  'The output state becomes strictly mathematically undefined or invalid',
  'It forces both $Q$ and $\bar{Q}$ to output a logic LOW (0) simultaneously',
  'It safely toggles the output to the complement of its previous state',
  'It risks pushing the circuit into metastability if the inputs transition to 0 simultaneously',
  ARRAY['A','B','D'],
  '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> The $S=1, R=1$ input on a NOR SR latch violates the complementary design, forcing both the $Q$ and $\bar{Q}$ physical outputs to 0 (B), which is a logically invalid state (A). Furthermore, if both inputs drop back to 0 simultaneously, the cross-coupled gates will race, leading to unpredictable metastable behavior (D). Toggling (C) applies to JK or T flip-flops, not SR.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('flip-flop');

-- Q64 — MSQ: Boolean identities (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='boolean-laws' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following Boolean expressions perfectly evaluate to a constant logic 1? (Select all that apply)',
  '$A + \bar{A}$',
  '$A + 1$',
  '$A \oplus \bar{A}$',
  '$A \cdot \bar{A}$',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> $A + \bar{A} = 1$ (Complementarity law). $A + 1 = 1$ (Annulment law). An XOR of any variable with its direct complement ensures the two inputs are always different, yielding $A \oplus \bar{A} = 1$. The AND of a variable and its complement ($A \cdot \bar{A}$) evaluates strictly to logic 0.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Q65 — MSQ: Decoder applications (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='decoders' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'What are common, practical real-world applications for an $n$-to-$2^n$ line Decoder? (Select all that apply)',
  'Translating binary memory addresses into physical chip-select signals (Memory Address Decoding)',
  'Implementing arbitrary Boolean sum-of-products combinatorial equations',
  'Isolating high-frequency radio signals',
  'Routing data from a single transmission line to multiple output destinations',
  ARRAY['A','B'],
  '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> Decoders precisely map $n$-bit binary addresses to unique wire activations, perfect for Memory Address selection (A). Combining a decoder with an external OR gate trivially implements Boolean logic (B). Routing a single data line to multiple destinations is the job of a Demultiplexer, not a raw decoder (D is false). Radio isolation is an analog feature (C is false).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('boolean-algebra');

-- Part 6 Complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DL PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1: Combinational Logic (11 Cards)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES

-- Card 1
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='boolean-laws' LIMIT 1),
  'What is the Consensus Theorem mathematically?',
  '<p>$AB + \bar{A}C + BC = AB + \bar{A}C$<br>The third term ($BC$) evaluates as mathematically redundant because whenever $B$ and $C$ are true, $A$ must be either 1 or 0, satisfying one of the first two terms anyway.</p>',
  ARRAY['boolean-algebra']
),

-- Card 2
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='k-maps' LIMIT 1),
  'Define a Prime Implicant vs an Essential Prime Implicant in a K-Map.',
  '<p><strong>Prime Implicant:</strong> A valid group of adjacent 1s that is as large as geometrically possible. It cannot be fully encompassed by a larger group.<br><strong>Essential Prime Implicant:</strong> A Prime Implicant that covers at least one minterm (a ''1'') that is absolutely NOT covered by any other group. It must appear in the final minimized expression.</p>',
  ARRAY['k-map']
),

-- Card 3
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='logic-gates' LIMIT 1),
  'Why are NAND and NOR classified as Universal Gates?',
  '<p>Because any arbitrary Boolean logic function (AND, OR, NOT, XOR) can be constructed structurally using exclusively NAND gates or exclusively NOR gates, without requiring any other type of underlying logic gate.</p>',
  ARRAY['boolean-algebra']
),

-- Card 4
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adders-sub' LIMIT 1),
  'What are the Boolean expressions for a Full Adder ($S$, $C_{out}$)?',
  '<p><strong>Sum:</strong> $S = A \oplus B \oplus C_{in}$<br><strong>Carry Out:</strong> $C_{out} = AB + B C_{in} + A C_{in}$</p>',
  ARRAY['boolean-algebra']
),

-- Card 5
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='circuit-delay' LIMIT 1),
  'What is a Static Hazard in a combinational logic circuit?',
  '<p>A Static Hazard is a momentary glitch where the output of a combinatorial circuit transitions incorrectly (e.g., 1 to 0 back to 1) due to asymmetrical signal propagation delays down different logic pathways. It is resolvable by adding redundant consensus terms to the K-Map design.</p>',
  ARRAY['dl-delay']
),

-- Card 6
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='multiplexers' LIMIT 1),
  'How many $2$-to-$1$ Multiplexers are needed to build an $n$-to-$1$ Multiplexer?',
  '<p>Building an $n$-to-$1$ MUX fundamentally requires exactly $(n-1)$ distinct $2$-to-$1$ multiplexers arranged in a binary structural tree (e.g., an 8-to-1 MUX requires 7 MUXes).</p>',
  ARRAY['multiplexer']
),

-- Card 7
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='decoders' LIMIT 1),
  'How does a Decoder implement Boolean logic functions?',
  '<p>An $n$-to-$2^n$ decoder correctly generates all $2^n$ possible minterms for $n$ variables on its output lines. A Boolean function can simply be implemented by passing the decoder outputs corresponding to the required minterms directly into external OR gates.</p>',
  ARRAY['boolean-algebra']
),

-- Card 8
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='signed-numbers' LIMIT 1),
  'What is the formula for the range of an $n$-bit 2''s complement number?',
  '<p>The range spans asymetrically from strictly $- (2^{n-1})$ through $+ (2^{n-1} - 1)$. For $n=8$ bits, it represents $-128$ through $+127$.</p>',
  ARRAY['number-system']
),

-- Card 9
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='signed-numbers' LIMIT 1),
  'How does hardware detect Arithmetic Overflow during 2''s complement addition?',
  '<p>Overflow theoretically occurs precisely when the Carry-In to the Most Significant Bit ($MSB$) differs from the Carry-Out of the MSB. Specifically computed as: $C_{in} \oplus C_{out} = 1$.</p>',
  ARRAY['number-system']
),

-- Card 10
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='number-systems' LIMIT 1),
  'How do you convert a Binary string into a Gray Code string?',
  '<p>The Most Significant Bit (MSB) simply copies directly down. For every subsequent lower bit index $i$: $Gray_i = Binary_i \oplus Binary_{i+1}$. Essentially, XOR each bit mathematically with the bit to its immediate left.</p>',
  ARRAY['number-system']
),

-- Card 11
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='boolean-laws' LIMIT 1),
  'State De Morgan''s Theorems.',
  '<p>1. The complement of a physical product is the sum of the complements: $\overline{(A \cdot B)} = \bar{A} + \bar{B}$<br>2. The complement of a physical sum is the product of the complements: $\overline{(A + B)} = \bar{A} \cdot \bar{B}$</p>',
  ARRAY['boolean-algebra']
);

-- Part 7 Complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DL PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2: Sequential Circuits & ADCs (11 Cards) + COMMIT
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES

-- Card 12
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'Compare Combinational and Sequential discrete Logic Circuits.',
  '<p><strong>Combinational:</strong> Output strictly depends solely on present inputs. No internal memory. Faster.<br><strong>Sequential:</strong> Output fundamentally depends on present inputs <em>and</em> the past history (state) of the circuit. Uses clocks and flip-flops for internal memory.</p>',
  ARRAY['state-machine']
),

-- Card 13
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'Explain the Race Around Condition in JK Flip-Flops and its solution.',
  '<p><strong>Condition:</strong> When a simple level-triggered JK flip-flop inputs are $J=1, K=1$ and the clock pulse remains HIGH longer than the gate propagation delay, the output toggles unpredictably and repeatedly.<br><strong>Solution:</strong> Use Edge-Triggering architectures or Master-Slave cascading flip-flops.</p>',
  ARRAY['flip-flop']
),

-- Card 14
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'State the Characteristic Equations mapping $Q_{t+1}$ for SR, D, JK, and T flip-flops.',
  '<p><strong>SR:</strong> $Q_{t+1} = S + \bar{R}Q_t$ (provided $SR = 0$)<br><strong>D:</strong> $Q_{t+1} = D$<br><strong>JK:</strong> $Q_{t+1} = J\bar{Q}_t + \bar{K}Q_t$<br><strong>T:</strong> $Q_{t+1} = T \oplus Q_t$</p>',
  ARRAY['flip-flop']
),

-- Card 15
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='state-machines' LIMIT 1),
  'What defines identically a Mealy Machine versus a Moore Machine?',
  '<p><strong>Mealy:</strong> Output depends mathematically on both the current state AND the current asynchronous inputs.<br><strong>Moore:</strong> Output depends exclusively on the current internal state completely independent of inputs.</p>',
  ARRAY['state-machine']
),

-- Card 16
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='counters' LIMIT 1),
  'Compare Synchronous vs Asynchronous (Ripple) Counters structurally.',
  '<p><strong>Synchronous:</strong> All flip-flops are driven by a singular global clock. Faster speed, less glitching, but strictly requires more complex combinatorial gating logic.<br><strong>Asynchronous:</strong> Clock sequentially ripples through each flip-flop (output of one drives clock of the next). Simpler, but incurs compounding delay.</p>',
  ARRAY['counter']
),

-- Card 17
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='registers' LIMIT 1),
  'Define Ring Counter vs Johnson Counter states.',
  '<p>For $n$ flip-flops:<br><strong>Ring Counter:</strong> Circulates a single 1. Yields exactly $n$ distinct states.<br><strong>Johnson Counter:</strong> Circulates the inverted output ($\bar{Q}$) back to input. Yields exactly $2n$ distinct states.</p>',
  ARRAY['counter']
),

-- Card 18
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flip-flops' LIMIT 1),
  'Define Setup Time and Hold Time for flip-flops.',
  '<p><strong>Setup Time ($T_s$):</strong> The strictly minimum time the data input must remain completely stable <em>before</em> the active clock edge arrives.<br><strong>Hold Time ($T_h$):</strong> The strictly minimum time the data input must remain completely stable <em>after</em> the active clock edge passes.</p>',
  ARRAY['dl-delay']
),

-- Card 19
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='sequential' LIMIT 1),
  (SELECT id FROM topics 'flip-flops' LIMIT 1),
  'What exactly causes Metastability in sequential circuits?',
  '<p>Violating the stringent Setup or Hold time tolerances causes the internal flip-flop latches to balance delicately between 0 and 1. The electrical output hovers at an invalid midterm voltage randomly before finally settling later, wreaking havoc on circuit synchronization.</p>',
  ARRAY['dl-delay']
),

-- Card 20
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adc-dac' LIMIT 1),
  'Distinguish Flash ADCs vs Successive Approximation (SAR) ADCs.',
  '<p><strong>Flash:</strong> Tests all voltage layers simultaneously utilizing parallel comparators. Fastest converter (1 cycle) but hardware scales exponentially ($2^n-1$ comparators).<br><strong>SAR:</strong> Scans using binary search. Slower ($n$ cycles) but requires vastly less routing and hardware.</p>',
  ARRAY['number-system']
),

-- Card 21
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='number-systems' LIMIT 1),
  'How do you quickly determine if a binary fraction (like $.0101_2$) evaluates to a terminating or non-terminating decimal?',
  '<p>Fractions whose binary representations strictly terminate correspond mathematically to decimal fractions where the precise denominator is uniquely a power of 2 (e.g., $1/2, 1/4, 5/8$). Anything else (like $1/10 = 0.1$) is infinite and repeating in purely binary.</p>',
  ARRAY['number-system']
),

-- Card 22
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adc-dac' LIMIT 1),
  'How is basic Analog ADC Resolution calculated?',
  '<p>$Resolution = \frac{V_{ref}}{2^n}$<br>This explicitly defines the incredibly smallest incremental analog voltage change required at the receiver to cause a singular 1-unit LSB transition in the final digital output.</p>',
  ARRAY['number-system']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing dl-seed.sql to verify data integrity:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='dl'));
-- Expected: 14 or 15 depending on mapping
-- (we made 14 topics: 3 + 4 + 4 + 3 = 14)
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dl');
-- Expected: 65
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dl')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dl');
-- Expected: 22

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug:  dl
-- Schema:        v2 (normalized tags, NUMERIC(10,2) NAT answers, topic enforcement)
-- Chapters:      4
-- Topics:        14
-- Questions:     65 total
--   MCQ:         45 (Q1–Q45)
--   NAT:         10 (Q46–Q55)
--   MSQ:         10 (Q56–Q65)
-- Flashcards:    22 (11 per batch)
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF dl-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
