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
