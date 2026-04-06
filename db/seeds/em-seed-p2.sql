-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — EM PYQ SEED v2  (Part 2 / 8)
-- MCQ Questions Q1–Q14 (Linear Algebra)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — Rank of a matrix (easy)
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
  '<p><strong>✓ Answer: A — 4.</strong></p><p><strong>Step-by-step:</strong> The rank of a matrix $A$ of dimension $m \times n$ is bounded by the minimum of its dimensions. Mathematically, $\text{Rank}(A) \le \min(m, n)$. Since $A$ is $4 \times 5$, $\min(4, 5) = 4$. So the maximum possible rank is 4.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Q2 — Determinant properties (medium)
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
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> When a matrix $A$ is multiplied by a scalar $k$, every single element of the matrix is multiplied by $k$. Because the determinant scales linearly with each row (or column), multiplying $n$ rows by $k$ results in factoring out $k$ exactly $n$ times. Therefore, $|kA| = k^n |A|$.</p><p><strong>GATE trap:</strong> Many students mistakenly pick $k|A|$. Remember, $k$ comes out of EVERY row one by one.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('determinant','matrix');

-- Q3 — System of Linear Equations (medium)
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
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Step-by-step:</strong><br>- If $\rho(A) \neq \rho(A|B)$, the system is <strong>inconsistent</strong> (no solution).<br>- If $\rho(A) = \rho(A|B) = r$, the system is <strong>consistent</strong>.<br>- If $r = n$ (number of variables), there is a <strong>unique solution</strong>.<br>- If $r < n$, there are $n - r$ free variables, leading to <strong>infinitely many solutions</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('system-of-equations');

-- Q4 — Eigenvalue trace/determinant property (easy)
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
  '<p><strong>✓ Answer: B — 4.</strong></p><p><strong>Step-by-step:</strong><br>Property 1: Sum of eigenvalues = Trace of matrix. $\lambda_1 + \lambda_2 + \lambda_3 = 10$.<br>Property 2: Product of eigenvalues = Determinant. $\lambda_1 \times \lambda_2 \times \lambda_3 = 24$.<br>Given $\lambda_1 = 2$ and $\lambda_2 = 4$.<br>Using Sum: $2 + 4 + \lambda_3 = 10 \implies \lambda_3 = 4$.<br>Check Product: $2 \times 4 \times 4 = 32 \neq 24$. Wait! Let me re-read the question.<br>If product is 24, $2 \times 4 \times \lambda_3 = 24 \implies \lambda_3 = 3$.<br>Let''s check the Sum: $2 + 4 + 3 = 9$. But trace is given as 10. This matrix configuration is highly conflicting mathematically as written, meaning no such matrix exists! However, usually these questions are mathematically sound. Let me rewrite the question values to perfectly align.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues');

-- Update the faulty Q4 text to be mathematically correct.
UPDATE questions SET question_text = 'A $3 \times 3$ matrix $A$ has trace 10 and determinant 24. If two of its eigenvalues are 2 and 4, what is the third eigenvalue? Wait, $2+4+3=9 \neq 10$. Let''s use trace=9, det=24. Two eigenvalues are 2 and 4. What is the third eigenvalue?', option_a = '3', correct_option = 'A', explanation = '<p><strong>✓ Answer: A — 3.</strong></p><p><strong>Step-by-step:</strong><br>Sum of eigenvalues = Trace. $2 + 4 + \lambda_3 = 9 \implies \lambda_3 = 3$.<br>Check product: $2 \times 4 \times 3 = 24$, which matches the determinant. So the third eigenvalue is 3.</p>' WHERE question_text LIKE 'A $3 \times 3$ matrix $A$ has trace 10%';

-- Clean up Q4 text fully
UPDATE questions SET question_text = 'A $3 \times 3$ matrix $A$ has trace 9 and determinant 24. If two of its eigenvalues are 2 and 4, what is the third eigenvalue?' WHERE question_text LIKE 'A $3 \times 3$ matrix $A$ has trace 9%';

-- Q5 — Inverse of a matrix (medium)
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
  '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> The inverse operation is NOT linear with respect to addition. Just like $1/(a+b) \neq 1/a + 1/b$ for real numbers, $(A+B)^{-1} \neq A^{-1} + B^{-1}$ for matrices in general.</p><p><strong>Why A, B, C are TRUE:</strong><br>- Reversal law of inverses: $(AB)^{-1} = B^{-1} A^{-1}$<br>- Transpose commutes with inverse: $(A^T)^{-1} = (A^{-1})^T$<br>- Determinant of inverse: $|A^{-1}| = |A|^{-1}$</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix','determinant');

-- Q6 — Cayley-Hamilton Theorem (medium)
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
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Step-by-step:</strong><br>1. From Cayley-Hamilton: $A^2 - 5A + 6I = 0$<br>2. Multiply both sides by $A^{-1}$: $A - 5I + 6A^{-1} = 0$<br>3. Isolate $A^{-1}$: $6A^{-1} = 5I - A$<br>4. Divide by 6: $A^{-1} = \frac{1}{6}(5I - A)$</p><p><strong>GATE trap:</strong> When multiplying by $A^{-1}$, the constant term $6$ becomes $6A^{-1}$ (since $6I \cdot A^{-1} = 6A^{-1}$). This is the standard trick to find inverse equations quickly.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix','eigenvalues');

-- Q7 — Orthogonal Matrix (medium)
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
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> For an orthogonal matrix, $Q^T Q = I$. Taking the determinant on both sides: $|Q^T Q| = |I| \implies |Q^T| |Q| = 1 \implies |Q|^2 = 1$. Thus, the determinant $|Q|$ can be either $+1$ or $-1$. It is not NECESSARILY equal to $+1$.</p><p><strong>Why others are ALWAYS true:</strong><br>- Definition of orthogonal matrix: $Q^T Q = Q Q^T = I$<br>- This implies $Q^{-1} = Q^T$<br>- The columns (and rows) of $Q$ are mutually orthogonal unit vectors, forming an orthonormal basis.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Q8 — Eigenvectors of symmetric matrix (hard)
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
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The Spectral Theorem for real symmetric matrices states two fundamental properties:<br>1. All its eigenvalues are strictly REAL.<br>2. Eigenvectors corresponding to DISTINCT eigenvalues are strictly ORTHOGONAL to each other.<br>Additionally, every real symmetric matrix is diagonalizable using an orthogonal matrix.</p><p><strong>GATE trap:</strong> Skew-symmetric real matrices have purely imaginary or zero eigenvalues. Orthogonal matrices have eigenvalues with absolute value 1. Real symmetric matrices have real eigenvalues.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q9 — Rank of XY (medium)
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
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Step-by-step:</strong> According to Sylvester''s Rank Inequality, the rank of a product of matrices is bounded above by the rank of each individual matrix. Specifically: $\text{Rank}(XY) \le \text{Rank}(X)$ AND $\text{Rank}(XY) \le \text{Rank}(Y)$. Thus, $\text{Rank}(XY) \le \min(\text{Rank}(X), \text{Rank}(Y))$.</p><p><strong>GATE tip:</strong> Multiplication can only "destroy" information (reduce rank), never create it.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Q10 — Singular Matrix Eigenvalue (easy)
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
  '<p><strong>✓ Answer: A — 0.</strong></p><p><strong>Rationale:</strong> A matrix is singular if and only if its determinant is exactly 0. The determinant of a matrix is the product of all its eigenvalues ($\lambda_1 \times \lambda_2 \times \ldots \times \lambda_n = |A|$). For the product to be 0, at least one of the eigenvalues MUST be strictly zero.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','determinant');

-- Q11 — Nilpotent Matrix (medium)
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
  '<p><strong>✓ Answer: B — All eigenvalues are 0.</strong></p><p><strong>Step-by-step:</strong> Let $\lambda$ be an eigenvalue of $A$ with eigenvector $x \neq 0$. Then $Ax = \lambda x$.<br>Multiply by $A$: $A^2 x = A(\lambda x) = \lambda(Ax) = \lambda^2 x$.<br>By induction: $A^k x = \lambda^k x$.<br>Since $A$ is nilpotent, $A^k = 0$, so $0 \cdot x = \lambda^k x$.<br>Since $x \neq 0$, we must have $\lambda^k = 0 \implies \lambda = 0$. Thus, EVERY eigenvalue is 0.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues','matrix');

-- Q12 — LU Decomposition condition (medium)
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
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The standard $LU$ decomposition (without pivoting/row exchanges) relies on Gaussian elimination proceeding without ever having to swap rows due to a zero pivot. This is mathematically guaranteed if and only if all leading principal minors (the top-left $1 \times 1, 2 \times 2, \ldots, n \times n$ sub-determinants) are strictly non-zero.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('matrix');

-- Q13 — Cramer's Rule (easy)
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
  '<p><strong>✓ Answer: C — The determinant of the coefficient matrix A.</strong></p><p><strong>Rationale:</strong> Cramer''s Rule states that $x_i = |A_i| / |A|$, where $|A|$ is the determinant of the coefficient matrix, and $|A_i|$ is the determinant of the matrix formed by replacing the $i$-th column of $A$ with the constants column vector $B$. Note that Cramer''s rule ONLY applies when $|A| \neq 0$ (unique solution).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('system-of-equations','determinant');

-- Q14 — Eigenvector scaling (easy)
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
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Step-by-step:</strong> Definition: $Av = \lambda v$.<br>Multiply both sides by scaler $c$: $c(Av) = c(\lambda v)$.<br>Because matrix multiplication is linear: $A(cv) = \lambda (cv)$.<br>Therefore, the vector $(cv)$ is ALSO an eigenvector of $A$, and it corresponds to the EXACT SAME eigenvalue $\lambda$. Eigenvectors only define a "direction"; their scaling does not change their status as eigenvectors for that specific $\lambda$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('eigenvalues');

-- Part 2 complete.
