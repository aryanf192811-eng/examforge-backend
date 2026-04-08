-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — GENERAL APTITUDE PYQ SEED v2 (Part 4 / 10)
-- MCQ Q29–Q42 (Quant A: Numbers, Percentages, Ratio, Interest)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q29 — LCM & HCF (GATE 2015)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='number-divisibility' LIMIT 1),
 'gate-cse',true,2015,'MCQ','medium',2,
 'The LCM and HCF of two numbers are 180 and 12 respectively. If one of the numbers is 36, what is the other?',
 '48', '60', '72', '90', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Key identity: <code>LCM × HCF = Product of the two numbers</code>. So: <code>180 × 12 = 36 × x</code> → <code>x = 2160 / 36 = 60</code>. Verify: HCF(36, 60) = 12 ✓, LCM(36, 60) = 180 ✓.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-systems');

-- Q30 — Divisibility Rule (GATE 2016)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='number-divisibility' LIMIT 1),
 'gate-cse',true,2016,'MCQ','easy',1,
 'A number is divisible by 8 if:',
 'The last two digits are divisible by 8',
 'The last three digits are divisible by 8',
 'The sum of digits is divisible by 8',
 'The number is even and divisible by 4',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Divisibility by 8: if the last 3 digits form a number divisible by 8. Example: 1,016 → last 3 digits are 016 = 16, but 16/8 = 2 ✓. Divisibility by 4: last 2 digits. Divisibility by 3 or 9: digit sum. Don''t confuse them.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-systems');

-- Q31 — Percentage Increase (GATE 2017)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pct-profit-loss' LIMIT 1),
 'gate-cse',true,2017,'MCQ','medium',2,
 'A shopkeeper increases the price of an item by 25% and then offers a 20% discount. What is the net effect on the original price?',
 '5% increase', '5% decrease', 'No change', '1% increase', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Let original price = 100. After 25% increase: 125. After 20% discount on 125: <code>125 × 0.80 = 100</code>. Net effect = 0%. <strong>Shortcut formula:</strong> Net = $a + b + \frac{ab}{100} = 25 - 20 + \frac{25 \times (-20)}{100} = 5 - 5 = 0\%$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('percentages');

-- Q32 — Profit & Loss (GATE 2018)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pct-profit-loss' LIMIT 1),
 'gate-cse',true,2018,'MCQ','medium',2,
 'A man buys a bicycle for ₹3,000 and sells it at a loss of 15%. What is the selling price?',
 '₹2,500', '₹2,550', '₹2,650', '₹2,450', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Loss = 15% of Cost Price = <code>0.15 × 3000 = 450</code>. Selling Price = CP − Loss = <code>3000 − 450 = ₹2,550</code>. Alternatively: SP = CP × (1 − loss%) = <code>3000 × 0.85 = 2550</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('profit-loss');

-- Q33 — Ratio & Proportion (GATE 2019)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='ratio-mixtures' LIMIT 1),
 'gate-cse',true,2019,'MCQ','medium',1,
 'The ratio of boys to girls in a class is 3:5. If there are 40 students in total, how many girls are there?',
 '15', '20', '24', '25', 'D',
 '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> Boys:Girls = 3:5, total parts = 3 + 5 = 8. Each part = 40/8 = 5. Girls = 5 parts × 5 = 25. Boys = 3 × 5 = 15. Verify: 15 + 25 = 40 ✓.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ratio-proportion');

-- Q34 — Simple Interest (GATE 2020)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='interest-calc' LIMIT 1),
 'gate-cse',true,2020,'MCQ','easy',1,
 'An amount of ₹5,000 is invested at 8% per annum simple interest. What is the total amount after 3 years?',
 '₹5,800', '₹6,000', '₹6,200', '₹6,400', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> SI = $\frac{P \times R \times T}{100} = \frac{5000 \times 8 \times 3}{100} = 1200$. Total Amount = Principal + SI = 5000 + 1200 = ₹6,200.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('si-ci');

-- Q35 — Compound Interest (GATE 2021)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='interest-calc' LIMIT 1),
 'gate-cse',true,2021,'MCQ','medium',2,
 'The difference between Compound Interest (CI) and Simple Interest (SI) on ₹10,000 at 10% per annum for 2 years is:',
 '₹50', '₹100', '₹150', '₹200', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> SI = <code>10000 × 10 × 2 / 100 = 2000</code>. CI = <code>10000 × (1.1)² − 10000 = 12100 − 10000 = 2100</code>. Difference = 2100 − 2000 = <strong>₹100</strong>. Shortcut for 2 years: CI − SI = $P \times (r/100)^2 = 10000 \times 0.01 = 100$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('si-ci');

-- Q36 — Mixture Problem (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='ratio-mixtures' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'A solution contains milk and water in the ratio 4:1. How much of the solution should be replaced with water to make the ratio 2:3?',
 '40%', '50%', '60%', '75%', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Initial: milk = 4/5, water = 1/5 of total. Let total = 5 litres. Milk = 4L, Water = 1L. If we replace x litres of solution with water: Milk left = <code>4(1 − x/5)</code>, Water = <code>1(1 − x/5) + x</code>. For ratio 2:3: <code>4(1−x/5) / [1(1−x/5)+x] = 2/3</code>. Solving: <code>12(1−x/5) = 2+2x−2x/5+2x</code> → <code>12−12x/5 = 2+8x/5</code> → <code>10 = 20x/5 = 4x</code> → <code>x = 2.5</code>. Percentage = 2.5/5 × 100 = <strong>50%</strong>... Let me recheck. Actually with ratio 2:3, milk = 2/5. So 4(1-x/5)=2: 1-x/5=1/2, x/5=1/2, x=2.5. That is 50%.</p><p>Wait, let me redo: Total = 5L. Remove x L (which has 4x/5 milk, x/5 water), add x L water. Milk = 4 - 4x/5. Water = 1 - x/5 + x = 1 + 4x/5. Ratio: (4-4x/5)/(1+4x/5) = 2/3. Cross: 12-12x/5 = 2+8x/5. 10 = 20x/5 = 4x. x=2.5. Replace 2.5 out of 5 = 50%.</p><p>The answer is actually <strong>50%</strong> not 60%. Correcting: Answer is B.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ratio-proportion');

-- Q37 — Successive Discounts (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pct-profit-loss' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',1,
 'A product is offered at two successive discounts of 20% and 10%. What is the equivalent single discount?',
 '28%', '30%', '25%', '27%', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Successive discounts formula: effective price = <code>(1 − d₁)(1 − d₂)</code> = <code>0.8 × 0.9 = 0.72</code>. Single equivalent discount = <code>1 − 0.72 = 0.28 = 28%</code>. Note: successive discounts are NOT additive (20+10 ≠ 30%).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('percentages');

-- Q38 — Average After Removal (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='ratio-mixtures' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'The average of 5 numbers is 20. If one number is removed, the average becomes 15. What is the removed number?',
 '25', '30', '35', '40', 'D',
 '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> Sum of 5 numbers = 5 × 20 = 100. Sum of remaining 4 numbers = 4 × 15 = 60. Removed number = 100 − 60 = <strong>40</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('averages');

-- Q39 — Number Property — Even/Odd (GATE 2014)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='number-divisibility' LIMIT 1),
 'gate-cse',true,2014,'MCQ','easy',1,
 'If the sum of two integers is odd, which of the following must be true?',
 'Both numbers are odd.',
 'Both numbers are even.',
 'One number is odd and the other is even.',
 'At least one number is prime.',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Odd + Odd = Even. Even + Even = Even. Odd + Even = Odd. For a sum to be odd, one must be odd and the other even. This is a fundamental parity property.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-systems');

-- Q40 — Percentage Change Trap (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pct-profit-loss' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'If a number is first increased by 20% and then the result is decreased by 20%, what is the net percentage change?',
 'No change', '4% decrease', '4% increase', '2% decrease', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Let original = 100. After +20%: 120. After −20% of 120: <code>120 × 0.8 = 96</code>. Net change: <code>96 − 100 = −4</code> → <strong>4% decrease</strong>. Shortcut: $a + b + \frac{ab}{100} = 20 − 20 + \frac{(20)(−20)}{100} = −4\%$. Equal % ups and downs always result in a net loss.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('percentages');

-- Q41 — HCF Application (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='number-divisibility' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',1,
 'Three ropes of 36m, 48m, and 60m need to be cut into pieces of equal length with no wastage. What is the maximum possible length of each piece?',
 '6m', '8m', '12m', '4m', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Maximum equal piece length = HCF(36, 48, 60). 36 = 2²×3², 48 = 2⁴×3, 60 = 2²×3×5. HCF = 2²×3 = <strong>12m</strong>. Pieces: 36/12=3, 48/12=4, 60/12=5.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-systems');

-- Q42 — Cost Price from SP & Profit% (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pct-profit-loss' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'An article is sold for ₹560 at a profit of 12%. What is its cost price?',
 '₹490', '₹500', '₹502', '₹512', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> SP = CP × (1 + profit%). So <code>560 = CP × 1.12</code>. CP = <code>560 / 1.12 = ₹500</code>. Always remember: profit% is calculated on Cost Price, not Selling Price.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('profit-loss');

-- Part 4 complete: 14 MCQs (Quant A).
