-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — EM PYQ SEED v2 (Part 6 / 8)
-- MSQ Questions Q56–Q65 (Linear Algebra, Calculus, Probability)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q56 — MSQ: Rank Properties (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
 (SELECT id FROM topics WHERE slug='matrix-inverse-rank' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Which of the following statements about the defined Rank of a matrix $A$ are TRUE? (Select all that apply)',
 'Rank($A$) = Rank($A^T$)',
 'Rank($A + B$) $\le$ Rank($A$) + Rank($B$)',
 'Rank($AB$) = Rank($A$) $\times$ Rank($B$)',
 'If $A$ is an $n \times n$ matrix, Rank($A$) = $n$ if and only if $|A| \neq 0$',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> Row rank always exactly equals column rank. Thus, transposition does not alter rank.<br>- <strong>B:</strong> The rank of a sum is bounded by the sum of their individual ranks (subadditivity property).<br>- <strong>D:</strong> A square matrix has full rank if and only if its determinant is non-zero (non-singular).</p><p><strong>Why C is FALSE:</strong> The rank of a product is rigidly bounded by Sylvester''s inequality: Rank($AB$) $\le \min(\text{Rank}(A), \text{Rank}(B))$. It is definitely not the multiplier product.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Q57 — MSQ: Independent Events (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='basic-probability' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Let $A$ and $B$ be independent probability events with $P(A) > 0$ and $P(B) > 0$. Which of the following equations hold true? (Select all that apply)',
 '$P(A \cap B) = P(A) \times P(B)$',
 '$P(A | B) = P(A)$',
 '$P(A \cup B) = P(A) + P(B)$',
 '$P(A) = 1 - P(B)$',
 ARRAY['A','B'],
 '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> Independence mathematically dictates that the occurrence of $B$ yields literally zero information about $A$.<br>- <strong>A:</strong> The defining formula for complete independence: the intersection probability is their product.<br>- <strong>B:</strong> Conditional probability $P(A|B)$ equals the outright marginal probability $P(A)$.</p><p><strong>Why C is FALSE:</strong> This is the formula for Mutually Exclusive events, NOT independent events (intersection would be 0, which contradicts $P(A)P(B) > 0$).<br><strong>Why D is FALSE:</strong> This implies $A$ is the precise complement of $B$, which is dependent.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q58 — MSQ: Eigenvalues of special matrices (hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
 (SELECT id FROM topics WHERE slug='eigenvalues-eigenvectors' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','hard',2,
 'Which of the following absolute statements intricately relating matrix types to their eigenvalues are correct? (Select all that apply)',
 'The eigenvalues of a real symmetric matrix are real',
 'The eigenvalues of a real skew-symmetric matrix are imaginary or zero',
 'The eigenvalues of an orthogonal matrix have an absolute magnitude equal to 1',
 'The eigenvalues of an identity matrix $I_n$ are $n$ distinct integer values',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> These are robust fundamental spectral theorems.<br>- <strong>A:</strong> True. Essential property of Hermitian / real symmetric tables.<br>- <strong>B:</strong> True. Skew-symmetric matrices ($A^T = -A$) yield imaginary (or zero) eigenvalues.<br>- <strong>C:</strong> True. Orthogonal matrices preserve vector lengths , thus their eigenvalues must lie exactly on the unit circle in the complex plane ($|\lambda| = 1$).</p><p><strong>Why D is FALSE:</strong> The identity matrix $I_n$ has exactly ONE eigenvalue ($1$) repeated $n$ times (algebraic multiplicity of $n$). They are certainly not distinct.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q59 — MSQ: Limits and Continuity (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
 (SELECT id FROM topics WHERE slug='continuity' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'For a given mathematical function $f(x)$ to be rigidly continuous exactly at a point $x=c$, which of the following criteria MUST be satisfied? (Select all that apply)',
 '$f(c)$ must be defined (must exist)',
 'The right-hand limit $\lim_{x \to c^+} f(x)$ must exist',
 'The left-hand limit $\lim_{x \to c^-} f(x)$ must exist',
 'The left-hand limit must perfectly equal the right-hand limit, and both must equal $f(c)$',
 ARRAY['A','B','C','D'],
 '<p><strong>✓ Answers: A, B, C, D.</strong></p><p><strong>Rationale:</strong> The formal robust definition of pointwise continuity mandates that ALL these intricately linked conditions hold. If the limit exists (requiring LHL=RHL), and the function value exists, they must mutually converge to the same identical value at $x=c$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits');

-- Q60 — MSQ: Probability Distributions (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='random-variables' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'Which of the categorized probability distributions below model DISCRETE random variables? (Select all that apply)',
 'Binomial Distribution',
 'Poisson Distribution',
 'Normal (Gaussian) Distribution',
 'Exponential Distribution',
 ARRAY['A','B'],
 '<p><strong>✓ Answers: A, B.</strong></p><p><strong>Rationale:</strong> Discrete distributions handle countable quantities (e.g., integer numbers like "heads in 10 flips" or "events per hour"). Binomial and Poisson fiercely fit this explicit definition.</p><p><strong>Why C and D are FALSE:</strong> Normal and Exponential distributions model <em>continuous</em> variables (like exact fluid height, infinite-precision lifespan, or measurable temperature) defined over an interval range using Probability Density Functions (PDFs).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions');

-- Q61 — MSQ: Linear Equations Consistencies (hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
 (SELECT id FROM topics WHERE slug='linear-equations' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','hard',2,
 'Consider exclusively a Homogeneous linear system $AX = 0$ consisting of $m$ broadly unique equations containing $n$ variables. Which statements are logically correct? (Select all that apply)',
 'The system is always rigidly consistent (never has "no solution")',
 'If $n > m$, the system has infinitely many non-trivial solutions',
 'If $\text{Rank}(A) = n$, the system possesses ONLY the trivial solution $(X=0)$',
 'If $\text{Rank}(A) < n$, the determinant of $A$ (if $m=n$) is non-zero',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Homogeneous systems anchor on the $B=0$ vector.<br>- <strong>A:</strong> X=0 is ALWAYS a valid trivial solution, preventing inconsistency.<br>- <strong>B:</strong> If variables outnumber equations ($n > m$), the rank can never reach $n$, leaving rigidly free variables, thereby unleashing infinitely many solutions.<br>- <strong>C:</strong> A full rank ($r=n$) locks down exactly 0 free variables, forcing the $X=0$ unique trivial solution.</p><p><strong>Why D is FALSE:</strong> If Rank $< n$ in a square array context, the matrix is singular, dictating that $|A|$ is EXACTLY zero.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('system-of-equations','matrix');

-- Q62 — MSQ: Positive Definite Matrices (hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
 (SELECT id FROM topics WHERE slug='eigenvalues-eigenvectors' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','hard',2,
 'A real symmetric matrix $A$ is certified as Positive Definite. Which profound mathematical constraints intrinsically apply to $A$? (Select all that apply)',
 'Exactly every single eigenvalue of $A$ is greater than 0',
 'The extensive determinant $|A|$ is positive ($|A| > 0$)',
 'All diagonal elements are positive ($A_{ii} > 0$)',
 '$x^T A x \ge 0$ for all non-zero vectors $x$',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> The defining identity of Positive Definite systems:<br>- <strong>A:</strong> positive eigenvalues ($\lambda_i > 0$) define the core characteristic.<br>- <strong>B:</strong> Determinant is broadly the product of positive eigenvalues, thereby staying positive.<br>- <strong>C:</strong> An strict mathematical consequence demands all main-axis diagonal trace inputs intrinsically exceed zero.</p><p><strong>Why D is FALSE:</strong> Positive Definite means $x^T A x > 0$. The $\ge$ inclusive inequality rigidly corresponds to a Positive <em>SEMI-Definite</em> matrix, which vastly tolerates exactly zero eigenvalues.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q63 — MSQ: Taylor Series derivatives (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
 (SELECT id FROM topics WHERE slug='derivatives' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Which of the listed functions famously maintain identical forms when derived an infinite number of times? (Select all that apply)',
 '$f(x) = e^x$',
 '$f(x) = \sin(x)$',
 '$f(x) = 0$',
 '$f(x) = x^n$',
 ARRAY['A','C'],
 '<p><strong>✓ Answers: A, C.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> The derivative of pure $e^x$ unambiguously remains exactly $e^x$ infinitely.<br>- <strong>C:</strong> The derivative of exactly 0 is permanently exactly 0 globally.</p><p><strong>Why B and D are FALSE:</strong> Sine oscillates cyclically to cosine, -sine, -cosine. Polynomial $x^n$ permanently diminishes forcefully down to exactly 0 after $n+1$ operations, drastically destroying the original identical structure .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('derivatives');

-- Q64 — MSQ: Bayes parameters (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='bayes-theorem-topic' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'In the classic exhaustive Bayes'' Theorem equation extensively isolating $P(A|B)$, which core distinct probability identities are fundamentally required? (Select all that apply)',
 'The defined Prior probability $P(A)$',
 'The extensively modeled Likelihood factor $P(B|A)$',
 'The vast Marginal probability $P(B)$',
 'The bounded Joint expectation $E[AB]$',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Bayes'' widely celebrated Theorem asserts: $P(A|B) = \frac{P(B|A) \times P(A)}{P(B)}$.<br>This commands utilizing exactly: Prior ($P(A)$), defined Likelihood ($P(B|A)$), and comprehensive Marginal normalizer ($P(B)$) .</p><p><strong>Why D is FALSE:</strong> Expected values govern heavy variance frameworks, bypassing fundamental pure combinatoric or continuous probabilistic frequency dependencies isolated in pure Bayesian logic .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability','bayes-theorem');

-- Q65 — MSQ: Extreme point constraints (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_options,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
 (SELECT id FROM topics WHERE slug='maxima-minima' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'To properly accurately detect an intense Local Maximum on a function graph, which extremely verified derivative thresholds must be exactly met? (Select all that apply)',
 'The constructed First Derivative zeroes ($f''(c) = 0$)',
 'The structured Second Derivative registers ($f''''(c) > 0$)',
 'The mapped Second Derivative plummets negatively ($f''''(c) < 0$)',
 'The evaluated Third Derivative perfectly hits zero ($f''''''(c) = 0$)',
 ARRAY['A','C'],
 '<p><strong>✓ Answers: A, C.</strong></p><p><strong>Rationale:</strong> To isolate exactly a Local Maximum globally:<br>- First step: The tangent slope flatlines. (First constraint $f''(c) = 0$).<br>- Second step: The curve bends downward globally identical to a dome. (Second constraint $f''''(c) < 0$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('maxima-minima','derivatives');

-- Part 6 complete.
