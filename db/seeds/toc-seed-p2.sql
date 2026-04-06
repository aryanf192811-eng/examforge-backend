-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — TOC PYQ SEED v2  (Part 2 / 8)
-- MCQ Questions Q1–Q14 (Regular Languages & Automata)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — DFA Language Recognition (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dfa-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Consider a language $L$ consisting of all strings over $\{0, 1\}$ that end with "01". What is the minimum number of states required for a DFA to accept $L$?',
  '2',
  '3',
  '4',
  '5',
  'B',
  '<p><strong>✓ Answer: B — 3.</strong></p><p><strong>Step-by-step:</strong><br>A minimum DFA pattern matching a substring of length $N$ at the end of a string generally requires $N+1$ states.<br>The states remember:<br>1: Read nothing or ended in 1.<br>2: Just read a 0.<br>3: Just read "01" (Final State).<br>Therefore, 3 states are required.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Q2 — Regular Expressions (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='regular-expressions' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following regular expressions represents the language of all strings over $\{a, b\}$ containing an even number of $a$''s?',
  '$(b^* a b^* a b^*)^*',
  '$b^* (a b^* a b^*)^*',
  '$b^* + (a b^* a b^*)^*',
  '$b^* (a b^* a)^*',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The expression $b^*(ab^*ab^*)^*$ reliably generates strings with an even number of $a$''s. The initial $b^*$ handles any leading $b$''s, and the cyclic portion $(ab^*ab^*)^*$ ensures that whenever an $a$ is introduced, it is always matched by a second $a$, guaranteeing an even total.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('regular-expressions');

-- Q3 — NFA vs DFA (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='nfa-to-dfa' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'If an NFA has $N$ states, what is the maximum number of states required to construct an equivalent minimal DFA in the worst-case scenario?',
  '$N^2$',
  '$2^N$',
  '$N!$',
  '$2N$',
  'B',
  '<p><strong>✓ Answer: B — $2^N$.</strong></p><p><strong>Rationale:</strong> The subset construction algorithm converts an NFA to a DFA. In the worst case, the DFA must track every possible combination (subset) of the NFA''s states. A set of $N$ elements has exactly $2^N$ subsets.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Q4 — DFA Minimization (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dfa-minimization' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The Myhill-Nerode theorem states that the number of states in a minimal DFA for a given regular language $L$ is equal to:',
  'The number of characters in the alphabet',
  'The number of accepting states in the DFA',
  'The number of equivalence classes of $L$ over the chosen alphabet',
  'The length of the longest string in $L$',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The Myhill-Nerode theorem proves that a minimal DFA has exactly as many states as there are equivalence classes of the right-invariant equivalence relation over the language strings. If there are infinitely many equivalence classes, the language is not regular.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Q5 — Closure Properties (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='regular-closure' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Let $L_1$ be a regular language and $L_2$ be a Context-Free Language. Which of the following is guaranteed to be a Context-Free Language?',
  '$L_1 \cap L_2$',
  '$L_2 - L_1$',
  'Both A and B',
  'Neither A nor B',
  'C',
  '<p><strong>✓ Answer: C — Both A and B.</strong></p><p><strong>Step-by-step:</strong><br>- The intersection of a CFL and a Regular Language establishes a CFL (proven using a PDA cross-product with a DFA). So $L_1 \cap L_2$ is a CFL.<br>- Set difference $L_2 - L_1$ equals $L_2 \cap \overline{L_1}$. Since Regular Languages are closed under complement, $\overline{L_1}$ is regular. Thus it reduces to the intersection of a CFL and a Regular Language, resulting in a CFL.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('closure-properties');

-- Q6 — Pumping Lemma (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='regular-pumping' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The Pumping Lemma for regular languages is primarily used to:',
  'Prove that a language is regular',
  'Prove that a language is not regular',
  'Find the shortest string accepted by a DFA',
  'Minimize a DFA into fewer states',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The Pumping Lemma forms a necessary (but not sufficient) condition for regularity. Because passing the Pumping Lemma does not guarantee regularity, it cannot prove a language is regular. It is primarily used via proof by contradiction to demonstrate that a language is irregular by showing it fails the condition.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pumping-lemma');

-- Q7 — Regular Expression Identities (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='regular-expressions' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following algebraic equalities regarding regular expressions is mathematically incorrect?',
  '$(R^*)^* = R^*$',
  '$(R + S)^* = (R^* S^*)^*',
  '$R(S + T) = RS + RT$',
  '$R + R = R^*$',
  'D',
  '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> $R + R$ simply duplicates the option $R$, meaning $R \cup R = R$. It does not grant Kleene closure (which produces zero or infinite occurrences). Options A, B, and C are all standard, mathematically valid regex identities.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('regular-expressions');

-- Q8 — Epsilon Closures (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='nfa-to-dfa' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the subset construction algorithm computing an NFA to a DFA, the $\epsilon$-closure of a given state subset $S$ contains:',
  'Only states reachable from $S$ reading exactly one symbol',
  'All states reachable from $S$ without consuming any input symbol',
  'All states reachable from $S$ consuming any string of input',
  'Only the original states present in $S$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The $\epsilon$-closure represents the set of all states reachable solely by traversing $\epsilon$-transitions (zero input symbols), starting from any state in a subset $S$. This operation is critical for removing null transitions during DFA translation.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Q9 — DFA Divisibility (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dfa-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What is the minimum number of states required to construct a DFA that accepts binary strings representing non-negative integers divisible by 5?',
  '3',
  '4',
  '5',
  '6',
  'C',
  '<p><strong>✓ Answer: C — 5.</strong></p><p><strong>Step-by-step:</strong><br>A DFA checking divisibility by $K$ acting upon base-$B$ strings normally requires exactly $K$ states, representing the modular remainders $0, 1, ..., (K-1)$. For $K=5$, the states $q_0, q_1, q_2, q_3, q_4$ represent these remainders. Since binary strings flow left to right, old remainders shift left via $R_{new} \equiv (2 \cdot R_{old} + \text{bit}) \pmod 5$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Q10 — Moore vs Mealy Machine (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mealy-moore' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the fundamental functional difference between a Moore machine and a Mealy machine?',
  'A Moore machine output depends on the state and input; a Mealy machine output depends only on the state.',
  'A Moore machine output depends only on the state; a Mealy machine output depends on both the state and input transition.',
  'A Moore machine has accepting states, but a Mealy machine does not.',
  'A Moore machine operates deterministically, but a Mealy machine is naturally non-deterministic.',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong><br>- <strong>Moore Machine:</strong> Output rests squarely on the current State. Result sequence is size $n+1$ for $n$ inputs.<br>- <strong>Mealy Machine:</strong> Output lies on the Transition (State + Input combination). Result sequence is exactly size $n$ for $n$ inputs. Mealy machines often require fewer states.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Q11 — Right-Linear Grammars (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dfa-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which Chomsky language family exactly equals the set of Right-Linear grammars?',
  'Type-0 (Turing Recognizable)',
  'Type-1 (Context-Sensitive)',
  'Type-2 (Context-Free)',
  'Type-3 (Regular)',
  'D',
  '<p><strong>✓ Answer: D — Type-3.</strong></p><p><strong>Rationale:</strong> By definition, Right-Linear grammars (productions of form $A \rightarrow wB$ or $A \rightarrow w$) and Left-Linear grammars map mechanically to DFA states, perfectly describing Regular Languages (Type-3).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hierarchy');

-- Q12 — Length of String accepted by Minimal DFA (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dfa-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Consider a DFA with exactly $n$ states accepting language $L$. What is the condition verifying if $L$ represents an INFINITE regular language?',
  '$L$ accepts at least one string $w$ having length $n \le |w| < 2n$',
  '$L$ accepts at least one string $w$ having length exactly $n$',
  '$L$ possesses a self-loop on the designated start state',
  '$L$ accepts every possible generated string',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> This leverages the bounds of the Pumping Lemma. If a minimal DFA with $n$ states accepts any string whose length $m$ satisfies $n \le m < 2n$, it guarantees a path spanning more than $n$ states, which forces a loop. The loop execution guarantees infinite accepted strings.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pumping-lemma','dfa');

-- Q13 — Set of Prefixes (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='regular-closure' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'If $L$ is regular, $Prefix(L)$ is defined as the set of all prefixes of all strings inherently belonging to $L$. Which statement is true?',
  '$Prefix(L)$ is guaranteed Context-Free, but not always Regular',
  '$Prefix(L)$ is strictly Regular',
  '$Prefix(L)$ forms a subset of exactly $L$',
  '$Prefix(L)$ is completely undecidable',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Step-by-step:</strong><br>Regular languages exhibit closure under the Prefix operation.<br>To construct a DFA for $Prefix(L)$ from the DFA for $L$, merely convert all states lying on a path to a valid underlying final state into accepting states. Thus, yielding another standard DFA.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('closure-properties');

-- Q14 — NFA string acceptance ambiguity (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='nfa-to-dfa' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'An NFA accepts a designated input string $w$ if and only if:',
  'All possible computational paths lead to an accepting state',
  'There exists at least one computation path traversing the graph that consumes all symbols and terminates in an accepting state',
  'No $\epsilon$-transitions are arbitrarily used during the parsing path',
  'The computation completely empties the reading stack at terminal end',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The formal definition of NFA acceptance requires only a single "successful" fork of non-deterministic execution to terminate in an accepting state after consuming all symbols of the input string.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dfa');

-- Part 2 complete.
