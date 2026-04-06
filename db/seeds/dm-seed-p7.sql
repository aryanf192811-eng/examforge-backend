-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DM PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1: Logic, Sets, Relations (11 Cards)
-- ═══════════════════════════════════════════════════════════════════════════

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
