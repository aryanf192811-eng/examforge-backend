-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — ALGORITHMS PYQ SEED v2 (Part 2 / 8)
-- MCQ Questions Q1–Q14 (Asymptotics & Divide and Conquer)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — Big-O Definition (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='asymptotic-notations' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Mathematically, a function $f(n) = O(g(n))$ if and only if there exist positive constants $c$ and $n_0$ such that:',
 '$0 \le f(n) \le c \cdot g(n)$ for all $n \ge n_0$',
 '$0 \le c \cdot g(n) \le f(n)$ for all $n \ge n_0$',
 '$0 \le f(n) < c \cdot g(n)$ for all $n \ge n_0$',
 '$f(n) = c \cdot g(n)$ for all $n \ge n_0$',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Big-O notation provides an asymptotic upper bound. $f(n)$ grows no faster than $g(n)$ multiplied by some constant $c$, eventually holding true for all input past a threshold $n_0$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('asymptotic-notation');

-- Q2 — Comparing Growth Rates (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='time-complexity' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Consider the functions $f(n) = 2^n$ and $g(n) = n!$. Which of the following asymptotic relationships accurately describes their growth rates as $n \to \infty$?',
 '$f(n) = O(g(n))$',
 '$f(n) = \Omega(g(n))$',
 '$f(n) = \Theta(g(n))$',
 '$g(n) = O(f(n))$',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The factorial function $n!$ fundamentally grows much faster than any exponential function with a constant base like $2^n$. Therefore, $2^n$ is upper-bounded by $n!$, making $f(n) = O(g(n))$ the only true statement.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('asymptotic-notation');

-- Q3 — Loop complexity (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='time-complexity' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Consider a loop defined as: `for (i = 1; i <= n; i = i * 2)`. What is the strict temporal complexity of this loop?',
 '$O(n)$',
 '$O(n \log n)$',
 '$O(\log n)$',
 '$O(1)$',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The loop variable `i` doubles each iteration ($1, 2, 4, 8 \dots$). It reaches $n$ after exactly $\log_2(n)$ steps. Thus, the time complexity is $O(\log n)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-complexity');

-- Q4 — Master Theorem applicability (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recurrence-relations' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Why can the Master Theorem NOT be used to instantly solve the recurrence relationship $T(n) = 2T(n/2) + n \log n$?',
 'Because $a$ and $b$ must be greater than 2',
 'Because the driving function $f(n) = n \log n$ is not polynomially larger than $n^{\log_b a}$',
 'Because it belongs to Case 1',
 'Because the base case $T(1)$ is implicitly negative',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Here $a=2, b=2 \implies n^{\log_b a} = n^1 = n$. The driving $f(n)$ is $n \log n$. To apply standard Case 3, $f(n)$ must be polynomially greater than $n^1$ (i.e., $n^{1+\epsilon}$). However, $n \log n$ is only logarithmically larger, causing it to fall between Case 2 and Case 3, requiring the extended Master theorem to $O(n \log^2 n)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('master-theorem');

-- Q5 — Solving Recurrence T(n)=T(n-1) (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recurrence-relations' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Identify the asymptotic time complexity for the recurrence $T(n) = T(n-1) + n$, assuming $T(1) = 1$.',
 '$O(n)$',
 '$O(n \log n)$',
 '$O(n^2)$',
 '$O(2^n)$',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Expanding the recurrence using back substitution: $T(n) = n + (n-1) + (n-2) + \dots + 1$. This is an arithmetic series the sum of the first $n$ integers, which evaluates to $\frac{n(n+1)}{2}$. Asymptotically, this is $O(n^2)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-complexity');

-- Q6 — Binary Search Recurrence (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='divide-conquer' LIMIT 1),
 (SELECT id FROM topics WHERE slug='binary-search-algo' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Which of the following recurrence relations accurately models the standard recursive Binary Search algorithm on a sorted array?',
 '$T(n) = 2T(n/2) + O(1)$',
 '$T(n) = T(n/2) + O(1)$',
 '$T(n) = T(n-1) + O(1)$',
 '$T(n) = 2T(n/2) + O(n)$',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Binary search makes exactly one comparison $O(1)$ and then recursively calls itself exactly once on half of the array ($T(n/2)$). Therefore, $T(n) = T(n/2) + O(1)$, which solves to $O(\log n)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('divide-conquer');

-- Q7 — Quick Sort worst case (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='divide-conquer' LIMIT 1),
 (SELECT id FROM topics WHERE slug='merge-quick-sort' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'When does the classic Quick Sort algorithm experience its absolute worst-case time complexity of $O(n^2)$?',
 'When the input array contains random noise',
 'When the pivot divides the array perfectly in half every time',
 'When the input array is ordered (sorted or reverse-sorted) and the pivot is chosen deterministically as the last element',
 'When all elements in the array are prime numbers',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The worst case manifests when the partition physically isolates an empty sub-array on one side and an $n-1$ element sub-array on the other. This occurs if the array is already sorted, yielding $T(n) = T(n-1) + O(n) = O(n^2)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-complexity');

-- Q8 — Merge Sort vs Quicksort stability (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='divide-conquer' LIMIT 1),
 (SELECT id FROM topics WHERE slug='merge-quick-sort' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'When classic comparative sorts, why is Merge Sort considered "Stable" while standard Quick Sort is fundamentally considered "Unstable"?',
 'Merge sort uses less auxiliary memory than quick sort',
 'Merge sort guarantees absolute preservation of the original relative order between valued elements during the merge phase',
 'Quick sort is more stable because it sorts in-place',
 'Merge sort avoids recursion ',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Stability means that identical keys retain their original chronological sequence. Merge sort achieves this because the merge step rigidly favors the left sub-array upon encountering equal values. Quick sort''s aggressive swapping violently disrupts the relative order of identical elements.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('divide-conquer');

-- Q9 — Divide and Conquer steps (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='divide-conquer' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dac-paradigm' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'Which of the following encompasses the three formal phases of the Divide and Conquer algorithmic paradigm?',
 'Initialization, Execution, Termination',
 'Divide, Conquer, Combine',
 'Guess, Iterate, Relax',
 'Sort, Filter, Map',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The paradigm fundamentally consists of exactly three steps: 1) <strong>Divide</strong> the huge problem into smaller logical sub-problems, 2) <strong>Conquer</strong> (solve) them recursively, and 3) <strong>Combine</strong> their solutions systematically to form the final result.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('divide-conquer');

-- Q10 — Max subarray problem (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='divide-conquer' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dac-paradigm' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'When employing a pure Divide and Conquer approach to solve the Maximum Contiguous Subarray problem in an array of $n$ elements, what is the asymptotic time complexity?',
 '$O(n^2)$',
 '$O(n \log n)$',
 '$O(n)$',
 '$O(\log n)$',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The divide and conquer approach splits the array exactly in half, solves the left and right halves recursively ($2T(n/2)$), and subsequently computes the max crossing subarray operating linearly ($O(n)$). The recurrence $T(n) = 2T(n/2) + O(n)$ yields $O(n \log n)$. (Note: Kadane''s DP algorithm achieves $O(n)$).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('divide-conquer','time-complexity');

-- Q11 — Recurrence tree depth (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recurrence-relations' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'If a recursive divide-and-conquer algorithm splits an input of size $n$ into identical subproblems of size $n/3$, what is the exact mathematical depth of its Recursion Tree extending down to base cases of size 1?',
 '$\log_2(n)$',
 '$\log_3(n)$',
 '$n/3$',
 '$3\log_2(n)$',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> At level $i$, the problem size is $n / 3^i$. The recursion halts when the explicit size reaches 1. Setting $n / 3^i = 1$ gives $3^i = n$, which resolves unequivocally to $i = \log_3(n)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-complexity');

-- Q12 — Quick Select (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='divide-conquer' LIMIT 1),
 (SELECT id FROM topics WHERE slug='merge-quick-sort' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'The QuickSelect algorithm intelligently finds the $k$-th smallest element in an unordered array. What is its mathematically <em>average-case</em> computational time complexity?',
 '$O(\log n)$',
 '$O(n)$',
 '$O(n \log n)$',
 '$O(n^2)$',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Like quicksort, it partitions the array around a pivot. Unlike quicksort, it only recurses into exactly one of the two partitions. Expected decay geometrically: $T(n) \approx T(n/2) + O(n)$, which evaluates via the Master Theorem to strict linear time $O(n)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('divide-conquer','time-complexity');

-- Q13 — O(n) notation rules (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='asymptotic-notations' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'If algorithm A has an exact complexity of $f(n) = 3n^2 + 15n \log n + 100$, what is its strict asymptotic classification using Big-Theta $\Theta$?',
 '$\Theta(n)$',
 '$\Theta(n \log n)$',
 '$\Theta(n^2)$',
 '$\Theta(n^3)$',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> In asymptotic limits ($n \to \infty$), only the fastest-growing dominant term physically dictates growth. $n^2$ outpaces $n \log n$, making the lower-order terms effectively negligible. Dropping the scalar $3$ provides the tightest bound: $\Theta(n^2)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('asymptotic-notation');

-- Q14 — Loop complexity 2 (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='time-complexity' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Evaluate the computational complexity of the code: `for (int i=1; i<=n; i++) { for (int j=1; j<=i; j++) { print(j); } }`',
 '$O(n)$',
 '$O(n \log n)$',
 '$O(n^2)$',
 '$O(2^n)$',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The inner loop triggers exactly `i` times. Summing this over the outer loop from $1$ to $n$: $\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$. Escaping constants and dropping $n$, the asymptotic rate evaluates to $O(n^2)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-complexity');

-- Part 2 Complete.
