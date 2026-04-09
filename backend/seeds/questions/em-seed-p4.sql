-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — EM PYQ SEED v2 (Part 4 / 8)
-- MCQ Questions Q29–Q45 (Probability & Statistics)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q29 — Conditional Probability (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='conditional-prob' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Given $P(A) = 0.5$, $P(B) = 0.4$, and $P(A \cap B) = 0.2$. What is $P(A | B)$?',
 '0.5',
 '0.4',
 '0.2',
 '0.8',
 'A',
 '<p><strong>✓ Answer: A — 0.5.</strong></p><p><strong>Step-by-step:</strong> The formula for conditional probability is $P(A|B) = \frac{P(A \cap B)}{P(B)}$.<br>Substitute the values: $\frac{0.2}{0.4} = \frac{1}{2} = 0.5$.</p><p><strong>Sub-note:</strong> Notice that $P(A|B) = 0.5 = P(A)$. This mathematically proves that events A and B are <strong>independent</strong>!</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q30 — Mutually Exclusive Events (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='basic-probability' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'If two events $A$ and $B$ are Mutually Exclusive (and $P(A)>0, P(B)>0$), which of the following is true?',
 '$P(A \cap B) = P(A)P(B)$',
 '$P(A \cup B) = 1$',
 '$P(A | B) = 0$',
 '$P(A) + P(B) = 1$',
 'C',
 '<p><strong>✓ Answer: C — $P(A | B) = 0$.</strong></p><p><strong>Step-by-step:</strong> "Mutually Exclusive" means the occurrences cannot happen at the same time. Thus, their intersection is empty: $A \cap B = \emptyset \implies P(A \cap B) = 0$.<br>Plugging this into conditional probability: $P(A|B) = \frac{P(A \cap B)}{P(B)} = \frac{0}{P(B)} = 0$.</p><p><strong>GATE trap:</strong> Many confuse mutually exclusive with independent. If they are mutually exclusive, they are highly dependent (if B happens, A is guaranteed NOT to happen, hence $P(A|B)=0$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q31 — Bayes Theorem (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='bayes-theorem-topic' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'A box contains 2 coins: one fair coin, and one biased coin (both sides are Heads). A coin is chosen at random and flipped. It lands Heads. What is the probability that the biased coin was chosen?',
 '1/2',
 '1/3',
 '2/3',
 '3/4',
 'C',
 '<p><strong>✓ Answer: C — 2/3.</strong></p><p><strong>Step-by-step (Bayes'' Theorem):</strong><br>Let $B$ = Chose Biased coin. $P(B) = 1/2$.<br>Let $F$ = Chose Fair coin. $P(F) = 1/2$.<br>Let $H$ = Observation of Heads.<br>$P(H|B) = 1$ (biased coin is always heads).<br>$P(H|F) = 1/2$ (fair coin is 50% heads).<br>We want to find $P(B|H)$.<br>Formula: $P(B|H) = \frac{P(H|B)P(B)}{P(H|B)P(B) + P(H|F)P(F)}$<br>Numerator = $1 \times (1/2) = 1/2$.<br>Denominator = $(1 \times 1/2) + (1/2 \times 1/2) = 1/2 + 1/4 = 3/4$.<br>Result = $\frac{1/2}{3/4} = \frac{2}{3}$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability','bayes-theorem');

-- Q32 — Expected Value Properties (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='statistics-basics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Let $X$ and $Y$ be two independent random variables. Which of the following is NOT guaranteed?',
 '$E[X+Y] = E[X] + E[Y]$',
 '$var(X+Y) = var(X) + var(Y)$',
 '$E[XY] = E[X] E[Y]$',
 '$var(XY) = var(X) var(Y)$',
 'D',
 '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong><br>- <strong>A</strong> is True: Expectation is linear, regardless of independence.<br>- <strong>B</strong> is True: Variances add if the variables are independent (covariance is 0).<br>- <strong>C</strong> is True: The expectation of a product factors for independent variables.<br>- <strong>D</strong> is False. The variance of a product of independent variables is $var(XY) = E[X^2]E[Y^2] - (E[X]E[Y])^2$. This is NOT equal to $var(X) \times var(Y)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('statistics','random-variable');

-- Q33 — Binomial Distribution (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='discrete-distributions' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'A biased coin has probability $p$ of landing heads. If flipped $n$ times, what is the exact Variance of the number of heads?',
 '$np$',
 '$np(1-p)$',
 '$\sqrt{np(1-p)}$',
 '$n(1-p)$',
 'B',
 '<p><strong>✓ Answer: B — $np(1-p)$.</strong></p><p><strong>Rationale:</strong> For a Binomial distribution $B(n, p)$:<br>- <strong>Mean / Expected Value:</strong> $E[X] = np$<br>- <strong>Variance:</strong> $var(X) = npq$ where $q = 1-p$. So $np(1-p)$.<br>- <strong>Standard Deviation:</strong> $\sqrt{np(1-p)}$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions','statistics');

-- Q34 — Poisson Limit Theorem (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='discrete-distributions' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'The Poisson distribution can closely approximate a Binomial distribution $B(n, p)$. Under what strict mathematical conditions is this approximation robust?',
 '$n$ is large, $p$ is large (close to 1)',
 '$n$ is small, $p$ is small',
 '$n$ is large, $p$ is very small, such that $\lambda = np$ is finite',
 '$n$ is small, $p$ is exactly 0.5',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The Poisson Limit Theorem states that as $n \to \infty$ and $p \to 0$, while their product $np = \lambda$ remains constant, the Binomial distribution converges perfectly into the Poisson distribution. This is why Poisson is used to model extremely rare events occurring over a vast number of trials (e.g., radioactive decay, network packet drops).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions');

-- Q35 — Exponential Distribution Memoryless (hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='continuous-distributions' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'Let $X$ be an exponentially distributed continuous random variable modeling a server''s lifespan. Given it has already survived $t$ hours, what is the probability it survives to $t+s$ hours?',
 '$P(X > t+s)$',
 '$P(X > s)$',
 '$P(X > t) \times P(X > s)$',
 '$1 - P(X > s)$',
 'B',
 '<p><strong>✓ Answer: B — $P(X > s)$.</strong></p><p><strong>Step-by-step:</strong> This tests the fundamental "Memoryless Property" unique to the Exponential Distribution for continuous variables (and Geometric for discrete).<br>Mathematically: $P(X > t+s \mid X > t) = P(X > s)$.<br>In plain English: The machine does not "age". Survival for the next $s$ hours is independent of the fact that it has already survived $t$ hours.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions','random-variable');

-- Q36 — Uniform Distribution PDF (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='continuous-distributions' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'If $X$ is a continuous uniform random variable defined on $[a, b]$, what is the strict Variance of $X$?',
 '$\frac{b-a}{2}$',
 '$\frac{b-a}{12}$',
 '$\frac{(b-a)^2}{12}$',
 '$\frac{(b+a)^2}{12}$',
 'C',
 '<p><strong>✓ Answer: C — $\frac{(b-a)^2}{12}$.</strong></p><p><strong>Step-by-step:</strong> By definition, the probability density function (PDF) is $f(x) = \frac{1}{b-a}$.<br>Mean $E[X] = \frac{a+b}{2}$.<br>To find Variance: $E[X^2] - (E[X])^2$.<br>$E[X^2] = \int_a^b x^2 \frac{1}{b-a} dx = \frac{b^3 - a^3}{3(b-a)} = \frac{b^2 + ab + a^2}{3}$.<br>Subtracting the squared mean gives $\frac{(b-a)^2}{12}$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions','statistics');

-- Q37 — Normal Distribution Empirical Rule (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='normal-distribution' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'For a perfectly Normal Distribution curve, approximately what percentage of the data falls within one standard deviation ($\mu \pm \sigma$) of the mean?',
 '50%',
 '68%',
 '95%',
 '99.7%',
 'B',
 '<p><strong>✓ Answer: B — 68%.</strong></p><p><strong>Rationale:</strong> The 68-95-99.7 empirical rule states:<br>- $\approx 68.27\%$ of values fall within 1 SD ($1\sigma$).<br>- $\approx 95.45\%$ within 2 SDs ($2\sigma$).<br>- $\approx 99.73\%$ within 3 SDs ($3\sigma$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions','statistics');

-- Q38 — Independent vs Uncorrelated (hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='statistics-basics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'If two random variables $X$ and $Y$ have a Covariance of zero ($cov(A,B) = 0$), which conclusion can be drawn unambiguously?',
 '$X$ and $Y$ are Independent',
 '$X$ and $Y$ are uncorrelated linearly',
 '$X$ and $Y$ have zero Variance',
 'The system is deterministic',
 'B',
 '<p><strong>✓ Answer: B — $X$ and $Y$ are uncorrelated linearly.</strong></p><p><strong>Step-by-step:</strong><br>- Covariance measures LINEAR dependence.<br>- If variables are independent, they are GUARANTEED to be uncorrelated ($Cov=0$).<br>- HOWEVER, if uncorrelated ($Cov=0$), they might still be dependent in a non-linear way (e.g., $Y = X^2$ symmetrically around 0 yields $Cov(X,Y)=0$, yet $Y$ is dependent on $X$).<br>Thus, $Cov=0$ proves only linear uncorrelation, NOT full independence.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('statistics','random-variable');

-- Q39 — Total Probability (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='bayes-theorem-topic' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Factory A produces 60% of chips, Factory B produces 40%. Defect rates are 1% for A and 5% for B. If a random chip is selected, what is the exact probability it is defective?',
 '0.06',
 '0.026',
 '0.03',
 '0.024',
 'B',
 '<p><strong>✓ Answer: B — 0.026.</strong></p><p><strong>Step-by-step (Law of Total Probability):</strong><br>Let $D$ = probability of defect.<br>$P(D) = P(D|A)P(A) + P(D|B)P(B)$<br>$P(D) = (0.01 \times 0.60) + (0.05 \times 0.40)$<br>$P(D) = 0.006 + 0.020$<br>$P(D) = 0.026$ (which is 2.6%).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q40 — Random Variables integration (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='random-variables' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Let $f(x) = cx^2$ for $0 < x < 3$ be a valid continuous Probability Density Function. What must be the scalar value of $c$?',
 '1/9',
 '1/3',
 '3',
 '9',
 'A',
 '<p><strong>✓ Answer: A — 1/9.</strong></p><p><strong>Step-by-step:</strong> For $f(x)$ to be a valid PDF, the total area under the curve across its entire domain MUST equal exactly 1.<br>Integrate: $\int_0^3 c x^2 dx = 1$<br>$c \left[ \frac{x^3}{3} \right]_0^3 = 1$<br>$c \left(\frac{27}{3} - 0\right) = 1$<br>$9c = 1 \implies c = 1/9$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('random-variable','integration');

-- Q41 — Matrix Eigenvalue shift (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
 (SELECT id FROM topics WHERE slug='eigenvalues-eigenvectors' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'If $A$ is an $n \times n$ matrix with an eigenvalue $\lambda$, and $I$ is the identity matrix, what is an eigenvalue of the matrix $(A - 5I)$?',
 '$\lambda$',
 '$\lambda - 5$',
 '$5\lambda$',
 '$\lambda / 5$',
 'B',
 '<p><strong>✓ Answer: B — $\lambda - 5$.</strong></p><p><strong>Step-by-step:</strong> Start at definition: $Ax = \lambda x$.<br>Subtract $5x$ from both sides: $Ax - 5x = \lambda x - 5x$.<br>Factor out $x$ on both sides: $(A - 5I)x = (\lambda - 5)x$.<br>This proves that $(\lambda - 5)$ is the eigenvalue for the shifted matrix $(A - 5I)$, keeping the same eigenvector $x$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q42 — Definite Integral Limit (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
 (SELECT id FROM topics WHERE slug='integration' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Using L''Hopital and Leibniz Rule to evaluate $\lim_{x \to 0} \frac{1}{x} \int_0^x \cos(t) dt$',
 '0',
 '1',
 '-1',
 '$\infty$',
 'B',
 '<p><strong>✓ Answer: B — 1.</strong></p><p><strong>Step-by-step:</strong><br>Limit evaluates to $\frac{\int_0^0}{0} = 0/0$. We apply L''Hôpital.<br>Numerator derivative: By Fundamental Theorem of Calculus/Leibniz rule, $\frac{d}{dx} \int_0^x \cos t dt = \cos(x)$.<br>Denominator derivative: $\frac{d}{dx} x = 1$.<br>Evaluate limit at $x=0$: $\frac{\cos(0)}{1} = \frac{1}{1} = 1$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration','limits');

-- Q43 — Random Variable Sum Variance (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='statistics-basics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Let $X = 3Y + 5$, where $Y$ is a random variable with Variance 10. What is the exact Variance of $X$?',
 '35',
 '30',
 '90',
 '95',
 'C',
 '<p><strong>✓ Answer: C — 90.</strong></p><p><strong>Step-by-step:</strong> The property of variance for a linear transformation $X = aY + b$ is given by $var(X) = a^2 var(Y)$. Constants ($b$) evaporate because variance measures spread, not shifts.<br>Here $a = 3$, so $a^2 = 9$.<br>$var(X) = 9 \times 10 = 90$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('statistics','random-variable');

-- Q44 — Continuous Continuity test (medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
 (SELECT id FROM topics WHERE slug='continuity' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Consider $f(x) = x \sin(1/x)$ for $x \neq 0$ and $f(0) = 0$. Is this function continuous and differentiable at exactly $x=0$?',
 'Continuous and Differentiable',
 'Continuous but NOT Differentiable',
 'Differentiable but NOT Continuous',
 'Neither',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Step-by-step:</strong><br>- <strong>Continuity:</strong> Limit $x \to 0$ of $x \sin|1/x|$. Since sine bounds between -1 and 1, applying Squeeze Theorem gives $0 \times (\text{bounded}) = 0$. Since limit matches $f(0)=0$, it is CONTINUOUS.<br>- <strong>Differentiability:</strong> Check derivative $f''(0) = \lim_{h \to 0} \frac{h \sin(1/h) - 0}{h} = \lim_{h \to 0} \sin(1/h)$. This limit fiercely wildly oscillates and does NOT exist. So it is NOT differentiable.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits','derivatives');

-- Q45 — Inverse of 2x2 Matrix (easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
 (SELECT id FROM topics WHERE slug='matrix-inverse-rank' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'The inverse of a $2 \times 2$ matrix with row 1 as $[a, b]$ and row 2 as $[c, d]$ involves swapping elements and negating others. What is the adjugate (adjoint) configuration matrix?',
 'Row 1: $[d, -b]$, Row 2: $[-c, a]$',
 'Row 1: $[a, -b]$, Row 2: $[-c, d]$',
 'Row 1: $[d, c]$, Row 2: $[b, a]$',
 'Row 1: $[-a, -b]$, Row 2: $[-c, -d]$',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The adjoint of a $2 \times 2$ matrix is found quickly by:<br>1. Swapping the elements on the primary diagonal ($a$ and $d$).<br>2. Negating the elements on the secondary diagonal ($b$ and $c$).<br>Resulting matrix: $[d, -b]$ on top, $[-c, a]$ on bottom.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Part 4 complete.
