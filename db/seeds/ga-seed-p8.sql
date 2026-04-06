-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — GENERAL APTITUDE PYQ SEED v2 (Part 8 / 10)
-- MSQ Q96–Q115 (Multiple Select Questions)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q96 — Grammar Rules (GATE 2017)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='error-correction' LIMIT 1),
 'gate-cse',true,2017,'MSQ','medium',2,
 'Which of the following sentences are grammatically CORRECT?',
 'Neither the students nor the teacher was present.',
 'The committee have decided to postpone the meeting.',
 'Each of the boys have submitted their homework.',
 'The news was shocking to everyone.',
 ARRAY['A','D'],
 '<p><strong>✓ Answer: A, D.</strong></p><p>A: "Neither...nor" — verb agrees with nearer subject "teacher" (singular → "was"). Correct. B: "Committee" is typically singular in American English → "has decided." C: "Each" is singular → "has submitted." D: "News" is uncountable/singular → "was." Correct.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','subject-verb');

-- Q97 — Uncountable Nouns (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='error-correction' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'Which of the following are UNCOUNTABLE nouns in English?',
 'Information', 'Chair', 'Advice', 'Furniture',
 ARRAY['A','C','D'],
 '<p><strong>✓ Answer: A, C, D.</strong></p><p>"Information," "advice," and "furniture" have no plural form in standard English. You say "pieces of furniture," not "furnitures." "Chair" (B) is countable: one chair, two chairs.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','vocabulary');

-- Q98 — Reading Comp — Multiple Inferences (GATE 2019)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='passage-comprehension' LIMIT 1),
 'gate-cse',true,2019,'MSQ','hard',2,
 '<em>Passage:</em> "Electric vehicles (EVs) produce zero tailpipe emissions, making them cleaner than internal combustion engine (ICE) vehicles in urban areas. However, the overall environmental impact depends on how the electricity is generated. In countries relying on coal, the lifecycle emissions of an EV may approach those of an efficient ICE vehicle."<br><br>Which inferences are supported by the passage?',
 'EVs are always better for the environment than ICE vehicles.',
 'The source of electricity affects the environmental benefit of EVs.',
 'EVs have zero tailpipe emissions.',
 'Coal-powered electricity can reduce the environmental advantage of EVs.',
 ARRAY['B','C','D'],
 '<p><strong>✓ Answer: B, C, D.</strong></p><p>B: stated — "depends on how electricity is generated." C: First sentence says "zero tailpipe emissions." D: "lifecycle emissions may approach those of ICE" in coal-dependent countries. A is contradicted — the passage says the benefit depends on electricity source.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('reading-comprehension','critical-reasoning');

-- Q99 — Properties of Numbers (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='number-divisibility' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Which of the following statements are TRUE?',
 'The square of any odd number is odd.',
 'The product of two even numbers is always divisible by 4.',
 'The sum of two prime numbers is always even.',
 'Every even number greater than 2 can be expressed as the sum of two primes (Goldbach''s conjecture).',
 ARRAY['A','B'],
 '<p><strong>✓ Answer: A, B.</strong></p><p>A: Odd × Odd = Odd ✓. B: (2a)(2b) = 4ab, divisible by 4 ✓. C: False — 2 + 3 = 5 (odd), because 2 is the only even prime. D: Goldbach''s conjecture is unproven (widely believed true but not a mathematical theorem).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-systems');

-- Q100 — Probability Properties (GATE 2020)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pnc-probability' LIMIT 1),
 'gate-cse',true,2020,'MSQ','medium',2,
 'Which of the following are ALWAYS true for any two events A and B?',
 '$P(A \cup B) = P(A) + P(B) - P(A \cap B)$',
 '$P(A \cap B) = P(A) \times P(B)$',
 '$0 \leq P(A) \leq 1$',
 '$P(A'') = 1 - P(A)$',
 ARRAY['A','C','D'],
 '<p><strong>✓ Answer: A, C, D.</strong></p><p>A: Inclusion-exclusion is always true. B: Only true for INDEPENDENT events, not always. C: Probability axiom. D: Complement rule is always true.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q101 — Valid Syllogistic Conclusions (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='inference-assumption' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','hard',2,
 '<em>Statements:</em> All roses are flowers. All flowers are beautiful.<br><br>Which conclusions follow?',
 'All roses are beautiful.',
 'Some beautiful things are roses.',
 'All beautiful things are roses.',
 'Some flowers are roses.',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answer: A, B, D.</strong></p><p>A: Roses ⊂ Flowers ⊂ Beautiful → All roses are beautiful (transitive). B: Since roses are beautiful, some beautiful things are roses. C: Not valid — there may be beautiful things that aren''t roses. D: From "All roses are flowers," it follows that some flowers are roses.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logical-deduction');

-- Q102 — Percentage Concepts (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pct-profit-loss' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',1,
 'Which statements are TRUE about percentages?',
 'A 50% increase followed by a 50% decrease gives the original value.',
 'Successive discounts of 10% and 20% are equivalent to a single discount of 28%.',
 'If A''s salary is 20% more than B''s, then B''s salary is 20% less than A''s.',
 'A 100% increase means the new value is double the original.',
 ARRAY['B','D'],
 '<p><strong>✓ Answer: B, D.</strong></p><p>A: False — 100 +50% = 150 −50% = 75 ≠ 100. B: True — (1-0.1)(1-0.2) = 0.72, discount = 28%. C: False — if B=100, A=120, then B is 20/120 = 16.67% less than A. D: True — 100% increase means double.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('percentages');

-- Q103 — Data Interpretation (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chart-interpretation' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Expenses (in thousands ₹) over 4 months:<br><table border="1" cellpadding="4"><tr><th>Month</th><th>Rent</th><th>Food</th><th>Transport</th></tr><tr><td>Jan</td><td>10</td><td>8</td><td>4</td></tr><tr><td>Feb</td><td>10</td><td>9</td><td>5</td></tr><tr><td>Mar</td><td>10</td><td>7</td><td>6</td></tr><tr><td>Apr</td><td>10</td><td>10</td><td>5</td></tr></table><br>Which statements are TRUE?',
 'Total expenditure increased every month.',
 'Rent remained constant across all months.',
 'Transport expense was highest in March.',
 'Food expense was lowest in January.',
 ARRAY['B','C'],
 '<p><strong>✓ Answer: B, C.</strong></p><p>A: Jan=22, Feb=24, Mar=23 (decreased!), Apr=25. Not monotonically increasing. B: Rent=10 every month ✓. C: Transport: 4,5,6,5 → highest in March (6) ✓. D: Food: 8,9,7,10 → lowest in March (7), not January (8). False.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-interpretation');

-- Q104 — Verbal Analogy Types (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='verbal-analogies' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'In the analogy <strong>DOCTOR : HOSPITAL</strong>, which of the following share the same relationship type (person : workplace)?',
 'Teacher : School',
 'Pen : Paper',
 'Chef : Kitchen',
 'Pilot : Airplane',
 ARRAY['A','C','D'],
 '<p><strong>✓ Answer: A, C, D.</strong></p><p>Doctor works in a hospital. Teacher works in a school (A), Chef works in a kitchen (C), Pilot works in an airplane (D). Pen:Paper is tool:tool or tool:medium — different relationship type.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('analogies');

-- Q105 — Time & Work Properties (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='time-work-pipes' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Which statements are TRUE about time and work problems?',
 'If A takes 10 days, A completes 1/10 of the work per day.',
 'Combined time of two workers is always half the slower worker''s time.',
 'If A is twice as efficient as B, A takes half the time B takes.',
 'A pipe that empties a tank has a negative work rate.',
 ARRAY['A','C','D'],
 '<p><strong>✓ Answer: A, C, D.</strong></p><p>A: Rate = 1/time. If 10 days → 1/10 per day ✓. B: False — it depends on both rates, not just the slower one. C: Twice efficient = double rate = half time ✓. D: Emptying pipe has negative contribution to filling ✓.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-work');

-- Q106 — Divisibility Rules That Hold (GATE 2018)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='number-divisibility' LIMIT 1),
 'gate-cse',true,2018,'MSQ','medium',1,
 'Which numbers are divisible by 6?',
 '132', '245', '354', '612',
 ARRAY['A','C','D'],
 '<p><strong>✓ Answer: A, C, D.</strong></p><p>Divisible by 6 = divisible by both 2 AND 3. 132: even ✓, digit sum=6 (div by 3) ✓. 245: odd ✗. 354: even ✓, digit sum=12 ✓. 612: even ✓, digit sum=9 ✓.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-systems');

-- Q107 — Critical Reasoning Weakeners (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='critical-arguments' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','hard',2,
 '<em>Argument:</em> "Students who attend coaching classes score higher in GATE. Therefore, coaching classes improve GATE scores."<br><br>Which, if true, would WEAKEN this argument?',
 'Students who join coaching were already strong academically.',
 'Some coaching classes use past GATE papers for practice.',
 'Self-study students who scored high didn''t attend any coaching.',
 'Coaching classes charge high fees.',
 ARRAY['A','C'],
 '<p><strong>✓ Answer: A, C.</strong></p><p>A: Selection bias — coaching students might already be better, so coaching isn''t the cause. C: Counter-evidence — shows high scores are achievable without coaching. B actually supports coaching. D is irrelevant to the effectiveness argument.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('critical-reasoning');

-- Q108 — Geometry Properties (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'Which statements about triangles are TRUE?',
 'The sum of angles in any triangle is 180°.',
 'An equilateral triangle has all angles equal to 60°.',
 'The hypotenuse is the longest side of a right triangle.',
 'A triangle can have two right angles.',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answer: A, B, C.</strong></p><p>A: Angle sum property ✓. B: 180/3 = 60° each ✓. C: Hypotenuse is opposite the largest angle (90°) ✓. D: Two 90° = 180°, leaving 0° for the third — impossible.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('geometry-mensuration');

-- Q109 — Set Theory Properties (GATE 2021)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='venn-sets' LIMIT 1),
 'gate-cse',true,2021,'MSQ','medium',2,
 'For sets A and B, which are ALWAYS true?',
 '$A \cup A = A$',
 '$A \cap B = B \cap A$',
 '$A \cup (B \cap C) = (A \cup B) \cap (A \cup C)$',
 '$|A \cup B| = |A| + |B|$',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answer: A, B, C.</strong></p><p>A: Idempotent law ✓. B: Intersection is commutative ✓. C: Distributive law ✓. D: Only true if A∩B = ∅ (disjoint). In general: |A∪B| = |A|+|B|−|A∩B|.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('venn-diagrams');

-- Q110 — Speed Conversions (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='speed-distance' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'Which conversions are correct?',
 '1 km/h = 5/18 m/s',
 '1 m/s = 3.6 km/h',
 '36 km/h = 10 m/s',
 '72 km/h = 25 m/s',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answer: A, B, C.</strong></p><p>A: 1 km/h = 1000/3600 = 5/18 m/s ✓. B: 1 m/s = 18/5 = 3.6 km/h ✓. C: 36 × 5/18 = 10 m/s ✓. D: 72 × 5/18 = 20 m/s ≠ 25.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-speed-distance');

-- Q111 — Interest Properties (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='interest-calc' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Which statements about Simple Interest (SI) and Compound Interest (CI) are TRUE?',
 'SI and CI are equal for the first year at the same rate.',
 'CI is always greater than SI for periods longer than 1 year.',
 'SI = P × R × T / 100',
 'CI for 2 years at 10% on ₹100 is exactly ₹20.',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answer: A, B, C.</strong></p><p>A: For 1 year, both give P×R/100 ✓. B: CI earns interest on interest → always more after year 1 ✓. C: Standard SI formula ✓. D: CI for 2 years = 100(1.1)²−100 = 121−100 = ₹21 ≠ 20.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('si-ci');

-- Q112 — Preposition Usage (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='articles-prepositions' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'Which sentences use prepositions ?',
 'She is good at mathematics.',
 'He insisted on paying the bill.',
 'They are interested for the project.',
 'We arrived at the station on time.',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answer: A, B, D.</strong></p><p>A: "good at" ✓. B: "insisted on" ✓. C: Should be "interested in" not "interested for." D: "arrived at" and "on time" ✓. Preposition collocations are frequently tested in GATE GA.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','prepositions');

-- Q113 — Ratio & Proportion (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='ratio-mixtures' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'If A:B = 3:4 and B:C = 2:5, which of the following are TRUE?',
 'A:C = 3:10',
 'B is common to both ratios and needs to be equalized.',
 'A:B:C = 3:4:10',
 'C is the largest among A, B, and C.',
 ARRAY['A','B','C','D'],
 '<p><strong>✓ Answer: A, B, C, D.</strong></p><p>B: Equalize B. A:B=3:4, B:C=2:5. LCM of B(4,2)=4. So B:C=4:10. A:B:C=3:4:10. A: A/C=3/10 ✓. C: 3:4:10 ✓. D: 10>4>3 ✓.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ratio-proportion');

-- Q114 — Logical Arguments (GATE 2016)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='critical-arguments' LIMIT 1),
 'gate-cse',true,2016,'MSQ','hard',2,
 '<em>Statement:</em> "All engineers are logical. Some logical people are creative."<br><br>Which conclusions can be derived?',
 'All engineers are creative.',
 'Some engineers may be creative.',
 'All logical people are engineers.',
 'Some creative people may be engineers.',
 ARRAY['B','D'],
 '<p><strong>✓ Answer: B, D.</strong></p><p>A: "Some" doesn''t mean "all" — invalid. B: Engineers are logical, and some logical people are creative, so some engineers MIGHT be creative ✓. C: "All X are Y" doesn''t mean "All Y are X." D: If some creative people are logical and some logical people are engineers → possible overlap ✓.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logical-deduction','critical-reasoning');

-- Q115 — Clock Properties (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='clocks-puzzles' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',1,
 'Which statements about clock angles are TRUE?',
 'The minute hand moves 6° per minute.',
 'The hour hand moves 0.5° per minute.',
 'At 6:00, the angle between hands is 180°.',
 'The hands overlap 24 times in 24 hours.',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answer: A, B, C.</strong></p><p>A: 360°/60 min = 6°/min ✓. B: 360°/720 min = 0.5°/min ✓. C: Hour hand at 180°, minute at 0° → 180° ✓. D: They overlap 22 times in 24 hours (11 per 12 hours), not 24.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('clocks-calendars');

-- Part 8 complete: 20 unique MSQ questions.
