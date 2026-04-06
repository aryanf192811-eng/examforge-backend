-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — GENERAL APTITUDE PYQ SEED v2 (Part 5 / 10)
-- MCQ Q43–Q56 (Quant B: Time&Work, Speed&Distance, P&C, Probability, Algebra)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q43 — Time & Work (GATE 2015)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='time-work-pipes' LIMIT 1),
 'gate-cse',true,2015,'MCQ','medium',2,
 'A can complete a task in 12 days and B can complete it in 18 days. If they work together, in how many days will they finish the task?',
 '6.5 days', '7 days', '7.2 days', '8 days', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> A''s rate = 1/12 per day, B''s rate = 1/18 per day. Combined rate = 1/12 + 1/18 = 3/36 + 2/36 = 5/36 per day. Time = 36/5 = <strong>7.2 days</strong>. LCM method: LCM(12,18) = 36 units. A does 3u/day, B does 2u/day. Together: 5u/day. Time = 36/5 = 7.2 days.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-work');

-- Q44 — Pipes & Cisterns (GATE 2018)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='time-work-pipes' LIMIT 1),
 'gate-cse',true,2018,'MCQ','medium',2,
 'Pipe A fills a tank in 6 hours and Pipe B empties it in 8 hours. If both pipes are open, how long does it take to fill the tank?',
 '20 hours', '24 hours', '28 hours', '14 hours', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Filling rate = 1/6 per hour. Emptying rate = 1/8 per hour. Net rate = 1/6 − 1/8 = 4/24 − 3/24 = 1/24 per hour. Time = <strong>24 hours</strong>. Key: emptying pipe has negative rate.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-work');

-- Q45 — Speed, Distance, Time (GATE 2016)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='speed-distance' LIMIT 1),
 'gate-cse',true,2016,'MCQ','medium',2,
 'A train 200m long crosses a platform 300m long in 25 seconds. What is the speed of the train?',
 '72 km/h', '60 km/h', '54 km/h', '80 km/h', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Total distance to cover = train length + platform length = 200 + 300 = 500m. Speed = 500/25 = 20 m/s. Converting: 20 × 18/5 = <strong>72 km/h</strong>. Conversion: m/s × 18/5 = km/h.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-speed-distance');

-- Q46 — Relative Speed (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='speed-distance' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Two trains are moving towards each other at 60 km/h and 40 km/h respectively. They are 200 km apart. After how long will they meet?',
 '1 hour', '1.5 hours', '2 hours', '2.5 hours', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> When moving towards each other, relative speed = sum = 60 + 40 = 100 km/h. Time = Distance / Relative Speed = 200/100 = <strong>2 hours</strong>. If moving in the same direction, relative speed = difference.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-speed-distance');

-- Q47 — Permutations (GATE 2017)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pnc-probability' LIMIT 1),
 'gate-cse',true,2017,'MCQ','medium',2,
 'How many 3-digit numbers can be formed using digits {1, 2, 3, 4, 5} without repetition?',
 '60', '120', '125', '80', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Without repetition, choose and arrange 3 digits from 5: $P(5,3) = 5 \times 4 \times 3 = 60$. With repetition, it would be $5^3 = 125$. The keyword "without repetition" is critical.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('permutation-combination');

-- Q48 — (GATE 2019)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pnc-probability' LIMIT 1),
 'gate-cse',true,2019,'MCQ','easy',1,
 'In how many ways can a committee of 3 be formed from 7 people?',
 '21', '35', '42', '210', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Order doesn''t matter (committee, not a queue): $C(7,3) = \frac{7!}{3! \times 4!} = \frac{7 \times 6 \times 5}{3 \times 2 \times 1} = 35$. If order mattered: $P(7,3) = 210$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('permutation-combination');

-- Q49 — Probability — Dice (GATE 2020)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pnc-probability' LIMIT 1),
 'gate-cse',true,2020,'MCQ','medium',2,
 'Two dice are rolled. What is the probability that the sum is 7?',
 '1/12', '1/6', '5/36', '7/36', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Total outcomes = 6 × 6 = 36. Pairs summing to 7: (1,6), (2,5), (3,4), (4,3), (5,2), (6,1) = 6 pairs. Probability = 6/36 = <strong>1/6</strong>. Sum of 7 has the most of any sum with two dice.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q50 — Probability — Cards (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pnc-probability' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'A card is drawn at random from a standard 52-card deck. What is the probability that it is a King or a Heart?',
 '4/13', '16/52', '17/52', '1/4', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> P(King) = 4/52. P(Heart) = 13/52. P(King ∩ Heart) = 1/52 (King of Hearts). By inclusion-exclusion: P(King ∪ Heart) = 4/52 + 13/52 − 1/52 = 16/52 = <strong>4/13</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q51 — Arithmetic Series Sum (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'What is the sum of the first 50 natural numbers?',
 '1225', '1250', '1275', '1300', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Sum = $\frac{n(n+1)}{2} = \frac{50 \times 51}{2} = 1275$. This is the Gauss formula for the sum of an arithmetic series from 1 to n.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('series-sequences');

-- Q52 — Quadratic Equation (GATE 2014)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'gate-cse',true,2014,'MCQ','medium',2,
 'If the sum of the roots of $x^2 - 5x + k = 0$ is 5 and the product of the roots is 6, what is the value of $k$?',
 '5', '6', '-5', '-6', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> For $ax^2 + bx + c = 0$: Sum of roots = $-b/a = 5$ ✓. Product of roots = $c/a = k/1 = k$. Given product = 6, so $k = 6$. Vieta''s formulas are essential for GATE.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('algebra');

-- Q53 — Geometric Series (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'What is the sum of the infinite geometric series: $1 + \frac{1}{2} + \frac{1}{4} + \frac{1}{8} + ...$?',
 '1.5', '2', '2.5', 'Diverges', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> This is an infinite GP with first term $a = 1$ and common ratio $r = 1/2$. Since $|r| < 1$, it converges. Sum = $\frac{a}{1-r} = \frac{1}{1-0.5} = 2$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('series-sequences');

-- Q54 — Triangle Area (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'The sides of a right-angled triangle are 6 cm, 8 cm, and 10 cm. What is its area?',
 '24 cm²', '30 cm²', '40 cm²', '48 cm²', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> In a right triangle, the two shorter sides are the base and height. Area = $\frac{1}{2} \times 6 \times 8 = 24$ cm². Verify it''s right-angled: $6^2 + 8^2 = 36 + 64 = 100 = 10^2$ ✓ (Pythagorean triplet).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('geometry-mensuration');

-- Q55 — Work Efficiency (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='time-work-pipes' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'A can do a piece of work in 10 days. B is 25% more efficient than A. How many days does B take to finish the same work?',
 '7.5 days', '8 days', '12.5 days', '6 days', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A''s rate = 1/10 per day. B is 25% more efficient: B''s rate = 1.25 × (1/10) = 1.25/10 = 1/8 per day. B finishes in <strong>8 days</strong>. Key: "more efficient" means higher rate, not more time.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-work');

-- Q56 — Average Speed Trap (GATE 2021)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='speed-distance' LIMIT 1),
 'gate-cse',true,2021,'MCQ','hard',2,
 'A person travels from A to B at 40 km/h and returns from B to A at 60 km/h. What is the average speed for the entire journey?',
 '50 km/h', '48 km/h', '45 km/h', '52 km/h', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Classic trap — average speed ≠ arithmetic mean of speeds! For same distance at different speeds: Average speed = $\frac{2 \times S_1 \times S_2}{S_1 + S_2} = \frac{2 \times 40 \times 60}{40 + 60} = \frac{4800}{100} = 48$ km/h. This is the harmonic mean.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-speed-distance');

-- Part 5 complete: 14 MCQs (Quant B).
