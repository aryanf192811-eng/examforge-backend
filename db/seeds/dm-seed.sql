-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” DM PYQ SEED v2  (Part 1 / 8)
-- Subject: Discrete Mathematics (DM)
-- Scope: Initialization, Chapters, Tags, Topics
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- â”€â”€â”€ Subject â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO subjects (slug, name, description, color, icon)
VALUES (
  'dm',
  'Discrete Mathematics',
  'Propositional logic, set theory, combinatorics, and graph theory fundamental to theoretical computer science.',
  '#9c27b0', -- Purple
  '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-infinity"><path d="M12 12c-2-2.67-4-4-6-4a4 4 0 1 0 0 8c2 0 4-1.33 6-4Zm0 0c2 2.67 4 4 6 4a4 4 0 1 0 0-8c-2 0-4 1.33-6 4Z"/></svg>'
) ON CONFLICT (slug) DO NOTHING;

-- â”€â”€â”€ Chapters â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
WITH s AS (SELECT id FROM subjects WHERE slug='dm')
INSERT INTO chapters (subject_id, slug, name, description, "order") VALUES
((SELECT id FROM s), 'logic-proofs', 'Logic and Proofs', 'Propositional logic, First-order logic, and Proof techniques.', 1),
((SELECT id FROM s), 'sets-relations-functions', 'Sets, Relations & Functions', 'Set theory, Posets, Lattices, Functions, and Group Theory.', 2),
((SELECT id FROM s), 'combinatorics', 'Combinatorics', 'Permutations, Combinations, Generating functions, and Recurrence relations.', 3),
((SELECT id FROM s), 'graph-theory', 'Graph Theory', 'Connectivity, Matching, Coloring, Trees, and Graph traversal.', 4)
ON CONFLICT (subject_id, slug) DO NOTHING;

-- â”€â”€â”€ Tags â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO tags (slug, name) VALUES
('logic', 'Logic'),
('propositional', 'Propositional Calculus'),
('first-order', 'First-Order Logic'),
('sets', 'Sets'),
('relations', 'Relations'),
('functions', 'Functions'),
('groups', 'Group Theory'),
('lattices', 'Lattices & Posets'),
('combinatorics', 'Combinatorics'),
('recurrence', 'Recurrence Relations'),
('graphs', 'Graphs'),
('trees', 'Trees'),
('matching', 'Matching & Coloring')
ON CONFLICT (slug) DO NOTHING;

-- â”€â”€â”€ Topics â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
WITH c1 AS (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
     c2 AS (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
     c3 AS (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
     c4 AS (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1)
INSERT INTO topics (chapter_id, slug, name, "order") VALUES
-- Chapter 1: Logic & Proofs
((SELECT id FROM c1), 'propositional-logic', 'Propositional Logic', 1),
((SELECT id FROM c1), 'first-order-logic', 'First-Order Logic', 2),
((SELECT id FROM c1), 'proof-techniques', 'Proof Techniques', 3),

-- Chapter 2: Sets, Relations & Functions
((SELECT id FROM c2), 'set-theory', 'Set Theory', 1),
((SELECT id FROM c2), 'relations-properties', 'Relations and Properties', 2),
((SELECT id FROM c2), 'equivalence-posets', 'Equivalence Relations & Posets', 3),
((SELECT id FROM c2), 'lattices-boolean', 'Lattices & Boolean Algebra', 4),
((SELECT id FROM c2), 'functions-types', 'Types of Functions', 5),
((SELECT id FROM c2), 'group-theory', 'Group Theory', 6),

-- Chapter 3: Combinatorics
((SELECT id FROM c3), 'permutations-combinations', 'Permutations & Combinations', 1),
((SELECT id FROM c3), 'pigeonhole-principle', 'Pigeonhole Principle', 2),
((SELECT id FROM c3), 'inclusion-exclusion', 'Inclusion-Exclusion Principle', 3),
((SELECT id FROM c3), 'generating-functions', 'Generating Functions', 4),
((SELECT id FROM c3), 'recurrence-relations', 'Recurrence Relations', 5),

-- Chapter 4: Graph Theory
((SELECT id FROM c4), 'graph-basics', 'Graph Basics & Properties', 1),
((SELECT id FROM c4), 'connectivity-paths', 'Connectivity, Euler & Hamilton Paths', 2),
((SELECT id FROM c4), 'planar-graphs', 'Planar Graphs', 3),
((SELECT id FROM c4), 'graph-coloring', 'Graph Coloring', 4),
((SELECT id FROM c4), 'matching', 'Matching & Independent Sets', 5),
((SELECT id FROM c4), 'trees-properties', 'Trees & Their Properties', 6)
ON CONFLICT (chapter_id, slug) DO NOTHING;

-- Part 1 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” DM PYQ SEED v2  (Part 2 / 8)
-- MCQ Questions Q1â€“Q14 (Logic & Set Theory)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Q1 â€” Propositional Logic Tautology (easy)
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
  '<p><strong>âœ“ Answer: C.</strong></p><p><strong>Step-by-step:</strong> Evaluate option C using logical equivalences:<br>$p \lor (p \rightarrow q) \equiv p \lor (\neg p \lor q) \equiv (p \lor \neg p) \lor q \equiv \text{True} \lor q \equiv \text{True}$.<br>Because it reduces to True under all truth assignments, it is a tautology.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','propositional');

-- Q2 â€” First-Order Logic Translation (medium)
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
  '<p><strong>âœ“ Answer: D â€” Both B and C.</strong></p><p><strong>Step-by-step:</strong><br>- "Someone can fool everyone" translates to $\exists x \forall y F(x, y)$.<br>- "No one can fool everyone" is the negation: $\neg \exists x \forall y F(x, y)$ (Option B).<br>- Pushing the negation inward gives $\forall x \exists y \neg F(x, y)$ (Option C).<br>Thus, both are correct logical translations.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','first-order');

-- Q3 â€” Propositional Logic Equivalence (medium)
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
  '<p><strong>âœ“ Answer: D â€” All of the above.</strong></p><p><strong>Step-by-step:</strong><br>- Option A is the definition of the biconditional: $(p \rightarrow q) \land (q \rightarrow p)$.<br>- Option B represents the truth table output: both true together or both false together.<br>- Option C derives from applying the implication rule to Option A: $(\neg p \lor q) \land (\neg q \lor p)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','propositional');

-- Q4 â€” Set Theory Intersections (easy)
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
  '<p><strong>âœ“ Answer: A.</strong></p><p><strong>Step-by-step:</strong> Set difference $A - B$ consists of elements in $A$ but not in $B$. Set intersection $A \cap B$ consists of elements in both $A$ and $B$. Their union contains all elements in $A$, restoring the original set $A$.</p><p>Algebraically: $(A \cap B^c) \cup (A \cap B) = A \cap (B^c \cup B) = A \cap \text{Universal} = A$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sets');

-- Q5 â€” Equivalence Relations (medium)
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
  '<p><strong>âœ“ Answer: A.</strong></p><p><strong>Rationale:</strong> The definition of an equivalence relation requires these three properties. By contrast, a Partial Order Relation (like $\le$) requires Reflexive, Antisymmetric, and Transitive properties (Option B).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations','sets');

-- Q6 â€” Number of Relations (easy)
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
  '<p><strong>âœ“ Answer: C â€” $2^{n^2}$.</strong></p><p><strong>Step-by-step:</strong> A relation on set $A$ is a subset of the Cartesian product $A \times A$. The set $A \times A$ contains $n \times n = n^2$ elements. The number of subsets of a set with $k$ elements is $2^k$. Therefore, there are $2^{n^2}$ possible relations.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations');

-- Q7 â€” Functions: Injective vs Surjective (medium)
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
  '<p><strong>âœ“ Answer: D.</strong></p><p><strong>Rationale:</strong><br>- Option A: Not injective ($f(-2)=f(2)$) and not surjective (no negative outputs).<br>- Option B: Injective, but not surjective (no negative outputs).<br>- Option C: Surjective on positive reals, but not injective ($x$ and $-x$ map to same output).<br>- Option D: Both injective and surjective on strictly positive numbers. Thus, it is a bijection.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions');

-- Q8 â€” Posets and Hasse Diagrams (medium)
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
  '<p><strong>âœ“ Answer: C â€” Both self-loops and transitive edges.</strong></p><p><strong>Rationale:</strong> A Hasse diagram simplifies the drawing of a POSET. Because a POSET is always reflexive and transitive by definition, we omit self-loops (showing reflexivity) and transitive edges (A to C when A to B and B to C exist) to reduce visual clutter.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations');

-- Q9 â€” Group Theory Basics (medium)
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
  '<p><strong>âœ“ Answer: B â€” Abelian Group.</strong></p><p><strong>Rationale:</strong><br>- Semigroup: satisfied closure and associativity.<br>- Monoid: Semigroup + identity element.<br>- Group: Monoid + inverses.<br>- Abelian Group: Group + commutative property ($a \ast b = b \ast a$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('groups');

-- Q10 â€” Logic inference (hard)
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
  '<p><strong>âœ“ Answer: B â€” $\neg p$.</strong></p><p><strong>Step-by-step:</strong><br>Using Hypothetical Syllogism on (1) and (2) yields $p \rightarrow r$.<br>Applying Modus Tollens to $p \rightarrow r$ and premise (3) $\neg r$, we conclude $\neg p$.<br>Alternatively, apply Modus Tollens to (2) and (3) to get $\neg q$, then to (1) to get $\neg p$. Both paths reach the same valid conclusion.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic');

-- Q11 â€” Boolean Algebra Idempotent Laws (easy)
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
  '<p><strong>âœ“ Answer: C.</strong></p><p><strong>Rationale:</strong> The Absorption Law identifies expressions where one term absorbs another, returning the original term. $x + (x \cdot y) = x (1 + y) = x (1) = x$. Option A is the Idempotent law, and Option B is an Identity law.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lattices');

-- Q12 â€” Universal Quantifier distribution (medium)
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
  '<p><strong>âœ“ Answer: C.</strong></p><p><strong>Rationale:</strong> The Universal Quantifier $\forall$ distributes over logical AND ($\land$) but NOT over OR ($\lor$). The Existential Quantifier $\exists$ distributes over OR ($\lor$) but NOT over AND ($\land$). Therefore, only option C represents a valid equivalence.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','first-order');

-- Q13 â€” Order of Group Element (hard)
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
  '<p><strong>âœ“ Answer: C.</strong></p><p><strong>Rationale:</strong> Lagrange''s theorem asserts that for any finite group $G$, the order (size) of every subgroup $H$ must be a divisor of the order of $G$. This also implies that the order of any element within the group divides the order of the group.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('groups');

-- Q14 â€” Symmetric Difference (easy)
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
  '<p><strong>âœ“ Answer: C â€” Both A and B.</strong></p><p><strong>Step-by-step:</strong> Symmetric difference represents elements in $A$ or $B$, but NOT in both.<br>- Option A represents union of the exclusive elements: $(A - B) \cup (B - A)$.<br>- Option B takes the union and subtracts the intersection: $(A \cup B) - (A \cap B)$.<br>- Both forms represent the same logic, similar to the XOR gate in boolean logic.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sets');

-- Part 2 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” DM PYQ SEED v2  (Part 3 / 8)
-- MCQ Questions Q15â€“Q28 (Combinatorics & Graph Theory)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Q15 â€” Pigeonhole Principle (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pigeonhole-principle' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'How many uniformly identical socks must be drawn from a drawer containing 5 colors of socks to guarantee at least a pair of the same color?',
  '5',
  '6',
  '10',
  '11',
  'B',
  '<p><strong>âœ“ Answer: B â€” 6.</strong></p><p><strong>Rationale:</strong> According to the Pigeonhole Principle, if $n$ items are placed into $m$ containers and $n > m$, at least one container must contain more than one item. Here, containers are the 5 colors. To guarantee two of the same color, we need $n = 5 + 1 = 6$ socks.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q16 â€” Number of Derangements (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='permutations-combinations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'What is the number of derangements of 4 items (permutations where no element appears in its original position)?',
  '9',
  '12',
  '24',
  '15',
  'A',
  '<p><strong>âœ“ Answer: A â€” 9.</strong></p><p><strong>Step-by-step:</strong> The formula for derangements of $n$ elements is $D_n = n! (1 - 1/1! + 1/2! - 1/3! + ... + (-1)^n/n!)$.<br>For $n = 4$:<br>$D_4 = 24 \times (1 - 1 + 1/2 - 1/6 + 1/24) = 24 \times (12/24 - 4/24 + 1/24) = 24 \times (9/24) = 9$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q17 â€” Generating Functions (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='generating-functions' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following describes the generating function for the sequence $1, 1, 1, 1, ...$?',
  '$1 / (1-x)$',
  '$1 / (1+x)$',
  '$1 / (1-x)^2$',
  '$e^x$',
  'A',
  '<p><strong>âœ“ Answer: A â€” $1 / (1-x)$.</strong></p><p><strong>Rationale:</strong> The geometric series expansion is $1 + x + x^2 + x^3 + ... = \frac{1}{1 - x}$ for $|x| < 1$. The coefficients of the $x^k$ terms represent the sequence, which is $1, 1, 1, ...$</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q18 â€” Recurrence Relation Solution (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='recurrence-relations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The Master Theorem resolves recurrence relations of the form $T(n) = aT(n/b) + \theta(n^k)$. What is the time complexity if $a > b^k$?',
  '$\theta(n^k \log n)$',
  '$\theta(n^{\log_b a})$',
  '$\theta(n^k)$',
  '$\theta(a^n)$',
  'B',
  '<p><strong>âœ“ Answer: B â€” $\theta(n^{\log_b a})$.</strong></p><p><strong>Rationale:</strong> By the Master Theorem, if $a > b^k$, the work done at the leaves dominates the total tree depth work, resulting in a complexity described by the number of leaves: $\theta(n^{\log_b a})$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recurrence','combinatorics');

-- Q19 â€” Graph Basics: Handshaking Lemma (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'According to the Handshaking Lemma, the sum of the degrees of all vertices in a simple undirected graph is always equal to:',
  'The number of edges',
  'Twice the number of edges',
  'The number of vertices',
  'Twice the number of vertices',
  'B',
  '<p><strong>âœ“ Answer: B â€” Twice the number of edges.</strong></p><p><strong>Rationale:</strong> Each edge connects exactly two distinct vertices. When summing the degrees of all vertices, every single edge gets counted exactly twice (once for each of its endpoints). Thus, $\sum deg(V) = 2E$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q20 â€” Graph Coloring & Planarity (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-coloring' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What is the maximum chromatic number for any simple connected planar graph?',
  '3',
  '4',
  '5',
  '6',
  'B',
  '<p><strong>âœ“ Answer: B â€” 4.</strong></p><p><strong>Rationale:</strong> The famous Four Color Theorem states that the vertices of every planar graph can be colored using at most 4 different colors such that no two adjacent vertices share the exact same color.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Q21 â€” Planar Graphs: Euler's Formula (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='planar-graphs' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Euler''s formula defines the relationship between vertices ($V$), edges ($E$), and regions/faces ($f$) for connected planar graphs. What is the formula?',
  '$v - e + f = 2$',
  '$v + e - f = 2$',
  '$v - e - f = 2$',
  '$e - v + f = 2$',
  'A',
  '<p><strong>âœ“ Answer: A â€” $v - e + f = 2$.</strong></p><p><strong>Rationale:</strong> This core formula applies strictly to connected planar graphs. If disconnected with $k$ components, the formula adjusts to $v - e + f = 1 + k$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q22 â€” Complete Graph Edges (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'How many edges are present in a complete graph $K_n$?',
  '$n$',
  '$n(n-1) / 2$',
  '$n^2$',
  '$n(n+1) / 2$',
  'B',
  '<p><strong>âœ“ Answer: B â€” $n(n-1)/2$.</strong></p><p><strong>Step-by-step:</strong> In a Complete Graph $K_n$, every vertex is connected to every other vertex. We use combinations: picking 2 vertices from $n$ available vertices without concerning order. This gives $\binom{n}{2} = n(n-1)/2$ edges.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q23 â€” Trees vs Cycles (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='trees-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following statements about trees is false?',
  'Every tree is a connected bipartite graph',
  'Adding any new edge to a tree creates exactly one cycle',
  'A tree with $n$ vertices has exactly $n-1$ edges',
  'Every tree must contain at least one vertex of degree 3',
  'D',
  '<p><strong>âœ“ Answer: D.</strong></p><p><strong>Rationale:</strong> Option D is false. A path graph is a tree (e.g., $A-B-C$), but the maximum degree in a path graph is 2. Therefore, a tree does not require any vertex of degree 3.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('trees','graphs');

-- Q24 â€” Euler vs Hamilton Paths (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'An Euler circuit exists in a connected, undirected graph if and only if:',
  'Every vertex has an even degree',
  'Every vertex has an odd degree',
  'The graph contains no cycles',
  'The graph is bipartite',
  'A',
  '<p><strong>âœ“ Answer: A â€” Every vertex has an even degree.</strong></p><p><strong>Rationale:</strong> An Euler circuit must traverse every single edge exactly once and return to the starting vertex. For every time a path enters a vertex via an edge, it must leave via an unused edge, requiring every vertex to naturally have an even degree pairing.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q25 â€” Inclusion-Exclusion (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='inclusion-exclusion' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'How many integers between 1 and 100 are divisible by either 2 or 5?',
  '50',
  '60',
  '70',
  '80',
  'B',
  '<p><strong>âœ“ Answer: B â€” 60.</strong></p><p><strong>Step-by-step:</strong> Let $A$ be multiples of 2, $B$ be multiples of 5.<br>$|A| = \lfloor 100/2 \rfloor = 50$<br>$|B| = \lfloor 100/5 \rfloor = 20$<br>$|A \cap B|$ (multiples of 10) $= \lfloor 100/10 \rfloor = 10$<br>$|A \cup B| = |A| + |B| - |A \cap B| = 50 + 20 - 10 = 60$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q26 â€” Bipartite Graph Chromatic Number (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-coloring' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the chromatic number of any non-empty bipartite graph?',
  '1',
  '2',
  '3',
  'Depends on vertices',
  'B',
  '<p><strong>âœ“ Answer: B â€” 2.</strong></p><p><strong>Rationale:</strong> A bipartite graph partitions vertices into two disjoint sets where edges only exist between the sets, not within them. You can color all nodes in the first set Color A, and all nodes in the second set Color B. Thus, it requires exactly 2 colors.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Q27 â€” Chromatic Number property (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-coloring' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'If the maximum degree of any vertex in a connected undirected graph is $\Delta$, what is the upper bound for the chromatic number $\chi(G)$ given by Brooks Theorem (assuming G is neither complete nor an odd cycle)?',
  '$\Delta$',
  '$\Delta + 1$',
  '$\Delta - 1$',
  'No upper limit',
  'A',
  '<p><strong>âœ“ Answer: A â€” $\Delta$.</strong></p><p><strong>Rationale:</strong> A greedy coloring algorithm usually requires $\Delta + 1$ colors. However, Brooks Theorem states that if the graph is neither a complete graph nor an odd cycle, the chromatic number $\chi(G)$ is bounded by $\Delta$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Q28 â€” Independent Sets (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='matching' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a graph $G$ with $n$ vertices, if the size of the maximum independent set is $\alpha$, what is the size of the minimum vertex cover $\beta$?',
  '$\alpha$',
  '$n - \alpha$',
  '$n / \alpha$',
  'Independent of $\alpha$',
  'B',
  '<p><strong>âœ“ Answer: B â€” $n - \alpha$.</strong></p><p><strong>Rationale:</strong> Gallai''s Theorem establishes that for any graph without isolated vertices, the sum of the independence number $\alpha$ and the vertex cover number $\beta$ equals the total number of vertices $n$. Hence, $\alpha + \beta = n$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Part 3 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” DM PYQ SEED v2  (Part 4 / 8)
-- MCQ Questions Q29â€“Q45 (Logic, Combinatorics, Advanced Graphs)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Q29 â€” Propositional Logic Converse (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='propositional-logic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the converse of the implication "If it rains, then the ground is wet"?',
  'If it does not rain, then the ground is not wet',
  'If the ground is not wet, then it does not rain',
  'If the ground is wet, then it rains',
  'It rains and the ground is not wet',
  'C',
  '<p><strong>âœ“ Answer: C.</strong></p><p><strong>Rationale:</strong> For an implication $p \rightarrow q$:<br>- Converse is $q \rightarrow p$.<br>- Inverse is $\neg p \rightarrow \neg q$.<br>- Contrapositive is $\neg q \rightarrow \neg p$.<br>Option C reverses the condition to $q \rightarrow p$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic');

-- Q30 â€” Lattices (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='lattices-boolean' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A POSET is considered a Lattice if and only if:',
  'Every pair of elements has a Greatest Lower Bound (GLB)',
  'Every pair of elements has a Least Upper Bound (LUB)',
  'Every pair of elements has both a GLB and LUB',
  'It has a unique maximal and minimal element',
  'C',
  '<p><strong>âœ“ Answer: C.</strong></p><p><strong>Rationale:</strong> The defining property of a Lattice is that any two elements within the poset must have both a unique supremum (LUB, join) and a unique infimum (GLB, meet).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('lattices');

-- Q31 â€” Combinations with Repetition (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='permutations-combinations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'How many non-negative integer solutions exist for the equation $x_1 + x_2 + x_3 = 10$?',
  '66',
  '45',
  '55',
  '120',
  'A',
  '<p><strong>âœ“ Answer: A â€” 66.</strong></p><p><strong>Step-by-step:</strong> This is solved using the "Stars and Bars" method for distributing $n$ identical items into $r$ distinct bins. The formula is $\binom{n + r - 1}{r - 1}$.<br>Here $n=10$ and $r=3$.<br>Result: $\binom{10 + 3 - 1}{3 - 1} = \binom{12}{2}$.<br>$\frac{12 \times 11}{2} = 66$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q32 â€” Graph Connectivity (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In an undirected graph, a connected component is:',
  'A subgraph containing only vertices of even degree',
  'A maximal connected subgraph',
  'A subgraph that forms a cycle',
  'A path between the two furthest vertices',
  'B',
  '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Rationale:</strong> By definition, a connected component is a maximal set of vertices connected to each other by paths. Adding any extra vertex to this component would break the connectivity.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q33 â€” Eulerian Graph definition (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which condition guarantees an undirected graph $G$ has an Eulerian path but NOT an Eulerian circuit?',
  'All vertices have even degree',
  'Exactly two vertices have odd degree',
  'All vertices have odd degree',
  'Exactly one vertex has an odd degree',
  'B',
  '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Rationale:</strong><br>- All even degrees $\implies$ Eulerian Circuit.<br>- Exactly two odd degrees $\implies$ Eulerian Path (starts at one odd vertex, ends at the other).<br>- Graphs cannot have exactly one odd-degree vertex due to the Handshaking Lemma.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q34 â€” Cartesian Product of Sets (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics,'set-theory') LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'If Set A has 4 elements and Set B has 5 elements, how many elements are in the power set of Cartesian product $A \times B$?',
  '$2^9$',
  '$20$',
  '$9$',
  '$2^{20}$',
  'D',
  '<p><strong>âœ“ Answer: D â€” $2^{20}$.</strong></p><p><strong>Step-by-step:</strong><br>- Number of elements in $A \times B$ is $|A| \times |B| = 4 \times 5 = 20$.<br>- The power set of a set with $n$ elements contains $2^n$ elements.<br>- Therefore, the power set contains $2^{20}$ elements.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sets');

-- Q35 â€” Complete Bipartite Edges (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'How many edges are present in a Complete Bipartite Graph $K_{m,n}$?',
  '$m + n$',
  '$m \times n$',
  '$m^2 + n^2$',
  '$(m+n)(m+n-1)/2$',
  'B',
  '<p><strong>âœ“ Answer: B â€” $m \times n$.</strong></p><p><strong>Rationale:</strong> In $K_{m,n}$, the vertex set is partitioned into two sets of sizes $m$ and $n$. Since it is complete, every vertex in the first set is connected to every vertex in the second set. The total edges is the product: $m \times n$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q36 â€” Walk, Path, Trail (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In graph theory, a walk in which no edge is repeated is specifically called a:',
  'Path',
  'Cycle',
  'Trail',
  'Tour',
  'C',
  '<p><strong>âœ“ Answer: C â€” Trail.</strong></p><p><strong>Rationale:</strong><br>- <strong>Walk:</strong> Anything goes.<br>- <strong>Trail:</strong> No repeated edges (vertices can be repeated).<br>- <strong>Path:</strong> No repeated vertices (which enforces no repeated edges).<br>- <strong>Cycle:</strong> A path that starts and ends at the same vertex.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q37 â€” Planar Graph Regions (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='planar-graphs' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'For a planar graph with 6 vertices and 9 edges, how many faces (regions) are created in its planar embedding?',
  '4',
  '5',
  '6',
  '7',
  'B',
  '<p><strong>âœ“ Answer: B â€” 5.</strong></p><p><strong>Step-by-step:</strong> Use Euler''s Formula $V - E + F = 2$.<br>$6 - 9 + F = 2$<br>$-3 + F = 2$<br>$F = 5$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q38 â€” Hamilton Cycle bound (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Dirac''s Theorem guarantees a Hamilton Cycle in a simple graph with $n$ vertices ($n \ge 3$) if every vertex has a degree of at least:',
  '$n-1$',
  '$n/2$',
  '$\sqrt{n}$',
  '2',
  'B',
  '<p><strong>âœ“ Answer: B â€” $n/2$.</strong></p><p><strong>Rationale:</strong> Dirac''s Theorem states that if $n \ge 3$ and $deg(v) \ge n/2$ for every vertex $v$, then the graph has a Hamilton cycle.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q39 â€” Group Theory Identiy (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='group-theory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In the mathematical group consisting of Integers under Addition ($\mathbb{Z}, +$), what is the identity element?',
  '0',
  '1',
  '-1',
  'It does not exist',
  'A',
  '<p><strong>âœ“ Answer: A â€” 0.</strong></p><p><strong>Rationale:</strong> The identity element $e$ in a group is defined such that $a + e = e + a = a$. Under addition, adding 0 leaves any integer unchanged.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('groups');

-- Q40 â€” Transitive Closure (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relations-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Warshall''s Algorithm is typically used to efficiently compute which property of a relation graph?',
  'Reflexive Closure',
  'Symmetric Closure',
  'Transitive Closure',
  'Equivalence Closure',
  'C',
  '<p><strong>âœ“ Answer: C â€” Transitive Closure.</strong></p><p><strong>Rationale:</strong> Warshall''s Algorithm $O(n^3)$ computes the boolean reachability matrix of a graph, which is mathematically identical to finding the transitive closure of a relation.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations','graphs');

-- Q41 â€” De Morgan's Law for sets (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='set-theory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'According to De Morgan''s Laws for Sets, the complement of the union $(A \cup B)^c$ is equal to:',
  '$A^c \cup B^c$',
  '$A^c \cap B^c$',
  '$A \cap B$',
  '$A \cup B$',
  'B',
  '<p><strong>âœ“ Answer: B â€” $A^c \cap B^c$.</strong></p><p><strong>Rationale:</strong> De Morgan''s laws distribute the complement while flipping the operator: $(A \cup B)^c = A^c \cap B^c$ and $(A \cap B)^c = A^c \cup B^c$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sets');

-- Q42 â€” Composition of Functions (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='functions-types' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Let $f(x) = 2x + 1$ and $g(x) = x^2$. What is the composition $(f \circ g)(x)$?',
  '$4x^2 + 4x + 1$',
  '$2x^2 + 1$',
  '$2x^3 + x^2$',
  '$x^2 + 2x + 1$',
  'B',
  '<p><strong>âœ“ Answer: B â€” $2x^2 + 1$.</strong></p><p><strong>Step-by-step:</strong> Composition means passing the output of $g$ into $f$.<br>$(f \circ g)(x) = f(g(x)) = f(x^2)$.<br>Substitute $x^2$ into $f$: $2(x^2) + 1 = 2x^2 + 1$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions');

-- Q43 â€” First Order Logic Valid Inference (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='first-order-logic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Consider the statements: "All dogs bark", "Fido does not bark". What is the valid conclusion?',
  'Fido is a dog',
  'Some dogs do not bark',
  'Fido is not a dog',
  'All options are invalid',
  'C',
  '<p><strong>âœ“ Answer: C â€” Fido is not a dog.</strong></p><p><strong>Step-by-step:</strong> This is a Modus Tollens argument.<br>Premise 1: $\forall x (D(x) \rightarrow B(x))$ (If $x$ is a dog, it barks).<br>Premise 2: $\neg B(F)$ (Fido does not bark).<br>Substituting Fido into P1: $D(F) \rightarrow B(F)$.<br>Applying Modus Tollens with $\neg B(F)$ gives $\neg D(F)$ : Fido is not a dog.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','first-order');

-- Q44 â€” Equivalence Class Size (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relations-properties' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'If a relation $R$ partitions a set $S$ into distinct equivalence classes, the union of all these classes is:',
  'The empty set $\emptyset$',
  'Set $S$',
  'A proper subset of $S$',
  'The Cartesian product $S \times S$',
  'B',
  '<p><strong>âœ“ Answer: B â€” Set $S$.</strong></p><p><strong>Rationale:</strong> The fundamental theorem of equivalence relations dictates that any equivalence relation on a set $S$ partitions $S$ into disjoint subsets (classes). By partition definition, their union covers the original set $S$ entirely.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations','sets');

-- Q45 â€” Complete Graph Coloring (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-coloring' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'What is the chromatic number of the complete graph $K_n$?',
  '$2$',
  '$n$',
  '$n-1$',
  '$n/2$',
  'B',
  '<p><strong>âœ“ Answer: B â€” $n$.</strong></p><p><strong>Rationale:</strong> In a complete graph, every vertex is connected to every other vertex. Consequently, no two vertices can share the same color. Thus, $n$ distinct vertices require $n$ different colors.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Part 4 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” DM PYQ SEED v2  (Part 5 / 8)
-- NAT Questions Q46â€“Q55 (Logic, Combinatorics, Graphs)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Q46 â€” Combinatorics: Derangements (NAT, medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='permutations-combinations' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  '5 friends place their hats in a pile. What is the total number of ways (derangements) that NO friend receives their own original hat?',
  44.00,44.00,NULL,
  '<p><strong>âœ“ Answer: 44.</strong></p><p><strong>Step-by-step:</strong><br>Using the derangement formula $D_n = n! \sum_{i=0}^n \frac{(-1)^i}{i!}$.<br>For $n = 5$:<br>$D_5 = 120 \left(\frac{1}{1} - \frac{1}{1} + \frac{1}{2} - \frac{1}{6} + \frac{1}{24} - \frac{1}{120}\right)$<br>$D_5 = 120 \left(0 + \frac{60 - 20 + 5 - 1}{120}\right)$<br>$D_5 = 44$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q47 â€” Graph Theory: Chromatic Number Planar (NAT, easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-coloring' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'According to the famous map-coloring theorem, what is the maximum chromatic number required to color ANY planar graph?',
  4.00,4.00,NULL,
  '<p><strong>âœ“ Answer: 4.</strong></p><p><strong>Rationale:</strong> The Four Color Theorem guarantees that the vertices of any planar graph can be colored with at most 4 colors such that no two adjacent vertices share the exact same color.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Q48 â€” Logic: Valid Truth Assignments (NAT, medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='propositional-logic' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'Consider the boolean expression $E = p \rightarrow (q \lor r)$. For exactly how many of the 8 possible truth assignments to $p, q, r$ is $E$ false?',
  1.00,1.00,NULL,
  '<p><strong>âœ“ Answer: 1.</strong></p><p><strong>Step-by-step:</strong><br>An implication $X \rightarrow Y$ is false IF AND ONLY IF $X$ is True and $Y$ is False.<br>Here, $X$ is $p$. So $p$ must be True.<br>$Y$ is $(q \lor r)$. For $Y$ to be False, both $q$ and $r$ must be False.<br>This yields exactly one row in the truth table: $p=T, q=F, r=F$.<br>For all other 7 assignments, the expression evaluates to True.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic');

-- Q49 â€” Set Theory: Count Subsets (NAT, easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='set-theory' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'If set $A$ contains exactly 5 elements, what is the exact number of proper subsets of $A$?',
  31.00,31.00,NULL,
  '<p><strong>âœ“ Answer: 31.</strong></p><p><strong>Step-by-step:</strong><br>- Total possible subsets generated by the power set is $2^n$. For $n=5$, $2^5 = 32$.<br>- Proper subsets exclude the set itself (which is improper).<br>- Therefore, number of proper subsets = $32 - 1 = 31$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sets');

-- Q50 â€” Combinatorics: Handshakes (NAT, easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='permutations-combinations' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'If there are exactly 12 people at a party and every person shakes hands with every other person exactly once, what is the total number of handshakes?',
  66.00,66.00,NULL,
  '<p><strong>âœ“ Answer: 66.</strong></p><p><strong>Step-by-step:</strong><br>This is choosing 2 people out of 12 for each handshake. Order does not matter.<br>$\binom{12}{2} = \frac{12 \times 11}{2} = 66$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q51 â€” Graph Theory: Total Degrees (NAT, easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'A simple undirected graph possesses exactly 14 edges. What is the sum of the degrees of all its vertices?',
  28.00,28.00,NULL,
  '<p><strong>âœ“ Answer: 28.</strong></p><p><strong>Step-by-step:</strong><br>By the Handshaking Lemma, the sum of degrees $\sum deg(v) = 2 \times E$.<br>Edges $E = 14$.<br>Sum $= 2 \times 14 = 28$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q52 â€” Trees: Nodes from Edges (NAT, medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='trees-properties' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'An undirected tree graph is known to contain exactly 15 edges. How many vertices does it contain?',
  16.00,16.00,NULL,
  '<p><strong>âœ“ Answer: 16.</strong></p><p><strong>Step-by-step:</strong><br>A fundamental property of any tree is that it is a connected acyclic graph. A tree containing $n$ vertices always contains $n - 1$ edges.<br>$E = V - 1$<br>$15 = V - 1 \implies V = 16$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('trees','graphs');

-- Q53 â€” Combinatorics: Integer Partitions (NAT, hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='inclusion-exclusion' LIMIT 1),
  'gate-cse',false,NULL,'NAT','hard',2,
  'Find the total number of integers from 1 to 100 that are divisible by either 3 or 5, but not by both.',
  47.00,47.00,NULL,
  '<p><strong>âœ“ Answer: 47.</strong></p><p><strong>Step-by-step:</strong><br>Let $A$ = divisible by 3, $B$ = divisible by 5. We want $|A| + |B| - 2|A \cap B|$ (symmetric difference).<br>$|A| = \lfloor 100/3 \rfloor = 33$<br>$|B| = \lfloor 100/5 \rfloor = 20$<br>$|A \cap B|$ (divisible by 15) $= \lfloor 100/15 \rfloor = 6$<br>Symmetric difference = $33 + 20 - 2(6) = 53 - 12 = 47$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('combinatorics');

-- Q54 â€” Partial Orders: Number of pairs (NAT, medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relations-properties' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'Consider the set $A = \{1, 2, 3\}$. The relation "less than or equal to" ($\le$) is defined on this set. How many ordered pairs populate this relation?',
  6.00,6.00,NULL,
  '<p><strong>âœ“ Answer: 6.</strong></p><p><strong>Step-by-step:</strong><br>The relation is $R = \{(x, y) \mid x \le y\}$.<br>Evaluating for $A$:<br>For $x=1$: (1,1), (1,2), (1,3)<br>For $x=2$: (2,2), (2,3)<br>For $x=3$: (3,3)<br>Total number of pairs = $3 + 2 + 1 = 6$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations','sets');

-- Q55 â€” Recurrence Evaluation (NAT, easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='recurrence-relations' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'Given $a_n = 2a_{n-1} + 3$ with base case $a_0 = 1$. What is the integer value of $a_3$?',
  29.00,29.00,NULL,
  '<p><strong>âœ“ Answer: 29.</strong></p><p><strong>Step-by-step:</strong><br>Calculate iteratively from base case:<br>$a_0 = 1$<br>$a_1 = 2(1) + 3 = 5$<br>$a_2 = 2(5) + 3 = 13$<br>$a_3 = 2(13) + 3 = 26 + 3 = 29$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recurrence','combinatorics');

-- Part 5 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” DM PYQ SEED v2  (Part 6 / 8)
-- MSQ Questions Q56â€“Q65 (Logic, Groups, Graphs)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Q56 â€” MSQ: Propositional Logic Tautologies (medium)
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
  '<p><strong>âœ“ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> Modus Ponens structure. Always true.<br>- <strong>B:</strong> Hypothetical Syllogism (transitivity of implication). Always true.<br>- <strong>D:</strong> Addition rule. If $p$ is true, $p \lor q$ is definitely true.<br>- <strong>Why C is FALSE:</strong> This asserts that if one is true, both are true. Fails when $p=T, q=F$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','propositional');

-- Q57 â€” MSQ: Set Operations (easy)
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
  '<p><strong>âœ“ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> Standard definition: elements in $A$ AND NOT in $B$.<br>- <strong>B:</strong> Taking $A$ and removing the overlap with $B$ leaves exactly $A - B$.<br>- <strong>C:</strong> The union of $A$ and $B$, minus everything in $B$, leaves exactly the elements unique to $A$.<br>- <strong>Why D is FALSE:</strong> This includes elements not in $B$ that are also not in $A$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sets');

-- Q58 â€” MSQ: Equivalence Relations Properties (medium)
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
  '<p><strong>âœ“ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Modular congruence is the classic textbook equivalence relation. Thus it must be Reflexive, Symmetric, and Transitive.<br><strong>Why D is FALSE:</strong> Antisymmetry fails. $2 \equiv 7 \pmod 5$ and $7 \equiv 2 \pmod 5$, but $2 \neq 7$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relations','sets');

-- Q59 â€” MSQ: Group Theory Abelian characteristics (hard)
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
  '<p><strong>âœ“ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> If $(xy)^2 = e \implies xyxy = e \implies xy = y^{-1}x^{-1} = yx$ (since elements are their own inverse). Thus commutative.<br>- <strong>B:</strong> Every cyclic group $G = \langle a \rangle$ is an Abelian group since $a^i a^j = a^{i+j} = a^j a^i$.<br>- <strong>C:</strong> Every group of prime order is cyclic, and because all cyclic groups are Abelian, prime-order groups are Abelian.<br>- <strong>Why D is FALSE:</strong> Having an identity element is a base requirement for all groups, not a condition for Abelian.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('groups');

-- Q60 â€” MSQ: Handshaking Lemma Corollaries (medium)
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
  '<p><strong>âœ“ Answers: A, B.</strong></p><p><strong>Rationale:</strong> Since $\sum deg(v) = 2E$, the sum is always even (Option B). For the sum to be even, the odd-degree nodes must pair up, meaning there is an even number of odd-degree vertices (Option A). Option C is false because you cannot have exactly 1 odd degree vertex (that sum would be odd). Option D is false because $E$ can be odd, only $2E$ is guaranteed even.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q61 â€” MSQ: Bipartite Graph Requirements (easy)
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
  '<p><strong>âœ“ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Bipartite means the graph can be partitioned into two independent sets (2-colorable). A known theorem states a graph is bipartite if and only if it does not contain any odd-length cycles. Options B and C state the exact same fact. Option D is irrelevant (a star graph is bipartite but can have a degree of $n$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs','matching');

-- Q62 â€” MSQ: Valid Tree Properties (medium)
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
  '<p><strong>âœ“ Answers: A, B, C, D.</strong></p><p><strong>Rationale:</strong> All 4 statements are classically equivalent standard definitions of a tree. Any one of these conditions implies all the other conditions, forming the mathematical definition of a minimally-connected, acyclic structure.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('trees','graphs');

-- Q63 â€” MSQ: First-Order Logic Entailments (hard)
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
  '<p><strong>âœ“ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong><br>- Continuous same quantifiers ($\forall\forall$ or $\exists\exists$) commute.<br>- Option C states: "There is someone who loves everyone $\implies$ Everyone is loved by someone". This is a valid forward deduction.<br>- Option D states: "Everyone loves someone $\implies$ There is someone who is loved by everyone". This is invalid logic (the subset direction does not hold backwards).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('logic','first-order');

-- Q64 â€” MSQ: Planar graph components (medium)
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
  '<p><strong>âœ“ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> This is Kuratowski''s Theorem.<br>- <strong>B:</strong> Standard Euler''s formula for planar faces.<br>- <strong>D:</strong> True, every planar graph has a vertex $deg(v) \le 5$, derived directly from $E \le 3V - 6$.<br>- <strong>Why C is FALSE:</strong> Planar graphs can absolutely contain triangles ($C_3$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('graphs');

-- Q65 â€” MSQ: Functions Composition validities (easy)
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
  '<p><strong>âœ“ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong><br>- The combination of bijections, injectives, or surjectives maintains those properties. (A, B).<br>- If the final map reaches everywhere, the final function $g$ must logically reach everywhere (C).<br>- However, if the composite is injective, only the first function $f$ MUST be injective. Function $g$ does not need to be inherently injective globally outside the codomain of $f$. Thus D is false.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions');

-- Part 6 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” DM PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1: Logic, Sets, Relations (11 Cards)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 1
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='propositional-logic' LIMIT 1),
  'List the Implication equivalences for $p \rightarrow q$.',
  '<ul><li><strong>Equivalence:</strong> $\neg p \lor q$</li><li><strong>Contrapositive:</strong> $\neg q \rightarrow \neg p$</li></ul>',
  ARRAY['logic','propositional']
),
-- Card 2
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='propositional-logic' LIMIT 1),
  'What are Modus Ponens and Modus Tollens?',
  '<ul><li><strong>Modus Ponens:</strong> If $p \rightarrow q$ and $p$ is true, then $q$ is true.</li><li><strong>Modus Tollens:</strong> If $p \rightarrow q$ and $\neg q$ is true, then $\neg p$ is true.</li></ul>',
  ARRAY['logic']
),
-- Card 3
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='logic-proofs' LIMIT 1),
  (SELECT id FROM topics WHERE slug='first-order-logic' LIMIT 1),
  'How do you negate quantifiers in First-Order Logic?',
  '<p><strong>De Morgan''s Laws for Quantifiers:</strong></p><ul><li>$\neg (\forall x P(x)) \equiv \exists x \neg P(x)$</li><li>$\neg (\exists x P(x)) \equiv \forall x \neg P(x)$</li></ul>',
  ARRAY['logic','first-order']
),
-- Card 4
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='set-theory' LIMIT 1),
  'Define Power Set and its cardinality.',
  '<p>The power set $P(A)$ is the set of all subsets of $A$, including the empty set and $A$ itself.</p><p>If $A$ has $N$ elements, $P(A)$ has $2^N$ elements.</p>',
  ARRAY['sets']
),
-- Card 5
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relations-properties' LIMIT 1),
  'Define Equivalence and Partial Order Relations.',
  '<ul><li><strong>Equivalence Relation:</strong> Reflexive, Symmetric, Transitive.</li><li><strong>Partial Order (POSET):</strong> Reflexive, Antisymmetric, Transitive.</li></ul>',
  ARRAY['relations','sets']
),
-- Card 6
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relations-properties' LIMIT 1),
  'What is the formula for the number of reflexive relations on a set of size $N$?',
  '<p>A relation is a subset of an $N \times N$ matrix.</p><p>Reflexive relations require the $N$ diagonal elements to be 1. The remaining $N^2 - N$ elements can be 0 or 1.</p><p>Result: $2^{N^2 - N}$.</p>',
  ARRAY['relations']
),
-- Card 7
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='functions-types' LIMIT 1),
  'Define Injective, Surjective, and Bijective functions.',
  '<ul><li><strong>Injective (One-to-One):</strong> No two inputs map to the same output.</li><li><strong>Surjective (Onto):</strong> Every element in the codomain gets mapped to.</li><li><strong>Bijective:</strong> Both injective and surjective (invertible).</li></ul>',
  ARRAY['functions']
),
-- Card 8
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='lattices-boolean' LIMIT 1),
  'What defines a Lattice?',
  '<p>A partially ordered set (POSET) where every pair of elements has both a unique least upper bound (LUB/Join) and a unique greatest lower bound (GLB/Meet).</p>',
  ARRAY['lattices']
),
-- Card 9
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='group-theory' LIMIT 1),
  'What are the four properties defining a Group?',
  '<ol><li><strong>Closure:</strong> Output stays in the set.</li><li><strong>Associativity:</strong> $(a*b)*c = a*(b*c)$</li><li><strong>Identity:</strong> An element $e$ exists where $a*e = a$.</li><li><strong>Inverse:</strong> Every $a$ has an $a^{-1}$ where $a*a^{-1} = e$.</li></ol>',
  ARRAY['groups']
),
-- Card 10
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='group-theory' LIMIT 1),
  'What is Lagrange''s Theorem in Group Theory?',
  '<p>For any finite group $G$, the order (number of elements) of every subgroup $H$ divides the order of $G$. Consequently, the order of any element also divides the order of the group.</p>',
  ARRAY['groups']
),
-- Card 11
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='sets-relations-functions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relations-properties' LIMIT 1),
  'What is Transitive Closure and how is it found?',
  '<p>The smallest transitive relation containing the original relation. It represents all reachable paths in a graph.</p><p>Typically found using Warshall''s Algorithm in $O(N^3)$ time.</p>',
  ARRAY['relations']
);

-- Part 7 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” DM PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2 (11 Cards) + COMMIT block
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 12
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='pigeonhole-principle' LIMIT 1),
  'What is the Pigeonhole Principle?',
  '<p>If $N$ items are placed into $M$ containers and $N > M$, then at least one container must contain more than one item.</p><p>Formula for minimum items in worst bucket: $\lceil N/M \rceil$.</p>',
  ARRAY['combinatorics']
),
-- Card 13
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='permutations-combinations' LIMIT 1),
  'What is the formula for Derangements $D_n$?',
  '<p>A permutation where no element is in its original position.</p><p>$D_n = n! (1 - 1/1! + 1/2! - 1/3! + ... + (-1)^n/n!)$</p>',
  ARRAY['combinatorics']
),
-- Card 14
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='combinatorics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='inclusion-exclusion' LIMIT 1),
  'State the Principle of Inclusion-Exclusion for 3 sets.',
  '<p>$|A \cup B \cup C| = |A| + |B| + |C|$<br>$- |A \cap B| - |A \cap C| - |B \cap C|$<br>$+ |A \cap B \cap C|$</p>',
  ARRAY['combinatorics']
),
-- Card 15
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'What is the Handshaking Lemma?',
  '<p>In any undirected graph, the sum of all vertex degrees equals twice the number of edges: $\sum deg(V) = 2E$.</p><p>Corollary: The number of vertices with an odd degree must be even.</p>',
  ARRAY['graphs']
),
-- Card 16
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='connectivity-paths' LIMIT 1),
  'Compare Eulerian and Hamiltonian graphs.',
  '<ul><li><strong>Eulerian Circuit:</strong> Visits every edge exactly once. Requires all vertices to have an even degree.</li><li><strong>Hamiltonian Cycle:</strong> Visits every vertex exactly once. More complex to prove (Dirac''s or Ore''s theorem).</li></ul>',
  ARRAY['graphs']
),
-- Card 17
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='planar-graphs' LIMIT 1),
  'State Euler''s Formula for connected Planar Graphs.',
  '<p><strong>$V - E + F = 2$</strong></p><p>Where $V$ is vertices, $E$ is edges, and $F$ is faces/regions (including the infinite outer region).</p>',
  ARRAY['graphs']
),
-- Card 18
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='trees-properties' LIMIT 1),
  'What are the core properties defining a Tree?',
  '<ul><li>An undirected, connected, acyclic graph.</li><li>Has $N$ vertices and exactly $N-1$ edges.</li><li>Adding any edge creates exactly one cycle.</li><li>Exactly one path exists between any two vertices.</li></ul>',
  ARRAY['trees','graphs']
),
-- Card 19
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-coloring' LIMIT 1),
  'What is the Chromatic Number of a Bipartite Graphic?',
  '<p><strong>Exactly 2.</strong></p><p>A graph is bipartite if and only if it does not contain any odd-length cycles. The vertices can be partitioned into two independent sets with no edges inside the sets.</p>',
  ARRAY['graphs','matching']
),
-- Card 20
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='graph-basics' LIMIT 1),
  'How many edges are in $K_N$ and $K_{M,N}$?',
  '<ul><li><strong>Complete Graph $K_N$:</strong> $\frac{N(N-1)}{2}$ edges.</li><li><strong>Complete Bipartite Graph $K_{M,N}$:</strong> $M \times N$ edges.</li></ul>',
  ARRAY['graphs']
),
-- Card 21
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='planar-graphs' LIMIT 1),
  'What is Kuratowski''s Theorem?',
  '<p>A graph is planar if and only if it does not contain any subgraph that is homeomorphic (edge subdivision) to $K_5$ (complete graph on 5 vertices) or $K_{3,3}$ (complete bipartite graph on 3+3 vertices).</p>',
  ARRAY['graphs']
),
-- Card 22
(
  (SELECT id FROM subjects WHERE slug='dm'),
  (SELECT id FROM chapters WHERE slug='graph-theory' LIMIT 1),
  (SELECT id FROM topics WHERE slug='matching' LIMIT 1),
  'What is the relationship between Maximum Independent Set ($\alpha$) and Minimum Vertex Cover ($\beta$)?',
  '<p><strong>Gallai''s Theorem:</strong> For a graph without isolated vertices, the sum of the independence number and the vertex cover number equals the total number of vertices.</p><p>$\alpha + \beta = |V|$</p>',
  ARRAY['matching','graphs']
);

COMMIT;

-- â”€â”€â”€ POST-SEED VERIFICATION QUERIES â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
-- Run these after executing dm-seed.sql to verify correctness:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='dm'));
-- Expected: 20
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dm');
-- Expected: 65
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dm');
-- Expected: 22
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='dm')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10

-- â”€â”€â”€ STATS COMMENT BLOCK â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
-- STATS:
-- Subject slug: dm
-- Schema version: v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- Chapters:     4 (Logic, Sets, Combinatorics, Graphs)
-- Topics:       20
-- Questions:    65 total
--   MCQ:        45 (Q1â€“Q45)
--   NAT:        10 (Q46â€“Q55)
--   MSQ:        10 (Q56â€“Q65)
-- Flashcards:   22 concise mathematical theory cards
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- END OF dm-seed.sql
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
