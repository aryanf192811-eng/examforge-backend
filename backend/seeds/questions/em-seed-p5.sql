-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — EM PYQ SEED v2 (Part 5 / 8)
-- NAT Questions Q46–Q55 (Linear Algebra, Calculus, Probability)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q46 — Determinant Evaluation (NAT, easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
 (SELECT id FROM topics WHERE slug='determinants' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'Let $A$ be a $2 \times 2$ matrix with $A_{11}=4, A_{12}=3, A_{21}=2, A_{22}=5$. What is the exact value of the determinant of $A$?',
 14.00,14.00,NULL,
 '<p><strong>✓ Answer: 14.</strong></p><p><strong>Step-by-step:</strong><br>For a $2 \times 2$ matrix $\begin{bmatrix} a & b \\ c & d \end{bmatrix}$, the determinant is $ad - bc$.<br>Here $a=4, b=3, c=2, d=5$.<br>$|A| = (4 \times 5) - (3 \times 2) = 20 - 6 = 14$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('determinant');

-- Q47 — Limits by L'Hopital (NAT, medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
 (SELECT id FROM topics WHERE slug='limits' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'Evaluate: $\lim_{x \to 0} \frac{1 - \cos(2x)}{x^2}$. What is the integer result?',
 2.00,2.00,NULL,
 '<p><strong>✓ Answer: 2.</strong></p><p><strong>Step-by-step:</strong><br>Plug $x=0$: $\frac{1-1}{0} = 0/0$. Use L''Hôpital.<br>Derivative of numerator: $0 - (-\sin(2x) \cdot 2) = 2\sin(2x)$.<br>Derivative of denominator: $2x$.<br>New limit: $\lim_{x \to 0} \frac{2\sin(2x)}{2x} = \lim_{x \to 0} \frac{\sin(2x)}{x}$.<br>Plug $x=0$: $0/0$. Use L''Hôpital again.<br>Numerator: $2\cos(2x)$. Denominator: 1.<br>Evaluate at $x=0$: $2 \cos(0) / 1 = 2 \times 1 = 2$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits');

-- Q48 — System of Equations solutions (NAT, medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
 (SELECT id FROM topics WHERE slug='linear-equations' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'Consider the system of equations:<br>$x + y + z = 1$<br>$x + 2y + 3z = 2$<br>$x + y + pz = 1$<br>For what exact value of $p$ does the system have infinitely many solutions?',
 1.00,1.00,NULL,
 '<p><strong>✓ Answer: 1.</strong></p><p><strong>Step-by-step:</strong><br>For infinitely many solutions, the determinant of the coefficient matrix must be 0, AND the augmented matrix must have the same rank.<br>Coefficient matrix $A$:<br>1, 1, 1<br>1, 2, 3<br>1, 1, p<br>$|A| = 1(2p - 3) - 1(p - 3) + 1(1 - 2) = 2p - 3 - p + 3 - 1 = p - 1$<br>Set $|A| = 0 \implies p = 1$.<br>Substitute $p=1$ into equation 3: $x+y+z=1$. This is identical to equation 1. So there are infinitely many solutions (a fully intersecting line of them).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('system-of-equations');

-- Q49 — Definite Integral numeric (NAT, easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
 (SELECT id FROM topics WHERE slug='integration' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'What is the precise value of $\int_0^1 (3x^2 + 2x) dx$?',
 2.00,2.00,NULL,
 '<p><strong>✓ Answer: 2.</strong></p><p><strong>Step-by-step:</strong><br>Integrate term-by-term: $\int 3x^2 dx = x^3$<br>$\int 2x dx = x^2$<br>Antiderivative $= x^3 + x^2$.<br>Evaluate from 0 to 1: $(1^3 + 1^2) - (0 + 0) = 1 + 1 = 2$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration');

-- Q50 — Sum of Eigenvalues (NAT, easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
 (SELECT id FROM topics WHERE slug='eigenvalues-eigenvectors' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'A $3 \times 3$ matrix $A$ has diagonal elements $-5, 12, 3$. What is the precise sum of all three eigenvalues of $A$?',
 10.00,10.00,NULL,
 '<p><strong>✓ Answer: 10.</strong></p><p><strong>Step-by-step:</strong><br>The sum of all eigenvalues of ANY square matrix is equal to the Trace of the matrix.<br>The Trace is simply the sum of its main diagonal elements.<br>Trace $= -5 + 12 + 3 = 10$.<br>Therefore, the sum of the eigenvalues is 10.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q51 — Combinations Probability (NAT, medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='basic-probability' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'An urn contains exactly 5 red balls and 3 blue balls. If two balls are drawn simultaneously without replacement, what is the exact probability (rounded to 2 decimal places) that both will be red?',
 0.35,0.36,NULL,
 '<p><strong>✓ Answer: 0.36.</strong></p><p><strong>Step-by-step:</strong><br>Total balls = $5 + 3 = 8$.<br>Number of ways to choose exactly 2 balls from 8: $\binom{8}{2} = \frac{8 \times 7}{2} = 28$.<br>Number of ways to choose 2 RED balls from the 5 reds: $\binom{5}{2} = \frac{5 \times 4}{2} = 10$.<br>Probability $P = 10 / 28 = 5 / 14 \approx 0.357$.<br>Rounded to two decimal places: 0.36.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q52 — Binomial Distribution expectation (NAT, easy)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='discrete-distributions' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'A student guesses on a 20-question multiple choice test. Each question has exactly 4 options. What is the Expected Number of correct answers?',
 5.00,5.00,'questions',
 '<p><strong>✓ Answer: 5.</strong></p><p><strong>Step-by-step:</strong><br>This is a Binomial Distribution problem. $n = 20$ trials.<br>Probability of guessing $p = 1/4 = 0.25$.<br>Expected value $E[X] = n \times p$<br>$20 \times 0.25 = 5$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions','statistics');

-- Q53 — Partial Derivative computation (NAT, medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
 (SELECT id FROM topics WHERE slug='partial-derivatives' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'Given $f(x, y) = 3x^2y + y^3 - 2x$. What is the direct numerical value of the mixed partial derivative $f_{xy}$ evaluated exactly at the point $(2, 3)$?',
 12.00,12.00,NULL,
 '<p><strong>✓ Answer: 12.</strong></p><p><strong>Step-by-step:</strong><br>1. First, find $f_x$ (treat $y$ as constant):<br>$f_x = \frac{\partial}{\partial x}(3x^2y + y^3 - 2x) = 6xy + 0 - 2 = 6xy - 2$.<br>2. Next, differentiate $f_x$ with respect to $y$:<br>$f_{xy} = \frac{\partial}{\partial y}(6xy - 2) = 6x$.<br>3. Finally evaluate exactly at $x=2$ (the value of $y$ drops out ):<br>$6(2) = 12$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('derivatives');

-- Q54 — Continuous PDF evaluation (NAT, medium)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='random-variables' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'A continuous random variable $X$ has a PDF exclusively defined by $f(x) = 2x$ for $0 \le x \le 1$ and 0 elsewhere. Calculate accurately the exact probability $P(0.5 < X < 1.0)$.',
 0.75,0.75,NULL,
 '<p><strong>✓ Answer: 0.75.</strong></p><p><strong>Step-by-step:</strong><br>The precise probability is the solid integral of the PDF over the requested interval.<br>$P = \int_{0.5}^{1} 2x dx$.<br>Antiderivative: $x^2$.<br>Evaluate fully from 0.5 to 1: $(1)^2 - (0.5)^2 = 1 - 0.25 = 0.75$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('random-variable','integration');

-- Q55 — Variance calculation (NAT, hard)
WITH q AS (INSERT INTO questions
 (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
 question_text,nat_answer_min,nat_answer_max,nat_unit,explanation)
VALUES(
 (SELECT id FROM subjects WHERE slug='em'),
 (SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='statistics-basics' LIMIT 1),
 'gate-cse',false,NULL,'NAT','hard',2,
 'A discrete random variable $X$ has exactly the following uniform probability distribution:<br>$P(X=2) = 0.5$<br>$P(X=4) = 0.5$<br>What is the exact numerical Variance of $X$?',
 1.00,1.00,NULL,
 '<p><strong>✓ Answer: 1.</strong></p><p><strong>Step-by-step:</strong><br>1. Calculate Expected Value (Mean) $E[X]$:<br>$E[X] = (2 \times 0.5) + (4 \times 0.5) = 1 + 2 = 3$.<br>2. Calculate Expected form of Square $E[X^2]$:<br>$E[X^2] = (2^2 \times 0.5) + (4^2 \times 0.5) = (4 \times 0.5) + (16 \times 0.5) = 2 + 8 = 10$.<br>3. Compute fully robust Variance: $var(X) = E[X^2] - (E[X])^2$<br>$var(X) = 10 - 3^2 = 10 - 9 = 1$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('statistics','random-variable');

-- Part 5 complete.
