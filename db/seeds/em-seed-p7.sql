-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — EM PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1: Linear Algebra and Calculus (11 Cards)
-- ═══════════════════════════════════════════════════════════════════════════

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
  'Explain L''Hôpital''s Rule.',
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
  '<p>If $I(x) = \int_{a(x)}^{b(x)} f(t) dt$, then the derivative is:</p><p><strong>$I''(x) = f(b(x)) \cdot b''(x) - f(a(x)) \cdot a''(x)$</strong></p><p><em>Often tested in L''Hôpital limits containing integrals.</em></p>',
  ARRAY['integration','derivatives']
);

-- Part 7 complete.
