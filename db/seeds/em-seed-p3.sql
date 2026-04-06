-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — EM PYQ SEED v2  (Part 3 / 8)
-- MCQ Questions Q15–Q28 (Calculus)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — Limit using L'Hopital (easy)
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
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Step-by-step:</strong> Plugging in $x=0$ yields $0/0$, so we can apply L''Hôpital''s Rule.<br>Take derivative of numerator: $a \cos(ax)$.<br>Take derivative of denominator: $b \cos(bx)$.<br>Evaluate limit at $x=0$: $\frac{a \cos(0)}{b \cos(0)} = \frac{a \cdot 1}{b \cdot 1} = \frac{a}{b}$.</p><p>Alternatively, using the standard limit $\lim_{x \to 0} \frac{\sin x}{x} = 1$:<br>$\frac{\sin(ax)}{\sin(bx)} = \frac{\frac{\sin(ax)}{ax} \cdot ax}{\frac{\sin(bx)}{bx} \cdot bx} \rightarrow \frac{1 \cdot ax}{1 \cdot bx} = \frac{a}{b}$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits');

-- Q16 — Continuity vs Differentiability (medium)
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
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong><br>- <strong>Continuity:</strong> $\lim_{x \to 0^-} |x| = 0$, $\lim_{x \to 0^+} |x| = 0$, and $f(0) = 0$. Since they all match, it is continuous.<br>- <strong>Differentiability:</strong> The left-hand derivative (LHD) is $\lim_{h \to 0^-} \frac{|h| - 0}{h} = \frac{-h}{h} = -1$. The right-hand derivative (RHD) is $\lim_{h \to 0^+} \frac{|h| - 0}{h} = \frac{h}{h} = 1$. Since LHD $\neq$ RHD, there is a sharp "corner" at $x=0$, making it NOT differentiable.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits');

-- Q17 — Rolle's Theorem conditions (easy)
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
  '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> Rolle''s Theorem requires ONLY three conditions:<br>1. $f(x)$ continuous on $[a, b]$<br>2. $f(x)$ differentiable on $(a, b)$<br>3. $f(a) = f(b)$<br>If these hold, the theorem guarantees there exists at least one $c$ in $(a, b)$ such that $f''(c) = 0$. It absolutely DOES NOT require the function value $f(x)$ to be 0 anywhere.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('mean-value-theorem','derivatives');

-- Q18 — Local Maxima condition (medium)
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
  '<p><strong>✓ Answer: C — $f''''(c) < 0$.</strong></p><p><strong>Step-by-step:</strong><br>- First derivative test: $f''(c) = 0$ identifies a critical stationary point.<br>- Second derivative test: The value of $f''''(c)$ tells us about concavity.<br>- If $f''''(c) > 0$, the curve is concave "upward" (like a cup $U$), meaning $c$ is a local MINIMUM.<br>- If $f''''(c) < 0$, the curve is concave "downward" (like a hat $\cap$), meaning $c$ is a local MAXIMUM.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('maxima-minima','derivatives');

-- Q19 — Integration by Parts (medium)
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
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Step-by-step:</strong> We use Integration by Parts: $\int u dv = uv - \int v du$.<br>Using LIATE rule, let $u = x$ and $dv = e^x dx$.<br>Then $du = dx$, and $v = e^x$.<br>Plugging into formula: $\int x e^x dx = x e^x - \int e^x dx$<br>$= x e^x - e^x + C$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration');

-- Q20 — Even function definite integral (easy)
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
  '<p><strong>✓ Answer: C — 0.</strong></p><p><strong>Rationale:</strong> The area under the curve for an alternating symmetric function from $-a$ to $0$ is the exact negative of the area from $0$ to $a$. For example, $\int_{-a}^{a} x^3 dx$. The positive and negative areas perfectly cancel each other out, always equating to exactly 0.</p><p><strong>GATE trap:</strong> The answer $2 \int_0^a f(x) dx$ applies if $f(x)$ is an EVEN function ($f(-x) = f(x)$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration');

-- Q21 — Limit using Expansion (hard)
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
  '<p><strong>✓ Answer: B — $1/2$.</strong></p><p><strong>Method 1 (L''Hôpital):</strong><br>Plug $x=0 \implies 0/0$. Apply L''H Rule:<br>Deriv(num) = $e^x - 1$. Deriv(den) = $2x$.<br>Limit $\rightarrow \frac{e^x - 1}{2x}$. Still $0/0$. Apply again:<br>Deriv(num) = $e^x$. Deriv(den) = $2$.<br>Evaluate limit at $x=0$: $e^0 / 2 = 1/2$.</p><p><strong>Method 2 (Maclaurin Series):</strong><br>Expansion of $e^x = 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \ldots$<br>Numerator: $(1 + x + x^2/2 + \ldots) - 1 - x = x^2/2 + x^3/6 + \ldots$<br>Divide by $x^2$: $1/2 + x/6 + \ldots$<br>Take limit as $x \to 0$: $1/2$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits','derivatives');

-- Q22 — Partial Derivatives (medium)
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
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Clairaut''s Theorem (also known as Schwarz''s Theorem) states that if the mixed partial derivatives $\frac{\partial^2 f}{\partial x \partial y}$ and $\frac{\partial^2 f}{\partial y \partial x}$ are continuous on a domain, then they are absolutely equal. Thus, the order of differentiation does not matter.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('derivatives');

-- Q23 — Lagrange Mean Value Theorem (medium)
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
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The term $\frac{f(b) - f(a)}{b - a}$ is precisely the mathematical formula for the slope of the secant line cutting through the endpoints of the interval. LMVT guarantees there is at least one tangent line inside the interval that is perfectly parallel (has exact same slope) to this secant line.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('mean-value-theorem','derivatives');

-- Q24 — Indeterminate Forms (easy)
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
  '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> $\infty + \infty = \infty$. It is completely deterministic and strictly unbounded. The other options $(0^0, \frac{\infty}{\infty}, 0 \times \infty)$ are strict indeterminate forms because different functions taking these limits converge asymptotically to entirely different finite (or infinite) constant values, hence needing L''Hôpital or series expansions.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('limits');

-- Q25 — Definite integral properties (medium)
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
  '<p><strong>✓ Answer: B — $\pi / 4$.</strong></p><p><strong>Step-by-step:</strong><br>1. Original: $I = \int_0^{\pi/2} \frac{\sin^n x}{\sin^n x + \cos^n x} dx$<br>2. Apply property: Replace $x$ with $(\pi/2 - x)$. We know $\sin(\pi/2 - x) = \cos x$ and $\cos(\pi/2 - x) = \sin x$.<br>3. This gives: $I = \int_0^{\pi/2} \frac{\cos^n x}{\cos^n x + \sin^n x} dx$<br>4. Add the two $I$ equations together: $2I = \int_0^{\pi/2} \frac{\sin^n x + \cos^n x}{\sin^n x + \cos^n x} dx$<br>5. $2I = \int_0^{\pi/2} 1 dx = \pi/2$.<br>6. $I = \pi / 4$.</p><p><strong>GATE trap:</strong> This result is robust and independent of $n$. Whether it''s $\sqrt{\sin x}$ or $\sin^5 x$, the answer is solidly $\pi / 4$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration');

-- Q26 — Maclaurin series application (hard)
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
  '<p><strong>✓ Answer: A — $1/3$.</strong></p><p><strong>Step-by-step:</strong><br>The Taylor (Maclaurin) series for $f(x) = \ln(1+x)$ is given by $\sum_{n=1}^\infty (-1)^{n+1} \frac{x^n}{n}$.<br>Expanding elements: $x - \frac{x^2}{2} + \frac{x^3}{3} - \frac{x^4}{4} + \ldots$<br>The strictly $x^3$ term is $+\frac{x^3}{3}$.<br>Therefore, the coefficient is exactly $1/3$.</p><p><strong>Why D is wrong:</strong> Many students confuse this with standard Taylor expansion $\frac{f^{(n)}(0)}{n!}$. The derivative $f''''''(0) = 2$, and $2/(3!) = 2/6 = 1/3$. Be extremely careful with signs and factorials!</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('derivatives');

-- Q27 — Saddle Point (medium)
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
  '<p><strong>✓ Answer: C — $D < 0$.</strong></p><p><strong>Step-by-step Second Derivative Test for 2 Vars:</strong><br>- If $D > 0$ and $f_{xx} > 0 \implies$ Local Minimum.<br>- If $D > 0$ and $f_{xx} < 0 \implies$ Local Maximum.<br>- If $D < 0 \implies$ <strong>Saddle Point</strong> (looks like a mountain pass; curves up horizontally but curves down vertically).<br>- If $D = 0 \implies$ Inconclusive.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('maxima-minima','derivatives');

-- Q28 — Integration basic property (easy)
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
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Reversing the upper and lower limits of integration multiplies the entire definite integral strictly by $-1$. This is a fundamental axiom defined in Riemann sums (where $\Delta x$ flips sign from $\frac{b-a}{n}$ to $\frac{a-b}{n}$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('integration');

-- Part 3 complete.
