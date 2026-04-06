-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COMPILER DESIGN (CD) PYQ SEED v2 (Part 1 / 8)
-- Master Initialization: Subject, Chapters, Topics, Tags
-- ═══════════════════════════════════════════════════════════════════════════

BEGIN;

-- 1. Insert Subject: Compiler Design
INSERT INTO subjects (name, slug, description, gradient_start, gradient_end, icon)
VALUES (
 'Compiler Design',
 'cd',
 'Lexical analysis, parsing techniques, semantic analysis, code optimization, and runtime environments.',
 '#4ade80', -- Green-400
 '#22c55e', -- Green-500
 'Terminal'
) ON CONFLICT (slug) DO NOTHING;

-- 2. Insert Chapters
WITH cd AS (SELECT id FROM subjects WHERE slug = 'cd')
INSERT INTO chapters (subject_id, name, slug, description, sequence)
VALUES
 ((SELECT id FROM cd), 'Lexical Analysis', 'lexical-analysis', 'Tokenization, regex to DFA mappings, buffer management.', 1),
 ((SELECT id FROM cd), 'Syntax Analysis', 'syntax-analysis', 'LL, LR, SLR, LALR parsers, and grammar properties.', 2),
 ((SELECT id FROM cd), 'Syntax Directed Translation', 'sdt-icg', 'SDT implementations, abstract syntax trees, and intermediate code.', 3),
 ((SELECT id FROM cd), 'Optimization & Runtime', 'optimization-runtime', 'Data-flow analysis, peephole optimization, and activation records.', 4)
ON CONFLICT (subject_id, slug) DO NOTHING;

-- 3. Insert Common Tags
INSERT INTO tags (name, slug) VALUES
('Lexical Analysis', 'lexical-analysis'),
('DFA', 'dfa-regex'),
('Tokens', 'tokens'),
('Parsing', 'parsing'),
('Top-Down Parsing', 'll-parsing'),
('Bottom-Up Parsing', 'lr-parsing'),
('First & Follow', 'first-follow'),
('SDT', 'sdt'),
('Intermediate Code', 'icg'),
('DAG', 'dag'),
('Code Optimization', 'optimization'),
('Liveness Analysis', 'liveness'),
('Runtime Environment', 'runtime-env'),
('Activation Records', 'activation')
ON CONFLICT (slug) DO NOTHING;

-- 4. Insert Topics
WITH chap_lex AS (SELECT id FROM chapters WHERE slug = 'lexical-analysis' AND subject_id = (SELECT id FROM subjects WHERE slug = 'cd')),
 chap_syn AS (SELECT id FROM chapters WHERE slug = 'syntax-analysis' AND subject_id = (SELECT id FROM subjects WHERE slug = 'cd')),
 chap_sdt AS (SELECT id FROM chapters WHERE slug = 'sdt-icg' AND subject_id = (SELECT id FROM subjects WHERE slug = 'cd')),
 chap_opt AS (SELECT id FROM chapters WHERE slug = 'optimization-runtime' AND subject_id = (SELECT id FROM subjects WHERE slug = 'cd'))
INSERT INTO topics (chapter_id, name, slug, sequence) VALUES
 -- Lexical
 ((SELECT id FROM chap_lex), 'Token Identification', 'token-identification', 1),
 ((SELECT id FROM chap_lex), 'Regex to DFA', 'regex-dfa', 2),
 ((SELECT id FROM chap_lex), 'Lexical Errors', 'lexical-errors', 3),

 -- Syntax Analysis
 ((SELECT id FROM chap_syn), 'Grammar Modifications', 'grammar-modifications', 4),
 ((SELECT id FROM chap_syn), 'First and Follow Sets', 'first-follow-sets', 5),
 ((SELECT id FROM chap_syn), 'LL(1) Parsing', 'll1-parsing', 6),
 ((SELECT id FROM chap_syn), 'LR(0) and SLR(1)', 'lr0-slr1', 7),
 ((SELECT id FROM chap_syn), 'LALR(1) and CLR(1)', 'lalr-clr', 8),
 ((SELECT id FROM chap_syn), 'Shift-Reduce Conflicts', 'shift-reduce', 9),

 -- SDT & Intermediate Code
 ((SELECT id FROM chap_sdt), 'Synthesized & Inherited Attributes', 'attributes', 10),
 ((SELECT id FROM chap_sdt), 'L-Attributed and S-Attributed', 'att-types', 11),
 ((SELECT id FROM chap_sdt), 'Three-Address Code (TAC)', 'tac', 12),
 ((SELECT id FROM chap_sdt), 'Abstract Syntax Trees', 'ast', 13),
 ((SELECT id FROM chap_sdt), 'Directed Acyclic Graphs (DAG)', 'dag-topic', 14),

 -- Optimization & Runtime
 ((SELECT id FROM chap_opt), 'Basic Blocks & Control Flow', 'basic-blocks', 15),
 ((SELECT id FROM chap_opt), 'Data-Flow Analysis', 'data-flow', 16),
 ((SELECT id FROM chap_opt), 'Machine Independent Optimization', 'code-opt', 17),
 ((SELECT id FROM chap_opt), 'Peephole Optimization', 'peephole', 18),
 ((SELECT id FROM chap_opt), 'Activation Records & Parameter Passing', 'runtime', 19)
ON CONFLICT (chapter_id, slug) DO NOTHING;

-- Part 1 complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CD PYQ SEED v2 (Part 2 / 8)
-- MCQ Questions Q1–Q14 (Lexical Analysis & Syntax Analysis basics)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — Lexical Tokens (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='lexical-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='token-identification' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'In the C programming language statement `printf("Value is %d", a);`, what constitutes a single recognized lexical token?',
 'The entire literal string `"Value is %d"`',
 'Only the alphanumeric word `printf`',
 'The format specifier `%d` independent from the string',
 'The parenthesis character `)` alongside the semicolon `;` as one token',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The lexical analyzer matches constants via regular expressions. A string literal enclosed in double quotes is extracted as a single continuous token string regardless of spaces or format specifiers inside it.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lexical-analysis','tokens');

-- Q2 — Lexical Analysis boundaries (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='lexical-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='lexical-errors' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Which explicit error category can a standard Lexical Analyzer detect during execution?',
 'Unmatched parenthesis inside an expression',
 'Type mismatch assigning float to integer',
 'Illegal identifier sequence like `25variable`',
 'Undeclared variable identifiers',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Lexical analyzers process sequences using finite automata. An identifier beginning directly with numerical digits violates standard regular expression rules and triggers an immediate lexical failure. Parenthesis matching requires grammar (pushdown automata).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lexical-analysis');

-- Q3 — Parsing techniques classification (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='ll1-parsing' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'An LL(1) parser operates parsing the input scanning left-to-right, constructing the parse tree using which directional derivation?',
 'Rightmost derivation evaluated backwards',
 'Leftmost derivation evaluated top-down',
 'Leftmost derivation evaluated bottom-up',
 'Rightmost derivation evaluated top-down',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The letters "LL" represent Left-to-right scanning and Leftmost derivation string replacement. LL applies derivations exclusively top-down recursive node paths.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('parsing','ll-parsing');

-- Q4 — Grammar ambiguities (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='grammar-modifications' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Consider the context-free grammar: $S \rightarrow SS \mid a \mid \epsilon$. Which structural modification guarantees eliminating ambiguity this specific language?',
 'Refactoring into $S \rightarrow aS \mid \epsilon$',
 'Applying left factoring upon the rule $SS$',
 'Eliminating the epsilon $\epsilon$ production',
 'Converting directly into Operator Grammar formulation',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The language evaluates $a^*$. The rule $S \rightarrow aS \mid \epsilon$ forms a right-recursive tree dictating exactly one deterministic parse path, breaking the ambiguous overlapping in $S \rightarrow SS$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('parsing');

-- Q5 — Left factoring necessity (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='grammar-modifications' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Left factoring acts as a required grammar transformation algorithm specifically targeted to eliminate which condition?',
 'Left recursion loops',
 'Non-deterministic predictive table branching',
 'Shift-reduce conflicts in LR ',
 'Empty string epsilon transitions',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Left factoring factors out common prefixes (e.g., $A \rightarrow \alpha \beta_1 \mid \alpha \beta_2$). This removes non-determinism, a unique parsing branch top-down LL predictive tables.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ll-parsing');

-- Q6 — LR parser classification capacities (hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='lalr-clr' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'the standard hierarchy Bottom-Up parsing constructs, which expression represents the correct logical containment subset property grammar capabilities?',
 'LR(0) $\subset$ LALR(1) $\subset$ SLR(1) $\subset$ CLR(1)',
 'LR(0) $\subset$ SLR(1) $\subset$ LALR(1) $\subset$ CLR(1)',
 'SLR(1) $\subset$ LR(0) $\subset$ LALR(1) $\subset$ CLR(1)',
 'LL(1) $\subset$ LALR(1) $\subset$ CLR(1) $\subset$ SLR(1)',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The parser capacity limit evaluates limits: LR(0) maps the weakest set. SLR(1) adds Follow sets. LALR(1) merges states using exact lookaheads processing CLR . CLR(1) maintains unique lookahead boundaries, holding maximum structural capacity bottom-up derivations.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lr-parsing');

-- Q7 — First and Follow interactions (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='first-follow-sets' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Under what specific condition does the token boundary calculate computing `FOLLOW(A)` to construct table sets for rule $A \rightarrow \alpha$?',
 'Always calculated every parsing prediction entry',
 'Only when computing $A$ yields an empty string evaluation ($\epsilon \in FIRST(\alpha)$)',
 'Exclusively terminal transitions skipping LL boundaries',
 'When $A$ represents the start symbol boundary',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> During LL(1) parsing table construction predictions, `FOLLOW(A)` calculates exclusively whenever the production path reaches an epsilon ($\epsilon$) token evaluation in `FIRST(\alpha)`, alternative choices based on downstream symbol locations.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('first-follow','ll-parsing');

-- Q8 — Operator Precedence conditions (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='shift-reduce' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Which condition prevents a formal grammar from being evaluated as an Operator Grammar?',
 'Contains productions multiple consecutive terminal tokens',
 'Contains two identical non-terminal matching adjacent locations ($A \rightarrow BC$)',
 'Contains operators evaluated processing right-associativity properties',
 'Lacks explicit parenthesis matching paths',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Operator grammars mechanically prevent assigning adjacency across two consecutive non-terminal string tokens. Additionally, epsilon productions blank values evaluate as restrictive failures valid operator matrices.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('parsing');

-- Q9 — Parsing stack mechanism (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='lr0-slr1' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'An LR parser bottom-up logic executes reducing actions by:',
 'Popping sequences tracing handles exactly corresponding grammar right-hand side elements',
 'Shifting terminal tokens pushing boundaries empty terminals',
 'Pushing non-terminal variables lookahead operations mapped sequentially',
 'Comparing string counts recursive left mappings',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> A reduction operation acts matching exactly the top stack segment (the handle) against a production rule $A \rightarrow \beta$. The string $\beta$ pops, and variable $A$ pushes.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lr-parsing');

-- Q10 — LL(1) capabilities (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='ll1-parsing' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'If a grammar proves mechanically unambiguous, does it mandate classification as an LL(1) Grammar?',
 'Yes, ambiguity and LL(1) equivalence represent mathematically identical constructs',
 'Yes, provided non-terminal tokens maintain strict singular recursive paths',
 'No, boundaries reveals many unambiguous grammars evaluate requiring deep lookahead or bottom-up evaluations',
 'No, LL(1) specifications permit ambiguous grammar constructs',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Although all LL(1) grammars calculate unambiguously, multiple valid unambiguous grammars require parsing traversing subsets surpassing single token lookahead limits, necessitating LL(k) constraints or bottom-up LR operations.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ll-parsing');

-- Q11 — Handle Definition properties (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='lr0-slr1' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'In the context of Bottom-Up parsing systems execution paths, a "handle" identifies:',
 'A terminal string exclusively parsing empty productions ',
 'A substring matching exactly the right-hand part regarding a specified production a valid rightmost derivation in reverse',
 'The lookahead character matching the shift transition token',
 'The leftmost variable maintaining derivation paths verifying token boundaries',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A handle represents a precise substring verifying right boundaries that mathematically tracks reverse directly forming rightmost derivations backward step-by-step.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lr-parsing');

-- Q12 — LALR(1) state consolidation (hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='lalr-clr' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'When compressing CLR(1) states consolidating limits converting LALR(1) parser tables, merging compatible core items can generate which new conflict type absent in the original matrix?',
 'Shift-Reduce conflicts',
 'Reduce-Reduce conflicts',
 'Shift-Shift conflicts',
 'No conflicts instantiate during core merging limits',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Modifying CLR(1) states consolidating paths comparing subsets matching item cores never triggers Shift-Reduce failures. However, uniting lookahead string conditions frequently introduces disjoint validation limits triggering direct Reduce-Reduce parsing conflicts.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lr-parsing');

-- Q13 — Shift-Reduce decision (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='shift-reduce' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'An SLR(1) parser evaluates state containing an item $A \rightarrow \alpha . b \beta$ and calculating $C \rightarrow \gamma .$ (where token $b \in \text{FOLLOW}(C)$). What exact conflict exists?',
 'Shift-Shift',
 'Reduce-Reduce',
 'Shift-Reduce',
 'State ambiguity limits',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The parser table verifies moving a Shift detecting token $b$. Simultaneously, calculating exact Follow sets mandates a Reduce matching item $C$. This establishes a classic Bottom-up Shift-Reduce collision limit.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lr-parsing');

-- Q14 — Regular grammar evaluation (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='cd'),
 (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
 (SELECT id FROM topics WHERE slug='ll1-parsing' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Are all Regular Grammars unambiguously mapped LL(1)?',
 'Yes, regular grammars dictate calculating linear LL boundaries',
 'No, regular grammars permit left recursion and non-determinism matching patterns escaping computing LL limits',
 'Yes, equivalent right-linear evaluations mandate predicting specific values ',
 'No, testing bounds determines right-linear boundaries fail testing LL properties ',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The Regular class natively includes ambiguous formats and patterns maintaining direct Left Recursion properties. Both properties specifically violate computing mechanical LL(1) rules, necessitating factorization operations transforming regular forms LL .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('parsing');

-- Part 2 complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CD PYQ SEED v2 (Part 3 / 8)
-- MCQ Questions Q15–Q28 (SDT, ICG, Attributes)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — Synthesized attributes (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='attributes' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'In Syntax-Directed Translation, what evaluates a synthesized attribute computing at a parse tree node $N$?', 'The attributes from the parent node', 'The attributes from its direct child nodes', 'The attributes from sibling nodes', 'Attributes from the root', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Synthesized attributes calculate values bottom-up using data from child components.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sdt');

-- Q16 — S-Attributed definitions (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='att-types' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'An S-Attributed Grammar Definition relies exclusively on which attribute type?', 'Inherited attributes', 'Synthesized attributes', 'Both Inherited and Synthesized', 'Lookahead tokens', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> S-Attributed grammars compute Synthesized values flowing bottom-up.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sdt');

-- Q17 — L-Attributed conditions (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='att-types' LIMIT 1), 'gate-cse',false,NULL,'MCQ','hard',2, 'For rule $A \rightarrow X_1 X_2 X_3$ in an L-Attributed environment, the inherited attributes of $X_2$ depend on:', 'Attributes of $X_1, X_2$, and $X_3$', 'Attributes of parent $A$ and left sibling $X_1$', 'Attributes of $X_3$ and $A$', 'Synthesized attributes of $X_2$', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> L-Attributed grammars compute Top-Down and Left-to-Right. The attributes of $X_2$ rely on parent $A$ and left sibling $X_1$.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sdt');

-- Q18 — Three-Address Code constructs (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='tac' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'The fundamental property of Three-Address Code (TAC) is that each instruction specifies:', 'Exactly infinite operands', 'At most three addresses (two operands, one result)', 'Exactly two addresses', 'Only memory blocks without operations', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> TAC processes instructions using a maximum of 3 addresses per statement.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('icg');

-- Q19 — Quadruples implementation (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='tac' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'When TAC using quadruples, which fields are required?', 'Operator, Argument 1, Argument 2, and Result', 'Argument 1, Argument 2, Result', 'Memory addresses and values', 'Output variable and computation', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> A Quadruple requires 4 exact fields: Operator, Arg1, Arg2, and Result.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('icg');

-- Q20 — Abstract Syntax Tree compression (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='ast' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'How does an Abstract Syntax Tree (AST) differ from a Parse Tree?', 'ASTs eliminate redundant structural tokens like parentheses', 'ASTs include all terminals', 'ASTs represent code at assembly level', 'ASTs only track comments', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> ASTs compress Parse Trees by dropping punctuation and structural artifacts.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('parsing');

-- Q21 — Directed Acyclic Graph efficiency (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='dag-topic' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'What is the primary optimization benefit of a Directed Acyclic Graph (DAG) over an AST?', 'It identifies and shares common subexpressions', 'It removes all operators', 'It compiles faster to binary', 'It reduces global variables', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> DAG evaluations determine common subexpressions and merge identical nodes.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dag','optimization');

-- Q22 — Bootstrapping Compiler Process (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='lexical-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='token-identification' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'The compiler term "bootstrapping" refers to:', 'Writing a compiler in the same language it compiles', 'Optimizing loops', 'Loading the OS', 'Linking static libraries', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Bootstrapping is a self-compiling compiler.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lexical-analysis');

-- Q23 — SDT Implementation structures (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='attributes' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'In which parsing method can S-Attributed definitions be most easily implemented?', 'Top-Down LL(1)', 'Bottom-Up LR Parsing', 'Recursive Descent', 'Operator Precedence', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> S-Attributed definitions evaluate bottom-up, matching LR parser reduction events.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sdt');

-- Q24 — Syntax Tree vs Parse Tree limits (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='ast' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'Which nodes typically form the interior of an AST?', 'Operators', 'Operands', 'Punctuation marks', 'Variables exactly as in parse trees', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> AST interior nodes act as operators, leaf nodes act as operands.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ast');

-- Q25 — Data flow analysis foundations (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='data-flow' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'Live Variable Analysis is critical primarily for:', 'Register allocation algorithms', 'Loop unrolling optimizations', 'Parse tree reductions', 'Lexical buffer allocations', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Register allocation depends on liveness analysis to know when a variable is no longer needed.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('liveness','optimization');

-- Q26 — SSA form (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='tac' LIMIT 1), 'gate-cse',false,NULL,'MCQ','hard',2, 'In Static Single Assignment (SSA) form, what resolves intersecting control flow paths assigning to the same variable?', 'Alpha functions', 'Phi ($\Phi$) functions', 'Gamma assignments', 'Delta assignments', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> $\Phi$ functions merge assignments arising from multiple incoming control paths.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('icg');

-- Q27 — Triples array layout (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='tac' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'How do Triples differ from Quadruples in TAC implementations?', 'They use pointers to statement indices instead of explicit result variables', 'They lack an operator field', 'They require four memory addresses per cell', 'They only support Boolean logic', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Triples avoid creating dummy temporary variables, referencing the index of the statement directly.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('icg');

-- Q28 — Indirect Triples benefits (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='tac' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'Why are Indirect Triples preferred over Standard Triples during code optimization?', 'They allow instruction reordering without updating pointers', 'They use less memory per instruction', 'They skip syntax validations', 'They encode floating-point limits differently', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Standard Triples tie pointers to explicit array indices. Indirect Triples use an array of pointers, permitting easy line swaps.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('icg');

-- Part 3 complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CD PYQ SEED v2 (Part 4 / 8)
-- MCQ Questions Q29–Q45 (Optimization & Runtime Environments) (clean)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q29 — Basic Block execution (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='basic-blocks' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'A Basic Block represents a sequence of continuous code instructions exhibiting:', 'Only one entry point and one exit point', 'Multiple entry points with loops', 'Variable loops inside the structure', 'Recursive call capacities', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> A basic block guarantees straight-line code execution without internal branches or multiple entry/exit paths.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Q30 — Control Flow Graphs (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='basic-blocks' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'Inside a Control Flow Graph (CFG), what do the nodes represent?', 'Individual variables', 'Basic blocks', 'Terminal tokens', 'Grammar productions', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> CFG nodes encapsulate entire continuous Basic Blocks, with edges the conditional jumps between them.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Q31 — Peephole Optimization mechanics (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='peephole' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'Peephole optimization typically operates passing a sliding window over which code state?', 'Source code', 'Intermediate representation', 'Target machine code', 'Lexical tokens', 'C', '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Peephole optimization is a localized pass occurring directly over generated target machine instructions.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Q32 — Common Subexpression Elimination (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'Which data structure is most appropriate to perform Local Common Subexpression Elimination?', 'Activation record stack', 'Directed Acyclic Graph (DAG)', 'State-Transition diagrams', 'Trie data sets', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> By plotting logic onto a DAG, nodes with identical operations evaluate as single merged nodes, naturally eliminating common subexpressions.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dag','optimization');

-- Q33 — Loop invariant code motion (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'Moving that evaluate irrespective of loop iterations into a pre-header block is classified as:', 'Loop unrolling', 'Strength reduction', 'Loop invariant code motion', 'Dead code elimination', 'C', '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Extracting logic that does not change across iterations prevents repetitive execution.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Q34 — Strength Reduction (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1), 'gate-cse',false,NULL,'MCQ','hard',2, 'Replacing an expensive operation $X \times 2$ with the computationally cheaper instruction $X + X$ or $X \ll 1$ provides a classic example of:', 'Strength Reduction', 'Constant Folding', 'Algebraic Simplification', 'Code Hoisting', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Strength reduction specifically replaces an expensive hardware operator (multiplication) with a cheaper operator (addition or shifts).</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Q35 — Constant Folding Phase (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'When the compiler identifies $X = 3 \times 4$ and replaces it with $X = 12$ during compile time, it executes:', 'Strength Reduction', 'Constant Folding', 'Constant Propagation', 'Copy Propagation', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Constant folding evaluates deterministic literals at compile-time to save runtime .</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Q36 — Dead Code Definition (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'Instructions modifying variables that are subsequently never utilized downstream represent:', 'Loop variants', 'Live variables', 'Dead code', 'Aliased references', 'C', '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Dead code outputs results to targets that never pass into live analysis downstream streams, meaning they can be deleted .</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Q37 — Activation Record layout (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='runtime' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'In a standard C compiler function states, the Activation Record contains:', 'Global variable locations only', 'Local variables, return address, and machine status', 'Static library dependencies', 'Heap allocations', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The activation record pushes runtime requirements including , local variables, dynamic links, and return addresses.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('runtime-env','activation');

-- Q38 — Static Allocation limits (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='runtime' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'Compilers assigning memory exclusively via Static Allocation lose the capability to support:', 'Global variables', 'Recursive functions', 'Constant declarations', 'Array checks', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Static allocation uses fixed memory locations. Recursion requires dynamic scaling stacks matching successive activation scopes.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('runtime-env');

-- Q39 — Heap memory utilization (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='runtime' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'Which mechanism manages objects bypassing LIFO stack constraints via functions like `malloc()`?', 'Register windows', 'Global static data zone', 'Heap memory allocation', 'Text execution block', 'C', '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The Heap allocates dynamic structures possessing lifetimes exceeding standard function stack block scopes.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('runtime-env');

-- Q40 — Parameter passing techniques (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='runtime' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'Call-by-Reference parameter handling entails passing:', 'Value copies', 'Machine addresses linking to the original variable', 'Variable names directly', 'Duplicate scope blocks', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Call-by-reference shares the exact memory address (pointer), meaning changes inside the function propagate to the original variable.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('runtime-env');

-- Q41 — Call by Name semantics (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='runtime' LIMIT 1), 'gate-cse',false,NULL,'MCQ','hard',2, 'Under Call-by-Name parameter parsing in languages like Algol, an argument expression is passed as:', 'Thunks delayed text substitutions', 'Constant numerical outputs', 'Memory pointers', 'String references', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Call-by-name textually replaces the parameter inside the function code, its mathematical dependencies (a "thunk") anew every time it is referenced.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('runtime-env');

-- Q42 — Data-flow equations components (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='data-flow' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'Standard data flow analysis equations for basic blocks consist primarily of which sets?', 'GEN and KILL sets', 'First and Follow sets', 'Shift and Reduce sets', 'Lexical and Syntax sets', 'A', '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The fundamental $OUT = GEN \cup (IN - KILL)$ equation manages local block impacts for data flow optimizations.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization','data-flow');

-- Q43 — Display implementation (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='runtime' LIMIT 1), 'gate-cse',false,NULL,'MCQ','hard',2, 'When supporting nested scoping inside block-structured languages, what data structure maps external references?', 'Graph nodes', 'Display arrays active pointers to outer lexical scopes', 'Register queues', 'Heap vectors', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A "Display" is an array of pointers allowing $O(1)$ access to variables in enclosing lexical boundaries.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('runtime-env');

-- Q44 — Next Use information (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1), 'gate-cse',false,NULL,'MCQ','medium',2, 'Which statement describes computing Next-Use inside Basic Blocks?', 'It calculates outputs scanning Top-to-Bottom', 'It evaluates scanning the block sequentially Bottom-to-Top', 'It requires multiple bidirectional passes', 'It relies on arbitrary execution jumps', 'B', '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Basic block Next-Use properties compute traversing backward from the exit boundary upwards, variable liveness state changes accurately.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('liveness','optimization');

-- Q45 — Optimization levels (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1), 'gate-cse',false,NULL,'MCQ','easy',1, 'Which compiler optimization scope analyzes logic within a single procedure or function boundary?', 'Local optimization', 'Peephole optimization', 'Global (Intra-procedural) optimization', 'Inter-procedural optimization', 'C', '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Intra-procedural (Global) optimization analyzes across multiple basic blocks but remains contained within a single function. Local applies to single blocks. Inter-procedural applies across multiple functions.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Part 4 complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CD PYQ SEED v2 (Part 5 / 8)
-- NAT Questions Q46–Q55 (Parsing tables, counts, expressions)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q46 — Left factoring count (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='grammar-modifications' LIMIT 1), 'gate-cse',false,NULL,'NAT','easy',1, 'Consider grammar rule $A \rightarrow abBc \mid abBd \mid abBe$. Upon applying left factoring to eliminate the common prefix, exactly how many new non-terminal variables are introduced?', 1.00,1.00,NULL, '<p><strong>✓ Answer: 1.</strong></p><p><strong>Rationale:</strong> The prefix $abB$ factors out, transforming into $A \rightarrow abB A''$ and $A'' \rightarrow c \mid d \mid e$. one new variable ($A''$) is introduced.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('parsing');

-- Q47 — Syntax Tree Nodes (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='ast' LIMIT 1), 'gate-cse',false,NULL,'NAT','medium',2, 'Evaluate the expression $(a + b) \times (c - d) + e$. How many total nodes (internal + leaves) exist in the optimal Abstract Syntax Tree (AST)?', 9.00,9.00,NULL, '<p><strong>✓ Answer: 9.</strong></p><p><strong>Rationale:</strong> The AST stores 5 operand leaves ($a, b, c, d, e$) and 4 operator internal nodes ($+, \times, -, +$). Total nodes = 9.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ast');

-- Q48 — DAG Node Compression (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='dag-topic' LIMIT 1), 'gate-cse',false,NULL,'NAT','medium',2, 'Given the code block $X = A + B; Y = A + B; Z = X \times Y$, what is the total number of nodes required to construct the Directed Acyclic Graph (DAG)?', 4.00,4.00,NULL, '<p><strong>✓ Answer: 4.</strong></p><p><strong>Rationale:</strong> The DAG maps $A$ and $B$ (2 leaves). It computes $A+B$ as one node shared by both $X$ and $Y$. It maps the $\times$ operator combining the shared node with itself. Total nodes = 4.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dag');

-- Q49 — LR(0) Items (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='lr0-slr1' LIMIT 1), 'gate-cse',false,NULL,'NAT','hard',2, 'A grammar contains exactly 3 production rules. Rule 1 has right-side length 2. Rule 2 has length 1. Rule 3 has length 0 (epsilon). Counting the augmented production, what is the maximum number of distinct LR(0) items generated?', 8.00,8.00,NULL, '<p><strong>✓ Answer: 8.</strong></p><p><strong>Rationale:</strong> Number of items equals rule length + 1. Augmented rule: 2 items. Rule 1 ($len 2$): 3 items. Rule 2 ($len 1$): 2 items. Rule 3 ($len 0$): 1 item ($A \rightarrow .$). Total = $2 + 3 + 2 + 1 = 8$.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lr-parsing');

-- Q50 — Lexical Token Count (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='lexical-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='token-identification' LIMIT 1), 'gate-cse',false,NULL,'NAT','easy',1, 'Count the exact number of lexical tokens in this C statement: `int arr[10] = {1, 2, 3};` (Assume no trailing EOF token is required)', 14.00,14.00,NULL, '<p><strong>✓ Answer: 14.</strong></p><p><strong>Rationale:</strong> The tokens are: `int`, `arr`, `[`, `10`, `]`, `=`, `{`, `1`, `,`, `2`, `,`, `3`, `}`, `;`. The count is exactly 14.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lexical-analysis','tokens');

-- Q51 — Basic Blocks Count (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='basic-blocks' LIMIT 1), 'gate-cse',false,NULL,'NAT','medium',2, 'A segment of TAC has lines 1-10. Jump statements are identified at lines 4 (goto 8) and 9 (goto 2). How many basic blocks are logically partitioned in this code map?', 4.00,4.00,NULL, '<p><strong>✓ Answer: 4.</strong></p><p><strong>Rationale:</strong> The leaders (starts) are line 1 (first), line 8 (target), line 2 (target), line 5 (follows jump), and line 10 (follows jump). The blocks span 1-1, 2-4, 5-7, 8-9, and 10.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Q52 — First Set Size (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='first-follow-sets' LIMIT 1), 'gate-cse',false,NULL,'NAT','medium',2, 'Grammar: $S \rightarrow aB \mid \epsilon$, $B \rightarrow c \mid dS$. What is the cardinality (number of elements) in $FIRST(S)$?', 2.00,2.00,NULL, '<p><strong>✓ Answer: 2.</strong></p><p><strong>Rationale:</strong> $FIRST(S)$ receives ''$a$'' from $aB$, and receives $\epsilon$ directly. So $FIRST(S) = \{a, \epsilon\}$. Cardinality is 2.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('first-follow');

-- Q53 — LALR vs CLR states (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='lalr-clr' LIMIT 1), 'gate-cse',false,NULL,'NAT','hard',2, 'If an LR(0) parser constructing a specific grammar generates exactly 20 states, what is the exact number of states the resulting LALR(1) parser generates?', 20.00,20.00,NULL, '<p><strong>✓ Answer: 20.</strong></p><p><strong>Rationale:</strong> LALR(1) parsers have the same number of states as the LR(0) and SLR(1) core parsers. Only the lookahead are merged. The state count matches perfectly.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lr-parsing');

-- Q54 — Minimum Temporaries (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='tac' LIMIT 1), 'gate-cse',false,NULL,'NAT','medium',2, 'Converting the logic $X = (A + B) * (C - D)$ into standard 3-Address Code mandates temporary outputs. What is the minimum number of independent temporary variables required assuming standard $t_1, t_2...$ assignments without optimizer reuse?', 2.00,2.00,NULL, '<p><strong>✓ Answer: 2.</strong></p><p><strong>Rationale:</strong> Step 1: $t_1 = A + B$. Step 2: $t_2 = C - D$. Step 3: $X = t_1 * t_2$. Exactly 2 intermediate temporaries are produced.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('icg');

-- Q55 — Follow Set computation (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='first-follow-sets' LIMIT 1), 'gate-cse',false,NULL,'NAT','medium',2, 'Grammar: $S \rightarrow AB$, $A \rightarrow a \mid \epsilon$, $B \rightarrow b$. Assume $S$ is the start variable. How many elements exist in $FOLLOW(A)$?', 1.00,1.00,NULL, '<p><strong>✓ Answer: 1.</strong></p><p><strong>Rationale:</strong> $FOLLOW(A)$ equals $FIRST(B)$, minus $\epsilon$. Since $B \rightarrow b$, $FIRST(B) = \{b\}$. Thus, $FOLLOW(A)$ contains the element $\{b\}$.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('first-follow');

-- Part 5 complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CD PYQ SEED v2 (Part 6 / 8)
-- MSQ Questions Q56–Q65 (Multi-Select Compiler Traits)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q56 — MSQ: Lexer tasks (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='lexical-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='token-identification' LIMIT 1), 'gate-cse',false,NULL,'MSQ','easy',1, 'Which operations are performed during the Lexical Analysis phase? (Select all that apply)', 'Matching regular expressions to generate tokens', 'Stripping whitespaces and removing comments', 'Verifying brackets and parenthesis balancing', 'Detecting identifier string sequences', ARRAY['A','B','D'], '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> Lexical analysis utilizes DFA limits to trim spaces, remove comments, and recognize identifiers/constants. parenthesis requires stack logic (Syntax Analysis phase).</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lexical-analysis');

-- Q57 — MSQ: LR Parser strengths (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='lr0-slr1' LIMIT 1), 'gate-cse',false,NULL,'MSQ','medium',2, 'Why are Bottom-Up LR Parsers more powerful than Top-Down LL Parsers? (Select all that apply)', 'LR parses shift tokens delaying decision until the rule handle is complete', 'LR supports and left-recursive grammars', 'LR constructs require matching predictive table loops traversing top-down', 'LR covers a mathematically larger subset of deterministic Context-Free properties', ARRAY['A','B','D'], '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> LR handles left-recursion perfectly and parses all DCFL bounds. Top-Down logic requires predicting immediately upon reading the first token, restricting capability.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lr-parsing');

-- Q58 — MSQ: S-Attributed characteristics (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='att-types' LIMIT 1), 'gate-cse',false,NULL,'MSQ','medium',2, 'Which statements accurately categorize S-Attributed SDT structures? (Select all that apply)', 'They exclusively evaluate synthesized ', 'They map inside bottom-up LR evaluations ', 'They assign data calculating child conditions passing to parent edges', 'They rely parsing logic top-down limits exclusively', ARRAY['A','B','C'], '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> S-Attributed data synthesizes upwards (child to parent), which integrates perfectly matching the Right-Hand-Side handle reductions found inside LR passing tools.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sdt');

-- Q59 — MSQ: Optimization loop constraints (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1), 'gate-cse',false,NULL,'MSQ','hard',2, 'Code Optimization logic classifies several mechanisms targeting repeating Loop segments. Select valid Loop optimizations.', 'Strength Reduction inside calculations', 'Loop Invariant Code Motion', 'Induction Variable elimination', 'Peephole Optimization limits target outputs', ARRAY['A','B','C'], '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Strength reduction, induction elimination, and code motion specifically optimize looping performance metrics. Peephole targets localized machine instructions, independent of global loop architectures.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Q60 — MSQ: TAC equivalents (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1), (SELECT id FROM topics WHERE slug='tac' LIMIT 1), 'gate-cse',false,NULL,'MSQ','medium',2, 'Intermediate Code operates across diverse structures data formats. Which apply as valid Intermediate Code abstractions? (Select all that apply)', 'Three-Address Code (TAC)', 'Static Single Assignment (SSA)', 'Post-fix / Polish Notation', 'Context-Sensitive syntax trees', ARRAY['A','B','C'], '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Compilers construct logic utilizing TAC, SSA , and Post-Fix logic strings as mathematical intermediate language mappings bridging frontend and backend code blocks.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('icg');

-- Q61 — MSQ: Shift-Reduce detection constraints (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='shift-reduce' LIMIT 1), 'gate-cse',false,NULL,'MSQ','hard',2, 'In typical Bottom-Up parsing execution calculating bounds limits, Shift-Reduce conflict matrices occur which conditions? (Select all that apply)', 'The parser must select between pushing a valid terminal and applying a completed right-hand production', 'An ambiguous grammar like "Dangling Else" logic presents competing execution paths', 'Lookahead calculations calculate identical intersection targets overlapping actions', 'The item state matches exclusively complete reduction nodes', ARRAY['A','B','C'], '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Ambiguity naturally generates shift-reduce conflicts. Overlapping lookaheads in SLR or LALR tables cause the machine to debate shifting a token versus concluding a derivation (reducing).</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lr-parsing');

-- Q62 — MSQ: Register Allocation strategies (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1), 'gate-cse',false,NULL,'MSQ','medium',2, 'Register Allocation manages hardware limits code limits predicting outputs structures. Algorithms employ which techniques? (Select all that apply)', 'Graph Coloring matching interference bounds', 'Liveness analysis active variable chains', 'Heuristic graph spilling reducing conflicts', 'Syntax matching lexical buffer sizes', ARRAY['A','B','C'], '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Interference graphs define live variable collisions, graph coloring paints variables calculating optimal memory spots, and spilling pushes excess data memory constraints to the stack array.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Q63 — MSQ: Symbol Table contents (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='lexical-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='token-identification' LIMIT 1), 'gate-cse',false,NULL,'MSQ','easy',1, 'A standard compiler Symbol Table maintains critical information bounds. Which data points are stored? (Select all that apply)', 'Variable name strings and lexical properties', 'Scope active lifetimes', 'Data type logic (int, float) byte bounds', 'Dynamic execution time logs managing bounds', ARRAY['A','B','C'], '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Symbol tables manage compile-time boundaries variables, , scope rules, and typing values. Execution happens locally run-time environments.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lexical-analysis');

-- Q64 — MSQ: Peephole limits logic constraints (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1), (SELECT id FROM topics WHERE slug='peephole' LIMIT 1), 'gate-cse',false,NULL,'MSQ','medium',2, 'Peephole verify structural conditions processing targeting limits paths. Select applicable properties.', 'Redundant Load/Store elimination memory ', 'Jumps bounds Jump commands (Branch chaining)', 'Dead branch removal passing fixed logic constraints', 'Global recursion reduction predicting loop invariants', ARRAY['A','B','C'], '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Peephole optimizations look inside short sequences detecting jumps-to-jumps, deleting unneeded local memory loads traversing logic blocks, and stripping dead constants. Recursion analysis operates global variables.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('optimization');

-- Q65 — MSQ: Top-Down parser failures (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES ((SELECT id FROM subjects WHERE slug='cd'), (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1), (SELECT id FROM topics WHERE slug='ll1-parsing' LIMIT 1), 'gate-cse',false,NULL,'MSQ','easy',1, 'Predictive Top-Down parsers LL(1) logic checks logic limitations fail completing grammar checks containing:', 'Left-recursive parameter properties', 'Non-deterministic prefix bounding overlap rules', 'Syntax components exact single derivations loops', 'Ambiguous bounds equivalent logic rules', ARRAY['A','B','D'], '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> Top-down predictive models require clean, deterministic, left-factored logic to select one derivation table row. Therefore Left-recursion, identical overlapping prefixes, and ambiguity mathematically block functionality.</p>') RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('parsing');

-- Part 6 complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CD PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1: Lexical & Syntax Analysis (11 Cards)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 1
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='lexical-analysis' LIMIT 1),
  (SELECT id FROM topics WHERE slug='token-identification' LIMIT 1),
  'What is the primary role of the Lexical Analyzer?',
  '<p>The Lexical Analyzer reads source characters, removes whitespace and comments, and groups characters into meaningful tokens using Finite Automata (DFA).</p>',
  ARRAY['lexical-analysis']
),
-- Card 2
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='lexical-analysis' LIMIT 1),
  (SELECT id FROM topics WHERE slug='lexical-errors' LIMIT 1),
  'What type of errors can the Lexical Analyzer detect?',
  '<p>It detects illegal characters and malformed tokens (like an identifier starting with a digit). It CANNOT detect unmatched parentheses (Syntax) or type mismatches (Semantic).</p>',
  ARRAY['lexical-analysis']
),
-- Card 3
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
  (SELECT id FROM topics WHERE slug='grammar-modifications' LIMIT 1),
  'Why is Left Recursion problematic for Top-Down Parsers?',
  '<p>Top-Down Parsers (like Recursive Descent) will enter an infinite loop when encountering Left Recursion (e.g., $A \rightarrow A\alpha$). The grammar must be restructured to right recursion.</p>',
  ARRAY['parsing']
),
-- Card 4
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
  (SELECT id FROM topics WHERE slug='first-follow-sets' LIMIT 1),
  'What is the use of FIRST and FOLLOW sets?',
  '<p>They are used to construct predictive parsing tables for LL(1) and determine lookahead tokens to decide which production rule to apply during parsing without backtracking.</p>',
  ARRAY['first-follow']
),
-- Card 5
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ll1-parsing' LIMIT 1),
  'What does LL(1) stand for?',
  '<p><strong>L</strong>: Left-to-right scan of the input. <br><strong>L</strong>: Leftmost derivation. <br><strong>1</strong>: One character of lookahead to make parsing decisions.</p>',
  ARRAY['ll-parsing']
),
-- Card 6
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
  (SELECT id FROM topics WHERE slug='grammar-modifications' LIMIT 1),
  'What is Left Factoring?',
  '<p>A grammar transformation used when two or more production alternatives share a common prefix. It removes non-determinism, allowing LL parsers to distinguish the correct rule.</p>',
  ARRAY['parsing']
),
-- Card 7
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
  (SELECT id FROM topics WHERE slug='lr0-slr1' LIMIT 1),
  'Describe the components of an LR Parser.',
  '<p>It consists of an input buffer, a stack (to hold states and grammar symbols), a parsing table (Action and Goto), and a parsing program that performs Shift and Reduce operations.</p>',
  ARRAY['lr-parsing']
),
-- Card 8
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
  (SELECT id FROM topics WHERE slug='shift-reduce' LIMIT 1),
  'What is a Shift-Reduce conflict?',
  '<p>In bottom-up parsing, it occurs when a state has both a valid shift transition (move to next state) and a valid reduce action (apply a production) for the same lookahead terminal.</p>',
  ARRAY['lr-parsing']
),
-- Card 9
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
  (SELECT id FROM topics WHERE slug='shift-reduce' LIMIT 1),
  'What is a Reduce-Reduce conflict?',
  '<p>Occurs when an LR parser state allows reduction by two different grammar production rules simultaneously for the exact same lookahead token.</p>',
  ARRAY['lr-parsing']
),
-- Card 10
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
  (SELECT id FROM topics WHERE slug='lalr-clr' LIMIT 1),
  'Place bottom-up parsers in order of increasing power.',
  '<p>$LR(0) \subset SLR(1) \subset LALR(1) \subset CLR(1)$. Number of states in LALR is identical to LR(0). Number of states in CLR is vastly larger due to split lookaheads.</p>',
  ARRAY['lr-parsing']
),
-- Card 11
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='syntax-analysis' LIMIT 1),
  (SELECT id FROM topics WHERE slug='shift-reduce' LIMIT 1),
  'What constitutes an Operator Grammar?',
  '<p>A grammar with zero $\epsilon$-productions and no two adjacent non-terminals on the right-hand side of any production rule.</p>',
  ARRAY['parsing']
);

-- Part 7 complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CD PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2: SDT, Optimization & Runtime (11 Cards) + COMMIT
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 12
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1),
  (SELECT id FROM topics WHERE slug='attributes' LIMIT 1),
  'Distinguish between Synthesized and Inherited Attributes.',
  '<ul><li><strong>Synthesized:</strong> Computed from children to parent (flows bottom-up).</li><li><strong>Inherited:</strong> Received from parent or left siblings (flows top-down and left-to-right).</li></ul>',
  ARRAY['sdt']
),
-- Card 13
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1),
  (SELECT id FROM topics WHERE slug='att-types' LIMIT 1),
  'What is an S-Attributed Grammar?',
  '<p>A Syntax-Directed Translation definition that uses only Synthesized attributes. It can be easily evaluated bottom-up alongside an LR parser.</p>',
  ARRAY['sdt']
),
-- Card 14
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1),
  (SELECT id FROM topics WHERE slug='att-types' LIMIT 1),
  'What is an L-Attributed Grammar?',
  '<p>A grammar where inherited attributes depend only on the parent and left siblings. It evaluates attributes left-to-right, making it perfect for top-down parsing.</p>',
  ARRAY['sdt']
),
-- Card 15
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ast' LIMIT 1),
  'Compare Parse Tree vs Abstract Syntax Tree (AST).',
  '<p>A Parse Tree contains all grammatical structures, non-terminals, and punctuation. An AST drops the structural artifacts and leaves only the meaningful operators (internal nodes) and operands (leaves).</p>',
  ARRAY['ast','parsing']
),
-- Card 16
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='sdt-icg' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dag-topic' LIMIT 1),
  'What is the purpose of a Directed Acyclic Graph (DAG) in compilation?',
  '<p>A DAG represents expressions where common subexpressions are merged into shared nodes. It is used heavily in local optimization to prevent redundant calculations.</p>',
  ARRAY['optimization','dag']
),
-- Card 17
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='basic-blocks' LIMIT 1),
  'What defines a Basic Block?',
  '<p>A sequence of continuous instructions with exactly one entry point and one exit point. There are no branches going into the middle, and no branches going out except at the very end.</p>',
  ARRAY['optimization']
),
-- Card 18
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1),
  'What is Loop Invariant Code Motion?',
  '<p>An optimization technique that identifies computations inside a loop that produce the exact same value on every iteration, and moves them outside to the loop''s pre-header.</p>',
  ARRAY['optimization']
),
-- Card 19
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='code-opt' LIMIT 1),
  'Explain Strength Reduction.',
  '<p>Replacing an expensive hardware operation with a cheaper equivalent. For example, replacing $A * 2$ with $A + A$ or $A \ll 1$. Often applied to loop induction variables.</p>',
  ARRAY['optimization']
),
-- Card 20
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='peephole' LIMIT 1),
  'What is Peephole Optimization?',
  '<p>A localized optimization pass operating over a small sliding window (peephole) of target machine instructions, used to eliminate redundant loads/stores and compact branch jumps.</p>',
  ARRAY['optimization']
),
-- Card 21
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='runtime' LIMIT 1),
  'What resides inside an Activation Record (Stack Frame)?',
  '<p>It stores function call state: function parameters, local variables, return memory address, saved machine registers, and access links to enclosing scopes.</p>',
  ARRAY['runtime-env']
),
-- Card 22
(
  (SELECT id FROM subjects WHERE slug='cd'),
  (SELECT id FROM chapters WHERE slug='optimization-runtime' LIMIT 1),
  (SELECT id FROM topics WHERE slug='data-flow' LIMIT 1),
  'Why is Live Variable Analysis important?',
  '<p>By computing which variables will be read in the future without being overwritten (Liveness), the compiler can efficiently allocate physical CPU registers via Graph Coloring techniques.</p>',
  ARRAY['liveness','optimization']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing cd-seed.sql to verify correctness:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='cd'));
-- Expected: 19
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='cd');
-- Expected: 65
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='cd');
-- Expected: 22
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='cd')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug: cd
-- Schema version: v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- Chapters:     4 
-- Topics:       19
-- Questions:    65 total
--   MCQ:        45 (Q1–Q45)
--   NAT:        10 (Q46–Q55)
--   MSQ:        10 (Q56–Q65)
-- Flashcards:   22 concise mathematical theory cards
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF cd-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
