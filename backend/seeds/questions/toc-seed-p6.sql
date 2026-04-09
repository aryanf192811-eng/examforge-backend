-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — TOC PYQ SEED v2 (Part 6 / 8)
-- MSQ Questions Q56–Q65 (Language limits, Automata structures)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q56 — MSQ: Regular Language properties (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='regular-closure' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Which of the following classical statements characterizing Regular Languages mathematically evaluate as true? (Select all that apply)',
 'Every finite language is Regular',
 'Regular Languages exclusively maintain closure bounding intersection operations',
 'The union combining two infinite Regular Languages ensures a Regular subset',
 'Every Context-Free defines a Regular subset',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> All finite languages are regular because a DFA can be specifically designed containing singular paths exactly every string.<br>- <strong>B:</strong> Regular sets exhibit closure under intersection (proven via DFA cross-product boundaries).<br>- <strong>C:</strong> Regular sets execute strict mathematical closure union operations.<br>- <strong>Why D is FALSE:</strong> Many Context-Free bounds ($a^n b^n$) defy Regular executions.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('closure-properties');

-- Q57 — MSQ: Context-Free Language Closure (hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='cfl-closure' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','hard',2,
 'Context-Free Languages verify mechanical mathematical closure which operational ? (Select all that apply)',
 'Operation Union merging components',
 'Operation Intersection bounds',
 'Operation Kleene Star sequences',
 'Complement definitions boundaries',
 ARRAY['A','C'],
 '<p><strong>✓ Answers: A, C.</strong></p><p><strong>Rationale:</strong> Context-Free Languages prove closed determining Union, Concatenation, maintaining Kleene Star logic properties. Mathematical limits technically fail capabilities Intersections and Complements.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfl-closure');

-- Q58 — MSQ: Decidable Properties bounds (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
 (SELECT id FROM topics WHERE slug='decidable-problems' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Which language boundary execute formulating Decidable computational bounds processing standard Context-Free Grammars? (Select all that apply)',
 'Finiteness sequence structures',
 'Membership verifying specific character constraints',
 'Emptiness grammar variables',
 'Ambiguity determining structural constraints',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> CFG derivations checks Emptiness valid token reaches. Finiteness detects cyclical dependencies non-terminal dependencies. Membership runs mechanically CYK capabilities. CFG Ambiguity is Undecidable mathematically.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability');

-- Q59 — MSQ: DFA limitations (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dfa-basics' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'Valid Deterministic Finite Automata execute processing rules restricting operations maintaining which conditions? (Select all that apply)',
 'Zero structural boundaries permit $\epsilon$-transitions ',
 'Constructing exactly one single active transitioning edge unique input boundaries',
 'Determining multiple Final States configuring outputs',
 'Processing non-deterministic sequences simultaneously simulating structures',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> DFA properties mathematically restrict rejecting $\epsilon$-transitions, force one explicit execution boundary recognizing individual tokens, and freely accept variables designating multiple terminal final state destinations. Non-determinism is mechanically forbidden.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Q60 — MSQ: Pushdown capacities (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pda-basics' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Pushdown Automata computational limitations execute capable operations which mathematical bounds? (Select all that apply)',
 'Recognizing strings form $a^n b^n c^n$',
 'structures counting $w w^R$ patterns ',
 'Calculating balanced mappings matching parenthesis ',
 'Determining creating matching variables testing $a^n b^m \mid n \le m$',
 ARRAY['B','C','D'],
 '<p><strong>✓ Answers: B, C, D.</strong></p><p><strong>Rationale:</strong> PDA bounds handle nested bracket relationships , map perfectly mathematical comparisons (like $n \le m$), string mappings determining symmetrical palindrome boundaries ($w w^R$). Tri-state equivalence $a^n b^n c^n$ demands escaping Pushdown limits CFG boundaries.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pda','cfg');

-- Q61 — MSQ: Undecidable limitations TM structures (hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
 (SELECT id FROM topics WHERE slug='halting-problem' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','hard',2,
 'Which properties verifying standard Turing Machine boundaries map essentially Undecidable outcomes? (Select all that apply)',
 'Verifying mathematical outputs reaching universal string acceptance ($L(M) = \Sigma^*$)',
 'Recognizing limits halting specific blank array ',
 'Calculating limits predicting execution tracks exceeding specifically 50 transitions',
 'Predicting operations outputs finite executions ($L(M)$ contains $N$ items)',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> The Halting condition verifying null blank inputs forms exactly known Turing tests essentially Undecidable loops. universal ($\Sigma^*$) language array checks Finiteness boundaries computing outputs map Undecidable metrics (Rice''s Theorem). Alternatively, specifically bounded limits ($K$ steps) is Decidable testing finite .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability','turing-machine');

-- Q62 — MSQ: Recursively Enumerable sets bounds (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursive-languages' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Select statements accurate Recursively Enumerable configuration behaviors. (Select all that apply)',
 'Equivalent computational models perfectly matching recognized boundaries generated tracing Type-0 Unrestricted Grammars',
 'ensuring execution recognizing exactly Halting Machine evaluations traversing inputs boundaries successfully',
 'limits predicting machine models non-halting executions determining properties rejecting input arrays ',
 'Maintaining mathematically closed evaluations string intersections',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> RE Language checks execute models equal verifying Type-0 Grammars accurately. valid input tokens perfectly resolves recognizing machine terminating limits successfully determining Accept loops. RE limits remain closed standard mathematical intersection boundaries determining bounds. RE rejects maintaining capabilities processing infinite determining valid rejection operations detecting inputs (Option C).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('closure-properties');

-- Q63 — MSQ: Greibach Normal (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chomsky-normal' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'Applying standard definitions limits formulating mathematical CFG constructs Greibach Normal Form checks guarantees matching conditions specifying: (Select all that apply)',
 'Formulating bounds computing omitting Left Recursion patterns',
 'syntax initiating exclusively creating singular Terminal characters components',
 'bounds ensuring exclusively non-terminal array sequences components appending Terminal arrays',
 'Creating string components matching lengths steps length equal derivations output targets',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> GNF properties demand eliminating Left Recursion . Grammars initiate processing outputs appending exactly isolated Terminal bounds ensuring calculated derivation boundaries matching outputs string limits length step components sequentially.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfg');

-- Q64 — MSQ: Closure boundaries Regular evaluation vectors (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='regular-closure' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'standard limits Regular models defines execution sets maintaining mathematical closure limits calculating paths boundaries checks determining: (Select all that apply)',
 'Homomorphism functions boundaries',
 'Inverse Homomorphism tracks limits calculating ',
 'Prefix string matching metrics',
 'String reversal execution loops ',
 ARRAY['A','B','C','D'],
 '<p><strong>✓ Answers: A, B, C, D.</strong></p><p><strong>Rationale:</strong> Regular logic verifies boundaries checks parsing mathematical homomorphism properties, executes equivalent limits structural determining testing prefix parsing boundaries successfully, establishing reversing DFA connections testing loops validly.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('closure-properties');

-- Q65 — MSQ: Post Correspondence capabilities structural tracks (hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
 (SELECT id FROM topics WHERE slug='reducibility' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','hard',2,
 'PCP (Post Correspondence Problem) string operations establishes standard metrics detecting testing bounds testing mathematical determining structures checks limitations: (Select all that apply)',
 'Evaluates computationally verifying Undecidable structure properties checks inputs general definitions operations',
 'Resolves verifying specifically Context-Free matching conditions testing boundaries checks grammar ambiguity boundaries bounds definitions',
 'Generates solutions checks determining operations verifying Regular expressions exclusively definitions values checks constraints properties testing rules ',
 'Proves Undecidable bounding limits determining evaluation bounds Modified PCP definitions logic evaluations mappings checks rules values sequences ',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> PCP remains a standard technique mathematically Undecidable limits arrays limits. Reductions PCP verify bounds CFG ambiguity checks matching boundaries. Modified PCP definitions naturally remain classically Undecidable bounds testing boundaries determining sequences.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability');

-- Part 6 complete.
