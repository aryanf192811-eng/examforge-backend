-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DM PYQ SEED v2  (Part 2 / 8)
-- MCQ Questions Q1–Q14 (Logic & Set Theory)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — Propositional Logic Tautology (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='propositional-logic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following propositions is a tautology?',
  '$(p \lor q) \rightarrow q$',
  '$p \lor (q \rightarrow p)$',
  '$p \lor (p \rightarrow q)$',
  '$(p \rightarrow q) \rightarrow p$',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Step-by-step:</strong> Evaluate option C using logical equivalences:<br>$p \lor (p \rightarrow q) \equiv p \lor (\neg p \lor q) \equiv (p \lor \neg p) \lor q \equiv \text{True} \lor q \equiv \text{True}$.<br>Because it reduces to True under all truth assignments, it is a tautology.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','propositional');

-- Q2 — First-Order Logic Translation (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='first-order-logic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Let $F(x, y)$ mean "$x$ can fool $y$". Translate: "No one can fool everyone."',
  '$\forall x \forall y (\neg F(x, y))$',
  '$\neg \exists x \forall y (F(x, y))$',
  '$\forall x \exists y (\neg F(x, y))$',
  'Both B and C',
  'D',
  '<p><strong>✓ Answer: D — Both B and C.</strong></p><p><strong>Step-by-step:</strong><br>- "Someone can fool everyone" translates to $\exists x \forall y F(x, y)$.<br>- "No one can fool everyone" is the negation: $\neg \exists x \forall y F(x, y)$ (Option B).<br>- Pushing the negation inward gives $\forall x \exists y \neg F(x, y)$ (Option C).<br>Thus, both are correct logical translations.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','first-order');

-- Q3 — Propositional Logic Equivalence (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='propositional-logic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The logical expression $p \leftrightarrow q$ is equivalent to:',
  '$(p \rightarrow q) \land (q \rightarrow p)$',
  '$(p \land q) \lor (\neg p \land \neg q)$',
  '$(\neg p \lor q) \land (\neg q \lor p)$',
  'All of the above',
  'D',
  '<p><strong>✓ Answer: D — All of the above.</strong></p><p><strong>Step-by-step:</strong><br>- Option A is the definition of the biconditional: $(p \rightarrow q) \land (q \rightarrow p)$.<br>- Option B represents the truth table output: both true together or both false together.<br>- Option C derives from applying the implication rule to Option A: $(\neg p \lor q) \land (\neg q \lor p)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','propositional');

-- Q4 — Set Theory Intersections (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='set-theory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'If $A$, $B$, and $C$ are sets, what is $(A - B) \cup (A \cap B)$?',
  '$A$',
  '$B$',
  '$A \cup B$',
  '$A \cap B$',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Step-by-step:</strong> Set difference $A - B$ consists of elements in $A$ but not in $B$. Set intersection $A \cap B$ consists of elements in both $A$ and $B$. Their union contains all elements in $A$, restoring the original set $A$.</p><p>Algebraically: $(A \cap B^c) \cup (A \cap B) = A \cap (B^c \cup B) = A \cap \text{Universal} = A$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sets');

-- Q5 — Equivalence Relations (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relations-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'For a relation $R$ on set $S$ to be an Equivalence Relation, it must be:',
  'Reflexive, Symmetric, and Transitive',
  'Reflexive, Antisymmetric, and Transitive',
  'Irreflexive, Symmetric, and Transitive',
  'Reflexive, Asymmetric, and Transitive',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The definition of an equivalence relation requires these three properties. By contrast, a Partial Order Relation (like $\le$) requires Reflexive, Antisymmetric, and Transitive properties (Option B).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations','sets');

-- Q6 — Number of Relations (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relations-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Given a set $A$ containing $n$ elements, what is the total number of distinct relations defined on $A$?',
  '$2^n$',
  '$n^2$',
  '$2^{n^2}$',
  '$2^{n(n-1)/2}$',
  'C',
  '<p><strong>✓ Answer: C — $2^{n^2}$.</strong></p><p><strong>Step-by-step:</strong> A relation on set $A$ is a subset of the Cartesian product $A \times A$. The set $A \times A$ contains $n \times n = n^2$ elements. The number of subsets of a set with $k$ elements is $2^k$. Therefore, there are $2^{n^2}$ possible relations.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations');

-- Q7 — Functions: Injective vs Surjective (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='functions-types' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Let $f(x) = x^2$ be a function. Under which domain and codomain is $f(x)$ a bijection?',
  '$f: \mathbb{R} \rightarrow \mathbb{R}$',
  '$f: \mathbb{R}^+ \rightarrow \mathbb{R}$',
  '$f: \mathbb{R} \rightarrow \mathbb{R}^+$',
  '$f: \mathbb{R}^+ \rightarrow \mathbb{R}^+$',
  'D',
  '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong><br>- Option A: Not injective ($f(-2)=f(2)$) and not surjective (no negative outputs).<br>- Option B: Injective, but not surjective (no negative outputs).<br>- Option C: Surjective on positive reals, but not injective ($x$ and $-x$ map to same output).<br>- Option D: Both injective and surjective on strictly positive numbers. Thus, it is a bijection.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions');

-- Q8 — Posets and Hasse Diagrams (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='equivalence-posets' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a Hasse diagram depicting a Partially Ordered Set (POSET), which types of edges are omitted?',
  'Self-loops only',
  'Transitive edges only',
  'Both self-loops and transitive edges',
  'None. All edges are drawn',
  'C',
  '<p><strong>✓ Answer: C — Both self-loops and transitive edges.</strong></p><p><strong>Rationale:</strong> A Hasse diagram simplifies the drawing of a POSET. Because a POSET is always reflexive and transitive by definition, we omit self-loops (showing reflexivity) and transitive edges (A to C when A to B and B to C exist) to reduce visual clutter.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations');

-- Q9 — Group Theory Basics (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='group-theory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A set with a binary operation forms a Group if it satisfies Closure, Associativity, Identity, and Inverse properties. If it also satisfies the Commutative property, what is it called?',
  'Cyclic Group',
  'Abelian Group',
  'Semigroup',
  'Monoid',
  'B',
  '<p><strong>✓ Answer: B — Abelian Group.</strong></p><p><strong>Rationale:</strong><br>- Semigroup: satisfied closure and associativity.<br>- Monoid: Semigroup + identity element.<br>- Group: Monoid + inverses.<br>- Abelian Group: Group + commutative property ($a \ast b = b \ast a$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('groups');

-- Q10 — Logic inference (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='propositional-logic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Consider the premises: (1) $p \rightarrow q$, (2) $q \rightarrow r$, (3) $\neg r$. Which valid inference can be drawn using Modus Tollens and Hypothetical Syllogism?',
  '$p$',
  '$\neg p$',
  '$q$',
  '$r$',
  'B',
  '<p><strong>✓ Answer: B — $\neg p$.</strong></p><p><strong>Step-by-step:</strong><br>Using Hypothetical Syllogism on (1) and (2) yields $p \rightarrow r$.<br>Applying Modus Tollens to $p \rightarrow r$ and premise (3) $\neg r$, we conclude $\neg p$.<br>Alternatively, apply Modus Tollens to (2) and (3) to get $\neg q$, then to (1) to get $\neg p$. Both paths reach the same valid conclusion.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic');

-- Q11 — Boolean Algebra Idempotent Laws (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='lattices-boolean' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following Boolean logic statements illustrates the Absorption Law?',
  '$x + x=x$',
  '$x + 0=x$',
  '$x + (x \cdot y) = x$',
  '$x \cdot (x^c \cdot y) = 0$',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The Absorption Law identifies expressions where one term absorbs another, returning the original term. $x + (x \cdot y) = x (1 + y) = x (1) = x$. Option A is the Idempotent law, and Option B is an Identity law.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lattices');

-- Q12 — Universal Quantifier distribution (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='first-order-logic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which quantifier distribution is logically valid in First Order Logic?',
  '$\exists x (P(x) \land Q(x)) \equiv \exists x P(x) \land \exists x Q(x)$',
  '$\forall x (P(x) \lor Q(x)) \equiv \forall x P(x) \lor \forall x Q(x)$',
  '$\forall x (P(x) \land Q(x)) \equiv \forall x P(x) \land \forall x Q(x)$',
  'All of above',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The Universal Quantifier $\forall$ distributes over logical AND ($\land$) but NOT over OR ($\lor$). The Existential Quantifier $\exists$ distributes over OR ($\lor$) but NOT over AND ($\land$). Therefore, only option C represents a valid equivalence.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','first-order');

-- Q13 — Order of Group Element (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='group-theory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'By Lagrange''s Theorem, what constraint exists on the order of a subgroup $H$ relative to a finite group $G$?',
  'The order of $H$ must equal the order of $G$',
  'The order of $G$ must divide the order of $H$',
  'The order of $H$ must exactly divide the order of $G$',
  'There is no relation',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Lagrange''s theorem asserts that for any finite group $G$, the order (size) of every subgroup $H$ must be a divisor of the order of $G$. This also implies that the order of any element within the group divides the order of the group.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('groups');

-- Q14 — Symmetric Difference (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='set-theory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The symmetric difference of sets $A$ and $B$, denoted $A \oplus B$, is mathematically equivalent to:',
  '$(A - B) \cup (B - A)$',
  '$(A \cup B) - (A \cap B)$',
  'Both A and B',
  'None of the above',
  'C',
  '<p><strong>✓ Answer: C — Both A and B.</strong></p><p><strong>Step-by-step:</strong> Symmetric difference represents elements in $A$ or $B$, but NOT in both.<br>- Option A represents union of the exclusive elements: $(A - B) \cup (B - A)$.<br>- Option B takes the union and subtracts the intersection: $(A \cup B) - (A \cap B)$.<br>- Both forms represent the same logic, similar to the XOR gate in boolean logic.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sets');

-- Part 2 complete.
