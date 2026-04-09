-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — TOC PYQ SEED v2  (Part 1 / 8)
-- Subject: Theory of Computation (TOC)
-- Scope: Initialization, Chapters, Tags, Topics
-- ═══════════════════════════════════════════════════════════════════════════

-- ─── Subject ─────────────────────────────────────────────────────────────
INSERT INTO subjects (slug, name, description, color, icon)
VALUES (
  'toc',
  'Theory of Computation',
  'Automata theory, regular languages, context-free grammars, Turing machines, and decidability.',
  '#f57c00', -- Orange
  '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-cpu"><rect width="16" height="16" x="4" y="4" rx="2" ry="2"/><rect width="6" height="6" x="9" y="9" rx="1" ry="1"/><path d="M15 2v2"/><path d="M15 20v2"/><path d="M2 15h2"/><path d="M20 15h2"/><path d="M2 9h2"/><path d="M20 9h2"/><path d="M9 2v2"/><path d="M9 20v2"/></svg>'
) ON CONFLICT (slug) DO NOTHING;

-- ─── Chapters ────────────────────────────────────────────────────────────
WITH s AS (SELECT id FROM subjects WHERE slug='toc')
INSERT INTO chapters (subject_id, slug, name, description, "order") VALUES
((SELECT id FROM s), 'regular-languages', 'Regular Languages & Finite Automata', 'DFA, NFA, Regular Expressions, and Pumping Lemma for Regular Languages.', 1),
((SELECT id FROM s), 'context-free-languages', 'Context-Free Languages & PDA', 'CFG, Pushdown Automata, Chomsky Normal Form, and properties of Context-Free Languages.', 2),
((SELECT id FROM s), 'turing-machines', 'Turing Machines & Computability', 'Turing Machines, Recursive Enumerable languages, and Unrestricted grammars.', 3),
((SELECT id FROM s), 'decidability', 'Undecidability & Complexity', 'Halting Problem, Rice''s Theorem, Decidability properties, and Reducibility.', 4)
ON CONFLICT (subject_id, slug) DO NOTHING;

-- ─── Tags ────────────────────────────────────────────────────────────────
INSERT INTO tags (slug, name) VALUES
('dfa', 'DFA & NFA'),
('regular-expressions', 'Regular Expressions'),
('closure-properties', 'Closure Properties'),
('cfg', 'Context-Free Grammars'),
('pda', 'Pushdown Automata'),
('pumping-lemma', 'Pumping Lemma'),
('turing-machine', 'Turing Machines'),
('decidability', 'Decidability'),
('undecidability', 'Undecidability'),
('rices-theorem', 'Rice''s Theorem'),
('hierarchy', 'Chomsky Hierarchy')
ON CONFLICT (slug) DO NOTHING;

-- ─── Topics ──────────────────────────────────────────────────────────────
WITH c1 AS (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
     c2 AS (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
     c3 AS (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
     c4 AS (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1)
INSERT INTO topics (chapter_id, slug, name, "order") VALUES
-- Chapter 1: Regular Languages
((SELECT id FROM c1), 'dfa-basics', 'Deterministic Finite Automata (DFA)', 1),
((SELECT id FROM c1), 'nfa-to-dfa', 'NFA and DFA Equivalence', 2),
((SELECT id FROM c1), 'regular-expressions', 'Regular Expressions & Identities', 3),
((SELECT id FROM c1), 'dfa-minimization', 'DFA Minimization', 4),
((SELECT id FROM c1), 'mealy-moore', 'Mealy & Moore Machines', 5),
((SELECT id FROM c1), 'regular-pumping', 'Pumping Lemma for Regular Languages', 6),
((SELECT id FROM c1), 'regular-closure', 'Closure Properties of Regular Languages', 7),

-- Chapter 2: Context-Free Languages
((SELECT id FROM c2), 'cfg-ambiguity', 'CFG & Ambiguity', 1),
((SELECT id FROM c2), 'chomsky-normal', 'Chomsky & Greibach Normal Forms', 2),
((SELECT id FROM c2), 'pda-basics', 'Pushdown Automata (PDA)', 3),
((SELECT id FROM c2), 'cfl-closure', 'Closure Properties of CFL & DCFL', 4),
((SELECT id FROM c2), 'cfl-pumping', 'Pumping Lemma for CFLs', 5),

-- Chapter 3: Turing Machines
((SELECT id FROM c3), 'tm-basics', 'Turing Machines Architecture', 1),
((SELECT id FROM c3), 'recursive-languages', 'Recursive vs Recursive Enumerable', 2),
((SELECT id FROM c3), 'chomsky-hierarchy', 'Chomsky Hierarchy Overview', 3),

-- Chapter 4: Decidability
((SELECT id FROM c4), 'halting-problem', 'The Halting Problem', 1),
((SELECT id FROM c4), 'decidable-problems', 'Decidable Properties of Languages', 2),
((SELECT id FROM c4), 'rices-theorem-topic', 'Rice''s Theorem', 3),
((SELECT id FROM c4), 'reducibility', 'Reducibility Concepts', 4)
ON CONFLICT (chapter_id, slug) DO NOTHING;

-- Part 1 complete.
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
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — TOC PYQ SEED v2  (Part 3 / 8)
-- MCQ Questions Q15–Q28 (Context-Free Grammars & PDA)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — CFG Ambiguity (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cfg-ambiguity' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A Context-Free Grammar (CFG) is classified as ambiguous if:',
  'It cannot be reduced to Chomsky Normal Form',
  'It has at least two distinct left-most derivations for the same string',
  'It generates the empty string',
  'No Pushdown Automaton can accept it',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Ambiguity occurs when a single string can be generated by multiple distinct parse trees (e.g., more than one leftmost derivation or rightmost derivation).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfg');

-- Q16 — Chomsky Normal Form (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='chomsky-normal' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In generating a string of exactly $n$ terminals ($n > 0$), what is the number of derivation steps required by a CFG in Chomsky Normal Form (CNF)?',
  '$n$',
  '$n-1$',
  '$2n-1$',
  '$2^n$',
  'C',
  '<p><strong>✓ Answer: C — $2n-1$.</strong></p><p><strong>Step-by-step:</strong><br>CNF restricts productions to $A \rightarrow BC$ or $A \rightarrow a$.<br>Generating $n$ separate terminals requires $n-1$ splitting steps to produce $n$ variables. Converting the $n$ variables takes $n$ steps. Total steps = $(n-1) + n = 2n-1$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfg');

-- Q17 — Non-Context Free Language (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cfl-closure' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Which language is NOT Context-Free?',
  '$L = \{a^n b^n c^n \mid n \ge 1\}$',
  '$L = \{a^n b^n \mid n \ge 1\}$',
  '$L = \{w w^R \mid w \in (a,b)^*\}$',
  '$L = \{a^n b^m \mid n \neq m\}$',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The language $a^n b^n c^n$ requires maintaining equality across three constraints. A standard Pushdown Automaton with a single stack can only balance two variables, making this language Context-Sensitive.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfl-closure','hierarchy');

-- Q18 — DCFL vs CFL (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pda-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which operational property differentiates Deterministic Context-Free Languages (DCFL) from Context-Free Languages (CFL)?',
  'DCFL representations are closed under complement operation',
  'DCFL representations are regular',
  'DCFL representations allow multiple stack operations per transition',
  'DCFLs can be recognized by finite automata',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Unlike traditional CFLs (which fail complement closure), Deterministic CFLs are closed under the complement operator.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfl-closure','pda');

-- Q19 — PDA Null State Acceptance (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pda-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In a Pushdown Automaton, acceptance by empty stack and acceptance by final state are:',
  'Equivalent in power, defining the same language family',
  'Different, final state is more powerful',
  'Different, empty stack is more powerful',
  'Only used in deterministic mode',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> A PDA accepting by empty stack can be converted to one accepting by final state, and vice versa. They define the same class of Context-Free Languages.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pda');

-- Q20 — CFG Left Recursion (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cfg-ambiguity' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Eliminating direct left recursion from $A \rightarrow A\alpha \mid \beta$ yields:',
  '$A \rightarrow \beta A''$, $A'' \rightarrow \alpha A'' \mid \epsilon$',
  '$A \rightarrow \alpha A''$, $A'' \rightarrow \beta A'' \mid \epsilon$',
  '$A \rightarrow A''\beta$, $A'' \rightarrow A''\alpha \mid \epsilon$',
  '$A \rightarrow \beta A$, $A \rightarrow \alpha A \mid \epsilon$',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The standard algorithm replaces the left-recursive loop $A \rightarrow A \alpha$ with right-recursive rules using a new variable $A''$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfg');

-- Q21 — Pumping Lemma CFL bound (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cfl-pumping' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the Pumping Lemma for Context-Free Languages ($w = uvxyz$), which rule forces the pumped segments to be close together?',
  '$|vxy| \le p$',
  '$|vy| > 0$',
  '$|uxy| \le p$',
  '$|v| = |y|$',
  'A',
  '<p><strong>✓ Answer: A — $|vxy| \le p$.</strong></p><p><strong>Rationale:</strong> The constraint $|vxy| \le p$ restricts the bounding distance in the parse tree, ensuring the repeating subtrees representing $v$ and $y$ are localized.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pumping-lemma');

-- Q22 — Decidability of CFL bounds (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cfl-closure' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which operation for Context-Free Grammars is explicitly Undecidable?',
  'Testing Emptiness ($L(G) = \emptyset$)',
  'Testing Membership ($w \in L(G)$)',
  'Testing Equivalence ($L(G_1) = L(G_2)$)',
  'Testing Finiteness (Is $L(G)$ finite?)',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The "Equivalence Problem" comparing whether two CFGs generate the same language is undecidable. Emptiness, Membership, and Finiteness are all decidable.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability','cfg');

-- Q23 — Linear Bounded Automata (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='chomsky-hierarchy' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Linear Bounded Automata (LBA) uniquely accept languages categorized under which Chomsky classification?',
  'Type-0 (Recursively Enumerable)',
  'Type-1 (Context-Sensitive)',
  'Type-2 (Context-Free)',
  'Type-3 (Regular)',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The Chomsky Hierarchy maps Linear Bounded Automata directly to Context-Sensitive Languages (Type-1).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hierarchy','turing-machine');

-- Q24 — Rice's Theorem Implementation (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='rices-theorem-topic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Rice''s Theorem states that for Turing Machines:',
  'Any non-trivial property of the language recognized is Undecidable',
  'Every semantic property is Decidable',
  'Only trivial properties are Undecidable',
  'Syntax checking is Undecidable',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Rice''s Theorem definitively proves that any non-trivial semantic property of Recursively Enumerable languages is mathematically undecidable.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('rices-theorem','decidability');

-- Q25 — Recursive Enumerable properties (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='recursive-languages' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'If language $L$ and its complement $\overline{L}$ are both Recursively Enumerable, what must be true about $L$?',
  'It is Context-Free',
  'It is strictly Regular',
  'It is Recursive (Decidable)',
  'It is Undecidable',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Post''s Theorem guarantees that if both $L$ and $\overline{L}$ are Recursively Enumerable (Turing Recognizable), then $L$ is Recursive (Turing Decidable).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability');

-- Q26 — CFG grammar generation bounds (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cfg-ambiguity' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What characterizes the production rules of Context-Free Grammars?',
  'The left-hand side must consist of exactly one non-terminal variable',
  'Both sides must have equal length',
  'The right-hand side can only contain terminals',
  'The rules must generate regular expressions',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The lack of context constraint defining CFGs requires that only a single non-terminal variable exists on the left side of any production.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cfg');

-- Q27 — Pushdown Automata Non-Determinism (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pda-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Are Deterministic Pushdown Automata (DPDA) functionally equivalent in computational power to Non-Deterministic Pushdown Automata (NPDA)?',
  'Yes, they accept the exact same language class',
  'No, NPDA accepting power strictly exceeds DPDA',
  'No, DPDA accepting power strictly exceeds NPDA',
  'Yes, provided the stack alphabet is binary',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> NPDAs accept all Context-Free Languages. DPDAs accept only Deterministic Context-Free Languages (a strict subset). Therefore, NPDA is strictly more powerful.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pda','cfg');

-- Q28 — The Halting Problem (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='halting-problem' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The Halting Problem determines whether an arbitrary Turing Machine halts on a given input. What is its decidability status?',
  'Decidable',
  'Undecidable, but Recursively Enumerable',
  'Not Recursively Enumerable',
  'Context-Free',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The Halting Problem is recognized by a Universal Turing Machine (so it is RE), but we cannot determine when it will loop infinitely, making it Undecidable.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('decidability','halting-problem');

-- Part 3 complete.
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
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — TOC PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1: Automata & CFLs (11 Cards)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 1
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dfa-basics' LIMIT 1),
  'Compare Regular Languages with Finite Languages.',
  '<p>All finite languages are Regular (a DFA can easily list all valid finite possibilities). However, not all Regular languages are finite (features like Kleene Star create infinite sets).</p>',
  ARRAY['dfa']
),
-- Card 2
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='nfa-to-dfa' LIMIT 1),
  'State the exact relationship between NFA and DFA.',
  '<p>Every NFA can be converted to an equivalent DFA using subset construction. They possess exactly the same computational power. Worst-case state expansion is $O(2^n)$.</p>',
  ARRAY['dfa']
),
-- Card 3
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mealy-moore' LIMIT 1),
  'What is the difference between Mealy and Moore Machines?',
  '<ul><li><strong>Moore Machine:</strong> Output depends solely on the current state (Outputs = $N+1$).</li><li><strong>Mealy Machine:</strong> Output depends on both current state and input transitions (Outputs = $N$). More concise.</li></ul>',
  ARRAY['dfa']
),
-- Card 4
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='regular-closure' LIMIT 1),
  'State the Closure Properties of Regular Languages.',
  '<p>Regular languages are closed under almost all standard operations: Union, Intersection, Complement, Concatenation, Kleene Star, Difference, and Reversal.</p>',
  ARRAY['closure-properties']
),
-- Card 5
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='regular-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='regular-pumping' LIMIT 1),
  'State the Pumping Lemma bounds for Regular Languages.',
  '<p>For string $w$ where $|w| \ge p$, split as $w=xyz$:</p><ul><li>$|xy| \le p$</li><li>$|y| \ge 1$</li><li>$xy^i z \in L$ for all $i \ge 0$</li></ul>',
  ARRAY['pumping-lemma']
),
-- Card 6
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cfl-closure' LIMIT 1),
  'Which fundamental closures do Context-Free Languages fail?',
  '<p>Context-Free Languages are NOT closed under <strong>Intersection</strong> and <strong>Complement</strong>. However, their deterministic subset (DCFL) is closed under Complement.</p>',
  ARRAY['cfl-closure']
),
-- Card 7
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cfg-ambiguity' LIMIT 1),
  'What defines an Ambiguous Grammar?',
  '<p>A CFG where at least one valid string can be parsed by two distinctly different parse trees (e.g., yielding multiple leftmost derivations). Inherently undecidable to verify.</p>',
  ARRAY['cfg']
),
-- Card 8
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='chomsky-normal' LIMIT 1),
  'Describe Chomsky Normal Form (CNF) and Greibach Normal Form (GNF).',
  '<ul><li><strong>CNF:</strong> Productions must be $A \rightarrow BC$ or $A \rightarrow a$.</li><li><strong>GNF:</strong> Productions must be $A \rightarrow a \alpha$ (terminal followed by variables).</li></ul>',
  ARRAY['cfg']
),
-- Card 9
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pda-basics' LIMIT 1),
  'What is the power ratio between deterministic and non-deterministic PDA?',
  '<p>Unlike finite automata, NPDA is strictly more powerful than DPDA. NPDA accepts all Context-Free Languages, while DPDA only recognizes Deterministic Context-Free Languages.</p>',
  ARRAY['pda']
),
-- Card 10
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cfl-pumping' LIMIT 1),
  'State the Pumping Lemma bounds for Context-Free Languages.',
  '<p>For string $w$ where $|w| \ge p$, split as $w=uvxyz$:</p><ul><li>$|vxy| \le p$</li><li>$|vy| \ge 1$</li><li>$uv^i xy^i z \in L$ for all $i \ge 0$</li></ul>',
  ARRAY['pumping-lemma']
),
-- Card 11
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='context-free-languages' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cfl-closure' LIMIT 1),
  'How do you check emptiness for a Context-Free Grammar?',
  '<p>Emptiness of a CFG is Decidable. You algorithmically trace backwards from terminals to the start symbol to determine if the start symbol can yield any terminal string.</p>',
  ARRAY['cfg','decidability']
);

-- Part 7 complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — TOC PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2: Turing Machines & Decidability (11 Cards) + COMMIT
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 12
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='chomsky-hierarchy' LIMIT 1),
  'Outline the Chomsky Hierarchy from highest power to lowest.',
  '<p>Type-0 (Recursively Enumerable / Turing Machine) $\supset$ Type-1 (Context Sensitive / LBA) $\supset$ Type-2 (Context-Free / PDA) $\supset$ Type-3 (Regular / DFA).</p>',
  ARRAY['hierarchy']
),
-- Card 13
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tm-basics' LIMIT 1),
  'Does a multi-tape Turing Machine increase computational power?',
  '<p>No. Multi-tape, non-deterministic, and multi-dimensional Turing Machines merely increase speed or efficiency. They possess the exact same theoretical computational power as a standard single-tape Turing Machine.</p>',
  ARRAY['turing-machine']
),
-- Card 14
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='chomsky-hierarchy' LIMIT 1),
  'What characterizes a Linear Bounded Automaton (LBA)?',
  '<p>A Turing Machine whose tape head is strictly restricted to the precise segments spanning the original input string. It operates within Type-1 Context-Sensitive languages.</p>',
  ARRAY['hierarchy','turing-machine']
),
-- Card 15
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='recursive-languages' LIMIT 1),
  'Distinguish between Recursive and Recursively Enumerable Languages.',
  '<ul><li><strong>Recursive (Decidable):</strong> Turing Machine halts and accepts valid strings, halts and rejects invalid strings.</li><li><strong>Recursively Enumerable:</strong> Turing Machine halts and accepts valid strings, but may loop infinitely on invalid strings.</li></ul>',
  ARRAY['turing-machine']
),
-- Card 16
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='turing-machines' LIMIT 1),
  (SELECT id FROM topics WHERE slug='recursive-languages' LIMIT 1),
  'What does Post''s Theorem fundamentally state?',
  '<p>If a language $L$ is Recursively Enumerable, and its complement $\overline{L}$ is also Recursively Enumerable, then both $L$ and $\overline{L}$ must be inherently Recursive (Decidable).</p>',
  ARRAY['decidability']
),
-- Card 17
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='halting-problem' LIMIT 1),
  'Explain the Halting Problem.',
  '<p>Given a description of an arbitrary Turing Machine and any specified input, it is definitively Undecidable to deterministically predict whether the machine will eventually halt or run forever across all potential cases.</p>',
  ARRAY['undecidability']
),
-- Card 18
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='rices-theorem-topic' LIMIT 1),
  'Summarize Rice''s Theorem.',
  '<p>Any non-trivial semantic property regarding the language recognized by a Turing Machine is universally Undecidable.</p>',
  ARRAY['rices-theorem']
),
-- Card 19
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='decidable-problems' LIMIT 1),
  'List the operations that are Decidable for Context-Free Grammars.',
  '<p>Emptiness (Does it accept anything?), Finiteness (Is the language finite?), and Membership (Does it generate string W? via CYK algorithm).</p>',
  ARRAY['decidability','cfg']
),
-- Card 20
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='decidable-problems' LIMIT 1),
  'List operations strictly Undecidable for Context-Free Grammars.',
  '<p>Equivalence ($L(G_1) = L(G_2)$), Universality ($L(G) = \Sigma^*$), Ambiguity, and determining whether $L(G_1) \cap L(G_2)$ is empty.</p>',
  ARRAY['decidability','cfg']
),
-- Card 21
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='reducibility' LIMIT 1),
  'What is the fundamental logic of Reducibility?',
  '<p>If solving Problem X automatically gives you the power to solve Problem Y, we say Y reduces to X. If Y is a known Undecidable problem (like Halting), then X must also be Undecidable.</p>',
  ARRAY['decidability']
),
-- Card 22
(
  (SELECT id FROM subjects WHERE slug='toc'),
  (SELECT id FROM chapters WHERE slug='decidability' LIMIT 1),
  (SELECT id FROM topics WHERE slug='reducibility' LIMIT 1),
  'What is the Post Correspondence Problem (PCP)?',
  '<p>Given dominos with strings on top and bottom, can you align them so the top string equals the bottom string? Modified PCP requires starting with a specific first domino. Both are known to be definitively Undecidable.</p>',
  ARRAY['undecidability']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing toc-seed.sql to verify correctness:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='toc'));
-- Expected: 19
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='toc');
-- Expected: 65
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='toc');
-- Expected: 22
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='toc')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug: toc
-- Schema version: v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- Chapters:     4 (Regular, CFG, Turing, Decidability)
-- Topics:       19
-- Questions:    65 total
--   MCQ:        45 (Q1–Q45)
--   NAT:        10 (Q46–Q55)
--   MSQ:        10 (Q56–Q65)
-- Flashcards:   22 concise mathematical theory cards
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF toc-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
