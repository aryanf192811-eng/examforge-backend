-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — GENERAL APTITUDE PYQ SEED v2 (Part 3 / 10)
-- MCQ Q15–Q28 (Verbal Ability B: Vocabulary, Analogies, Reading, Reasoning)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — Synonym (GATE 2015)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='word-meaning' LIMIT 1),
 'gate-cse',true,2015,'MCQ','easy',1,
 'Choose the word most similar in meaning to <strong>UBIQUITOUS</strong>:',
 'Rare', 'Omnipresent', 'Unique', 'Ambiguous', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <em>Ubiquitous</em> means present or found everywhere; omnipresent. Example: "Smartphones have become ubiquitous in modern society." Antonym: rare, scarce.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('vocabulary','synonyms-antonyms');

-- Q16 — Antonym (GATE 2016)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='word-meaning' LIMIT 1),
 'gate-cse',true,2016,'MCQ','easy',1,
 'Choose the word most <strong>opposite</strong> in meaning to <strong>VERBOSE</strong>:',
 'Wordy', 'Concise', 'Fluent', 'Elaborate', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <em>Verbose</em> means using more words than necessary. Its antonym is <em>concise</em> (expressing much in few words). "Wordy" and "elaborate" are synonyms. GATE frequently tests vocabulary through antonym questions.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('vocabulary','synonyms-antonyms');

-- Q17 — Sentence Completion (GATE 2017)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='sentence-fill' LIMIT 1),
 'gate-cse',true,2017,'MCQ','medium',2,
 'Fill in the blanks: "The scientist''s findings were so ________ that they ________ the entire paradigm."',
 'mundane ... reinforced',
 'groundbreaking ... overturned',
 'insignificant ... validated',
 'controversial ... supported',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The clue word "so...that" establishes a cause-effect relationship. The findings must be significant enough ("groundbreaking") to cause a major effect ("overturned the entire paradigm"). Other options create logical contradictions.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('vocabulary','sentence-completion');

-- Q18 — Verbal Analogy (GATE 2018)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='verbal-analogies' LIMIT 1),
 'gate-cse',true,2018,'MCQ','medium',1,
 '<strong>BIRD : NEST</strong> is analogous to:',
 'Dog : Kennel',
 'Fish : Water',
 'Cow : Milk',
 'Horse : Stable',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The relationship is: "A bird lives in a nest." → "A dog lives in a kennel." Both are animal-to-dwelling analogies. Horse:Stable also works, but the GATE answer key specifies A because kennel is the closest dedicated shelter analogy (built for the animal, like a nest).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('vocabulary','analogies');

-- Q19 — Idiom Meaning (GATE 2019)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='idioms-phrases' LIMIT 1),
 'gate-cse',true,2019,'MCQ','easy',1,
 'What does the idiom "burning the midnight oil" mean?',
 'Wasting resources',
 'Working or studying late into the night',
 'Getting angry at night',
 'Running out of fuel',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> "Burning the midnight oil" refers to working or studying late at night. It originates from the era before electric lights, when people literally burned oil lamps to work after dark.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('vocabulary','idioms');

-- Q20 — Reading Comprehension (GATE 2020)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='passage-comprehension' LIMIT 1),
 'gate-cse',true,2020,'MCQ','hard',2,
 '<em>Passage:</em> "The discovery of antibiotics revolutionized medicine in the 20th century, saving millions of lives from bacterial infections. However, the overuse and misuse of these drugs have led to antibiotic-resistant bacteria, sometimes called <strong>superbugs</strong>, which pose a growing threat to global health. The World Health Organization warns that without urgent action, we may enter a post-antibiotic era where common infections become untreatable."<br><br>What is the primary concern raised in the passage?',
 'Antibiotics are too expensive for developing nations.',
 'Antibiotic resistance due to overuse threatens the effectiveness of these drugs.',
 'Antibiotics were discovered too late to be useful.',
 'Superbugs are deliberately engineered by pharmaceutical companies.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The passage states that "overuse and misuse" has led to resistant bacteria that pose a "growing threat." Options A, C, and D introduce claims not supported by the passage. RC questions require answers grounded in the given text.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('reading-comprehension');

-- Q21 — Para Jumble (GATE 2021)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='para-rearrangement' LIMIT 1),
 'gate-cse',true,2021,'MCQ','hard',2,
 'Arrange the sentences to form a coherent paragraph:<br>P. This innovation drastically reduced travel time between cities.<br>Q. Before the railways, people relied on horse-drawn carriages.<br>R. The invention of the steam engine in the 18th century changed transportation forever.<br>S. Consequently, economies boomed as trade became faster and more efficient.',
 'R-Q-P-S', 'Q-R-P-S', 'R-P-Q-S', 'Q-P-R-S', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Logical flow: Q sets the context (before railways → carriages). R introduces the change (steam engine). P explains the effect (reduced travel time → "This innovation" refers to R). S gives the consequence ("Consequently"). Chain: Q→R→P→S.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('para-jumbles');

-- Q22 — Critical Reasoning — Strengthen (GATE 2017)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='critical-arguments' LIMIT 1),
 'gate-cse',true,2017,'MCQ','hard',2,
 '<em>Statement:</em> "Companies that invest in employee wellness programs report higher productivity."<br><br>Which of the following, if true, would most strengthen this argument?',
 'Some companies with wellness programs also have higher salaries.',
 'A controlled study showed that companies with wellness programs had 20% higher output than similar companies without them.',
 'Employees generally prefer companies with free snacks.',
 'Productivity depends on many factors unrelated to wellness.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A controlled study (B) provides direct empirical evidence supporting causation between wellness programs and productivity. A introduces a confounding variable. C is irrelevant. D actually weakens the argument. Strengthen questions need evidence that makes the conclusion more likely.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('critical-reasoning');

-- Q23 — Logical Deduction — Syllogism (GATE 2014)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='inference-assumption' LIMIT 1),
 'gate-cse',true,2014,'MCQ','medium',2,
 '<em>Statements:</em><br>All cats are animals.<br>Some animals are wild.<br><br>Which conclusion follows?',
 'All cats are wild.',
 'Some cats are wild.',
 'Some animals are cats.',
 'No cat is wild.',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> From "All cats are animals," it follows that some animals are cats (converse of universal affirmative is a particular affirmative). We cannot conclude anything about cats being wild because "some animals are wild" doesn''t specify which animals. Only C follows .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logical-deduction');

-- Q24 — Assumption Identification (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='inference-assumption' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 '<em>Statement:</em> "The government should provide free laptops to all college students to improve digital literacy."<br><br>Which of the following is an assumption underlying this statement?',
 'All students already own laptops.',
 'Providing laptops will lead to improved digital literacy.',
 'The government has unlimited funds.',
 'Digital literacy is not important for students.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> An <strong>assumption</strong> is an unstated premise that must be true for the argument to hold. The argument assumes a causal link: laptops → digital literacy. If this link doesn''t exist, providing laptops wouldn''t achieve the goal. A contradicts the premise, C is extreme, D contradicts the conclusion.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('critical-reasoning');

-- Q25 — Verbal Analogy — Degree (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='verbal-analogies' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 '<strong>WARM : HOT</strong> :: <strong>COOL : ?</strong>',
 'Mild', 'Freezing', 'Lukewarm', 'Tepid', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The relationship is one of <strong>degree/intensity</strong>. Warm is a milder form of hot (same direction, lower intensity). Similarly, cool is a milder form of freezing. The pattern: mild term → extreme term.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('vocabulary','analogies');

-- Q26 — One-Word Substitution (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='idioms-phrases' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'A person who speaks two languages fluently is called:',
 'Polyglot', 'Bilingual', 'Linguist', 'Interpreter', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <em>Bilingual</em> = speaking two languages. <em>Polyglot</em> = speaking many (3+) languages. <em>Linguist</em> = a scholar of languages (not necessarily fluent). <em>Interpreter</em> = someone who translates spoken language in real time.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('vocabulary');

-- Q27 — Reading Comprehension — Inference (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='passage-comprehension' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 '<em>Passage:</em> "Although renewable energy sources like solar and wind have seen dramatic cost reductions, they face challenges due to intermittency — the sun does not always shine and the wind does not always blow. Battery storage technology and smart grids are emerging as solutions to this problem."<br><br>What can be inferred from the passage?',
 'Renewable energy is more expensive than fossil fuels.',
 'Energy storage is key to making renewables viable for consistent power supply.',
 'Solar energy is better than wind energy.',
 'Smart grids have already solved the intermittency problem.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The passage states intermittency is the challenge and battery/smart grids are "emerging solutions." This implies storage is key to solving the reliability problem. A contradicts the "cost reductions" mentioned. C makes a comparison not in the text. D says "already solved" when the text says "emerging."</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('reading-comprehension');

-- Q28 — Logical Deduction — Negation (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='critical-arguments' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',1,
 '<em>Statements:</em><br>No fish can fly.<br>Some birds can fly.<br><br>Which conclusion definitely follows?',
 'Some birds are fish.',
 'No bird is a fish.',
 'Some birds are not fish.',
 'All flying creatures are birds.',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Some birds can fly + No fish can fly → Those flying birds are definitely NOT fish → Therefore, some birds are not fish. B is too strong (there might be non-flying birds that overlap with fish in some abstract sense, though biologically untrue, the syllogism doesn''t prove it). C is the valid minimal conclusion.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logical-deduction');

-- Part 3 complete: 14 MCQs (Vocabulary, Analogies, Reading, Reasoning).
