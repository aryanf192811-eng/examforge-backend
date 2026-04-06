-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DL PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1: Combinational Logic (11 Cards)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES

-- Card 1
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='boolean-laws' LIMIT 1),
  'What is the Consensus Theorem mathematically?',
  '<p>$AB + \bar{A}C + BC = AB + \bar{A}C$<br>The third term ($BC$) evaluates as mathematically redundant because whenever $B$ and $C$ are true, $A$ must be either 1 or 0, satisfying one of the first two terms anyway.</p>',
  ARRAY['boolean-algebra']
),

-- Card 2
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='k-maps' LIMIT 1),
  'Define a Prime Implicant vs an Essential Prime Implicant in a K-Map.',
  '<p><strong>Prime Implicant:</strong> A valid group of adjacent 1s that is as large as geometrically possible. It cannot be fully encompassed by a larger group.<br><strong>Essential Prime Implicant:</strong> A Prime Implicant that covers at least one minterm (a ''1'') that is absolutely NOT covered by any other group. It must appear in the final minimized expression.</p>',
  ARRAY['k-map']
),

-- Card 3
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='logic-gates' LIMIT 1),
  'Why are NAND and NOR classified as Universal Gates?',
  '<p>Because any arbitrary Boolean logic function (AND, OR, NOT, XOR) can be constructed structurally using exclusively NAND gates or exclusively NOR gates, without requiring any other type of underlying logic gate.</p>',
  ARRAY['boolean-algebra']
),

-- Card 4
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='adders-sub' LIMIT 1),
  'What are the Boolean expressions for a Full Adder ($S$, $C_{out}$)?',
  '<p><strong>Sum:</strong> $S = A \oplus B \oplus C_{in}$<br><strong>Carry Out:</strong> $C_{out} = AB + B C_{in} + A C_{in}$</p>',
  ARRAY['boolean-algebra']
),

-- Card 5
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='circuit-delay' LIMIT 1),
  'What is a Static Hazard in a combinational logic circuit?',
  '<p>A Static Hazard is a momentary glitch where the output of a combinatorial circuit transitions incorrectly (e.g., 1 to 0 back to 1) due to asymmetrical signal propagation delays down different logic pathways. It is resolvable by adding redundant consensus terms to the K-Map design.</p>',
  ARRAY['dl-delay']
),

-- Card 6
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='multiplexers' LIMIT 1),
  'How many $2$-to-$1$ Multiplexers are needed to build an $n$-to-$1$ Multiplexer?',
  '<p>Building an $n$-to-$1$ MUX fundamentally requires exactly $(n-1)$ distinct $2$-to-$1$ multiplexers arranged in a binary structural tree (e.g., an 8-to-1 MUX requires 7 MUXes).</p>',
  ARRAY['multiplexer']
),

-- Card 7
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='combinational' LIMIT 1),
  (SELECT id FROM topics WHERE slug='decoders' LIMIT 1),
  'How does a Decoder implement Boolean logic functions?',
  '<p>An $n$-to-$2^n$ decoder correctly generates all $2^n$ possible minterms for $n$ variables on its output lines. A Boolean function can simply be implemented by passing the decoder outputs corresponding to the required minterms directly into external OR gates.</p>',
  ARRAY['boolean-algebra']
),

-- Card 8
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='signed-numbers' LIMIT 1),
  'What is the formula for the range of an $n$-bit 2''s complement number?',
  '<p>The range spans asymetrically from strictly $- (2^{n-1})$ through $+ (2^{n-1} - 1)$. For $n=8$ bits, it represents $-128$ through $+127$.</p>',
  ARRAY['number-system']
),

-- Card 9
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='signed-numbers' LIMIT 1),
  'How does hardware detect Arithmetic Overflow during 2''s complement addition?',
  '<p>Overflow theoretically occurs precisely when the Carry-In to the Most Significant Bit ($MSB$) differs from the Carry-Out of the MSB. Specifically computed as: $C_{in} \oplus C_{out} = 1$.</p>',
  ARRAY['number-system']
),

-- Card 10
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='numbers-converters' LIMIT 1),
  (SELECT id FROM topics WHERE slug='number-systems' LIMIT 1),
  'How do you convert a Binary string into a Gray Code string?',
  '<p>The Most Significant Bit (MSB) simply copies directly down. For every subsequent lower bit index $i$: $Gray_i = Binary_i \oplus Binary_{i+1}$. Essentially, XOR each bit mathematically with the bit to its immediate left.</p>',
  ARRAY['number-system']
),

-- Card 11
(
  (SELECT id FROM subjects WHERE slug='dl'),
  (SELECT id FROM chapters WHERE slug='boolean-logic' LIMIT 1),
  (SELECT id FROM topics WHERE slug='boolean-laws' LIMIT 1),
  'State De Morgan''s Theorems.',
  '<p>1. The complement of a physical product is the sum of the complements: $\overline{(A \cdot B)} = \bar{A} + \bar{B}$<br>2. The complement of a physical sum is the product of the complements: $\overline{(A + B)} = \bar{A} \cdot \bar{B}$</p>',
  ARRAY['boolean-algebra']
);

-- Part 7 Complete.
