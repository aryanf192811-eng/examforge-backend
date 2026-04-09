-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — EM PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2: Probability & Statistics (11 Cards) + COMMIT block
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 12
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='basic-probability' LIMIT 1),
  'Compare Mutually Exclusive and Independent Events.',
  '<p><strong>Mutually Exclusive:</strong> $A \cap B = \emptyset$. They cannot happen together. $P(A \cup B) = P(A) + P(B)$.</p><p><strong>Independent:</strong> Occurrence of one does not affect the other. $P(A \cap B) = P(A)P(B)$.</p><p><em>If two events with non-zero probability are Mutually Exclusive, they are DEPENDENT.</em></p>',
  ARRAY['probability']
),
-- Card 13
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bayes-theorem-topic' LIMIT 1),
  'State Bayes'' Theorem and the Law of Total Probability.',
  '<p><strong>Total Probability:</strong> $P(A) = \sum P(A|B_i)P(B_i)$</p><p><strong>Bayes'' Theorem:</strong> Reverses conditional probability.<br>$P(B_i | A) = \frac{P(A | B_i) P(B_i)}{P(A)}$</p>',
  ARRAY['bayes-theorem','probability']
),
-- Card 14
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='random-variables' LIMIT 1),
  'What are the core properties of a valid Probability Density Function (PDF)?',
  '<ul><li><strong>Non-negative:</strong> $f(x) \ge 0$ for all $x$.</li><li><strong>Total Area is 1:</strong> $\int_{-\infty}^{\infty} f(x) dx = 1$.</li><li><strong>Interval Probability:</strong> $P(a \le X \le b) = \int_{a}^{b} f(x) dx$.</li></ul>',
  ARRAY['random-variable','distributions']
),
-- Card 15
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='statistics-basics' LIMIT 1),
  'State the expected value and variance properties for linear transformations $aX + b$.',
  '<p>For a random variable $X$ and constants $a, b$:</p><ul><li><strong>Mean:</strong> $E[aX + b] = aE[X] + b$</li><li><strong>Variance:</strong> $var(aX + b) = a^2 var(X)$</li><li><strong>Standard Deviation:</strong> $\sigma_{aX+b} = |a| \sigma_X$</li></ul>',
  ARRAY['statistics','random-variable']
),
-- Card 16
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='statistics-basics' LIMIT 1),
  'State the expected value and variance properties for independent random variables $X$ and $Y$.',
  '<ul><li><strong>Mean of Sum:</strong> $E[X \pm Y] = E[X] \pm E[Y]$ (true even if dependent)</li><li><strong>Variance of Sum:</strong> $var(X \pm Y) = var(X) + var(Y)$</li><li><strong>Expected Product:</strong> $E[XY] = E[X]E[Y]$</li></ul>',
  ARRAY['statistics','random-variable']
),
-- Card 17
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='distributions' LIMIT 1),
  'What are the Mean and Variance of the Binomial Distribution $B(n, p)$?',
  '<p>For $n$ independent trials with success probability $p$:</p><ul><li><strong>Mean:</strong> $\mu = np$</li><li><strong>Variance:</strong> $\sigma^2 = np(1-p)$</li></ul>',
  ARRAY['distributions','statistics']
),
-- Card 18
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='discrete-distributions' LIMIT 1),
  'What is the relationship between Mean and Variance in a Poisson Distribution?',
  '<p>In a Poisson distribution with parameter $\lambda$:</p><p><strong>Mean = Variance = $\lambda$</strong></p>',
  ARRAY['distributions','statistics']
),
-- Card 19
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='continuous-distributions' LIMIT 1),
  'Explain the Memoryless Property of the Exponential Distribution.',
  '<p>The probability of survival for an additional time $s$ does not depend on the time $t$ already survived.</p><p>$P(X > t+s \mid X > t) = P(X > s)$</p><p><em>Geometric distribution is its discrete counterpart.</em></p>',
  ARRAY['distributions','random-variable']
),
-- Card 20
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='normal-distribution' LIMIT 1),
  'State the Empirical Rule (68-95-99.7) for the Normal Distribution.',
  '<p>For data following a normal distribution:</p><ul><li>$\approx 68\%$ falls within $1\sigma$ of the mean.</li><li>$\approx 95\%$ falls within $2\sigma$ of the mean.</li><li>$\approx 99.7\%$ falls within $3\sigma$ of the mean.</li></ul>',
  ARRAY['distributions','statistics']
),
-- Card 21
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='continuous-distributions' LIMIT 1),
  'What are the Mean and Variance of a Continuous Uniform Distribution on $[a, b]$?',
  '<ul><li><strong>Mean:</strong> $\frac{a+b}{2}$</li><li><strong>Variance:</strong> $\frac{(b-a)^2}{12}$</li><li><strong>PDF:</strong> $f(x) = \frac{1}{b-a}$</li></ul>',
  ARRAY['distributions','statistics']
),
-- Card 22
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
  (SELECT id FROM topics WHERE slug='discrete-distributions' LIMIT 1),
  'When does the Poisson Limit Theorem apply to a Binomial Distribution?',
  '<p>The Poisson distribution approximates the Binomial distribution when:</p><ul><li>The number of trials $n \to \infty$ is very large.</li><li>The success probability $p \to 0$ is very small.</li><li>Their product $np = \lambda$ remains a moderate constant.</li></ul>',
  ARRAY['distributions']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing em-seed.sql to verify correctness:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='em'));
-- Expected: 22
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='em');
-- Expected: 65
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='em');
-- Expected: 22
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='em')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug: em
-- Schema version: v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- Chapters:     3 (Linear Algebra, Calculus, Probability & Statistics)
-- Topics:       22
-- Questions:    65 total
--   MCQ:        45 (Q1–Q45)
--   NAT:        10 (Q46–Q55)
--   MSQ:        10 (Q56–Q65)
-- Flashcards:   22 concise mathematical theory cards
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF em-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
