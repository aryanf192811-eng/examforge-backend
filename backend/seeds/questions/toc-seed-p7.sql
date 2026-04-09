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
