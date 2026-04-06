-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — GENERAL APTITUDE PYQ SEED v2 (Part 6 / 10)
-- MCQ Q57–Q70 (Mixed: Data Interpretation, Venn Diagrams, Clocks, Logic)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q57 — Data Table Interpretation (GATE 2017)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chart-interpretation' LIMIT 1),
 'gate-cse',true,2017,'MCQ','medium',2,
 'The following table shows the production (in thousands) of a company over 5 years:<br><table border="1" cellpadding="4"><tr><th>Year</th><th>2016</th><th>2017</th><th>2018</th><th>2019</th><th>2020</th></tr><tr><td>Production</td><td>50</td><td>60</td><td>75</td><td>90</td><td>80</td></tr></table><br>In which year was the percentage increase in production the highest compared to the previous year?',
 '2017', '2018', '2019', '2020', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Percentage increases: 2017: (60-50)/50 × 100 = 20%. 2018: (75-60)/60 × 100 = 25%. 2019: (90-75)/75 × 100 = 20%. 2020: (80-90)/90 = -11.1% (decrease). Highest increase: <strong>2018 at 25%</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-interpretation');

-- Q58 — Venn Diagram — Two Sets (GATE 2019)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='venn-sets' LIMIT 1),
 'gate-cse',true,2019,'MCQ','medium',2,
 'In a class of 60 students, 35 play cricket, 25 play football, and 10 play both. How many students play neither?',
 '5', '10', '15', '20', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Using inclusion-exclusion: |A ∪ B| = |A| + |B| − |A ∩ B| = 35 + 25 − 10 = 50. Neither = Total − |A ∪ B| = 60 − 50 = <strong>10</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('venn-diagrams');

-- Q59 — Venn Diagram — Three Sets (GATE 2021)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='venn-sets' LIMIT 1),
 'gate-cse',true,2021,'MCQ','hard',2,
 'In a survey of 100 people: 50 like tea, 40 like coffee, 30 like juice. 15 like both tea and coffee, 10 like both coffee and juice, 12 like both tea and juice, and 5 like all three. How many like none?',
 '8', '10', '12', '15', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> |T ∪ C ∪ J| = |T| + |C| + |J| − |T∩C| − |C∩J| − |T∩J| + |T∩C∩J| = 50 + 40 + 30 − 15 − 10 − 12 + 5 = <strong>88</strong>. None = 100 − 88 = <strong>12</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('venn-diagrams');

-- Q60 — Clock Angle (GATE 2016)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='clocks-puzzles' LIMIT 1),
 'gate-cse',true,2016,'MCQ','medium',2,
 'What is the angle between the hour and minute hands of a clock at 3:30?',
 '90°', '75°', '105°', '120°', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Hour hand at 3:30: 3×30 + 30×0.5 = 90 + 15 = 105°. Minute hand at 30 min: 30×6 = 180°. Angle = |180 − 105| = <strong>75°</strong>. Formula: angle = |30H − 5.5M| where H=hour, M=minutes.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('clocks-calendars');

-- Q61 — Calendar — Day Finding (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='clocks-puzzles' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'If January 1st of a non-leap year is a Monday, what day is March 1st of the same year?',
 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'D',
 '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> Days from Jan 1 to Mar 1 (non-leap): Jan has 31 days, Feb has 28 days. Total = 31 + 28 = 59 days. 59 mod 7 = 3 (since 59 = 8×7 + 3). So March 1st = Monday + 3 = <strong>Thursday</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('clocks-calendars');

-- Q62 — Logical Puzzle — Seating (GATE 2018)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='clocks-puzzles' LIMIT 1),
 'gate-cse',true,2018,'MCQ','hard',2,
 'Five people A, B, C, D, E sit in a row. B is to the right of A. D is to the left of C. E is not at either end. B is not adjacent to D. Who sits in the middle?',
 'A', 'B', 'C', 'E', 'D',
 '<p><strong>✓ Answer: D (E).</strong></p><p><strong>Rationale:</strong> : B right of A, D left of C, E not at ends, B not next to D. One valid arrangement: A-B-E-D-C. E is in position 3 (middle). Other arrangements may exist, but E always ends up in the middle position to satisfy all simultaneously.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logical-deduction');

-- Q63 — Pie Chart Interpretation (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chart-interpretation' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'In a company''s budget, the following percentages are allocated: Salaries: 40%, Rent: 20%, Marketing: 15%, R&D: 10%, Miscellaneous: 15%. If the total budget is ₹5,00,000, how much more is spent on Salaries than on Marketing and R&D combined?',
 '₹50,000', '₹75,000', '₹1,00,000', '₹1,25,000', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Salaries = 40% of 5,00,000 = ₹2,00,000. Marketing + R&D = 15% + 10% = 25% = ₹1,25,000. Difference = 2,00,000 − 1,25,000 = <strong>₹75,000</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-interpretation');

-- Q64 — Data Sufficiency (GATE 2020)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-sufficiency' LIMIT 1),
 'gate-cse',true,2020,'MCQ','hard',2,
 '<em>Question:</em> Is integer $x$ positive?<br><strong>Statement I:</strong> $x^2 > 0$.<br><strong>Statement II:</strong> $x^3 > 0$.<br><br>Which statement(s) alone are sufficient to answer?',
 'Statement I alone is sufficient.',
 'Statement II alone is sufficient.',
 'Both statements together are needed.',
 'Neither statement alone nor together is sufficient.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Statement I ($x^2 > 0$): True for both positive AND negative x (e.g., $(-3)^2 = 9 > 0$). Only tells us $x \neq 0$. Insufficient alone. Statement II ($x^3 > 0$): Cube preserves sign — only positive numbers have positive cubes. So $x > 0$. <strong>Sufficient alone.</strong></p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logical-deduction');

-- Q65 — Bar Chart Comparison (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chart-interpretation' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',1,
 'Sales data for two products over 4 quarters:<br><table border="1" cellpadding="4"><tr><th>Quarter</th><th>Product A</th><th>Product B</th></tr><tr><td>Q1</td><td>120</td><td>80</td></tr><tr><td>Q2</td><td>150</td><td>100</td></tr><tr><td>Q3</td><td>180</td><td>160</td></tr><tr><td>Q4</td><td>200</td><td>200</td></tr></table><br>In which quarter did Product B show the highest percentage growth over the previous quarter?',
 'Q2', 'Q3', 'Q4', 'All quarters had equal growth', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Q2 growth: (100-80)/80 = 25%. Q3 growth: (160-100)/100 = <strong>60%</strong>. Q4 growth: (200-160)/160 = 25%. Q3 has the highest percentage growth at 60%.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-interpretation');

-- Q66 — Clock Hands Meeting (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='clocks-puzzles' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'How many times do the hour and minute hands of a clock coincide in a 12-hour period?',
 '12', '11', '10', '22', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> One might expect 12 (once per hour), but between 11 and 1, the hands coincide only at 12:00 (not separately at 11-something and 12-something). So they meet <strong>11 times</strong> in 12 hours: roughly every 65.45 minutes (720/11 ≈ 65.45 min).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('clocks-calendars');

-- Q67 — Blood Relations (GATE 2015)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='clocks-puzzles' LIMIT 1),
 'gate-cse',true,2015,'MCQ','medium',1,
 'A says to B: "You are my mother''s husband''s sister''s son." What is the relation of B to A?',
 'Brother', 'Cousin', 'Uncle', 'Nephew', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Step through: A''s mother → her husband (A''s father) → his sister (A''s aunt) → her son (A''s <strong>cousin</strong>). So B is A''s cousin.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logical-deduction');

-- Q68 — Direction Sense (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='clocks-puzzles' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'A person walks 5 km North, then turns right and walks 3 km, then turns right again and walks 5 km. How far is he from the starting point?',
 '0 km', '3 km', '5 km', '8 km', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> North 5km → right (East) 3km → right (South) 5km. The 5km North and 5km South cancel out. He is <strong>3 km East</strong> of the start.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logical-deduction');

-- Q69 — Data Table — Avg Calculation (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chart-interpretation' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',2,
 'Marks obtained by 5 students: 78, 82, 65, 91, 74. What is the average?',
 '74', '76', '78', '80', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Sum = 78 + 82 + 65 + 91 + 74 = 390. Average = 390/5 = <strong>78</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('averages','data-interpretation');

-- Q70 — Coding-Decoding (GATE 2014)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='clocks-puzzles' LIMIT 1),
 'gate-cse',true,2014,'MCQ','easy',1,
 'In a certain code, GATE is written as HBUF. How would EXAM be written in the same code?',
 'FYBN', 'FXBM', 'EYAM', 'GZCO', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Pattern: each letter is shifted +1 in the alphabet. G→H, A→B, T→U, E→F. Applying to EXAM: E→F, X→Y, A→B, M→N = <strong>FYBN</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logical-deduction');

-- Part 6 complete: 14 MCQs (Data Interpretation & Logic).
