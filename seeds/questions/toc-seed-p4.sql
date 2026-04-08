-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — TOC PYQ SEED v2 (Part 4 / 8)
-- MCQ Questions Q29–Q45 (Turing Machines, Computability & Decidability)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q29 — Universal Turing Machine (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
 (SELECT id FROM topics WHERE slug='tm-basics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'A Universal Turing Machine (UTM) can simulate the execution of:',
 'Only Finite Automata and Pushdown Automata',
 'Any other arbitrary Turing Machine when provided its encoded description and input',
 'Only deterministic Turing Machines',
 'Linear Bounded Automata ',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A Universal Turing Machine can read the blueprint string formatting any target Turing Machine and execute the provided .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('turing-machine');

-- Q30 — Recursively Enumerable Languages intersection (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursive-languages' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Are Recursively Enumerable (RE) languages closed under intersection and complement?',
 'Closed under both intersection and complement',
 'Closed under intersection, but NOT closed under complement',
 'Not closed under intersection, but closed under complement',
 'Not closed under either',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> RE languages simulate machines in parallel to accept intersections. However, if they were closed under complement, all RE languages would become Recursive (Decidable), which is false.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability');

-- Q31 — Chomsky Hierarchy Bounds (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chomsky-hierarchy' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'According to the Chomsky Hierarchy, Context-Free Languages exist as a strict subset within which broader language family?',
 'Regular Languages',
 'Finite Languages',
 'Context-Sensitive Languages',
 'Polynomial Languages',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The standard subset chain is: Regular (Type 3) $\subset$ Context-Free (Type 2) $\subset$ Context-Sensitive (Type 1) $\subset$ Recursively Enumerable (Type 0).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hierarchy');

-- Q32 — Undecidability property mappings (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
 (SELECT id FROM topics WHERE slug='decidable-problems' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Which language property concerning Regular Languages is mathematically Undecidable?',
 'Testing Emptiness ($L = \emptyset$)',
 'Testing Membership ($w \in L$)',
 'Testing Finiteness (Is $L$ finite)?',
 'None of the above. They are all decidable.',
 'D',
 '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> Every standard query (Emptiness, Finiteness, Membership, Equivalence) regarding Regular Languages is Decidable using DFA graph algorithms.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability');

-- Q33 — Pumping Lemma bounds (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='cfl-pumping' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'To prove language $L = \{ a^{p} \mid p \text{ is prime} \}$ is not regular via the Pumping Lemma ($w = xyz$), which parameter choice forces a contradiction?',
 'Selecting $i = |xy|$',
 'Selecting $i = p+1$',
 'Selecting $i = 0$',
 'Both B and A',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The pumped string length becomes $p + (i-1)|y|$. By choosing $i = p+1$, the length becomes $p + p|y| = p(1+|y|)$, which is composite, proving the language is not regular.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pumping-lemma');

-- Q34 — Multi-Tape Turing Machine (hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
 (SELECT id FROM topics WHERE slug='tm-basics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'How does a Multi-Tape Turing Machine compare conceptually with a standard Single-Tape Turing Machine?',
 'Multi-tape machines accept a larger class of languages',
 'Multi-tape machines accept the same class of languages (Recursively Enumerable)',
 'Multi-tape machines only recognize Context-Sensitive languages',
 'Multi-tape machines cannot handle infinite recursion',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A Multi-Tape TM can be simulated by a Single-Tape TM. They have exactly the same computational power regarding language recognition, though the multi-tape variant may compute faster.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('turing-machine');

-- Q35 — Halting Problem Reduction (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
 (SELECT id FROM topics WHERE slug='reducibility' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'When reducing the known Undecidable Halting Problem $H$ logically towards an unknown Problem $X$, what does a valid reduction prove?',
 'Problem $X$ is Decidable',
 'Problem $X$ is Undecidable',
 'Problem $X$ is NP-Complete',
 'No conclusions arise',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Reducibility principle: If solving $X$ would also allow you to simultaneously solve the unsolvable Halting Problem, then Problem $X$ must also be Undecidable.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability');

-- Q36 — Greibach Normal Form (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chomsky-normal' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Greibach Normal Form (GNF) requires all productions to be of the form:',
 '$A \rightarrow BC$',
 '$A \rightarrow a\alpha$ (Single terminal followed by zero or more variables)',
 '$A \rightarrow aB$',
 '$A \rightarrow BCa$',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> GNF productions always start with exactly one terminal character, ensuring each derivation step consumes one input character.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfg');

-- Q37 — Regular Grammar definition (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dfa-basics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'A grammar containing exclusively production formats $A \rightarrow aB$ and $A \rightarrow \epsilon$ generates:',
 'Regular Languages',
 'Context-Sensitive Languages',
 'Context-Free Languages',
 'Recursively Enumerable Languages',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> This is the strict definition of a Right-Linear Grammar, which corresponds exactly to Regular Languages.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hierarchy');

-- Q38 — PDA Stack (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pda-basics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'A Finite Automaton equipped with exactly TWO independent stacks has computational power equivalent to:',
 'A Pushdown Automaton',
 'A Linear Bounded Automaton',
 'A Turing Machine',
 'A Deterministic Finite Automaton',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Two stacks can effectively simulate the left and right sides of an infinite Turing Machine tape, granting full Turing-complete power.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pda','turing-machine');

-- Q39 — Regular subset (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
 (SELECT id FROM topics WHERE slug='decidable-problems' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Given a Context-Free Grammar $G$, determining if $L(G)$ is a Regular language is:',
 'Decidable',
 'Undecidable',
 'Decidable only if $G$ is ambiguous',
 'NP-Complete',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> By Greibach''s Theorem (and to the Halting problem), testing if a Context-Free Language happens to also be Regular is Undecidable.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability');

-- Q40 — Recursively Enumerable Closure (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursive-languages' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Recursively Enumerable languages are closed under:',
 'Union and Intersection',
 'Complement and Difference',
 'Symmetric Difference',
 'All operations',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> RE Languages are closed under Union, Intersection, Concatenation, and Kleene Star. They are NOT closed under Complement or Difference.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('closure-properties');

-- Q41 — Deterministic PDA constraints (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pda-basics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Deterministic Context-Free Languages (DCFL) fail closure under which operation?',
 'Complement',
 'Union',
 'Inverse Homomorphism',
 'Intersection with a Regular Language',
 'B',
 '<p><strong>✓ Answer: B — Union.</strong></p><p><strong>Rationale:</strong> While standard CFLs are closed under Union, DCFLs are NOT. DCFLs are closed under Complement, unlike general CFLs.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfl-closure');

-- Q42 — Context-Sensitive production properties (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chomsky-hierarchy' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Context-Sensitive grammar rules $\alpha \rightarrow \beta$ require which structural length boundary ?',
 '$|\alpha| \le |\beta|$',
 '$|\alpha| > |\beta|$',
 '$|\alpha| = 1$',
 'There is no size limit',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The fundamental rule for Context-Sensitive grammars is that productions cannot shrink the string length (non-contracting). Thus, the right side must be at least as long as the left side.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hierarchy');

-- Q43 — Universal check for CFG (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
 (SELECT id FROM topics WHERE slug='decidable-problems' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Given a CFG $G$, testing if it generates all possible strings ($L(G) = \Sigma^*$) evaluates as:',
 'Decidable',
 'Undecidable',
 'Recursively Enumerable but not Recursive',
 'Context-Free',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The Universality Problem is Undecidable for Context-Free Grammars, even though it is Decidable for Regular Languages via minimal DFA comparisons.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability');

-- Q44 — Linear Bounded Automata limits (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chomsky-hierarchy' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'How much tape space is permitted for a Linear Bounded Automaton (LBA) to execute its ?',
 'Finite tape space independent of the input size',
 'Tape space scaled to the input size boundary markers',
 'Exactly two stacks representing infinite boundaries',
 'Infinite unconstrained tape matching standard TMs',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> An LBA restricts the Turing Machine head to operate within the bounds surrounding the original input string using left and right end markers.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('turing-machine');

-- Q45 — Regular operation failure (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='regular-closure' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Regular languages fail to maintain mathematical closure under which specific operation?',
 'Union bounds',
 'Concatenation',
 'Subset constraints',
 'Kleene Star',
 'C',
 '<p><strong>✓ Answer: C — Subset constraints.</strong></p><p><strong>Rationale:</strong> Regular bounds remain closed Union, Concatenation, and Kleene Star. Subset operations fail because a regular language can easily contain a non-regular subset (e.g., $a^n b^n$ is a subset of $a^*b^*$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('closure-properties');

-- Part 4 complete.
