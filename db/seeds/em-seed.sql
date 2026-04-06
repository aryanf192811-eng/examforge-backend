-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” EM PYQ SEED v2  (Part 1 / 8)
-- Subject : Engineering Mathematics | Exam: gate-cse | Branch: cse
-- Schema  : v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
BEGIN;

-- â”€â”€ Subject â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO subjects (slug,name,category,branch_slug,icon,order_index,is_published,exam_weight_pct)
VALUES ('em','Engineering Mathematics','GATE','cse','ðŸ“',3,true,13)
ON CONFLICT (slug) DO NOTHING;

-- â”€â”€ Chapters (4) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
-- GATE CSE EM has 3 main chapters but let's break it down logically.
INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='em'), 'Linear Algebra', 'linear-algebra', 1, 180, true, 'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='linear-algebra');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='em'), 'Calculus', 'calculus', 2, 180, true, 'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='calculus');

INSERT INTO chapters (subject_id,title,slug,order_index,estimated_mins,is_published,gate_weightage)
SELECT (SELECT id FROM subjects WHERE slug='em'), 'Probability & Statistics', 'probability-statistics', 3, 240, true, 'high'
WHERE NOT EXISTS (SELECT 1 FROM chapters WHERE slug='probability-statistics');

-- â”€â”€ SECTION 0: TAGS â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
INSERT INTO tags (slug,name) VALUES
  ('matrix',            'Matrices'),
  ('determinant',       'Determinants'),
  ('eigenvalues',       'Eigenvalues & Eigenvectors'),
  ('system-of-equations','System of Equations'),
  ('limits',            'Limits & Continuity'),
  ('derivatives',       'Derivatives'),
  ('maxima-minima',     'Maxima & Minima'),
  ('integration',       'Integration'),
  ('mean-value-theorem','Mean Value Theorem'),
  ('probability',       'Probability'),
  ('bayes-theorem',     'Bayes Theorem'),
  ('random-variable',   'Random Variables'),
  ('distributions',     'Probability Distributions'),
  ('statistics',        'Statistics (Mean, Variance)')
ON CONFLICT (slug) DO NOTHING;

-- â”€â”€ SECTION 1: TOPICS â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
-- Chapter: linear-algebra
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'Matrix Operations & Types','matrix-operations',1),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'Determinants & Properties','determinants',2),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'Inverse & Rank of a Matrix','matrix-inverse-rank',3),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'System of Linear Equations (Consistency)','linear-equations',4),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'Eigenvalues & Eigenvectors','eigenvalues-eigenvectors',5),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'Cayley-Hamilton Theorem','cayley-hamilton',6),
  ((SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),'LU Decomposition','lu-decomposition',7);

-- Chapter: calculus
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Limits & L''Hopital''s Rule','limits',1),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Continuity & Differentiability','continuity',2),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Mean Value Theorems (Rolle''s, Lagrange)','mean-value-theorems',3),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Maxima & Minima (Single Variable)','maxima-minima',4),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Partial Derivatives & Multivariable Extrema','partial-derivatives',5),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Definite Integrals & Properties','integration',6),
  ((SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),'Evaluation of Series via Integrals','series-integration',7);

-- Chapter: probability-statistics
INSERT INTO topics (chapter_id,name,slug,order_index) VALUES
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Basic Probability & Combinatorics','basic-probability',1),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Conditional Probability','conditional-prob',2),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Total Probability & Bayes'' Theorem','bayes-theorem-topic',3),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Random Variables (Discrete & Continuous)','random-variables',4),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Expectation, Variance & Standard Deviation','statistics-basics',5),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Binomial & Poisson Distributions','discrete-distributions',6),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Uniform & Exponential Distributions','continuous-distributions',7),
  ((SELECT id FROM chapters WHERE slug='probability-statistics' LIMIT 1),'Normal Distribution','normal-distribution',8);

-- Part 1 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” EM PYQ SEED v2  (Part 2 / 8)
-- MCQ Questions Q1â€“Q14 (Linear Algebra)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Q1 â€” Rank of a matrix (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='matrix-inverse-rank' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Let $A$ be a $4 \times 5$ matrix. What is the maximum possible rank of $A$?',
  '4',
  '5',
  '9',
  '20',
  'A',
  '<p><strong>âœ“ Answer: A â€” 4.</strong></p><p><strong>Step-by-step:</strong> The rank of a matrix $A$ of dimension $m \times n$ is bounded by the minimum of its dimensions. Mathematically, $\text{Rank}(A) \le \min(m, n)$. Since $A$ is $4 \times 5$, $\min(4, 5) = 4$. So the maximum possible rank is 4.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Q2 â€” Determinant properties (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='determinants' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'If $A$ is an $n \times n$ matrix and $k$ is a scalar, what is the determinant of $kA$?',
  '$k |A|$',
  '$k^n |A|$',
  '$|A| / k$',
  '$n k |A|$',
  'B',
  '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Rationale:</strong> When a matrix $A$ is multiplied by a scalar $k$, every single element of the matrix is multiplied by $k$. Because the determinant scales linearly with each row (or column), multiplying $n$ rows by $k$ results in factoring out $k$ exactly $n$ times. Therefore, $|kA| = k^n |A|$.</p><p><strong>GATE trap:</strong> Many students mistakenly pick $k|A|$. Remember, $k$ comes out of EVERY row one by one.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('determinant','matrix');

-- Q3 â€” System of Linear Equations (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='linear-equations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Consider a non-homogeneous system of linear equations $AX = B$ where $A$ is an $m \times n$ matrix. Let $\rho(A)$ be the rank of $A$ and $\rho(A|B)$ be the rank of the augmented matrix. The system has infinitely many solutions if and only if:',
  '$\rho(A) \neq \rho(A|B)$',
  '$\rho(A) = \rho(A|B) = n$',
  '$\rho(A) = \rho(A|B) < n$',
  '$\rho(A) = \rho(A|B) > n$',
  'C',
  '<p><strong>âœ“ Answer: C.</strong></p><p><strong>Step-by-step:</strong><br>- If $\rho(A) \neq \rho(A|B)$, the system is <strong>inconsistent</strong> (no solution).<br>- If $\rho(A) = \rho(A|B) = r$, the system is <strong>consistent</strong>.<br>- If $r = n$ (number of variables), there is a <strong>unique solution</strong>.<br>- If $r < n$, there are $n - r$ free variables, leading to <strong>infinitely many solutions</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('system-of-equations');

-- Q4 â€” Eigenvalue trace/determinant property (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='eigenvalues-eigenvectors' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A $3 \times 3$ matrix $A$ has trace 10 and determinant 24. If two of its eigenvalues are 2 and 4, what is the third eigenvalue?',
  '3',
  '4',
  '6',
  '8',
  'B',
  '<p><strong>âœ“ Answer: B â€” 4.</strong></p><p><strong>Step-by-step:</strong><br>Property 1: Sum of eigenvalues = Trace of matrix. $\lambda_1 + \lambda_2 + \lambda_3 = 10$.<br>Property 2: Product of eigenvalues = Determinant. $\lambda_1 \times \lambda_2 \times \lambda_3 = 24$.<br>Given $\lambda_1 = 2$ and $\lambda_2 = 4$.<br>Using Sum: $2 + 4 + \lambda_3 = 10 \implies \lambda_3 = 4$.<br>Check Product: $2 \times 4 \times 4 = 32 \neq 24$. Wait! Let me re-read the question.<br>If product is 24, $2 \times 4 \times \lambda_3 = 24 \implies \lambda_3 = 3$.<br>Let''s check the Sum: $2 + 4 + 3 = 9$. But trace is given as 10. This matrix configuration is highly conflicting mathematically as written, meaning no such matrix exists! However, usually these questions are mathematically sound. Let me rewrite the question values to perfectly align.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues');

-- Update the faulty Q4 text to be mathematically correct.
UPDATE questions SET question_text = 'A $3 \times 3$ matrix $A$ has trace 10 and determinant 24. If two of its eigenvalues are 2 and 4, what is the third eigenvalue? Wait, $2+4+3=9 \neq 10$. Let''s use trace=9, det=24. Two eigenvalues are 2 and 4. What is the third eigenvalue?', option_a = '3', correct_option = 'A', explanation = '<p><strong>âœ“ Answer: A â€” 3.</strong></p><p><strong>Step-by-step:</strong><br>Sum of eigenvalues = Trace. $2 + 4 + \lambda_3 = 9 \implies \lambda_3 = 3$.<br>Check product: $2 \times 4 \times 3 = 24$, which matches the determinant. So the third eigenvalue is 3.</p>' WHERE question_text LIKE 'A $3 \times 3$ matrix $A$ has trace 10%';

-- Clean up Q4 text fully
UPDATE questions SET question_text = 'A $3 \times 3$ matrix $A$ has trace 9 and determinant 24. If two of its eigenvalues are 2 and 4, what is the third eigenvalue?' WHERE question_text LIKE 'A $3 \times 3$ matrix $A$ has trace 9%';

-- Q5 â€” Inverse of a matrix (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='matrix-inverse-rank' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Consider a non-singular $n \times n$ matrix $A$. Which of the following is strictly FALSE?',
  '$(AB)^{-1} = B^{-1}A^{-1}$',
  '$(A^T)^{-1} = (A^{-1})^T$',
  '$|A^{-1}| = 1 / |A|$',
  '$(A+B)^{-1} = A^{-1} + B^{-1}$',
  'D',
  '<p><strong>âœ“ Answer: D.</strong></p><p><strong>Rationale:</strong> The inverse operation is NOT linear with respect to addition. Just like $1/(a+b) \neq 1/a + 1/b$ for real numbers, $(A+B)^{-1} \neq A^{-1} + B^{-1}$ for matrices in general.</p><p><strong>Why A, B, C are TRUE:</strong><br>- Reversal law of inverses: $(AB)^{-1} = B^{-1} A^{-1}$<br>- Transpose commutes with inverse: $(A^T)^{-1} = (A^{-1})^T$<br>- Determinant of inverse: $|A^{-1}| = |A|^{-1}$</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix','determinant');

-- Q6 â€” Cayley-Hamilton Theorem (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cayley-hamilton' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'According to the Cayley-Hamilton theorem, every square matrix satisfies its own characteristic equation. If the characteristic equation of matrix $A$ is $\lambda^2 - 5\lambda + 6 = 0$, what is the expression for $A^{-1}$ in terms of $A$ and $I$?',
  '$A^{-1} = \frac{1}{6}(5I - A)$',
  '$A^{-1} = \frac{1}{6}(A - 5I)$',
  '$A^{-1} = 5A - 6I$',
  '$A^{-1} = \frac{1}{5}(6I - A)$',
  'A',
  '<p><strong>âœ“ Answer: A.</strong></p><p><strong>Step-by-step:</strong><br>1. From Cayley-Hamilton: $A^2 - 5A + 6I = 0$<br>2. Multiply both sides by $A^{-1}$: $A - 5I + 6A^{-1} = 0$<br>3. Isolate $A^{-1}$: $6A^{-1} = 5I - A$<br>4. Divide by 6: $A^{-1} = \frac{1}{6}(5I - A)$</p><p><strong>GATE trap:</strong> When multiplying by $A^{-1}$, the constant term $6$ becomes $6A^{-1}$ (since $6I \cdot A^{-1} = 6A^{-1}$). This is the standard trick to find inverse equations quickly.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix','eigenvalues');

-- Q7 â€” Orthogonal Matrix (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='matrix-operations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Let $Q$ be an $n \times n$ orthogonal matrix. Which of the following is NOT necessarily true?',
  '$Q^T Q = I$',
  '$|Q| = 1$',
  '$Q^{-1} = Q^T$',
  'The columns of Q form an orthonormal basis',
  'B',
  '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Rationale:</strong> For an orthogonal matrix, $Q^T Q = I$. Taking the determinant on both sides: $|Q^T Q| = |I| \implies |Q^T| |Q| = 1 \implies |Q|^2 = 1$. Thus, the determinant $|Q|$ can be either $+1$ or $-1$. It is not NECESSARILY equal to $+1$.</p><p><strong>Why others are ALWAYS true:</strong><br>- Definition of orthogonal matrix: $Q^T Q = Q Q^T = I$<br>- This implies $Q^{-1} = Q^T$<br>- The columns (and rows) of $Q$ are mutually orthogonal unit vectors, forming an orthonormal basis.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Q8 â€” Eigenvectors of symmetric matrix (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='eigenvalues-eigenvectors' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Consider a real symmetric matrix $A$. Which of the following is a guaranteed property of $A$?',
  'All its eigenvalues are purely imaginary or zero',
  'Its eigenvectors corresponding to distinct eigenvalues are orthogonal',
  'It cannot be diagonalized',
  'Its determinant is always positive',
  'B',
  '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Rationale:</strong> The Spectral Theorem for real symmetric matrices states two fundamental properties:<br>1. All its eigenvalues are strictly REAL.<br>2. Eigenvectors corresponding to DISTINCT eigenvalues are strictly ORTHOGONAL to each other.<br>Additionally, every real symmetric matrix is diagonalizable using an orthogonal matrix.</p><p><strong>GATE trap:</strong> Skew-symmetric real matrices have purely imaginary or zero eigenvalues. Orthogonal matrices have eigenvalues with absolute value 1. Real symmetric matrices have real eigenvalues.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q9 â€” Rank of XY (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='matrix-inverse-rank' LIMIT 1),
  'gate-cse',true,2015,'MCQ','medium',2,
  'Let $X$ and $Y$ be two matrices such that $X$ is of size $m \times n$ and $Y$ is of size $n \times p$. What is the relationship between the rank of the product matrix $XY$ and the ranks of $X$ and $Y$?',
  '$\text{Rank}(XY) = \min(\text{Rank}(X), \text{Rank}(Y))$',
  '$\text{Rank}(XY) \le \min(\text{Rank}(X), \text{Rank}(Y))$',
  '$\text{Rank}(XY) = \text{Rank}(X) \times \text{Rank}(Y)$',
  '$\text{Rank}(XY) \ge \max(\text{Rank}(X), \text{Rank}(Y))$',
  'B',
  '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Step-by-step:</strong> According to Sylvester''s Rank Inequality, the rank of a product of matrices is bounded above by the rank of each individual matrix. Specifically: $\text{Rank}(XY) \le \text{Rank}(X)$ AND $\text{Rank}(XY) \le \text{Rank}(Y)$. Thus, $\text{Rank}(XY) \le \min(\text{Rank}(X), \text{Rank}(Y))$.</p><p><strong>GATE tip:</strong> Multiplication can only "destroy" information (reduce rank), never create it.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Q10 â€” Singular Matrix Eigenvalue (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='eigenvalues-eigenvectors' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'If $A$ is a square singular matrix, which of the following MUST be an eigenvalue of $A$?',
  '0',
  '1',
  '-1',
  'Imaginary $i$',
  'A',
  '<p><strong>âœ“ Answer: A â€” 0.</strong></p><p><strong>Rationale:</strong> A matrix is singular if and only if its determinant is exactly 0. The determinant of a matrix is the product of all its eigenvalues ($\lambda_1 \times \lambda_2 \times \ldots \times \lambda_n = |A|$). For the product to be 0, at least one of the eigenvalues MUST be strictly zero.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','determinant');

-- Q11 â€” Nilpotent Matrix (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='matrix-operations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A square matrix $A$ is called nilpotent of index $k$ if $A^k = 0$ for some integer $k > 0$. What can be said about the eigenvalues of a nilpotent matrix?',
  'All eigenvalues are 1',
  'All eigenvalues are 0',
  'Eigenvalues alternate between 1 and -1',
  'Eigenvalues cannot be determined without knowing k',
  'B',
  '<p><strong>âœ“ Answer: B â€” All eigenvalues are 0.</strong></p><p><strong>Step-by-step:</strong> Let $\lambda$ be an eigenvalue of $A$ with eigenvector $x \neq 0$. Then $Ax = \lambda x$.<br>Multiply by $A$: $A^2 x = A(\lambda x) = \lambda(Ax) = \lambda^2 x$.<br>By induction: $A^k x = \lambda^k x$.<br>Since $A$ is nilpotent, $A^k = 0$, so $0 \cdot x = \lambda^k x$.<br>Since $x \neq 0$, we must have $\lambda^k = 0 \implies \lambda = 0$. Thus, EVERY eigenvalue is 0.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q12 â€” LU Decomposition condition (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='lu-decomposition' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Under what condition can a square matrix $A$ be decomposed as $A = LU$, where $L$ is a lower triangular matrix and $U$ is an upper triangular matrix (without row exchanges)?',
  'If A is singular',
  'If all principal leading minors of A are non-zero',
  'If A is an orthogonal matrix',
  'If A is symmetric',
  'B',
  '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Rationale:</strong> The standard $LU$ decomposition (without pivoting/row exchanges) relies on Gaussian elimination proceeding without ever having to swap rows due to a zero pivot. This is mathematically guaranteed if and only if all leading principal minors (the top-left $1 \times 1, 2 \times 2, \ldots, n \times n$ sub-determinants) are strictly non-zero.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Q13 â€” Cramer's Rule (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='linear-equations' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'When solving a system of linear equations $AX = B$ using Cramer''s Rule, the denominator used to calculate each variable is:',
  'The determinant of matrix B',
  'The trace of matrix A',
  'The determinant of the coefficient matrix A',
  'The product of the diagonal elements of A',
  'C',
  '<p><strong>âœ“ Answer: C â€” The determinant of the coefficient matrix A.</strong></p><p><strong>Rationale:</strong> Cramer''s Rule states that $x_i = |A_i| / |A|$, where $|A|$ is the determinant of the coefficient matrix, and $|A_i|$ is the determinant of the matrix formed by replacing the $i$-th column of $A$ with the constants column vector $B$. Note that Cramer''s rule ONLY applies when $|A| \neq 0$ (unique solution).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('system-of-equations','determinant');

-- Q14 â€” Eigenvector scaling (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='eigenvalues-eigenvectors' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'If $v$ is an eigenvector of matrix $A$ corresponding to eigenvalue $\lambda$, and $c$ is a non-zero scalar, which of the following is true for the vector $cv$?',
  'It is an eigenvector of $A$ corresponding to eigenvalue $c\lambda$',
  'It is an eigenvector of $A$ corresponding to eigenvalue $\lambda$',
  'It is NOT an eigenvector of $A$',
  'It is an eigenvector of $cA$ corresponding to eigenvalue $\lambda/c$',
  'B',
  '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Step-by-step:</strong> Definition: $Av = \lambda v$.<br>Multiply both sides by scaler $c$: $c(Av) = c(\lambda v)$.<br>Because matrix multiplication is linear: $A(cv) = \lambda (cv)$.<br>Therefore, the vector $(cv)$ is ALSO an eigenvector of $A$, and it corresponds to the EXACT SAME eigenvalue $\lambda$. Eigenvectors only define a "direction"; their scaling does not change their status as eigenvectors for that specific $\lambda$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues');

-- Part 2 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” EM PYQ SEED v2  (Part 3 / 8)
-- MCQ Questions Q15â€“Q28 (Calculus)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Q15 â€” Limit using L'Hopital (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='limits' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Evaluate: $\lim_{x \to 0} \frac{\sin(ax)}{\sin(bx)}$, where $b \neq 0$.',
  '$0$',
  '$a/b$',
  '$b/a$',
  'undefined',
  'B',
  '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Step-by-step:</strong> Plugging in $x=0$ yields $0/0$, so we can apply L''HÃ´pital''s Rule.<br>Take derivative of numerator: $a \cos(ax)$.<br>Take derivative of denominator: $b \cos(bx)$.<br>Evaluate limit at $x=0$: $\frac{a \cos(0)}{b \cos(0)} = \frac{a \cdot 1}{b \cdot 1} = \frac{a}{b}$.</p><p>Alternatively, using the standard limit $\lim_{x \to 0} \frac{\sin x}{x} = 1$:<br>$\frac{\sin(ax)}{\sin(bx)} = \frac{\frac{\sin(ax)}{ax} \cdot ax}{\frac{\sin(bx)}{bx} \cdot bx} \rightarrow \frac{1 \cdot ax}{1 \cdot bx} = \frac{a}{b}$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits');

-- Q16 â€” Continuity vs Differentiability (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='continuity' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Consider the function $f(x) = |x|$. Which of the following statements is strictly TRUE at $x = 0$?',
  'It is both continuous and differentiable',
  'It is continuous but NOT differentiable',
  'It is differentiable but NOT continuous',
  'It is neither continuous nor differentiable',
  'B',
  '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Rationale:</strong><br>- <strong>Continuity:</strong> $\lim_{x \to 0^-} |x| = 0$, $\lim_{x \to 0^+} |x| = 0$, and $f(0) = 0$. Since they all match, it is continuous.<br>- <strong>Differentiability:</strong> The left-hand derivative (LHD) is $\lim_{h \to 0^-} \frac{|h| - 0}{h} = \frac{-h}{h} = -1$. The right-hand derivative (RHD) is $\lim_{h \to 0^+} \frac{|h| - 0}{h} = \frac{h}{h} = 1$. Since LHD $\neq$ RHD, there is a sharp "corner" at $x=0$, making it NOT differentiable.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits');

-- Q17 â€” Rolle's Theorem conditions (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mean-value-theorems' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following conditions is NOT strictly required to apply Rolle''s Theorem for a function $f(x)$ on the interval $[a, b]$?',
  '$f(x)$ is continuous on the closed interval $[a, b]$',
  '$f(x)$ is differentiable on the open interval $(a, b)$',
  '$f(a) = f(b)$',
  '$f(x)$ must be equal to 0 at some point in $[a, b]$',
  'D',
  '<p><strong>âœ“ Answer: D.</strong></p><p><strong>Rationale:</strong> Rolle''s Theorem requires ONLY three conditions:<br>1. $f(x)$ continuous on $[a, b]$<br>2. $f(x)$ differentiable on $(a, b)$<br>3. $f(a) = f(b)$<br>If these hold, the theorem guarantees there exists at least one $c$ in $(a, b)$ such that $f''(c) = 0$. It absolutely DOES NOT require the function value $f(x)$ to be 0 anywhere.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('mean-value-theorem','derivatives');

-- Q18 â€” Local Maxima condition (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='maxima-minima' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Let $f(x)$ be a twice-differentiable single-variable function. At a stationary point $x=c$ where $f''(c) = 0$, what condition confirms that $x=c$ is a point of local MAXIMA?',
  '$f''''(c) = 0$',
  '$f''''(c) > 0$',
  '$f''''(c) < 0$',
  '$f''''(c)$ is undefined',
  'C',
  '<p><strong>âœ“ Answer: C â€” $f''''(c) < 0$.</strong></p><p><strong>Step-by-step:</strong><br>- First derivative test: $f''(c) = 0$ identifies a critical stationary point.<br>- Second derivative test: The value of $f''''(c)$ tells us about concavity.<br>- If $f''''(c) > 0$, the curve is concave "upward" (like a cup $U$), meaning $c$ is a local MINIMUM.<br>- If $f''''(c) < 0$, the curve is concave "downward" (like a hat $\cap$), meaning $c$ is a local MAXIMUM.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('maxima-minima','derivatives');

-- Q19 â€” Integration by Parts (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='integration' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Evaluate the indefinite integral: $\int x e^x dx$',
  '$x e^x - e^x + C$',
  '$x e^x + e^x + C$',
  '$e^x(x^2/2) + C$',
  '$x^2 e^x + C$',
  'A',
  '<p><strong>âœ“ Answer: A.</strong></p><p><strong>Step-by-step:</strong> We use Integration by Parts: $\int u dv = uv - \int v du$.<br>Using LIATE rule, let $u = x$ and $dv = e^x dx$.<br>Then $du = dx$, and $v = e^x$.<br>Plugging into formula: $\int x e^x dx = x e^x - \int e^x dx$<br>$= x e^x - e^x + C$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration');

-- Q20 â€” Even function definite integral (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='integration' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'If $f(x)$ is an odd function (i.e., $f(-x) = -f(x)$), what is the value of the definite integral $\int_{-a}^{a} f(x) dx$?',
  '$2 \int_{0}^{a} f(x) dx$',
  '$\int_{0}^{a} f(x) dx$',
  '$0$',
  'Cannot be determined without knowing $f(x)$',
  'C',
  '<p><strong>âœ“ Answer: C â€” 0.</strong></p><p><strong>Rationale:</strong> The area under the curve for an alternating symmetric function from $-a$ to $0$ is the exact negative of the area from $0$ to $a$. For example, $\int_{-a}^{a} x^3 dx$. The positive and negative areas perfectly cancel each other out, always equating to exactly 0.</p><p><strong>GATE trap:</strong> The answer $2 \int_0^a f(x) dx$ applies if $f(x)$ is an EVEN function ($f(-x) = f(x)$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration');

-- Q21 â€” Limit using Expansion (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='limits' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Evaluate $\lim_{x \to 0} \frac{e^x - 1 - x}{x^2}$.',
  '$0$',
  '$1/2$',
  '$1$',
  '$\infty$',
  'B',
  '<p><strong>âœ“ Answer: B â€” $1/2$.</strong></p><p><strong>Method 1 (L''HÃ´pital):</strong><br>Plug $x=0 \implies 0/0$. Apply L''H Rule:<br>Deriv(num) = $e^x - 1$. Deriv(den) = $2x$.<br>Limit $\rightarrow \frac{e^x - 1}{2x}$. Still $0/0$. Apply again:<br>Deriv(num) = $e^x$. Deriv(den) = $2$.<br>Evaluate limit at $x=0$: $e^0 / 2 = 1/2$.</p><p><strong>Method 2 (Maclaurin Series):</strong><br>Expansion of $e^x = 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \ldots$<br>Numerator: $(1 + x + x^2/2 + \ldots) - 1 - x = x^2/2 + x^3/6 + \ldots$<br>Divide by $x^2$: $1/2 + x/6 + \ldots$<br>Take limit as $x \to 0$: $1/2$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits','derivatives');

-- Q22 â€” Partial Derivatives (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='partial-derivatives' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'For a function $f(x, y)$, the mixed partial derivatives $f_{xy}$ and $f_{yx}$ are guaranteed to be strictly equal under which famous theorem if the second partial derivatives are continuous?',
  'Rolle''s Theorem',
  'Cauchy''s Theorem',
  'Clairaut''s Theorem (Schwarz''s Theorem)',
  'Euler''s Theorem',
  'C',
  '<p><strong>âœ“ Answer: C.</strong></p><p><strong>Rationale:</strong> Clairaut''s Theorem (also known as Schwarz''s Theorem) states that if the mixed partial derivatives $\frac{\partial^2 f}{\partial x \partial y}$ and $\frac{\partial^2 f}{\partial y \partial x}$ are continuous on a domain, then they are absolutely equal. Thus, the order of differentiation does not matter.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('derivatives');

-- Q23 â€” Lagrange Mean Value Theorem (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mean-value-theorems' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The Lagrange Mean Value Theorem (LMVT) states that there exists a $c \in (a, b)$ such that $f''(c) = \frac{f(b) - f(a)}{b - a}$. Geometrically, what does this slope $f''(c)$ represent?',
  'The slope of the Secant line connecting $(a, f(a))$ and $(b, f(b))$',
  'The slope of the Tangent line at $x=a$',
  'The area under the curve from $a$ to $b$ divided by $(b-a)$',
  'The minimum value of the curve in the interval',
  'A',
  '<p><strong>âœ“ Answer: A.</strong></p><p><strong>Rationale:</strong> The term $\frac{f(b) - f(a)}{b - a}$ is precisely the mathematical formula for the slope of the secant line cutting through the endpoints of the interval. LMVT guarantees there is at least one tangent line inside the interval that is perfectly parallel (has exact same slope) to this secant line.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('mean-value-theorem','derivatives');

-- Q24 â€” Indeterminate Forms (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='limits' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following is NOT mathematically classified as an "indeterminate form"?',
  '$0^0$',
  '$\infty / \infty$',
  '$0 \times \infty$',
  '$\infty + \infty$',
  'D',
  '<p><strong>âœ“ Answer: D.</strong></p><p><strong>Rationale:</strong> $\infty + \infty = \infty$. It is completely deterministic and strictly unbounded. The other options $(0^0, \frac{\infty}{\infty}, 0 \times \infty)$ are strict indeterminate forms because different functions taking these limits converge asymptotically to entirely different finite (or infinite) constant values, hence needing L''HÃ´pital or series expansions.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits');

-- Q25 â€” Definite integral properties (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='integration' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Using the famous property of definite integrals $\int_0^a f(x) dx = \int_0^a f(a-x) dx$, evaluate: $I = \int_0^{\pi/2} \frac{\sin^n x}{\sin^n x + \cos^n x} dx$',
  '$\pi / 2$',
  '$\pi / 4$',
  '$1$',
  '$0$',
  'B',
  '<p><strong>âœ“ Answer: B â€” $\pi / 4$.</strong></p><p><strong>Step-by-step:</strong><br>1. Original: $I = \int_0^{\pi/2} \frac{\sin^n x}{\sin^n x + \cos^n x} dx$<br>2. Apply property: Replace $x$ with $(\pi/2 - x)$. We know $\sin(\pi/2 - x) = \cos x$ and $\cos(\pi/2 - x) = \sin x$.<br>3. This gives: $I = \int_0^{\pi/2} \frac{\cos^n x}{\cos^n x + \sin^n x} dx$<br>4. Add the two $I$ equations together: $2I = \int_0^{\pi/2} \frac{\sin^n x + \cos^n x}{\sin^n x + \cos^n x} dx$<br>5. $2I = \int_0^{\pi/2} 1 dx = \pi/2$.<br>6. $I = \pi / 4$.</p><p><strong>GATE trap:</strong> This result is robust and independent of $n$. Whether it''s $\sqrt{\sin x}$ or $\sin^5 x$, the answer is solidly $\pi / 4$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration');

-- Q26 â€” Maclaurin series application (hard)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='derivatives' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Consider the Taylor series of $\ln(1+x)$ centered at $x=0$. What is the coefficient of the $x^3$ term?',
  '$1/3$',
  '$-1/3$',
  '$1/6$',
  '$-1/6$',
  'A',
  '<p><strong>âœ“ Answer: A â€” $1/3$.</strong></p><p><strong>Step-by-step:</strong><br>The Taylor (Maclaurin) series for $f(x) = \ln(1+x)$ is given by $\sum_{n=1}^\infty (-1)^{n+1} \frac{x^n}{n}$.<br>Expanding elements: $x - \frac{x^2}{2} + \frac{x^3}{3} - \frac{x^4}{4} + \ldots$<br>The strictly $x^3$ term is $+\frac{x^3}{3}$.<br>Therefore, the coefficient is exactly $1/3$.</p><p><strong>Why D is wrong:</strong> Many students confuse this with standard Taylor expansion $\frac{f^{(n)}(0)}{n!}$. The derivative $f''''''(0) = 2$, and $2/(3!) = 2/6 = 1/3$. Be extremely careful with signs and factorials!</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('derivatives');

-- Q27 â€” Saddle Point (medium)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='partial-derivatives' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'For a two-variable function $f(x, y)$, a critical point is evaluated using the discriminant $D = f_{xx} f_{yy} - (f_{xy})^2$. What condition strictly dictates that the point is a "Saddle Point"?',
  '$D > 0, f_{xx} > 0$',
  '$D > 0, f_{xx} < 0$',
  '$D < 0$',
  '$D = 0$',
  'C',
  '<p><strong>âœ“ Answer: C â€” $D < 0$.</strong></p><p><strong>Step-by-step Second Derivative Test for 2 Vars:</strong><br>- If $D > 0$ and $f_{xx} > 0 \implies$ Local Minimum.<br>- If $D > 0$ and $f_{xx} < 0 \implies$ Local Maximum.<br>- If $D < 0 \implies$ <strong>Saddle Point</strong> (looks like a mountain pass; curves up horizontally but curves down vertically).<br>- If $D = 0 \implies$ Inconclusive.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('maxima-minima','derivatives');

-- Q28 â€” Integration basic property (easy)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='integration' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Reverse limits property: What is $\int_b^a f(x) dx$ equal to?',
  '$\int_a^b f(x) dx$',
  '$-\int_a^b f(x) dx$',
  '$| \int_a^b f(x) dx |$',
  '$0$',
  'B',
  '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Rationale:</strong> Reversing the upper and lower limits of integration multiplies the entire definite integral strictly by $-1$. This is a fundamental axiom defined in Riemann sums (where $\Delta x$ flips sign from $\frac{b-a}{n}$ to $\frac{a-b}{n}$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration');

-- Part 3 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” EM PYQ SEED v2 (Part 4 / 8)
-- MCQ Questions Q29â€“Q45 (Probability & Statistics)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Q29 â€” Conditional Probability (easy)
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
 '<p><strong>âœ“ Answer: A â€” 0.5.</strong></p><p><strong>Step-by-step:</strong> The formula for conditional probability is $P(A|B) = \frac{P(A \cap B)}{P(B)}$.<br>Substitute the values: $\frac{0.2}{0.4} = \frac{1}{2} = 0.5$.</p><p><strong>Sub-note:</strong> Notice that $P(A|B) = 0.5 = P(A)$. This mathematically proves that events A and B are <strong>independent</strong>!</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q30 â€” Mutually Exclusive Events (easy)
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
 '<p><strong>âœ“ Answer: C â€” $P(A | B) = 0$.</strong></p><p><strong>Step-by-step:</strong> "Mutually Exclusive" means the occurrences cannot happen at the same time. Thus, their intersection is empty: $A \cap B = \emptyset \implies P(A \cap B) = 0$.<br>Plugging this into conditional probability: $P(A|B) = \frac{P(A \cap B)}{P(B)} = \frac{0}{P(B)} = 0$.</p><p><strong>GATE trap:</strong> Many confuse mutually exclusive with independent. If they are mutually exclusive, they are highly dependent (if B happens, A is guaranteed NOT to happen, hence $P(A|B)=0$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q31 â€” Bayes Theorem (medium)
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
 '<p><strong>âœ“ Answer: C â€” 2/3.</strong></p><p><strong>Step-by-step (Bayes'' Theorem):</strong><br>Let $B$ = Chose Biased coin. $P(B) = 1/2$.<br>Let $F$ = Chose Fair coin. $P(F) = 1/2$.<br>Let $H$ = Observation of Heads.<br>$P(H|B) = 1$ (biased coin is always heads).<br>$P(H|F) = 1/2$ (fair coin is 50% heads).<br>We want to find $P(B|H)$.<br>Formula: $P(B|H) = \frac{P(H|B)P(B)}{P(H|B)P(B) + P(H|F)P(F)}$<br>Numerator = $1 \times (1/2) = 1/2$.<br>Denominator = $(1 \times 1/2) + (1/2 \times 1/2) = 1/2 + 1/4 = 3/4$.<br>Result = $\frac{1/2}{3/4} = \frac{2}{3}$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability','bayes-theorem');

-- Q32 â€” Expected Value Properties (medium)
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
 '<p><strong>âœ“ Answer: D.</strong></p><p><strong>Rationale:</strong><br>- <strong>A</strong> is True: Expectation is linear, regardless of independence.<br>- <strong>B</strong> is True: Variances add if the variables are independent (covariance is 0).<br>- <strong>C</strong> is True: The expectation of a product factors for independent variables.<br>- <strong>D</strong> is False. The variance of a product of independent variables is $var(XY) = E[X^2]E[Y^2] - (E[X]E[Y])^2$. This is NOT equal to $var(X) \times var(Y)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('statistics','random-variable');

-- Q33 â€” Binomial Distribution (easy)
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
 '<p><strong>âœ“ Answer: B â€” $np(1-p)$.</strong></p><p><strong>Rationale:</strong> For a Binomial distribution $B(n, p)$:<br>- <strong>Mean / Expected Value:</strong> $E[X] = np$<br>- <strong>Variance:</strong> $var(X) = npq$ where $q = 1-p$. So $np(1-p)$.<br>- <strong>Standard Deviation:</strong> $\sqrt{np(1-p)}$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions','statistics');

-- Q34 â€” Poisson Limit Theorem (medium)
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
 '<p><strong>âœ“ Answer: C.</strong></p><p><strong>Rationale:</strong> The Poisson Limit Theorem states that as $n \to \infty$ and $p \to 0$, while their product $np = \lambda$ remains constant, the Binomial distribution converges perfectly into the Poisson distribution. This is why Poisson is used to model extremely rare events occurring over a vast number of trials (e.g., radioactive decay, network packet drops).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions');

-- Q35 â€” Exponential Distribution Memoryless (hard)
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
 '<p><strong>âœ“ Answer: B â€” $P(X > s)$.</strong></p><p><strong>Step-by-step:</strong> This tests the fundamental "Memoryless Property" unique to the Exponential Distribution for continuous variables (and Geometric for discrete).<br>Mathematically: $P(X > t+s \mid X > t) = P(X > s)$.<br>In plain English: The machine does not "age". Survival for the next $s$ hours is independent of the fact that it has already survived $t$ hours.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions','random-variable');

-- Q36 â€” Uniform Distribution PDF (medium)
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
 '<p><strong>âœ“ Answer: C â€” $\frac{(b-a)^2}{12}$.</strong></p><p><strong>Step-by-step:</strong> By definition, the probability density function (PDF) is $f(x) = \frac{1}{b-a}$.<br>Mean $E[X] = \frac{a+b}{2}$.<br>To find Variance: $E[X^2] - (E[X])^2$.<br>$E[X^2] = \int_a^b x^2 \frac{1}{b-a} dx = \frac{b^3 - a^3}{3(b-a)} = \frac{b^2 + ab + a^2}{3}$.<br>Subtracting the squared mean gives $\frac{(b-a)^2}{12}$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions','statistics');

-- Q37 â€” Normal Distribution Empirical Rule (easy)
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
 '<p><strong>âœ“ Answer: B â€” 68%.</strong></p><p><strong>Rationale:</strong> The 68-95-99.7 empirical rule states:<br>- $\approx 68.27\%$ of values fall within 1 SD ($1\sigma$).<br>- $\approx 95.45\%$ within 2 SDs ($2\sigma$).<br>- $\approx 99.73\%$ within 3 SDs ($3\sigma$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions','statistics');

-- Q38 â€” Independent vs Uncorrelated (hard)
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
 '<p><strong>âœ“ Answer: B â€” $X$ and $Y$ are uncorrelated linearly.</strong></p><p><strong>Step-by-step:</strong><br>- Covariance measures LINEAR dependence.<br>- If variables are independent, they are GUARANTEED to be uncorrelated ($Cov=0$).<br>- HOWEVER, if uncorrelated ($Cov=0$), they might still be dependent in a non-linear way (e.g., $Y = X^2$ symmetrically around 0 yields $Cov(X,Y)=0$, yet $Y$ is dependent on $X$).<br>Thus, $Cov=0$ proves only linear uncorrelation, NOT full independence.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('statistics','random-variable');

-- Q39 â€” Total Probability (medium)
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
 '<p><strong>âœ“ Answer: B â€” 0.026.</strong></p><p><strong>Step-by-step (Law of Total Probability):</strong><br>Let $D$ = probability of defect.<br>$P(D) = P(D|A)P(A) + P(D|B)P(B)$<br>$P(D) = (0.01 \times 0.60) + (0.05 \times 0.40)$<br>$P(D) = 0.006 + 0.020$<br>$P(D) = 0.026$ (which is 2.6%).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q40 â€” Random Variables integration (medium)
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
 '<p><strong>âœ“ Answer: A â€” 1/9.</strong></p><p><strong>Step-by-step:</strong> For $f(x)$ to be a valid PDF, the total area under the curve across its entire domain MUST equal exactly 1.<br>Integrate: $\int_0^3 c x^2 dx = 1$<br>$c \left[ \frac{x^3}{3} \right]_0^3 = 1$<br>$c \left(\frac{27}{3} - 0\right) = 1$<br>$9c = 1 \implies c = 1/9$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('random-variable','integration');

-- Q41 â€” Matrix Eigenvalue shift (medium)
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
 '<p><strong>âœ“ Answer: B â€” $\lambda - 5$.</strong></p><p><strong>Step-by-step:</strong> Start at definition: $Ax = \lambda x$.<br>Subtract $5x$ from both sides: $Ax - 5x = \lambda x - 5x$.<br>Factor out $x$ on both sides: $(A - 5I)x = (\lambda - 5)x$.<br>This proves that $(\lambda - 5)$ is the eigenvalue for the shifted matrix $(A - 5I)$, keeping the same eigenvector $x$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q42 â€” Definite Integral Limit (medium)
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
 '<p><strong>âœ“ Answer: B â€” 1.</strong></p><p><strong>Step-by-step:</strong><br>Limit evaluates to $\frac{\int_0^0}{0} = 0/0$. We apply L''HÃ´pital.<br>Numerator derivative: By Fundamental Theorem of Calculus/Leibniz rule, $\frac{d}{dx} \int_0^x \cos t dt = \cos(x)$.<br>Denominator derivative: $\frac{d}{dx} x = 1$.<br>Evaluate limit at $x=0$: $\frac{\cos(0)}{1} = \frac{1}{1} = 1$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration','limits');

-- Q43 â€” Random Variable Sum Variance (easy)
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
 '<p><strong>âœ“ Answer: C â€” 90.</strong></p><p><strong>Step-by-step:</strong> The property of variance for a linear transformation $X = aY + b$ is given by $var(X) = a^2 var(Y)$. Constants ($b$) evaporate because variance measures spread, not shifts.<br>Here $a = 3$, so $a^2 = 9$.<br>$var(X) = 9 \times 10 = 90$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('statistics','random-variable');

-- Q44 â€” Continuous Continuity test (medium)
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
 '<p><strong>âœ“ Answer: B.</strong></p><p><strong>Step-by-step:</strong><br>- <strong>Continuity:</strong> Limit $x \to 0$ of $x \sin|1/x|$. Since sine bounds between -1 and 1, applying Squeeze Theorem gives $0 \times (\text{bounded}) = 0$. Since limit matches $f(0)=0$, it is CONTINUOUS.<br>- <strong>Differentiability:</strong> Check derivative $f''(0) = \lim_{h \to 0} \frac{h \sin(1/h) - 0}{h} = \lim_{h \to 0} \sin(1/h)$. This limit fiercely wildly oscillates and does NOT exist. So it is NOT differentiable.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits','derivatives');

-- Q45 â€” Inverse of 2x2 Matrix (easy)
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
 '<p><strong>âœ“ Answer: A.</strong></p><p><strong>Rationale:</strong> The adjoint of a $2 \times 2$ matrix is found quickly by:<br>1. Swapping the elements on the primary diagonal ($a$ and $d$).<br>2. Negating the elements on the secondary diagonal ($b$ and $c$).<br>Resulting matrix: $[d, -b]$ on top, $[-c, a]$ on bottom.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Part 4 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” EM PYQ SEED v2 (Part 5 / 8)
-- NAT Questions Q46â€“Q55 (Linear Algebra, Calculus, Probability)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Q46 â€” Determinant Evaluation (NAT, easy)
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
 '<p><strong>âœ“ Answer: 14.</strong></p><p><strong>Step-by-step:</strong><br>For a $2 \times 2$ matrix $\begin{bmatrix} a & b \\ c & d \end{bmatrix}$, the determinant is $ad - bc$.<br>Here $a=4, b=3, c=2, d=5$.<br>$|A| = (4 \times 5) - (3 \times 2) = 20 - 6 = 14$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('determinant');

-- Q47 â€” Limits by L'Hopital (NAT, medium)
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
 '<p><strong>âœ“ Answer: 2.</strong></p><p><strong>Step-by-step:</strong><br>Plug $x=0$: $\frac{1-1}{0} = 0/0$. Use L''HÃ´pital.<br>Derivative of numerator: $0 - (-\sin(2x) \cdot 2) = 2\sin(2x)$.<br>Derivative of denominator: $2x$.<br>New limit: $\lim_{x \to 0} \frac{2\sin(2x)}{2x} = \lim_{x \to 0} \frac{\sin(2x)}{x}$.<br>Plug $x=0$: $0/0$. Use L''HÃ´pital again.<br>Numerator: $2\cos(2x)$. Denominator: 1.<br>Evaluate at $x=0$: $2 \cos(0) / 1 = 2 \times 1 = 2$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits');

-- Q48 â€” System of Equations solutions (NAT, medium)
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
 '<p><strong>âœ“ Answer: 1.</strong></p><p><strong>Step-by-step:</strong><br>For infinitely many solutions, the determinant of the coefficient matrix must be 0, AND the augmented matrix must have the same rank.<br>Coefficient matrix $A$:<br>1, 1, 1<br>1, 2, 3<br>1, 1, p<br>$|A| = 1(2p - 3) - 1(p - 3) + 1(1 - 2) = 2p - 3 - p + 3 - 1 = p - 1$<br>Set $|A| = 0 \implies p = 1$.<br>Substitute $p=1$ into equation 3: $x+y+z=1$. This is identical to equation 1. So there are infinitely many solutions (a fully intersecting line of them).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('system-of-equations');

-- Q49 â€” Definite Integral numeric (NAT, easy)
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
 '<p><strong>âœ“ Answer: 2.</strong></p><p><strong>Step-by-step:</strong><br>Integrate term-by-term: $\int 3x^2 dx = x^3$<br>$\int 2x dx = x^2$<br>Antiderivative $= x^3 + x^2$.<br>Evaluate from 0 to 1: $(1^3 + 1^2) - (0 + 0) = 1 + 1 = 2$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration');

-- Q50 â€” Sum of Eigenvalues (NAT, easy)
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
 '<p><strong>âœ“ Answer: 10.</strong></p><p><strong>Step-by-step:</strong><br>The sum of all eigenvalues of ANY square matrix is equal to the Trace of the matrix.<br>The Trace is simply the sum of its main diagonal elements.<br>Trace $= -5 + 12 + 3 = 10$.<br>Therefore, the sum of the eigenvalues is 10.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q51 â€” Combinations Probability (NAT, medium)
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
 '<p><strong>âœ“ Answer: 0.36.</strong></p><p><strong>Step-by-step:</strong><br>Total balls = $5 + 3 = 8$.<br>Number of ways to choose exactly 2 balls from 8: $\binom{8}{2} = \frac{8 \times 7}{2} = 28$.<br>Number of ways to choose 2 RED balls from the 5 reds: $\binom{5}{2} = \frac{5 \times 4}{2} = 10$.<br>Probability $P = 10 / 28 = 5 / 14 \approx 0.357$.<br>Rounded to two decimal places: 0.36.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q52 â€” Binomial Distribution expectation (NAT, easy)
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
 '<p><strong>âœ“ Answer: 5.</strong></p><p><strong>Step-by-step:</strong><br>This is a Binomial Distribution problem. $n = 20$ trials.<br>Probability of guessing $p = 1/4 = 0.25$.<br>Expected value $E[X] = n \times p$<br>$20 \times 0.25 = 5$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions','statistics');

-- Q53 â€” Partial Derivative computation (NAT, medium)
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
 '<p><strong>âœ“ Answer: 12.</strong></p><p><strong>Step-by-step:</strong><br>1. First, find $f_x$ (treat $y$ as constant):<br>$f_x = \frac{\partial}{\partial x}(3x^2y + y^3 - 2x) = 6xy + 0 - 2 = 6xy - 2$.<br>2. Next, differentiate $f_x$ with respect to $y$:<br>$f_{xy} = \frac{\partial}{\partial y}(6xy - 2) = 6x$.<br>3. Finally evaluate exactly at $x=2$ (the value of $y$ drops out ):<br>$6(2) = 12$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('derivatives');

-- Q54 â€” Continuous PDF evaluation (NAT, medium)
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
 '<p><strong>âœ“ Answer: 0.75.</strong></p><p><strong>Step-by-step:</strong><br>The precise probability is the solid integral of the PDF over the requested interval.<br>$P = \int_{0.5}^{1} 2x dx$.<br>Antiderivative: $x^2$.<br>Evaluate fully from 0.5 to 1: $(1)^2 - (0.5)^2 = 1 - 0.25 = 0.75$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('random-variable','integration');

-- Q55 â€” Variance calculation (NAT, hard)
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
 '<p><strong>âœ“ Answer: 1.</strong></p><p><strong>Step-by-step:</strong><br>1. Calculate Expected Value (Mean) $E[X]$:<br>$E[X] = (2 \times 0.5) + (4 \times 0.5) = 1 + 2 = 3$.<br>2. Calculate Expected form of Square $E[X^2]$:<br>$E[X^2] = (2^2 \times 0.5) + (4^2 \times 0.5) = (4 \times 0.5) + (16 \times 0.5) = 2 + 8 = 10$.<br>3. Compute fully robust Variance: $var(X) = E[X^2] - (E[X])^2$<br>$var(X) = 10 - 3^2 = 10 - 9 = 1$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('statistics','random-variable');

-- Part 5 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” EM PYQ SEED v2 (Part 6 / 8)
-- MSQ Questions Q56â€“Q65 (Linear Algebra, Calculus, Probability)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Q56 â€” MSQ: Rank Properties (medium)
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
 '<p><strong>âœ“ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> Row rank always exactly equals column rank. Thus, transposition does not alter rank.<br>- <strong>B:</strong> The rank of a sum is bounded by the sum of their individual ranks (subadditivity property).<br>- <strong>D:</strong> A square matrix has full rank if and only if its determinant is non-zero (non-singular).</p><p><strong>Why C is FALSE:</strong> The rank of a product is rigidly bounded by Sylvester''s inequality: Rank($AB$) $\le \min(\text{Rank}(A), \text{Rank}(B))$. It is definitely not the multiplier product.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Q57 â€” MSQ: Independent Events (medium)
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
 '<p><strong>âœ“ Answers: A, B.</strong></p><p><strong>Rationale:</strong> Independence mathematically dictates that the occurrence of $B$ yields literally zero information about $A$.<br>- <strong>A:</strong> The defining formula for complete independence: the intersection probability is their product.<br>- <strong>B:</strong> Conditional probability $P(A|B)$ equals the outright marginal probability $P(A)$.</p><p><strong>Why C is FALSE:</strong> This is the formula for Mutually Exclusive events, NOT independent events (intersection would be 0, which contradicts $P(A)P(B) > 0$).<br><strong>Why D is FALSE:</strong> This implies $A$ is the precise complement of $B$, which is dependent.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability');

-- Q58 â€” MSQ: Eigenvalues of special matrices (hard)
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
 '<p><strong>âœ“ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> These are robust fundamental spectral theorems.<br>- <strong>A:</strong> True. Essential property of Hermitian / real symmetric tables.<br>- <strong>B:</strong> True. Skew-symmetric matrices ($A^T = -A$) yield imaginary (or zero) eigenvalues.<br>- <strong>C:</strong> True. Orthogonal matrices preserve vector lengths , thus their eigenvalues must lie exactly on the unit circle in the complex plane ($|\lambda| = 1$).</p><p><strong>Why D is FALSE:</strong> The identity matrix $I_n$ has exactly ONE eigenvalue ($1$) repeated $n$ times (algebraic multiplicity of $n$). They are certainly not distinct.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q59 â€” MSQ: Limits and Continuity (medium)
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
 '<p><strong>âœ“ Answers: A, B, C, D.</strong></p><p><strong>Rationale:</strong> The formal robust definition of pointwise continuity mandates that ALL these intricately linked conditions hold. If the limit exists (requiring LHL=RHL), and the function value exists, they must mutually converge to the same identical value at $x=c$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits');

-- Q60 â€” MSQ: Probability Distributions (easy)
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
 '<p><strong>âœ“ Answers: A, B.</strong></p><p><strong>Rationale:</strong> Discrete distributions handle countable quantities (e.g., integer numbers like "heads in 10 flips" or "events per hour"). Binomial and Poisson fiercely fit this explicit definition.</p><p><strong>Why C and D are FALSE:</strong> Normal and Exponential distributions model <em>continuous</em> variables (like exact fluid height, infinite-precision lifespan, or measurable temperature) defined over an interval range using Probability Density Functions (PDFs).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('distributions');

-- Q61 â€” MSQ: Linear Equations Consistencies (hard)
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
 '<p><strong>âœ“ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Homogeneous systems anchor on the $B=0$ vector.<br>- <strong>A:</strong> X=0 is ALWAYS a valid trivial solution, preventing inconsistency.<br>- <strong>B:</strong> If variables outnumber equations ($n > m$), the rank can never reach $n$, leaving rigidly free variables, thereby unleashing infinitely many solutions.<br>- <strong>C:</strong> A full rank ($r=n$) locks down exactly 0 free variables, forcing the $X=0$ unique trivial solution.</p><p><strong>Why D is FALSE:</strong> If Rank $< n$ in a square array context, the matrix is singular, dictating that $|A|$ is EXACTLY zero.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('system-of-equations','matrix');

-- Q62 â€” MSQ: Positive Definite Matrices (hard)
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
 '<p><strong>âœ“ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> The defining identity of Positive Definite systems:<br>- <strong>A:</strong> positive eigenvalues ($\lambda_i > 0$) define the core characteristic.<br>- <strong>B:</strong> Determinant is broadly the product of positive eigenvalues, thereby staying positive.<br>- <strong>C:</strong> An strict mathematical consequence demands all main-axis diagonal trace inputs intrinsically exceed zero.</p><p><strong>Why D is FALSE:</strong> Positive Definite means $x^T A x > 0$. The $\ge$ inclusive inequality rigidly corresponds to a Positive <em>SEMI-Definite</em> matrix, which vastly tolerates exactly zero eigenvalues.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q63 â€” MSQ: Taylor Series derivatives (medium)
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
 '<p><strong>âœ“ Answers: A, C.</strong></p><p><strong>Rationale:</strong><br>- <strong>A:</strong> The derivative of pure $e^x$ unambiguously remains exactly $e^x$ infinitely.<br>- <strong>C:</strong> The derivative of exactly 0 is permanently exactly 0 globally.</p><p><strong>Why B and D are FALSE:</strong> Sine oscillates cyclically to cosine, -sine, -cosine. Polynomial $x^n$ permanently diminishes forcefully down to exactly 0 after $n+1$ operations, drastically destroying the original identical structure .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('derivatives');

-- Q64 â€” MSQ: Bayes parameters (medium)
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
 '<p><strong>âœ“ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> Bayes'' widely celebrated Theorem asserts: $P(A|B) = \frac{P(B|A) \times P(A)}{P(B)}$.<br>This commands utilizing exactly: Prior ($P(A)$), defined Likelihood ($P(B|A)$), and comprehensive Marginal normalizer ($P(B)$) .</p><p><strong>Why D is FALSE:</strong> Expected values govern heavy variance frameworks, bypassing fundamental pure combinatoric or continuous probabilistic frequency dependencies isolated in pure Bayesian logic .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('probability','bayes-theorem');

-- Q65 â€” MSQ: Extreme point constraints (easy)
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
 '<p><strong>âœ“ Answers: A, C.</strong></p><p><strong>Rationale:</strong> To isolate exactly a Local Maximum globally:<br>- First step: The tangent slope flatlines. (First constraint $f''(c) = 0$).<br>- Second step: The curve bends downward globally identical to a dome. (Second constraint $f''''(c) < 0$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('maxima-minima','derivatives');

-- Part 6 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” EM PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1: Linear Algebra and Calculus (11 Cards)
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
-- Card 1: Rank property
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='matrix-inverse-rank' LIMIT 1),
  'What is the formula for the Rank of a product of matrices $AB$ (Sylvester''s Inequality)?',
  '<p><strong>Rank($AB$) $\le \min(\text{Rank}(A), \text{Rank}(B))$</strong></p><p>Multiplication cannot increase the rank beyond the limits of either individual operand.</p>',
  ARRAY['matrix']
),
-- Card 2: Consistency
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='linear-equations' LIMIT 1),
  'How do you check consistency of a system of linear equations $AX = B$?',
  '<p>Compare the rank of Coefficient Matrix $A$ and Augmented Matrix $(A|B)$:</p><ul><li><strong>Rank($A$) $\neq$ Rank($A|B$):</strong> Inconsistent (No solution)</li><li><strong>Rank($A$) = Rank($A|B$) = $n$ (variables):</strong> Consistent, Unique Solution</li><li><strong>Rank($A$) = Rank($A|B$) < $n$:</strong> Consistent, Infinitely Many Solutions</li></ul>',
  ARRAY['system-of-equations','matrix']
),
-- Card 3: Eigenvalues to trace/det
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='eigenvalues-eigenvectors' LIMIT 1),
  'State the properties relating Eigenvalues to Matrix Trace and Determinant.',
  '<p>For any $n \times n$ matrix $A$:</p><ul><li><strong>Sum of Eigenvalues:</strong> $\sum \lambda_i = \text{Trace}(A)$ <em>(sum of main diagonal elements)</em></li><li><strong>Product of Eigenvalues:</strong> $\prod \lambda_i = \det(A)$</li></ul>',
  ARRAY['eigenvalues','determinant','matrix']
),
-- Card 4: Special Eigenvalues
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='eigenvalues-eigenvectors' LIMIT 1),
  'What are the eigenvalues for Symmetric, Skew-Symmetric, and Orthogonal matrices?',
  '<ul><li><strong>Real Symmetric ($A^T = A$):</strong> All eigenvalues are Real.</li><li><strong>Real Skew-Symmetric ($A^T = -A$):</strong> All eigenvalues are Purely Imaginary or Zero.</li><li><strong>Orthogonal ($A^T A = I$):</strong> All eigenvalues lie on the unit circle ($| \lambda | = 1$).</li></ul>',
  ARRAY['eigenvalues','matrix']
),
-- Card 5: Cayley
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cayley-hamilton' LIMIT 1),
  'State the Cayley-Hamilton Theorem.',
  '<p><strong>"Every square matrix satisfies its own characteristic equation."</strong></p><p>If the characteristic equation $|A - \lambda I| = 0$ is a polynomial $P(\lambda) = 0$, then substituting the matrix $A$ in place of $\lambda$ yields the zero matrix: $P(A) = 0$.</p>',
  ARRAY['matrix','eigenvalues']
),
-- Card 6: Eigen transformation
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='eigenvalues-eigenvectors' LIMIT 1),
  'If $\lambda$ is an eigenvalue of non-singular matrix $A$, what are the eigenvalues of $A^{-1}$, $A^k$, and $(A - cI)$?',
  '<ul><li><strong>$A^{-1}$:</strong> $1/\lambda$</li><li><strong>$A^k$:</strong> $\lambda^k$</li><li><strong>$(A - cI)$:</strong> $\lambda - c$</li><li><strong>$adj(A)$:</strong> $|A| / \lambda$</li></ul><p><em>The eigenvectors for all these remain identical to $A$.</em></p>',
  ARRAY['eigenvalues','matrix']
),
-- Card 7: Idempotent/Nilpotent
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='linear-algebra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='matrix-operations' LIMIT 1),
  'Define an Idempotent Matrix and a Nilpotent Matrix.',
  '<ul><li><strong>Idempotent:</strong> $A^2 = A$. <em>(Eigenvalues are 0 or 1)</em></li><li><strong>Nilpotent:</strong> $A^k = 0$ for positive integer $k$. <em>(Eigenvalues are 0)</em></li></ul>',
  ARRAY['matrix']
),
-- Card 8: L'Hopital
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='limits' LIMIT 1),
  'Explain L''HÃ´pital''s Rule.',
  '<p>If $\lim \frac{f(x)}{g(x)}$ yields $0/0$ or $\infty/\infty$, take the derivative of the numerator $f''(x)$ and the denominator $g''(x)$. Evaluate $\lim \frac{f''(x)}{g''(x)}$. Apply iteratively if needed.</p>',
  ARRAY['limits','derivatives']
),
-- Card 9: Mean Value
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mean-value-theorems' LIMIT 1),
  'Compare Rolle''s Theorem and Lagrange Mean Value Theorem (LMVT).',
  '<p>Both require $f(x)$ continuous on $[a, b]$ and differentiable on $(a, b)$.</p><ul><li><strong>Rolle''s:</strong> Requires $f(a) = f(b)$. Guarantees $c$ where $f''(c) = 0$.</li><li><strong>LMVT:</strong> Guarantees $c$ where $f''(c) = \frac{f(b) - f(a)}{b - a}$ (tangent parallel to secant).</li></ul>',
  ARRAY['mean-value-theorem','derivatives']
),
-- Card 10: Definite Integral parity
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='integration' LIMIT 1),
  'State the definite integral parity rule for Symmetric Limits ($\int_{-a}^a$).',
  '<p>When integrating from $-a$ to $a$:</p><ul><li>If $f(x)$ is an <strong>ODD</strong> function ($f(-x) = -f(x)$), the integral is <strong>$0$</strong>.</li><li>If $f(x)$ is an <strong>EVEN</strong> function ($f(-x) = f(x)$), the integral is <strong>$2 \int_0^a f(x) dx$</strong>.</li></ul>',
  ARRAY['integration']
),
-- Card 11: Leibniz Rule
(
  (SELECT id FROM subjects WHERE slug='em'),
  (SELECT id FROM chapters WHERE slug='calculus' LIMIT 1),
  (SELECT id FROM topics WHERE slug='integration' LIMIT 1),
  'What is Leibnitz''s Rule for differentiating an integral with variable limits?',
  '<p>If $I(x) = \int_{a(x)}^{b(x)} f(t) dt$, then the derivative is:</p><p><strong>$I''(x) = f(b(x)) \cdot b''(x) - f(a(x)) \cdot a''(x)$</strong></p><p><em>Often tested in L''HÃ´pital limits containing integrals.</em></p>',
  ARRAY['integration','derivatives']
);

-- Part 7 complete.
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- EXAMFORGE â€” EM PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2: Probability & Statistics (11 Cards) + COMMIT block
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

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

-- â”€â”€â”€ POST-SEED VERIFICATION QUERIES â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
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

-- â”€â”€â”€ STATS COMMENT BLOCK â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
-- STATS:
-- Subject slug: em
-- Schema version: v2 (normalized tags, NUMERIC(10,2) NAT, topic enforcement)
-- Chapters:     3 (Linear Algebra, Calculus, Probability & Statistics)
-- Topics:       22
-- Questions:    65 total
--   MCQ:        45 (Q1â€“Q45)
--   NAT:        10 (Q46â€“Q55)
--   MSQ:        10 (Q56â€“Q65)
-- Flashcards:   22 concise mathematical theory cards
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- END OF em-seed.sql
-- â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
