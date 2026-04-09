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
