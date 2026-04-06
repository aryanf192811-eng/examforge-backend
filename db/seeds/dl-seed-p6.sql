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
