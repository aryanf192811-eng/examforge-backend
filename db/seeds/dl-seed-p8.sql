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
