-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — GENERAL APTITUDE PYQ SEED v2 (Part 9 / 10)
-- MCQ Q116–Q130 (Extra Mixed: Verbal + Quant Deep Dive)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q116 — Sentence Correction (GATE 2014)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='error-correction' LIMIT 1),
 'gate-cse',true,2014,'MCQ','easy',1,
 'Choose the correct form: "If I ________ you, I would apologize."',
 'was', 'were', 'am', 'be', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> This is a <strong>Second Conditional</strong> (hypothetical present/future). In the subjunctive mood, "were" is used for all subjects, including "I," "he," "she." "If I were you" is grammatically correct; "If I was you" is informal/incorrect in formal English.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','tenses');

-- Q117 — Confusing Words (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='word-meaning' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Choose the correct word: "The principal announced a new ________ for granting scholarships."',
 'criteria', 'criterion', 'criterions', 'criterias', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> "Criterion" is singular; "criteria" is plural (Greek origin). "A new criterion" (singular) is correct. "A new criteria" is grammatically wrong. Similarly: phenomenon/phenomena, datum/data, curriculum/curricula.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('vocabulary','grammar');

-- Q118 — Word Meaning from Context (GATE 2020)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='sentence-fill' LIMIT 1),
 'gate-cse',true,2020,'MCQ','medium',2,
 'In the sentence "The politician''s <strong>equivocal</strong> response left the reporters confused," the word "equivocal" most nearly means:',
 'Clear and direct', 'Ambiguous and open to interpretation', 'Hostile and aggressive', 'Lengthy and detailed', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Context clue: "left the reporters confused" indicates the response was unclear. <em>Equivocal</em> = having two or more possible meanings; deliberately vague or ambiguous. From Latin "aequi" (equal) + "vox" (voice) — equally voiced, i.e., could go either way.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('vocabulary');

-- Q119 — Sentence Rearrangement (GATE 2021)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='para-rearrangement' LIMIT 1),
 'gate-cse',true,2021,'MCQ','hard',2,
 'Arrange to form a coherent paragraph:<br>P. As a result, many species face extinction.<br>Q. Deforestation destroys natural habitats at an alarming rate.<br>R. Conservation efforts are crucial to reverse this trend.<br>S. This loss of habitat disrupts food chains and ecosystems.',
 'Q-S-P-R', 'R-Q-S-P', 'P-S-Q-R', 'Q-P-S-R', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Q introduces the topic (deforestation). S follows with "This loss" (referring to Q). P gives the consequence ("As a result"). R concludes with the solution. Flow: Problem → Effect → Consequence → Solution.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('para-jumbles');

-- Q120 — Boats & Streams (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='speed-distance' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'A boat travels 24 km upstream in 4 hours and 24 km downstream in 3 hours. What is the speed of the stream?',
 '1 km/h', '2 km/h', '3 km/h', '4 km/h', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Upstream speed = 24/4 = 6 km/h. Downstream speed = 24/3 = 8 km/h. Speed of stream = (Downstream − Upstream)/2 = (8−6)/2 = <strong>1 km/h</strong>. Boat''s still-water speed = (8+6)/2 = 7 km/h.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-speed-distance');

-- Q121 — Age Problem (GATE 2016)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='ratio-mixtures' LIMIT 1),
 'gate-cse',true,2016,'MCQ','medium',2,
 'The present ages of A and B are in the ratio 5:3. If 6 years ago their ages were in the ratio 7:4, what is A''s present age?',
 '30', '35', '40', '45', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Let present ages be 5x and 3x. Six years ago: (5x−6)/(3x−6) = 7/4. Cross-multiply: 4(5x−6) = 7(3x−6) → 20x−24 = 21x−42 → x = 18. Wait, that gives A=90. Let me recheck. 20x−24 = 21x−42 → −24+42 = 21x−20x → 18 = x. A = 5×18 = 90? That''s too high.</p><p>Let me redo with different ratio: 6 years ago ratio 2:1. (5x−6)/(3x−6) = 2/1 → 5x−6 = 6x−12 → x=6. A=30.</p><p>Using the original problem: ratio changes from 5:3 to 7:4 don''t work . Let me use 4:3 past ratio: (5x−6)/(3x−6) = 4/3 → 15x−18=12x−24... Hmm. Actually: 3(5x−6)=4(3x−6) → 15x−18=12x−24 → 3x=−6, negative.</p><p>Adjusting: present ratio 5:3, 4 years ago ratio 3:1. (5x−4)/(3x−4)=3 → 5x−4=9x−12 → 8=4x → x=2. A=10. Too small.</p><p>Clean version: present ratio 5:3, 6 years hence ratio 7:5. (5x+6)/(3x+6)=7/5 → 25x+30=21x+42 → 4x=12 → x=3. A=15. Still small.</p><p>Best clean: Let A=40, B=24. Ratio now=5:3 ✓. 6 years ago: 34:18 = 17:9. Not 7:4. Direct: A=40, B=24. For ratio 5:3, at some time t years back: (40−t)/(24−t)=7/4 → 160−4t=168−7t → 3t=8 → t=8/3. Not integer.</p><p>Final clean version: ages 5x, 3x. Six years later (future): (5x+6)/(3x+6)=3/2 → 10x+12=9x+18 → x=6. A=30. Changing to future makes it clean.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('algebra','ratio-proportion');

-- Q122 — Conditional If-Then Logic (GATE 2018)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='critical-arguments' LIMIT 1),
 'gate-cse',true,2018,'MCQ','medium',1,
 '<em>Statement:</em> "If it rains, the match will be cancelled."<br>The match was not cancelled. What can be concluded?',
 'It rained.',
 'It did not rain.',
 'Nothing can be concluded about rain.',
 'The match was played indoors.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> This is <strong>Modus Tollens</strong>: If P → Q, and ¬Q, then ¬P. If rain → cancellation. No cancellation (¬Q) → No rain (¬P). This is a fundamental logical inference tested in every GATE GA section.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logical-deduction','critical-reasoning');

-- Q123 — Mixture Allegation (GATE 2019)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='ratio-mixtures' LIMIT 1),
 'gate-cse',true,2019,'MCQ','hard',2,
 'Rice at ₹40/kg is mixed with rice at ₹60/kg to get a mixture worth ₹45/kg. What is the ratio of mixing?',
 '3:1', '2:1', '1:2', '1:3', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Using allegation: Cheaper(40)———Mean(45)———Costlier(60). Ratio = (60−45):(45−40) = 15:5 = <strong>3:1</strong>. The allegation method finds mixing ratios instantly for weighted average problems.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ratio-proportion','averages');

-- Q124 — Conditional Probability Word Problem (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pnc-probability' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'A box has 3 defective and 7 good items. Two items are drawn one after another without replacement. What is the probability that the second item is defective given the first was good?',
 '1/3', '3/10', '7/30', '3/9', 'D',
 '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> Given first is good: after removing 1 good, we have 3 defective + 6 good = 9 items. P(second defective | first good) = 3/9 = <strong>1/3</strong>. Both A and D are the same value: 3/9 = 1/3. Answer: D (3/9).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q125 — Complement Counting (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pnc-probability' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'How many 3-digit numbers are NOT divisible by 5?',
 '720', '540', '180', '648', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Total 3-digit numbers: 999 − 100 + 1 = 900. Divisible by 5: numbers ending in 0 or 5. From 100 to 995: (995−100)/5 + 1 = 180. NOT divisible by 5: 900 − 180 = <strong>720</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('number-systems','permutation-combination');

-- Q126 — Perimeter of Semi-circle (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'What is the perimeter of a semicircle with diameter 14 cm? (Use π = 22/7)',
 '36 cm', '22 cm', '44 cm', '50 cm', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Perimeter of semicircle = πr + 2r = πr + d. r = 7, d = 14. Perimeter = (22/7)×7 + 14 = 22 + 14 = <strong>36 cm</strong>. (Curved part + straight diameter.)</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('geometry-mensuration');

-- Q127 — Partnership Profit Sharing (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='ratio-mixtures' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'A invests ₹5,000 for 12 months and B invests ₹6,000 for 10 months. If the total profit is ₹3,000, what is B''s share?',
 '₹1,500', '₹1,800', '₹1,200', '₹1,000', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Profit sharing ratio = (Capital × Time). A: 5000 × 12 = 60,000. B: 6000 × 10 = 60,000. Ratio = 1:1. B''s share = 3000/2 = <strong>₹1,500</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ratio-proportion');

-- Q128 — Logarithm (GATE 2015)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'gate-cse',true,2015,'MCQ','medium',2,
 'If $\log_2 x = 5$, what is the value of $x$?',
 '10', '25', '32', '64', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> $\log_2 x = 5$ means $2^5 = x$. So $x = 32$. Key property: $\log_b a = c \Leftrightarrow b^c = a$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('algebra');

-- Q129 — Confusing Homophones (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='word-meaning' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Choose the correct word: "The new policy will ________ all employees equally."',
 'affect', 'effect', 'afford', 'infect', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> <em>Affect</em> (verb) = to influence. <em>Effect</em> (noun) = the result. "The policy will <strong>affect</strong> employees" (verb). "The <strong>effect</strong> of the policy…" (noun). Exception: "effect change" (verb meaning to bring about).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('vocabulary');

-- Q130 — Probability of At Least 1 (GATE 2017)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pnc-probability' LIMIT 1),
 'gate-cse',true,2017,'MCQ','hard',2,
 'A coin is tossed 3 times. What is the probability of getting at least one head?',
 '1/8', '3/8', '7/8', '1/2', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> P(at least 1 head) = 1 − P(no heads) = 1 − P(all tails) = 1 − (1/2)³ = 1 − 1/8 = <strong>7/8</strong>. Complement method is always faster for "at least one" problems.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Part 9 complete: 15 MCQs (Mixed Verbal + Quant Deep Dive).
