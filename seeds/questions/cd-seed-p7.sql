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
