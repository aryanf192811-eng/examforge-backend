-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DM PYQ SEED v2  (Part 6 / 8)
-- MSQ Questions Q56–Q65 (Logic, Groups, Graphs)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q56 — MSQ: Propositional Logic Tautologies (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='propositional-logic' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following propositional expressions are tautologies? (Select all that apply)',
  '$(p \land (p \rightarrow q)) \rightarrow q$',
  '$((p \rightarrow q) \land (q \rightarrow r)) \rightarrow (p \rightarrow r)$',
  '$(p \lor q) \rightarrow (p \land q)$',
  '$p \rightarrow (p \lor q)$',
  ARRAY['A','B','D'],
  '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> Modus Ponens structure. Always true.<br>- <strong>B:</strong> Hypothetical Syllogism (transitivity of implication). Always true.<br>- <strong>D:</strong> Addition rule. If $p$ is true, $p \lor q$ is definitely true.<br>- <strong>Why C is FALSE:</strong> This asserts that if one is true, both are true. Fails when $p=T, q=F$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','propositional');

-- Q57 — MSQ: Set Operations (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='set-theory' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'Which of the following set identities accurately define the Set Difference constraint $A - B$? (Select all that apply)',
  '$A \cap B^c$',
  '$A - (A \cap B)$',
  '$(A \cup B) - B$',
  '$A \cup B^c$',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> Standard definition: elements in $A$ AND NOT in $B$.<br>- <strong>B:</strong> Taking $A$ and removing the overlap with $B$ leaves exactly $A - B$.<br>- <strong>C:</strong> The union of $A$ and $B$, minus everything in $B$, leaves exactly the elements unique to $A$.<br>- <strong>Why D is FALSE:</strong> This includes elements not in $B$ that are also not in $A$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sets');

-- Q58 — MSQ: Equivalence Relations Properties (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relations-properties' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Consider the relation $R$ containing pairs $(x, y)$ such that $x \equiv y \pmod m$ on integers. Which properties does $R$ guarantee? (Select all that apply)',
  'Reflexivity ($x \equiv x$)',
  'Symmetry (If $x \equiv y$, then $y \equiv x$)',
  'Transitivity (If $x \equiv y$ and $y \equiv z$, then $x \equiv z$)',
  'Antisymmetry (If $x \equiv y$ and $y \equiv x$, then $x = y$)',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Modular congruence is the classic textbook equivalence relation. Thus it must be Reflexive, Symmetric, and Transitive.<br><strong>Why D is FALSE:</strong> Antisymmetry fails. $2 \equiv 7 \pmod 5$ and $7 \equiv 2 \pmod 5$, but $2 \neq 7$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations','sets');

-- Q59 — MSQ: Group Theory Abelian characteristics (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='group-theory' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','hard',2,
  'Which of the following conditions necessarily guarantee that a defined Group $G$ is Abelian (commutative)? (Select all that apply)',
  'Every element in the group is its own inverse ($x^2 = e$)',
  'The group is cyclic',
  'The group order is a prime number',
  'The group contains an identity element',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> If $(xy)^2 = e \implies xyxy = e \implies xy = y^{-1}x^{-1} = yx$ (since elements are their own inverse). Thus commutative.<br>- <strong>B:</strong> Every cyclic group $G = \langle a \rangle$ is an Abelian group since $a^i a^j = a^{i+j} = a^j a^i$.<br>- <strong>C:</strong> Every group of prime order is cyclic, and because all cyclic groups are Abelian, prime-order groups are Abelian.<br>- <strong>Why D is FALSE:</strong> Having an identity element is a base requirement for all groups, not a condition for Abelian.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('groups');

-- Q60 — MSQ: Handshaking Lemma Corollaries (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'For any finite undirected graph, which statements are mathematically true corollaries of the handshaking theorem? (Select all that apply)',
  'The number of vertices with odd degree is always even',
  'The sum of the degrees of all vertices is an even number',
  'The graph can contain exactly one odd-degree vertex',
  'The total number of edges is always an even number',
  ARRAY['A','B'],
  '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> Since $\sum deg(v) = 2E$, the sum is always even (Option B). For the sum to be even, the odd-degree nodes must pair up, meaning there is an even number of odd-degree vertices (Option A). Option C is false because you cannot have exactly 1 odd degree vertex (that sum would be odd). Option D is false because $E$ can be odd, only $2E$ is guaranteed even.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q61 — MSQ: Bipartite Graph Requirements (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'A graph $G$ is Bipartite if and only if which of the following statements hold true? (Select all that apply)',
  'The graph vertices can be colored using exactly 2 colors',
  'The graph contains absolutely no cycles of odd length',
  'Every cycle in the graph has an even number of edges',
  'The maximum vertex degree is 2',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Bipartite means the graph can be partitioned into two independent sets (2-colorable). A known theorem states a graph is bipartite if and only if it does not contain any odd-length cycles. Options B and C state the exact same fact. Option D is irrelevant (a star graph is bipartite but can have a degree of $n$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Q62 — MSQ: Valid Tree Properties (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='trees-properties' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'An undirected graph $G = (V,E)$ is defined as a free tree. Which of the following conditions correctly identify a tree? (Select all that apply)',
  '$G$ is connected and has exactly $|V| - 1$ edges',
  '$G$ is acyclic and possesses exactly $|V| - 1$ edges',
  'There rests exactly one simple path between any two distinct vertices in $G$',
  '$G$ is connected, and removing any single edge strictly disconnects it',
  ARRAY['A','B','C','D'],
  '<p><strong>✓ Answers: A, B, C, D.</strong></p><p><strong>Rationale:</strong> All 4 statements are classically equivalent standard definitions of a tree. Any one of these conditions implies all the other conditions, forming the mathematical definition of a minimally-connected, acyclic structure.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('trees','graphs');

-- Q63 — MSQ: First-Order Logic Entailments (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='first-order-logic' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','hard',2,
  'Which quantifications are logically valid implications in First Order Logic? (Select all that apply)',
  '$\forall x \forall y P(x, y) \implies \forall y \forall x P(x, y)$',
  '$\exists x \exists y P(x, y) \implies \exists y \exists x P(x, y)$',
  '$\exists x \forall y P(x, y) \implies \forall y \exists x P(x, y)$',
  '$\forall x \exists y P(x, y) \implies \exists y \forall x P(x, y)$',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong><br>- Continuous same quantifiers ($\forall\forall$ or $\exists\exists$) commute.<br>- Option C states: "There is someone who loves everyone $\implies$ Everyone is loved by someone". This is a valid forward deduction.<br>- Option D states: "Everyone loves someone $\implies$ There is someone who is loved by everyone". This is invalid logic (the subset direction does not hold backwards).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','first-order');

-- Q64 — MSQ: Planar graph components (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='planar-graphs' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'What are known properties of specifically Planar Graphs? (Select all that apply)',
  'Contains no subgraphs homeomorphic to $K_5$ or $K_{3,3}$',
  'Follows Euler''s formula $V - E + f = 2$ when connected',
  'It cannot contain any cycles of length $3$',
  'There is always at least one vertex with degree $\le 5$',
  ARRAY['A','B','D'],
  '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> This is Kuratowski''s Theorem.<br>- <strong>B:</strong> Standard Euler''s formula for planar faces.<br>- <strong>D:</strong> True, every planar graph has a vertex $deg(v) \le 5$, derived directly from $E \le 3V - 6$.<br>- <strong>Why C is FALSE:</strong> Planar graphs can absolutely contain triangles ($C_3$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q65 — MSQ: Functions Composition validities (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='functions-types' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'Given functions $f: A \rightarrow B$ and $g: B \rightarrow C$. The composite $g \circ f$ maps $A$ to $C$. Which rules dictate the characteristics of this composition? (Select all that apply)',
  'If both $f$ and $g$ are injective, $g \circ f$ is injective',
  'If both $f$ and $g$ are surjective, $g \circ f$ is surjective',
  'If $g \circ f$ is surjective, then $g$ must be surjective',
  'If $g \circ f$ is injective, then $g$ must be injective',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong><br>- The combination of bijections, injectives, or surjectives maintains those properties. (A, B).<br>- If the final map reaches everywhere, the final function $g$ must logically reach everywhere (C).<br>- However, if the composite is injective, only the first function $f$ MUST be injective. Function $g$ does not need to be inherently injective globally outside the codomain of $f$. Thus D is false.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions');

-- Part 6 complete.
