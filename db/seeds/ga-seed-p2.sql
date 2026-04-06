-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — GENERAL APTITUDE PYQ SEED v2 (Part 2 / 10)
-- MCQ Q1–Q14 (Verbal Ability A: Grammar, Articles, Tenses, Agreement)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — Article Usage (GATE 2015)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='articles-prepositions' LIMIT 1),
 'gate-cse',true,2015,'MCQ','easy',1,
 'Choose the correct sentence:',
 'He is a honest man.',
 'He is an honest man.',
 'He is the honest man.',
 'He is honest man.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The article <em>an</em> is used before words that begin with a vowel <strong>sound</strong>, not necessarily a vowel letter. "Honest" starts with a silent ''h'', so the initial sound is the vowel /ɒn/. Hence: <em>an</em> honest man.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','articles');

-- Q2 — Preposition Choice (GATE 2016)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='articles-prepositions' LIMIT 1),
 'gate-cse',true,2016,'MCQ','easy',1,
 'Fill in the blank: "She has been working in this company ________ 2015."',
 'from', 'since', 'for', 'by', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <em>Since</em> is used with a specific point in time (2015, Monday, January). <em>For</em> is used with a duration (two years, three months). <em>From</em> is used with <em>to/till</em> for a range.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','prepositions');

-- Q3 — Tense Identification (GATE 2017)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='tenses-voice' LIMIT 1),
 'gate-cse',true,2017,'MCQ','medium',1,
 'Identify the correct sentence:',
 'I have completed the project yesterday.',
 'I completed the project yesterday.',
 'I had completed the project yesterday.',
 'I was completing the project yesterday.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> "Yesterday" is a definite past time marker, requiring <strong>Simple Past</strong> tense. Present Perfect ("have completed") cannot be used with definite past time adverbs (yesterday, last week, in 2020). Past Perfect requires a reference to another past event.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','tenses');

-- Q4 — Subject-Verb Agreement (GATE 2018)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='subject-verb-agreement' LIMIT 1),
 'gate-cse',true,2018,'MCQ','medium',1,
 'Choose the grammatically correct sentence:',
 'Each of the students have submitted their assignment.',
 'Each of the students has submitted his or her assignment.',
 'Each of the students have submitted his or her assignment.',
 'Each of the student has submitted their assignment.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> "Each" is a <strong>singular</strong> indefinite pronoun, requiring a singular verb ("has") and singular pronoun ("his or her"). "Students" is plural because of "of the students" (prepositional phrase), but the subject is "Each" (singular).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','subject-verb');

-- Q5 — Active to Passive Voice (GATE 2019)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='tenses-voice' LIMIT 1),
 'gate-cse',true,2019,'MCQ','medium',2,
 'Convert to passive voice: "The researchers are conducting an experiment."',
 'An experiment is being conducted by the researchers.',
 'An experiment is conducted by the researchers.',
 'An experiment has been conducted by the researchers.',
 'An experiment was being conducted by the researchers.',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Active: Subject (researchers) + is/are + V-ing + Object (experiment). Passive: Object + is/are + being + Past Participle + by + Subject. Present Continuous Active → Present Continuous Passive: "is being conducted."</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','tenses');

-- Q6 — Error Correction (GATE 2020)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='error-correction' LIMIT 1),
 'gate-cse',true,2020,'MCQ','medium',2,
 'Identify the error in: "Neither the manager nor the employees <u>was</u> aware of the policy change."',
 'No error',
 '"was" should be "were" because "employees" (the nearer subject) is plural',
 '"nor" should be "or"',
 '"neither" should be "either"',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> With "neither...nor" and "either...or," the verb agrees with the <strong>nearer subject</strong>. "Employees" (plural) is closer to the verb, so it requires "were." If reversed: "Neither the employees nor the manager <em>was</em>..." would be correct.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','subject-verb');

-- Q7 — Preposition with Verbs (GATE 2014)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='articles-prepositions' LIMIT 1),
 'gate-cse',true,2014,'MCQ','easy',1,
 'Fill in the blank: "The committee will look ________ the matter urgently."',
 'after', 'into', 'upon', 'for', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> "Look into" means to investigate or examine. "Look after" means to take care of. "Look upon" means to regard. "Look for" means to search. Context demands investigation.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','prepositions');

-- Q8 — Conditional Tenses (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='tenses-voice' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Choose the correct sentence:',
 'If I would have known, I would have helped.',
 'If I had known, I would have helped.',
 'If I knew, I would have helped.',
 'If I have known, I will have helped.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> This is a <strong>Third Conditional</strong> (impossible past condition): "If + Past Perfect, would have + Past Participle." It describes an unreal situation in the past. "Would have" never appears in the if-clause.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','tenses');

-- Q9 — Countable vs Uncountable (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='error-correction' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Choose the correct sentence:',
 'I need some informations about the course.',
 'I need some information about the course.',
 'I need an information about the course.',
 'I need few informations about the course.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> "Information" is an <strong>uncountable noun</strong> in English — it has no plural form. You cannot say "informations" or "an information." Use quantifiers like "some," "a piece of," or "a lot of." Other uncountable nouns: advice, furniture, luggage, equipment.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar');

-- Q10 — Parallelism (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='error-correction' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Which sentence demonstrates correct parallel structure?',
 'She likes reading, writing, and to swim.',
 'She likes reading, writing, and swimming.',
 'She likes to read, writing, and swimming.',
 'She likes reading, to write, and to swim.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <strong>Parallelism</strong> requires all items in a list to have the same grammatical form. Option B uses gerunds : reading, writing, swimming. Mixed forms (gerund + infinitive) violate parallel structure.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar');

-- Q11 — Relative Pronouns (GATE 2021)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='error-correction' LIMIT 1),
 'gate-cse',true,2021,'MCQ','easy',1,
 'Fill in the blank: "The professor ________ lecture I attended is a renowned scientist."',
 'who', 'whom', 'whose', 'which', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> "Whose" shows possession — the lecture belongs to the professor. "Who" is for subjects, "whom" for objects. "Which" is for things, not people. "Whose lecture" = the professor''s lecture.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar');

-- Q12 — Dangling Modifier (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='error-correction' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'Which sentence has a dangling modifier?',
 'Walking through the park, the flowers looked beautiful.',
 'Walking through the park, she noticed the beautiful flowers.',
 'She walked through the park and noticed the beautiful flowers.',
 'While she was walking through the park, the flowers looked beautiful.',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> A <strong>dangling modifier</strong> occurs when the participial phrase doesn''t modify the grammatical subject. In A, "Walking through the park" modifies "the flowers" — implying the flowers were walking. In B, the modifier attaches to "she."</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar');

-- Q13 — Reported Speech (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='tenses-voice' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',1,
 'Convert to reported speech: He said, "I am going to the market."',
 'He said that he is going to the market.',
 'He said that he was going to the market.',
 'He said that he had been going to the market.',
 'He said that he will go to the market.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In reported speech, tenses shift back: Present Continuous ("am going") → Past Continuous ("was going"). Pronoun: "I" → "he." The reporting verb "said" triggers the tense backshift.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','tenses');

-- Q14 — Correct Use of "Neither...Nor" (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='subject-verb-agreement' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',1,
 'Choose the correct sentence:',
 'Neither the captain nor the players is ready.',
 'Neither the captain nor the players are ready.',
 'Neither the captain or the players are ready.',
 'Neither the captain nor the players was ready.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> "Neither...nor" (not "or") is the correct pairing. The verb agrees with the nearer subject: "players" is plural → "are." If reversed: "Neither the players nor the captain <em>is</em> ready" would be correct.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('grammar','subject-verb');

-- Part 2 complete: 14 MCQs (Verbal Grammar).
