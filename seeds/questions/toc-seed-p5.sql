-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — TOC PYQ SEED v2 (Part 5 / 8)
-- NAT Questions Q46–Q55 (Automata bounds, )
-- ═══════════════════════════════════════════════════════════════════════════

-- Q46 — DFA States Intersection (NAT, medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dfa-basics' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'DFA $A$ has 4 states and DFA $B$ has 3 states. What is the maximum number of states required to construct a DFA recognizing the intersection language $L(A) \cap L(B)$?',
 12.00,12.00,NULL,
 '<p><strong>✓ Answer: 12.</strong></p><p><strong>Step-by-step:</strong><br>Using the standard Cross-Product Construction method for building union or intersection machines: $N_{states} \le N_A \times N_B$.<br>Maximum states = $4 \times 3 = 12$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Q47 — Regular Expression String length (NAT, easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='regular-expressions' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'Consider the regular expression $R = (0+1)^4$. What is the exact length of every string accepted by the minimum DFA for $R$?',
 4.00,4.00,NULL,
 '<p><strong>✓ Answer: 4.</strong></p><p><strong>Step-by-step:</strong><br>The expression requires exactly 4 characters, choosing either 0 or 1 at each step. There is no Kleene star. The language only accepts strings of exact length 4.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('regular-expressions');

-- Q48 — Ambiguity (NAT, medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='cfg-ambiguity' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'Consider the grammar $E \rightarrow E+E \mid a$. How many distinct leftmost derivations exist producing the string $a+a+a$?',
 2.00,2.00,NULL,
 '<p><strong>✓ Answer: 2.</strong></p><p><strong>Step-by-step:</strong><br>Parse 1 (Right branching): $E \Rightarrow E+E \Rightarrow a+E \Rightarrow a+E+E \Rightarrow a+a+E \Rightarrow a+a+a$.<br>Parse 2 (Left branching): $E \Rightarrow E+E \Rightarrow E+E+E \Rightarrow a+E+E \Rightarrow a+a+E \Rightarrow a+a+a$.<br>This demonstrates typical operator ambiguity.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfg');

-- Q49 — DFA modulo constraints (NAT, easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dfa-basics' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'A minimal DFA recognizes the language of strings containing "a" and "b" where $N_a(w) \pmod 3 = 0$ AND $N_b(w) \pmod 2 = 0$. How many states exist in this DFA?',
 6.00,6.00,NULL,
 '<p><strong>✓ Answer: 6.</strong></p><p><strong>Step-by-step:</strong><br>Modulo counters are independent. A counter mod 3 requires 3 states. A counter mod 2 requires 2 states. The product automaton tracks both simultaneously, resulting in $3 \times 2 = 6$ states.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Q50 — Pumping Lemma string size (NAT, medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='regular-pumping' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'Let $L$ be a regular language recognized by a minimal DFA having 5 states. To guarantee that $L$ is infinite based on the Pumping Lemma bounds, the existence of a string of length $K$ ensures a cyclic repeating loop. What is the minimal length $K$ guaranteeing infinite accepted loops?',
 5.00,5.00,NULL,
 '<p><strong>✓ Answer: 5.</strong></p><p><strong>Step-by-step:</strong><br>By the Pigeonhole Principle, a path reading $N$ characters traverses $N+1$ states. If a string has length $N=5$, traversing it requires 6 states. Since the DFA only has 5 states, a state must be revisited establishing a loop. The bounds infinite regularity search string lengths $n \le |w| < 2n$, meaning length 5 suffices.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pumping-lemma','dfa');

-- Q51 — Chomsky Normal Form Length (NAT, easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chomsky-normal' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'A CFG optimized in Chomsky Normal Form (CNF) requires exactly 15 derivation steps to generate a string $w$. What is the exact length of the terminal string $w$?',
 8.00,8.00,NULL,
 '<p><strong>✓ Answer: 8.</strong></p><p><strong>Step-by-step:</strong><br>The general CNF step derivation formula is $Steps = 2n - 1$, where $n$ is the length of the string.<br>$15 = 2n - 1$<br>$16 = 2n \implies n = 8$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfg');

-- Q52 — Computability bounds (NAT, medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
 (SELECT id FROM topics WHERE slug='decidable-problems' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'How many Undecidable properties exist determining the Universal language $L = \Sigma^*$ over arbitrary DFA models?',
 0.00,0.00,NULL,
 '<p><strong>✓ Answer: 0.</strong></p><p><strong>Rationale:</strong> The equivalence (Universality) problem whether a DFA matches $\Sigma^*$ is Decidable. Every fundamental property comparing and DFA boundaries executes fully Decidable limits.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability');

-- Q53 — Mealy machine output lengths (NAT, hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='mealy-moore' LIMIT 1),
 'gate-cse',false,NULL,'NAT','hard',2,
 'A Mealy Machine processes an input string 18 characters. What is the exact character length generated creating the execution output string?',
 18.00,18.00,NULL,
 '<p><strong>✓ Answer: 18.</strong></p><p><strong>Step-by-step:</strong><br>Mealy machines trigger outputs mapped synchronously upon individual transition edges. Therefore, traversing 18 inputs executes exactly 18 transitions, yielding exactly 18 output characters. (A Moore machine would yield 19).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Q54 — Minimum states substring bounds (NAT, easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dfa-basics' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'What is the minimum number of states bounding a DFA that exclusively recognizes strings starting matching the prefix "101"?',
 5.00,5.00,NULL,
 '<p><strong>✓ Answer: 5.</strong></p><p><strong>Step-by-step:</strong><br>Prefix recognition requires $N+2$ states. $N=3$ characters.<br>State list:<br>1: Start<br>2: Read "1"<br>3: Read "10"<br>4: Read "101" (Final State, accepting all subsequent input).<br>5: Dead State (Trap state catching invalid prefixes).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Q55 — NFA subsets sizes (NAT, medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='toc'),
 (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
 (SELECT id FROM topics WHERE slug='nfa-to-dfa' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'An NFA encompasses exactly 4 functional states ($q_0, q_1, q_2, q_3$). Using deterministic subset construction, what calculates the absolute upper maximum bounding limit representing DFA structural states?',
 16.00,16.00,NULL,
 '<p><strong>✓ Answer: 16.</strong></p><p><strong>Step-by-step:</strong><br>The subset algorithm models sets combining functional subset possibilities NFA boundaries.<br>Max limits calculate $2^N$. For $N=4$, $2^4 = 16$ structural subset .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Part 5 complete.
