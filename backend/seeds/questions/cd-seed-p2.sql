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
