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
