-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — C PROGRAMMING PYQ SEED v2 (Part 3 / 8)
-- MCQ Questions Q15–Q28 (Functions, Scope & Recursion)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — Static Variable Persistence (GATE 2006)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'gate-cse',true,2006,'MCQ','medium',2,
 'What is the output?<br><pre><code class="language-c">void f() {
 static int count = 0;
 count++;
 printf("%d ", count);
}
int main() {
 f(); f(); f();
 return 0;
}</code></pre>',
 '1 1 1', '1 2 3', '0 1 2', '3 3 3', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A <code>static</code> local variable is initialized only once and retains its value between function calls. First call: count becomes 1. Second: 2. Third: 3. Output: <code>1 2 3</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions');

-- Q16 — Pass by Value Swap Failure (GATE 2008)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'gate-cse',true,2008,'MCQ','easy',2,
 'What is the output?<br><pre><code class="language-c">void swap(int a, int b) {
 int temp = a; a = b; b = temp;
}
int main() {
 int x = 10, y = 20;
 swap(x, y);
 printf("%d %d", x, y);
}</code></pre>',
 '20 10', '10 20', '20 20', '10 10', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> C passes arguments by value. The function <code>swap</code> receives copies of <code>x</code> and <code>y</code>. Swapping the copies does not affect the originals in <code>main</code>. Output: <code>10 20</code>. To actually swap, use pointers: <code>swap(int *a, int *b)</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions');

-- Q17 — Recursive Print Order (GATE 2011)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'gate-cse',true,2011,'MCQ','hard',2,
 'What is the output?<br><pre><code class="language-c">void f(int n) {
 if (n <= 0) return;
 printf("%d ", n);
 f(n - 1);
 printf("%d ", n);
}
int main() { f(3); }</code></pre>',
 '3 2 1 1 2 3', '3 2 1 0 1 2 3', '1 2 3 3 2 1', '3 2 1', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> The function prints <code>n</code> before and after the recursive call (like a pre-order + post-order traversal). Call stack: f(3) prints 3, calls f(2) which prints 2, calls f(1) which prints 1, calls f(0) which returns. Then unwinding: prints 1, 2, 3. Output: <code>3 2 1 1 2 3</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Q18 — Recursive Fibonacci Count (GATE 2014)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'gate-cse',true,2014,'MCQ','hard',2,
 'Consider the naive recursive Fibonacci:<br><pre><code class="language-c">int fib(int n) {
 if (n <= 1) return n;
 return fib(n-1) + fib(n-2);
}</code></pre>How many times is <code>fib(1)</code> called when computing <code>fib(5)</code>?',
 '3', '5', '8', '4', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Drawing the recursion tree for fib(5): fib(5)→fib(4)+fib(3), fib(4)→fib(3)+fib(2), etc. Counting all leaf nodes where n=1: fib(1) is called exactly 5 times. This exponential redundancy is why memoization or DP is preferred.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Q19 — Extern Variable Linkage (GATE 2015)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'gate-cse',true,2015,'MCQ','medium',1,
 'What does the <code>extern</code> keyword do when applied to a variable declaration inside a function?',
 'Allocates memory for a new local variable in stack',
 'Declares that the variable is defined elsewhere (another file or global scope)',
 'Makes the variable constant and read-only',
 'Restricts the variable scope to the current block only',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>extern</code> is a declaration, not a definition. It tells the compiler that storage for this variable exists somewhere else (typically at file scope or in another translation unit). No memory is allocated by an extern declaration.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions');

-- Q20 — Function Pointer Syntax (GATE 2017)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'gate-cse',true,2017,'MCQ','medium',2,
 'Which declaration defines a pointer <code>fp</code> to a function that takes two <code>int</code> and returns an <code>int</code>?',
 '<code>int *fp(int, int);</code>',
 '<code>int (*fp)(int, int);</code>',
 '<code>int *(fp)(int, int);</code>',
 '<code>(int*) fp(int, int);</code>',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The parentheses around <code>*fp</code> are critical. <code>int (*fp)(int, int)</code> declares fp as a pointer to a function. Without them, <code>int *fp(int, int)</code> declares a function returning <code>int*</code>. This is a classic C declaration reading exercise (spiral rule).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions','pointers');

-- Q21 — Tower of Hanoi Moves (GATE 2019)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'gate-cse',true,2019,'MCQ','medium',1,
 'The Tower of Hanoi problem for $n$ disks requires how many minimum moves?',
 '$n^2$',
 '$2n$',
 '$2^n - 1$',
 '$n!$',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The recurrence is $T(n) = 2T(n-1) + 1$ with $T(1) = 1$. Solving: $T(n) = 2^n - 1$. For $n=3$: 7 moves. For $n=4$: 15 moves. This is a fundamental recursion identity.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Q22 — Recursive String Reverse (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'What is the output?<br><pre><code class="language-c">void rev(char *s) {
 if (*s == ''\0'') return;
 rev(s + 1);
 printf("%c", *s);
}
int main() { rev("GATE"); }</code></pre>',
 'GATE', 'ETAG', 'E', 'Segmentation Fault', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The function recurses to the end of the string before printing. When it reaches the null terminator, it returns and each frame prints its character: E, T, A, G → "ETAG".</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Q23 — Scope of Local Variables (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'What is the output?<br><pre><code class="language-c">int x = 10;
void f() { int x = 20; printf("%d ", x); }
int main() {
 f();
 printf("%d", x);
}</code></pre>',
 '20 20', '10 10', '20 10', '10 20', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The local <code>x=20</code> in function <code>f</code> shadows the global <code>x=10</code>. Inside <code>f</code>, the local version is used (prints 20). In <code>main</code>, the global <code>x</code> is visible (prints 10). Output: <code>20 10</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions');

-- Q24 — Recursive Sum (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'What does <code>f(5)</code> return?<br><pre><code class="language-c">int f(int n) {
 if (n == 0) return 0;
 return n + f(n - 1);
}</code></pre>',
 '10', '15', '20', '5', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>f(5) = 5 + f(4) = 5 + 4 + f(3) = ... = 5+4+3+2+1+0 = 15</code>. This computes $\sum_{i=0}^{n} i = \frac{n(n+1)}{2} = 15$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Q25 — Volatile Keyword (GATE 2020)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='macros-scope' LIMIT 1),
 'gate-cse',true,2020,'MCQ','medium',1,
 'The <code>volatile</code> qualifier in C instructs the compiler to:',
 'Store the variable in a CPU register for faster access',
 'Not optimize away reads/writes because the value may change unexpectedly (e.g., by hardware or another thread)',
 'Make the variable constant after initialization',
 'Allocate the variable on the heap instead of the stack',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>volatile</code> tells the compiler that a variable''s value can change at any time without any action by the code the compiler finds nearby. The compiler must re-read the variable from memory on every access rather than caching it in a register. Common for memory-I/O and signal handlers.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q26 — Mutual Recursion (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'What is the output?<br><pre><code class="language-c">int isOdd(int);
int isEven(int n) {
 if (n == 0) return 1;
 return isOdd(n - 1);
}
int isOdd(int n) {
 if (n == 0) return 0;
 return isEven(n - 1);
}
int main() { printf("%d", isEven(4)); }</code></pre>',
 '0', '1', '4', 'Stack Overflow', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Mutual recursion: isEven(4)→isOdd(3)→isEven(2)→isOdd(1)→isEven(0)→returns 1. Since 4 is even, the result is 1 (true). This demonstrates forward declaration and mutual recursion in C.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Q27 — Returning Local Pointer Danger (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'What is the issue with this code?<br><pre><code class="language-c">int* f() {
 int x = 42;
 return &amp;x;
}
int main() {
 int *p = f();
 printf("%d", *p);
}</code></pre>',
 'Prints 42 ',
 'Compiler error: cannot return address of local',
 'Undefined behavior: returns pointer to a local variable whose lifetime has ended',
 'Prints 0',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The local variable <code>x</code> lives on the stack frame of <code>f()</code>. When <code>f</code> returns, its stack frame is deallocated, making the returned pointer dangling. Dereferencing it is undefined behavior. The compiler may warn but it compiles. Use <code>static</code> or <code>malloc</code> to fix.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions','pointers');

-- Q28 — Recursive Power of 2 (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',1,
 'What does <code>f(8)</code> return?<br><pre><code class="language-c">int f(int n) {
 if (n == 1) return 1;
 if (n % 2 != 0) return 0;
 return f(n / 2);
}</code></pre>',
 '0', '1', '8', '3', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> f(8): 8 is even → f(4): 4 is even → f(2): 2 is even → f(1): returns 1. The function whether n is a power of 2 by repeatedly halving. 8 = $2^3$, so it returns 1 (true).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Part 3 Complete: 14 unique MCQs.
