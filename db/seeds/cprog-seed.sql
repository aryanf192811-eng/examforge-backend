-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — C PROGRAMMING PYQ SEED v2 (Part 1 / 8)
-- Subject, Chapters, Topics, & Base Tags
-- ═══════════════════════════════════════════════════════════════════════════

-- 1. Subject Insert (Idempotent)
INSERT INTO subjects (name, description, difficulty, is_published, slug)
VALUES (
 'C Programming',
 'Core mechanics, memory , recursion, and pointer arithmetic based on GATE curriculum .',
 'medium',
 false,
 'cprog'
) ON CONFLICT (slug) DO NOTHING;

-- 2. Chapters Insert
WITH s AS (SELECT id FROM subjects WHERE slug='cprog')
INSERT INTO chapters (subject_id, name, order_index, is_published, slug)
VALUES
 ((SELECT id FROM s), 'Basics & Control Flow', 1, false, 'c-basics-flow'),
 ((SELECT id FROM s), 'Functions & Recursion', 2, false, 'c-functions-recursion'),
 ((SELECT id FROM s), 'Pointers & Arrays', 3, false, 'c-pointers-arrays'),
 ((SELECT id FROM s), 'Structs & Memory Allocation', 4, false, 'c-structs-memory')
ON CONFLICT (slug) DO NOTHING;

-- 3. Topics Insert
WITH 
 c1 AS (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 c2 AS (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 c3 AS (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 c4 AS (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1)
INSERT INTO topics (chapter_id, name, order_index, is_published, slug)
VALUES
 -- Chapter 1 Topics
 ((SELECT id FROM c1), 'Data Types & Operators', 1, false, 'data-types-operators'),
 ((SELECT id FROM c1), 'Control Flow (if, loops)', 2, false, 'control-flow'),
 ((SELECT id FROM c1), 'Macros & Scope', 3, false, 'macros-scope'),
 
 -- Chapter 2 Topics
 ((SELECT id FROM c2), 'Function Calls & ', 1, false, 'function-params'),
 ((SELECT id FROM c2), 'Recursion Mechanics', 2, false, 'recursion-mechanics'),
 
 -- Chapter 3 Topics
 ((SELECT id FROM c3), 'Pointer Arithmetic', 1, false, 'pointer-arithmetic'),
 ((SELECT id FROM c3), '1D and Matrix Arrays', 2, false, 'arrays-matrices'),
 ((SELECT id FROM c3), 'Strings handling', 3, false, 'strings-handling'),
 
 -- Chapter 4 Topics
 ((SELECT id FROM c4), 'Structures & Unions', 1, false, 'structs-unions'),
 ((SELECT id FROM c4), 'Dynamic Memory (malloc/free)', 2, false, 'dynamic-memory')
ON CONFLICT (slug) DO NOTHING;

-- 4. Tags Insert
INSERT INTO tags (name, slug)
VALUES
 ('C Basics', 'c-basics'),
 ('Control Flow', 'control-flow'),
 ('Pointers', 'pointers'),
 ('Arrays', 'arrays'),
 ('Functions', 'functions'),
 ('Recursion', 'recursion'),
 ('Structures', 'structs'),
 ('Memory Management', 'memory-management'),
 ('Macros', 'macros'),
 ('Pointer Arithmetic', 'pointer-arithmetic')
ON CONFLICT (slug) DO NOTHING;

-- End of Part 1.


-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — C PROGRAMMING PYQ SEED v2 (Part 2 / 8)
-- MCQ Questions Q1–Q14 (Basics, Data Types & Control Flow)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — Operator Precedence (GATE 2004)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',true,2004,'MCQ','medium',1,
 'Consider the following C program snippet:<br><pre><code class="language-c">int a = 2, b = 3, c = 4, d = 5;
int result = a * b + c / d;</code></pre>What is the value stored in <code>result</code>?',
 '6', '7', '8', '0', 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Multiplication and division have higher precedence than addition. Evaluation: <code>(2*3) + (4/5) = 6 + 0 = 6</code>. Integer division <code>4/5</code> truncates to 0.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q2 — Pre/Post Increment (GATE 2005)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',true,2005,'MCQ','medium',2,
 'What is the output of the following C code?<br><pre><code class="language-c">int x = 5;
int y = ++x;
int z = x++;
printf("%d %d %d", x, y, z);</code></pre>',
 '6 6 6', '7 6 6', '7 6 7', '6 7 6', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>++x</code> increments x to 6 first, then assigns y=6. <code>x++</code> assigns z=6 (current value), then increments x to 7. Final: x=7, y=6, z=6.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q3 — Switch Fallthrough (GATE 2007)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='control-flow' LIMIT 1),
 'gate-cse',true,2007,'MCQ','easy',2,
 'What is printed by the following code?<br><pre><code class="language-c">int c = 1;
switch(c) {
 case 1: printf("1");
 case 2: printf("2");
 default: printf("3");
}</code></pre>',
 '1', '12', '123', 'Compiler Error', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Without <code>break</code> statements, C switch-case falls through all subsequent cases. Case 1 matches, prints "1", then falls into case 2 ("2") and default ("3"). Output: "123".</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('control-flow');

-- Q4 — Bitwise Clear Lowest Bit (GATE 2012)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',true,2012,'MCQ','medium',1,
 'For a positive integer <code>x</code>, what does the expression <code>x &amp; (x - 1)</code> accomplish?',
 'Isolates the rightmost set bit',
 'Divides the number by 2',
 'Clears (turns off) the lowest set bit',
 'Reverses all bits',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Subtracting 1 from <code>x</code> flips all bits from the lowest set bit downward. ANDing with the original clears that lowest set bit. Example: <code>12 (1100) &amp; 11 (1011) = 8 (1000)</code>. This trick is used to powers of 2.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q5 — Short-Circuit Evaluation (GATE 2015)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',true,2015,'MCQ','hard',2,
 'What is the output?<br><pre><code class="language-c">int a = 0, b = 2;
if (a && ++b)
 printf("%d", b);
else
 printf("%d", b);</code></pre>',
 '0', '2', '3', 'Undefined Behavior', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> C uses short-circuit evaluation. In <code>a && ++b</code>, since <code>a=0</code> (false), the entire AND is false and <code>++b</code> is never executed. <code>b</code> remains 2. The else branch prints 2.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('control-flow');

-- Q6 — Macro Expansion Trap (GATE 2018)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='macros-scope' LIMIT 1),
 'gate-cse',true,2018,'MCQ','medium',1,
 'Given <code>#define SQR(x) x * x</code>, what does <code>SQR(3 + 2)</code> evaluate to?',
 '25', '11', '10', '13', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Macros perform textual substitution without parenthesization. <code>SQR(3+2)</code> expands to <code>3 + 2 * 3 + 2</code>. By operator precedence: <code>3 + 6 + 2 = 11</code>. The fix would be <code>#define SQR(x) ((x)*(x))</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('macros');

-- Q7 — Ternary Operator Nesting (GATE 2010)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='control-flow' LIMIT 1),
 'gate-cse',true,2010,'MCQ','medium',2,
 'What value does <code>result</code> hold after execution?<br><pre><code class="language-c">int a = 5, b = 3, c = 8;
int result = (a > b) ? ((a > c) ? a : c) : ((b > c) ? b : c);</code></pre>',
 '5', '3', '8', 'Compiler Error', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Outer condition: <code>a > b</code> is <code>5 > 3</code> → true. Inner condition: <code>a > c</code> is <code>5 > 8</code> → false, so the result is <code>c = 8</code>. This nested ternary finds the maximum of three numbers.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('control-flow');

-- Q8 — Comma Operator (GATE 2009)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',true,2009,'MCQ','medium',1,
 'What is the output?<br><pre><code class="language-c">int x = (1, 2, 3);
printf("%d", x);</code></pre>',
 '1', '2', '3', 'Compiler Error', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The comma operator evaluates each operand left to right and returns the value of the rightmost operand. <code>(1, 2, 3)</code> evaluates 1 (discards), 2 (discards), 3 (returned). So <code>x = 3</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q9 — sizeof Operator on Types (GATE 2013)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',true,2013,'MCQ','easy',1,
 'On a typical 64-bit system where <code>int</code> is 4 bytes, what does the following print?<br><pre><code class="language-c">printf("%zu", sizeof(3.14));</code></pre>',
 '4', '8', '10', '16', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In C, a floating-point literal like <code>3.14</code> without a suffix is of type <code>double</code>, which occupies 8 bytes on standard platforms (IEEE 754 double precision). Use <code>3.14f</code> for <code>float</code> (4 bytes).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q10 — Enum Values (GATE 2016)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',true,2016,'MCQ','easy',1,
 'What is the output?<br><pre><code class="language-c">enum color {RED, GREEN = 5, BLUE};
printf("%d %d %d", RED, GREEN, BLUE);</code></pre>',
 '0 1 2', '0 5 6', '1 5 6', '0 5 2', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>enum</code> starts at 0 by default. <code>RED=0</code>. <code>GREEN</code> is set to 5. <code>BLUE</code> follows sequentially as <code>5+1=6</code>. Output: <code>0 5 6</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q11 — do-while vs while (GATE 2008)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='control-flow' LIMIT 1),
 'gate-cse',true,2008,'MCQ','easy',2,
 'What is the output?<br><pre><code class="language-c">int i = 10;
do {
 printf("%d ", i);
 i--;
} while (i > 10);</code></pre>',
 'No output (loop body never executes)',
 '10',
 '10 9 8 7 6 5 4 3 2 1',
 'Infinite loop',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A <code>do-while</code> loop always executes the body at least once before the condition. It prints <code>10</code>, decrements <code>i</code> to 9, then <code>9 > 10</code> → false → exits. A regular <code>while</code> loop would produce no output.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('control-flow');

-- Q12 — Type Promotion in Expressions (GATE 2014)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',true,2014,'MCQ','hard',2,
 'What is the output?<br><pre><code class="language-c">int a = -1;
unsigned int b = 1;
if (a > b)
 printf("greater");
else
 printf("smaller");</code></pre>',
 'smaller', 'greater', 'Compiler Error', 'Undefined Behavior', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> When comparing <code>int</code> and <code>unsigned int</code>, the signed value is implicitly converted to unsigned. <code>-1</code> becomes <code>UINT_MAX</code> (e.g., 4294967295 on 32-bit), which is far greater than 1. This is a classic GATE trap on implicit type promotion.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q13 — Semicolon after for loop (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='control-flow' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'What is the output?<br><pre><code class="language-c">int i;
for (i = 0; i < 5; i++);
printf("%d", i);</code></pre>',
 '4', '5', '0', 'Infinite loop', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The semicolon <code>;</code> after the for loop creates an empty loop body. The loop runs with <code>i</code> going from 0 to 4, then <code>i</code> becomes 5 and the condition fails. The <code>printf</code> is outside the loop, printing 5.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('control-flow');

-- Q14 — Logical OR Short-Circuit (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'What is the output?<br><pre><code class="language-c">int a = 1, b = 1;
int c = a || b++;
printf("%d %d %d", a, b, c);</code></pre>',
 '1 2 1', '1 1 1', '1 2 0', '1 1 0', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Logical OR (<code>||</code>) short-circuits when the left operand is true. Since <code>a=1</code> is true, <code>b++</code> is never executed. <code>b</code> stays 1, <code>c</code> gets 1 (true). Output: <code>1 1 1</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('control-flow');

-- Part 2 Complete: 14 unique MCQs.


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


-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — C PROGRAMMING PYQ SEED v2 (Part 4 / 8)
-- MCQ Questions Q29–Q42 (Pointers & Arrays)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q29 — Pointer to Array (GATE 2004)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',true,2004,'MCQ','medium',1,
 'What is the output?<br><pre><code class="language-c">int a[] = {10, 20, 30, 40, 50};
int *p = a;
printf("%d", *(p + 3));</code></pre>',
 '10', '30', '40', '50', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> <code>p</code> points to <code>a[0]</code>. <code>p+3</code> advances by 3 integers, pointing to <code>a[3]</code>. Dereferencing gives 40. Pointer arithmetic: <code>*(p+i)</code> is equivalent to <code>a[i]</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointers','arrays');

-- Q30 — *p++ vs (*p)++ (GATE 2009)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',true,2009,'MCQ','hard',2,
 'What is the output?<br><pre><code class="language-c">int a[] = {10, 20, 30};
int *p = a;
int x = *p++;
int y = *p;
printf("%d %d", x, y);</code></pre>',
 '10 10', '10 20', '20 20', '20 30', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>*p++</code> is parsed as <code>*(p++)</code> due to precedence. Post-increment returns the old pointer value, so <code>x = *a[0] = 10</code>, then <code>p</code> advances to <code>a[1]</code>. <code>y = *p = 20</code>. Key GATE trap: <code>*p++</code> ≠ <code>(*p)++</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointers','pointer-arithmetic');

-- Q31 — Array Name as Pointer (GATE 2010)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='arrays-matrices' LIMIT 1),
 'gate-cse',true,2010,'MCQ','medium',1,
 'Which statement about arrays and pointers in C is FALSE?',
 '<code>a[i]</code> is equivalent to <code>*(a + i)</code>',
 'An array name decays to a pointer to its first element in most expressions',
 'An array name can be reassigned to point to a different memory location',
 '<code>sizeof(a)</code> gives the total array size in bytes, not the pointer size',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> An array name is NOT a modifiable lvalue. You cannot write <code>a = some_ptr</code>. It decays to a pointer in expressions but is not itself a pointer variable that can be reassigned. All other statements are true.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('arrays','pointers');

-- Q32 — &a+1 Trick (GATE 2017)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',true,2017,'MCQ','hard',2,
 'What is the output?<br><pre><code class="language-c">int a[5] = {1, 2, 3, 4, 5};
int *ptr = (int*)(&amp;a + 1);
printf("%d", *(ptr - 1));</code></pre>',
 '1', '2', '5', 'Garbage Value', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> <code>&amp;a</code> is a pointer to the entire array (type <code>int(*)[5]</code>). <code>&amp;a + 1</code> jumps past all 5 elements (20 bytes). Casting to <code>int*</code> and subtracting 1 moves back by one integer to <code>a[4]</code>, which is 5.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointer-arithmetic');

-- Q33 — String Literal Immutability (GATE 2012)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='strings-handling' LIMIT 1),
 'gate-cse',true,2012,'MCQ','medium',2,
 'What happens when this code executes?<br><pre><code class="language-c">char *s = "hello";
s[0] = ''H'';</code></pre>',
 'Prints "Hello" ',
 'Compiler error: cannot modify string literal',
 'Undefined behavior / likely segmentation fault at runtime',
 'Silently does nothing',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> <code>"hello"</code> is a string literal stored in read-only memory. <code>char *s</code> points to it. Modifying it is undefined behavior (typically a segfault on modern systems). Use <code>char s[] = "hello"</code> for a modifiable copy.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointers');

-- Q34 — char* vs char[] (GATE 2013)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='strings-handling' LIMIT 1),
 'gate-cse',true,2013,'MCQ','medium',1,
 'Which of the following creates a modifiable copy of the string on the stack?',
 '<code>char *s = "GATE";</code>',
 '<code>char s[] = "GATE";</code>',
 '<code>const char *s = "GATE";</code>',
 '<code>char *s = (char*)malloc(5); s = "GATE";</code>',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>char s[] = "GATE"</code> creates a local array of 5 bytes (including ''\\0'') on the stack, copying the string literal contents. This copy is modifiable. <code>char *s = "GATE"</code> only stores a pointer to the read-only string literal. Option D leaks the malloc''d memory.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('arrays','pointers');

-- Q35 — 2D Array Pointer Arithmetic (GATE 2011)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='arrays-matrices' LIMIT 1),
 'gate-cse',true,2011,'MCQ','hard',2,
 'Given <code>int a[3][4];</code>, which expression gives the value at <code>a[1][2]</code>?',
 '<code>*(*(a + 1) + 2)</code>',
 '<code>*(a + 1) + 2</code>',
 '<code>**(a + 1 + 2)</code>',
 '<code>*(a + 6)</code>',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> For 2D arrays: <code>a[i][j] ≡ *(*(a+i)+j)</code>. <code>a+1</code> points to the second row (type <code>int(*)[4]</code>). <code>*(a+1)</code> decays to <code>int*</code> pointing to <code>a[1][0]</code>. Adding 2 reaches <code>a[1][2]</code>. Final dereference gives the value.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('arrays','pointer-arithmetic');

-- Q36 — void* Casting (GATE 2016)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',true,2016,'MCQ','medium',1,
 'Which statement about <code>void*</code> pointers in C is TRUE?',
 'A <code>void*</code> can be dereferenced without casting',
 'A <code>void*</code> can hold the address of any data type and can be cast to any pointer type',
 'Arithmetic operations like <code>void_ptr + 1</code> are well-defined in standard C',
 'A <code>void*</code> cannot be passed to functions',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>void*</code> is the generic pointer type in C. It can store any pointer but cannot be dereferenced (no type info) or used in arithmetic (no size info) without casting first. This is why <code>malloc</code> returns <code>void*</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointers');

-- Q37 — Dangling Pointer (GATE 2018)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',true,2018,'MCQ','medium',2,
 'A dangling pointer is created when:',
 'A pointer is declared but not initialized',
 'A pointer points to memory that has been freed or deallocated',
 'A pointer is set to NULL',
 'Two pointers point to the same memory location',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A dangling pointer occurs after <code>free(ptr)</code> — the pointer still holds the old address but the memory is no longer valid. Dereferencing it is undefined behavior. Option A describes a wild pointer. Option D describes aliasing, which is valid.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointers','memory-management');

-- Q38 — Pointer to Pointer (GATE 2019)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',true,2019,'MCQ','medium',2,
 'What is the output?<br><pre><code class="language-c">int x = 5;
int *p = &amp;x;
int **pp = &amp;p;
**pp = 10;
printf("%d", x);</code></pre>',
 '5', '10', 'Garbage Value', 'Compiler Error', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>pp</code> points to <code>p</code>, which points to <code>x</code>. <code>**pp</code> dereferences twice: first to get <code>p</code>, then to get <code>x</code>. Assigning <code>**pp = 10</code> modifies <code>x</code> to 10. Output: 10.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointers');

-- Q39 — strlen vs sizeof (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='strings-handling' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'What is the output?<br><pre><code class="language-c">char s[] = "GATE";
printf("%zu %zu", strlen(s), sizeof(s));</code></pre>',
 '4 4', '4 5', '5 5', '5 4', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>strlen</code> counts characters until ''\\0'' → 4 ("GATE"). <code>sizeof</code> includes the null terminator → 5 bytes. This is a classic distinction between string length and array storage size.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('arrays');

-- Q40 — Array of Pointers (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'What is the output?<br><pre><code class="language-c">char *fruits[] = {"apple", "banana", "cherry"};
printf("%c", *fruits[1]);</code></pre>',
 'a', 'b', 'c', 'Compiler Error', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>fruits[1]</code> is a <code>char*</code> pointing to "banana". <code>*fruits[1]</code> dereferences it to get the first character ''b''. Array of pointers is the idiomatic way to represent an array of strings in C.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointers','arrays');

-- Q41 — Null Pointer (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'What happens when you dereference a NULL pointer in C?',
 'Returns 0',
 'Returns -1',
 'Undefined behavior (typically segmentation fault)',
 'Compiler prevents compilation',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Dereferencing <code>NULL</code> is undefined behavior per the C standard. On most modern systems it causes a segmentation fault. The compiler does not prevent this at compile time because pointer values are runtime data.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointers');

-- Q42 — Pointer Subtraction (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',1,
 'What is the output?<br><pre><code class="language-c">int a[] = {10, 20, 30, 40};
int *p = &amp;a[0], *q = &amp;a[3];
printf("%ld", q - p);</code></pre>',
 '12', '3', '4', 'Undefined', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Pointer subtraction yields the number of elements between them, not bytes. <code>q</code> is at index 3, <code>p</code> at index 0. Difference: 3 elements. The byte difference would be 12 (3 × 4 bytes), but pointer arithmetic divides by element size.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointer-arithmetic');

-- Part 4 Complete: 14 unique MCQs.


-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — C PROGRAMMING PYQ SEED v2 (Part 5 / 8)
-- MCQ Questions Q43–Q56 (Structs, Unions & Dynamic Memory)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q43 — Structure Padding (GATE 2015)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'gate-cse',true,2015,'MCQ','hard',2,
 'On a 32-bit system with natural alignment, what is <code>sizeof(S)</code>?<br><pre><code class="language-c">struct S {
 char c; // 1 byte
 int i; // 4 bytes
 char d; // 1 byte
};</code></pre>',
 '6', '8', '12', '9', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> With natural alignment: <code>c</code> at offset 0 (1 byte + 3 padding), <code>i</code> at offset 4 (4 bytes), <code>d</code> at offset 8 (1 byte + 3 padding to reach next multiple of 4). Total: 12 bytes. Reordering as <code>{int, char, char}</code> would give 8 bytes.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('structs');

-- Q44 — Union Size (GATE 2013)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'gate-cse',true,2013,'MCQ','medium',1,
 'What is <code>sizeof(U)</code>?<br><pre><code class="language-c">union U {
 int i; // 4 bytes
 double d; // 8 bytes
 char c; // 1 byte
};</code></pre>',
 '13', '4', '8', '1', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> A <code>union</code> allocates enough memory for its largest member. All members share the same memory. The largest is <code>double</code> at 8 bytes. <code>sizeof(U) = 8</code>. Only one member can hold a valid value at any time.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('structs');

-- Q45 — Union Overlay Behavior (GATE 2016)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'gate-cse',true,2016,'MCQ','hard',2,
 'What is the output on a little-endian 32-bit machine?<br><pre><code class="language-c">union { int i; char c[4]; } u;
u.i = 0x41424344;
printf("%c", u.c[0]);</code></pre>',
 'A', 'B', 'C', 'D', 'D',
 '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> On little-endian systems, the least significant byte is stored first. <code>0x41424344</code> stores as bytes: <code>0x44, 0x43, 0x42, 0x41</code>. <code>u.c[0] = 0x44 = ''D''</code>. On big-endian, it would print ''A''. This is a classic endianness probe question.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('structs','memory-management');

-- Q46 — malloc vs calloc (GATE 2014)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'gate-cse',true,2014,'MCQ','easy',1,
 'What is the key difference between <code>malloc(n * sizeof(int))</code> and <code>calloc(n, sizeof(int))</code>?',
 '<code>malloc</code> initializes memory to zero; <code>calloc</code> does not',
 '<code>calloc</code> initializes all allocated bytes to zero; <code>malloc</code> leaves memory uninitialized',
 'They are functionally identical with no difference',
 '<code>calloc</code> allocates from the stack; <code>malloc</code> from the heap',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>calloc</code> allocates and zero-initializes. <code>malloc</code> allocates but the memory contents are indeterminate. Both allocate from the heap. <code>calloc</code> also takes two arguments (count, size) which can help avoid integer overflow in the multiplication.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('memory-management');

-- Q47 — realloc Behavior (GATE 2018)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'gate-cse',true,2018,'MCQ','medium',2,
 'What does <code>realloc(ptr, 0)</code> do according to the C standard?',
 'Does nothing and returns the same pointer',
 'Equivalent to <code>free(ptr)</code> — deallocates the memory',
 'Always returns NULL without freeing',
 'Causes a compiler error',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Per C99/C11, <code>realloc(ptr, 0)</code> is implementation-defined but historically equivalent to freeing the pointer. Conversely, <code>realloc(NULL, size)</code> is equivalent to <code>malloc(size)</code>. Both are classic exam trivia points.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('memory-management');

-- Q48 — Memory Leak Detection (GATE 2019)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'gate-cse',true,2019,'MCQ','medium',2,
 'Which code causes a memory leak?<br><pre><code class="language-c">// Option A:
int *p = malloc(40); free(p);
// Option B:
int *p = malloc(40); p = malloc(80); free(p);
// Option C:
int *p = malloc(40); free(p); p = NULL;
// Option D:
int *p = NULL; free(p);</code></pre>',
 'A', 'B', 'C', 'D', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In B, the first <code>malloc(40)</code> is never freed before <code>p</code> is reassigned to a new allocation. The original 40 bytes are lost (leaked). A and C free. D is safe — <code>free(NULL)</code> is a no-op per the standard.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('memory-management');

-- Q49 — Double Free (GATE 2020)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'gate-cse',true,2020,'MCQ','medium',1,
 'What happens when you call <code>free(ptr)</code> twice on the same pointer without reassignment?',
 'The second free is ignored ',
 'Undefined behavior — may corrupt the heap metadata',
 'Returns an error code',
 'Frees the next block in the heap',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Double-free is undefined behavior. It can corrupt the heap allocator''s internal metadata, potentially leading to crashes, security vulnerabilities, or silent data corruption. Best practice: set <code>ptr = NULL</code> after freeing.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('memory-management');

-- Q50 — typedef struct (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'What is the purpose of the following code?<br><pre><code class="language-c">typedef struct { int x; int y; } Point;</code></pre>',
 'Creates a variable named Point',
 'Creates a type alias so <code>Point</code> can be used instead of <code>struct { int x; int y; }</code>',
 'Declares a function called Point',
 'Creates a pointer to a structure',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> <code>typedef</code> creates an alias. After this, you can write <code>Point p;</code> instead of <code>struct { int x; int y; } p;</code>. The struct itself is anonymous — the only name is the typedef alias <code>Point</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('structs');

-- Q51 — Self-Referential Structure (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'Which declaration is valid for a linked list node in C?',
 '<code>struct Node { int data; Node *next; };</code>',
 '<code>struct Node { int data; struct Node *next; };</code>',
 '<code>struct Node { int data; struct Node next; };</code>',
 '<code>typedef struct { int data; Node *next; } Node;</code>',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A struct can contain a pointer to its own type (self-referential). You must use the full <code>struct Node *</code> syntax inside the definition. Option A omits <code>struct</code>. Option C would cause infinite recursion in size calculation. Option D uses <code>Node</code> before it is defined by the typedef.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('structs','pointers');

-- Q52 — Struct Bit Fields (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'What is the maximum value that <code>s.x</code> can hold?<br><pre><code class="language-c">struct S { unsigned int x : 3; };</code></pre>',
 '3', '7', '8', '255', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A bit field of width 3 can hold values from 0 to $2^3 - 1 = 7$. The <code>: 3</code> specifies that <code>x</code> uses exactly 3 bits. Assigning 8 (which needs 4 bits) would overflow and be truncated.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('structs');

-- Q53 — Struct Assignment Copy (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','easy',1,
 'What is the output?<br><pre><code class="language-c">struct Point { int x, y; };
struct Point a = {1, 2}, b;
b = a;
b.x = 10;
printf("%d %d", a.x, b.x);</code></pre>',
 '10 10', '1 10', '1 1', 'Compiler Error', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Struct assignment in C performs a shallow (member-wise) copy. <code>b = a</code> copies both members. Then <code>b.x = 10</code> only modifies the copy. <code>a.x</code> remains 1. Output: <code>1 10</code>. Unlike arrays, structs can be assigned.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('structs');

-- Q54 — Flexible Array Member (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','hard',2,
 'What is a Flexible Array Member (FAM) in C99?<br><pre><code class="language-c">struct Header {
 int len;
 char data[];
};</code></pre>',
 'An array with a compile-time variable length',
 'An incomplete array type at the end of a struct, whose storage is allocated dynamically beyond the struct size',
 'A pointer disguised as an array',
 'A zero-length array for backward compatibility with C89',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A FAM is declared as an array with no size at the end of a struct. <code>sizeof(struct Header)</code> does not include <code>data</code>. You allocate extra bytes via <code>malloc(sizeof(Header) + n)</code> and use <code>data[0..n-1]</code>. It''s not a pointer — no indirection overhead.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('memory-management','structs');

-- Q55 — Struct Padding Optimization (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',1,
 'Given two structs with the same members but different ordering, which has smaller <code>sizeof</code> on a 32-bit system?<br><pre><code class="language-c">struct A { char a; int b; char c; }; // ?
struct B { int b; char a; char c; }; // ?</code></pre>',
 'Both are equal', 'A is smaller', 'B is smaller', 'Depends on the compiler', 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Struct A: char(1)+pad(3)+int(4)+char(1)+pad(3) = 12 bytes. Struct B: int(4)+char(1)+char(1)+pad(2) = 8 bytes. Ordering members from largest to smallest alignment minimizes padding. This is a key systems programming optimization.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('structs');

-- Q56 — sizeof Struct with Pointer Member (Practice)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'gate-cse',false,NULL,'MCQ','medium',2,
 'On a 64-bit system, what is <code>sizeof(S)</code>?<br><pre><code class="language-c">struct S { char *name; int age; };</code></pre>',
 '12', '16', '8', '24', 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> On 64-bit: pointers are 8 bytes, <code>int</code> is 4 bytes. Layout: <code>name</code> at offset 0 (8 bytes) + <code>age</code> at offset 8 (4 bytes) + 4 bytes padding to align struct to 8-byte boundary = 16 bytes total.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('structs','memory-management');

-- Part 5 Complete: 14 unique MCQs.


-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — C PROGRAMMING PYQ SEED v2 (Part 6 / 8)
-- NAT Questions Q57–Q76 (Code Tracing — Numeric Answers)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q57 — sizeof array (GATE 2011)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='arrays-matrices' LIMIT 1),
 'gate-cse',true,2011,'NAT','medium',2,
 'On a 32-bit system where <code>int</code> is 4 bytes, what does <code>sizeof(a)</code> return?<br><pre><code class="language-c">int a[5] = {1, 2, 3};</code></pre>',
 20.00, 20.00, NULL,
 '<p><strong>✓ Answer: 20</strong></p><p><strong>Rationale:</strong> The array is declared with size 5 regardless of how many initializers are provided. Remaining elements are zero-initialized. <code>sizeof(a) = 5 × 4 = 20</code> bytes.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('arrays');

-- Q58 — Bitwise shift + OR
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'What is the output?<br><pre><code class="language-c">printf("%d", 1 &lt;&lt; 3 | 4);</code></pre>',
 12.00, 12.00, NULL,
 '<p><strong>✓ Answer: 12.</strong></p><p><strong>Rationale:</strong> <code>1 &lt;&lt; 3 = 8</code> (binary 1000). <code>8 | 4 = 12</code> (binary 1000 | 0100 = 1100). Bitwise OR sets bits present in either operand.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q59 — Recursive factorial (GATE 2009)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'gate-cse',true,2009,'NAT','medium',2,
 'What does <code>f(5)</code> return?<br><pre><code class="language-c">int f(int n) {
 if (n <= 1) return 1;
 return n * f(n - 1);
}</code></pre>',
 120.00, 120.00, NULL,
 '<p><strong>✓ Answer: 120.</strong></p><p><strong>Rationale:</strong> <code>f(5) = 5 × f(4) = 5 × 4 × f(3) = 5 × 4 × 3 × f(2) = 5 × 4 × 3 × 2 × f(1) = 5 × 4 × 3 × 2 × 1 = 120</code>. This is the factorial function: $5! = 120$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Q60 — Loop with break (GATE 2012)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='control-flow' LIMIT 1),
 'gate-cse',true,2012,'NAT','easy',1,
 'What value of <code>i</code> is printed?<br><pre><code class="language-c">int i;
for (i = 0; i < 10; i++) {
 if (i == 5) break;
}
printf("%d", i);</code></pre>',
 5.00, 5.00, NULL,
 '<p><strong>✓ Answer: 5.</strong></p><p><strong>Rationale:</strong> The loop increments <code>i</code> from 0. When <code>i</code> reaches 5, the <code>break</code> exits the loop. <code>i</code> retains its value of 5. The <code>printf</code> outside the loop prints 5.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('control-flow');

-- Q61 — XOR swap
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'What is the value of <code>a</code> after execution?<br><pre><code class="language-c">int a = 5, b = 9;
a = a ^ b;
b = a ^ b;
a = a ^ b;</code></pre>',
 9.00, 9.00, NULL,
 '<p><strong>✓ Answer: 9.</strong></p><p><strong>Rationale:</strong> This is the XOR swap algorithm. Step 1: <code>a = 5^9 = 12</code>. Step 2: <code>b = 12^9 = 5</code>. Step 3: <code>a = 12^5 = 9</code>. Values swapped without a temp variable. <code>a=9, b=5</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q62 — Nested loop iterations
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='control-flow' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'How many times does the <code>printf</code> execute?<br><pre><code class="language-c">for (int i = 0; i < 4; i++)
 for (int j = i; j < 4; j++)
 printf("*");</code></pre>',
 10.00, 10.00, NULL,
 '<p><strong>✓ Answer: 10.</strong></p><p><strong>Rationale:</strong> i=0: j runs 0..3 (4 times). i=1: j runs 1..3 (3 times). i=2: j runs 2..3 (2 times). i=3: j runs 3..3 (1 time). Total: 4+3+2+1 = 10. This is $\binom{n+1}{2}$ for n=4.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('control-flow');

-- Q63 — Pointer arithmetic difference
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',true,2015,'NAT','medium',2,
 'What is the output?<br><pre><code class="language-c">int arr[10];
printf("%ld", &amp;arr[7] - &amp;arr[2]);</code></pre>',
 5.00, 5.00, NULL,
 '<p><strong>✓ Answer: 5.</strong></p><p><strong>Rationale:</strong> Pointer subtraction in C yields the number of elements between two pointers, not bytes. <code>&amp;arr[7] - &amp;arr[2] = 7 - 2 = 5</code> elements.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointer-arithmetic');

-- Q64 — Recursive GCD (GATE 2010)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'gate-cse',true,2010,'NAT','medium',2,
 'What does <code>gcd(48, 18)</code> return?<br><pre><code class="language-c">int gcd(int a, int b) {
 if (b == 0) return a;
 return gcd(b, a % b);
}</code></pre>',
 6.00, 6.00, NULL,
 '<p><strong>✓ Answer: 6.</strong></p><p><strong>Rationale:</strong> Euclid''s algorithm: gcd(48,18) → gcd(18,12) → gcd(12,6) → gcd(6,0) → returns 6. This is the standard recursive GCD implementation in C.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Q65 — Structure sizeof with padding
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'gate-cse',true,2017,'NAT','hard',2,
 'On a 32-bit system with natural alignment, what is <code>sizeof(S)</code>?<br><pre><code class="language-c">struct S { char a; double b; char c; };</code></pre><br>Assume <code>double</code> is 8 bytes.',
 24.00, 24.00, NULL,
 '<p><strong>✓ Answer: 24.</strong></p><p><strong>Rationale:</strong> With 8-byte alignment for double: <code>a</code> at offset 0 (1 byte + 7 padding), <code>b</code> at offset 8 (8 bytes), <code>c</code> at offset 16 (1 byte + 7 padding to align to 8-byte boundary). Total: 24 bytes.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('structs');

-- Q66 — String length counting
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='strings-handling' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'What is the output?<br><pre><code class="language-c">char s[] = "Hello\0World";
printf("%zu", strlen(s));</code></pre>',
 5.00, 5.00, NULL,
 '<p><strong>✓ Answer: 5.</strong></p><p><strong>Rationale:</strong> <code>strlen</code> counts characters until the first null terminator <code>\0</code>. The explicit <code>\0</code> after "Hello" terminates the string. "World" is invisible to <code>strlen</code>. Result: 5.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('arrays');

-- Q67 — Modulo and division
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'What is the output?<br><pre><code class="language-c">int x = 17;
printf("%d", x / 5 + x % 5);</code></pre>',
 5.00, 5.00, NULL,
 '<p><strong>✓ Answer: 5.</strong></p><p><strong>Rationale:</strong> <code>17/5 = 3</code> (integer division truncates). <code>17%5 = 2</code> (remainder). <code>3 + 2 = 5</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q68 — Post-increment in loop condition
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='control-flow' LIMIT 1),
 'gate-cse',true,2014,'NAT','medium',2,
 'How many times is "hi" printed?<br><pre><code class="language-c">int i = 0;
while (i++ < 5)
 printf("hi ");</code></pre>',
 5.00, 5.00, NULL,
 '<p><strong>✓ Answer: 5.</strong></p><p><strong>Rationale:</strong> Post-increment: the comparison uses the old value. Iterations: i=0 (0<5 true, print), i=1 (1<5 true), ..., i=4 (4<5 true). When i=5, (5<5) is false → stop. Five prints total.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('control-flow');

-- Q69 — Recursive call count
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'gate-cse',false,NULL,'NAT','hard',2,
 'How many times is <code>f()</code> called in total (including the initial call)?<br><pre><code class="language-c">void f(int n) {
 if (n <= 0) return;
 f(n - 1);
 f(n - 1);
}
// calling f(3)</code></pre>',
 15.00, 15.00, NULL,
 '<p><strong>✓ Answer: 15.</strong></p><p><strong>Rationale:</strong> Each call spawns two sub-calls. Number of nodes in a complete binary tree of height 3: $2^{h+1} - 1 = 2^4 - 1 = 15$. f(3) calls f(2) twice, each calls f(1) twice, each calls f(0) twice, which return immediately.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Q70 — Conditional expression value
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'What is the output?<br><pre><code class="language-c">int x = 10;
int y = (x > 5) ? x * 2 : x + 2;
printf("%d", y);</code></pre>',
 20.00, 20.00, NULL,
 '<p><strong>✓ Answer: 20.</strong></p><p><strong>Rationale:</strong> <code>x > 5</code> is true (10 > 5). The ternary returns <code>x * 2 = 20</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q71 — sizeof pointer vs array
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',true,2016,'NAT','medium',2,
 'On a 64-bit system where <code>int</code> is 4 bytes, what is <code>sizeof(p)</code>?<br><pre><code class="language-c">int a[10];
int *p = a;</code></pre>',
 8.00, 8.00, NULL,
 '<p><strong>✓ Answer: 8.</strong></p><p><strong>Rationale:</strong> <code>p</code> is a pointer, and on a 64-bit system, all pointers are 8 bytes regardless of what they point to. <code>sizeof(a)</code> would be 40, but <code>sizeof(p)</code> is always the pointer size: 8.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointers');

-- Q72 — Bitwise AND masking
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',1,
 'What is the output?<br><pre><code class="language-c">int x = 0xFF;
printf("%d", x &amp; 0x0F);</code></pre>',
 15.00, 15.00, NULL,
 '<p><strong>✓ Answer: 15.</strong></p><p><strong>Rationale:</strong> <code>0xFF = 11111111</code>, <code>0x0F = 00001111</code>. AND masks the upper 4 bits to zero: result = <code>00001111 = 15</code>. This is a standard bit-masking technique to extract the lower nibble.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q73 — Recursive binary representation
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'gate-cse',false,NULL,'NAT','hard',2,
 'How many recursive calls are made by <code>f(10)</code> (not counting the initial call)?<br><pre><code class="language-c">void f(int n) {
 if (n == 0) return;
 f(n / 2);
 printf("%d", n % 2);
}</code></pre>',
 3.00, 3.00, NULL,
 '<p><strong>✓ Answer: 3.</strong></p><p><strong>Rationale:</strong> f(10)→f(5)→f(2)→f(1)→f(0) returns. That is 3 recursive calls after the initial. The function prints the binary representation of n (1010 for 10). The depth is $\lfloor \log_2 n \rfloor = 3$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('recursion');

-- Q74 — Static vs Auto in loop
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'gate-cse',true,2013,'NAT','medium',2,
 'What is the final value printed?<br><pre><code class="language-c">void f() {
 static int x = 0;
 x += 10;
 printf("%d ", x);
}
int main() {
 f(); f(); f();
}</code></pre><br>Answer with the LAST number printed.',
 30.00, 30.00, NULL,
 '<p><strong>✓ Answer: 30.</strong></p><p><strong>Rationale:</strong> Static variable <code>x</code> persists between calls. f() #1: x=10. f() #2: x=20. f() #3: x=30. Prints: <code>10 20 30</code>. Last number: 30.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functions');

-- Q75 — Complement operator
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',false,NULL,'NAT','medium',2,
 'What is the output? (Assume 32-bit <code>int</code> with 2''s complement)<br><pre><code class="language-c">int x = 0;
printf("%d", ~x);</code></pre>',
 -1.00, -1.00, NULL,
 '<p><strong>✓ Answer: -1.</strong></p><p><strong>Rationale:</strong> <code>~0</code> flips all bits from <code>00...0</code> to <code>11...1</code>. In 2''s complement, all 1s represents -1. This is a key identity: <code>~x = -(x+1)</code> for signed integers.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q76 — Array initialization count
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='arrays-matrices' LIMIT 1),
 'gate-cse',false,NULL,'NAT','easy',1,
 'What does the following print?<br><pre><code class="language-c">int a[] = {1, 2, 3, 4, 5, 6};
printf("%zu", sizeof(a) / sizeof(a[0]));</code></pre>',
 6.00, 6.00, NULL,
 '<p><strong>✓ Answer: 6.</strong></p><p><strong>Rationale:</strong> <code>sizeof(a) = 24</code> (6 ints × 4 bytes). <code>sizeof(a[0]) = 4</code>. Division: <code>24/4 = 6</code>. This is the standard idiom for computing array length in C.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('arrays');

-- Part 6 Complete: 20 unique NAT questions.


-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — C PROGRAMMING PYQ SEED v2 (Part 7 / 8)
-- MSQ Questions Q77–Q90 (Multiple Select — C Language Edge Cases)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q77 — Valid pointer operations (GATE 2015)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'gate-cse',true,2015,'MSQ','medium',2,
 'Which of the following operations are valid on pointers in standard C?',
 'Adding an integer to a pointer: <code>ptr + 3</code>',
 'Subtracting two pointers of the same type: <code>p1 - p2</code>',
 'Multiplying two pointers: <code>p1 * p2</code>',
 'Comparing pointers with relational operators: <code>p1 < p2</code>',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answer: A, B, D.</strong></p><p><strong>Rationale:</strong> Addition of integer to pointer (A) and subtraction of same-type pointers (B) are valid arithmetic. Comparison (D) is valid for pointers into the same array. Multiplication (C) is never valid — pointers are addresses, not numbers to multiply.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('pointers','pointer-arithmetic');

-- Q78 — Valid array declarations
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='arrays-matrices' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'Which of the following are valid array declarations in C?',
 '<code>int a[5];</code>',
 '<code>int a[] = {1, 2, 3};</code>',
 '<code>int a[];</code> (without initializer, at file scope)',
 '<code>int n = 5; int a[n];</code> (inside a function, C99)',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answer: A, B, D.</strong></p><p><strong>Rationale:</strong> A: explicit size, valid. B: size inferred from initializer (3), valid. C: incomplete type without initializer is invalid. D: Variable Length Array (VLA), valid in C99 inside functions. VLAs are optional in C11.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('arrays');

-- Q79 — Storage classes in C
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='macros-scope' LIMIT 1),
 'gate-cse',true,2018,'MSQ','medium',2,
 'Which of the following are valid storage class specifiers in C?',
 '<code>auto</code>',
 '<code>register</code>',
 '<code>volatile</code>',
 '<code>static</code>',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answer: A, B, D.</strong></p><p><strong>Rationale:</strong> C has four storage classes: <code>auto</code>, <code>register</code>, <code>static</code>, <code>extern</code>. <code>volatile</code> (C) is a type qualifier, not a storage class. Similarly, <code>const</code> is a qualifier.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q80 — Causes of segfault
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Which of the following can cause a segmentation fault?',
 'Dereferencing a NULL pointer',
 'Writing to a string literal: <code>char *s = "abc"; s[0] = ''x'';</code>',
 'Accessing <code>arr[0]</code> where <code>int arr[5];</code>',
 'Stack overflow from infinite recursion',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answer: A, B, D.</strong></p><p><strong>Rationale:</strong> A: NULL dereference accesses address 0 (protected). B: String literals are in read-only memory. D: Each recursive call pushes a stack frame; infinite recursion exhausts the stack. C is valid array access (index 0 is in bounds).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('memory-management','pointers');

-- Q81 — Undefined behavior in C
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',true,2017,'MSQ','hard',2,
 'Which of the following exhibit undefined behavior in C?',
 'Signed integer overflow: <code>INT_MAX + 1</code>',
 'Using a variable before initializing it (auto storage class)',
 'Dividing by zero: <code>5 / 0</code>',
 'Unsigned integer overflow: <code>UINT_MAX + 1</code>',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answer: A, B, C.</strong></p><p><strong>Rationale:</strong> Signed overflow (A) and division by zero (C) are undefined per the C standard. Using uninitialized auto variables (B) reads indeterminate values (UB). Unsigned overflow (D) is well-defined — it wraps around modulo $2^n$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q82 — Properties of unions
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Which statements about C <code>union</code> are TRUE?',
 'All members share the same starting memory address',
 'Size of a union equals the sum of of all members',
 'Only one member can hold a valid value at any time',
 'A union can contain both data members and function pointers',
 ARRAY['A','C','D'],
 '<p><strong>✓ Answer: A, C, D.</strong></p><p><strong>Rationale:</strong> A: All union members overlap at offset 0. C: Writing to one member invalidates others (type punning aside). D: Function pointers are valid members. B is false — union size equals the LARGEST member, not the sum.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('structs');

-- Q83 — Macro vs inline function
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='macros-scope' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',2,
 'Which are advantages of <code>inline</code> functions over <code>#define</code> macros?',
 'Type is performed on arguments',
 'No multiple-evaluation side effects with expressions like <code>i++</code>',
 'Can be debugged with standard debugging tools',
 'They always execute faster than macros',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answer: A, B, C.</strong></p><p><strong>Rationale:</strong> Inline functions are real functions: the compiler type-arguments (A), evaluates them once (B), and they have proper debug symbols (C). D is false — both are typically inlined at the same level; macros have zero overhead by definition.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('macros');

-- Q84 — What free() does NOT do
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',1,
 'Which statements about <code>free(ptr)</code> are TRUE?',
 'It deallocates the memory pointed to by <code>ptr</code>',
 'It sets <code>ptr</code> to NULL automatically',
 'Calling <code>free(NULL)</code> is safe and does nothing',
 'After <code>free(ptr)</code>, using <code>*ptr</code> is undefined behavior',
 ARRAY['A','C','D'],
 '<p><strong>✓ Answer: A, C, D.</strong></p><p><strong>Rationale:</strong> A: free() deallocates the heap block. C: free(NULL) is a defined no-op per the standard. D: After freeing, the pointer is dangling. B is false — free() does NOT modify the pointer variable itself; you must manually set <code>ptr = NULL</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('memory-management');

-- Q85 — Header file purposes
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='macros-scope' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'What does <code>#include &lt;stdio.h&gt;</code> provide?',
 'Declaration of <code>printf</code> and <code>scanf</code>',
 'Definition of the <code>FILE</code> type',
 'Macro constants like <code>EOF</code> and <code>NULL</code>',
 'The compiled machine code for I/O functions',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answer: A, B, C.</strong></p><p><strong>Rationale:</strong> Header files contain declarations (A), type definitions (B), and macro constants (C). They do NOT contain compiled code (D) — that comes from linking with the C standard library (e.g., libc.so). Headers are text processed by the preprocessor.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('macros');

-- Q86 — Properties of const (GATE 2020)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',true,2020,'MSQ','medium',2,
 'Which are TRUE about <code>const int *p</code>?',
 'The pointer <code>p</code> can be reassigned to point elsewhere',
 'The value at <code>*p</code> cannot be modified through <code>p</code>',
 'It is identical to <code>int * const p</code>',
 'The underlying <code>int</code> variable itself may still be modified (not through p)',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answer: A, B, D.</strong></p><p><strong>Rationale:</strong> <code>const int *p</code>: pointer to const int. The pointer itself is mutable (A). Cannot modify <code>*p</code> (B). C is false — <code>int * const p</code> is a const pointer to mutable int (reversed). D: the original variable can be modified if it was not declared const.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics','pointers');

-- Q87 — Valid loop constructs
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='control-flow' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',1,
 'Which of the following are valid infinite loop constructs in C?',
 '<code>while(1) { }</code>',
 '<code>for(;;) { }</code>',
 '<code>do { } while(1);</code>',
 '<code>loop { }</code>',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answer: A, B, C.</strong></p><p><strong>Rationale:</strong> A: <code>while(1)</code> is the classic infinite loop. B: <code>for(;;)</code> omits all three clauses (valid in C — condition defaults to true). C: do-while with true condition. D: <code>loop</code> is not a C keyword.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('control-flow');

-- Q88 — Format specifier matching
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','easy',2,
 'Which format specifiers are matched to their types in <code>printf</code>?',
 '<code>%d</code> for <code>int</code>',
 '<code>%f</code> for <code>float</code>',
 '<code>%lf</code> for <code>double</code> in <code>printf</code>',
 '<code>%p</code> for pointer addresses',
 ARRAY['A','B','D'],
 '<p><strong>✓ Answer: A, B, D.</strong></p><p><strong>Rationale:</strong> A: <code>%d</code> is for int. B: <code>%f</code> works for float (promoted to double). D: <code>%p</code> prints pointer addresses. C is tricky: in <code>printf</code>, <code>%f</code> handles both float and double (due to default argument promotion). <code>%lf</code> for printf was added in C99 but <code>%f</code> suffices since float promotes to double.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('c-basics');

-- Q89 — Preprocessor directives
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='macros-scope' LIMIT 1),
 'gate-cse',false,NULL,'MSQ','medium',1,
 'Which are valid C preprocessor directives?',
 '<code>#include</code>',
 '<code>#define</code>',
 '<code>#pragma</code>',
 '<code>#import</code>',
 ARRAY['A','B','C'],
 '<p><strong>✓ Answer: A, B, C.</strong></p><p><strong>Rationale:</strong> <code>#include</code>, <code>#define</code>, and <code>#pragma</code> are standard C preprocessor directives. <code>#import</code> is an Objective-C extension, not standard C. Other valid directives include <code>#ifdef</code>, <code>#ifndef</code>, <code>#undef</code>, <code>#error</code>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('macros');

-- Q90 — malloc return type
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'gate-cse',true,2019,'MSQ','medium',2,
 'Which statements about <code>malloc</code> in C are TRUE?',
 'It returns <code>void*</code> which is implicitly cast to any pointer type in C',
 'It initializes the allocated memory to zero',
 'It returns NULL if allocation fails',
 'The memory allocated by malloc persists until freed or the program exits',
 ARRAY['A','C','D'],
 '<p><strong>✓ Answer: A, C, D.</strong></p><p><strong>Rationale:</strong> A: In C (unlike C++), <code>void*</code> implicitly converts to any pointer type. B is false — malloc does NOT zero-initialize (use calloc for that). C: returns NULL on failure. D: heap memory persists until free() or program termination.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('memory-management');

-- Part 7 Complete: 14 unique MSQ questions.


-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — C PROGRAMMING PYQ SEED v2 (Part 8 / 8)
-- Flashcards (40 unique) & Final Stats
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES
-- Chapter 1: Basics & Control Flow
((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'What is the size of <code>int</code> on a typical 32-bit system?',
 '<p>4 bytes (32 bits). Range: -2,147,483,648 to 2,147,483,647 for signed. The C standard only guarantees <code>int</code> is at least 16 bits.</p>',
 ARRAY['c-basics']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'What is the difference between <code>++i</code> (pre-increment) and <code>i++</code> (post-increment)?',
 '<p><code>++i</code> increments first, then uses the new value. <code>i++</code> uses the current value, then increments. In <code>int x = i++;</code>, x gets the old value of i.</p>',
 ARRAY['c-basics']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'What does the <code>sizeof</code> operator return?',
 '<p>The size in bytes of a type or expression, evaluated at compile time (except for VLAs). It returns type <code>size_t</code>. <code>sizeof(char)</code> is always 1.</p>',
 ARRAY['c-basics']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'What is short-circuit evaluation in C?',
 '<p>Logical <code>&&</code> and <code>||</code> stop as soon as the result is determined. <code>0 && expr</code> → expr never runs. <code>1 || expr</code> → expr never runs. This is guaranteed left-to-right.</p>',
 ARRAY['control-flow']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='control-flow' LIMIT 1),
 'What happens without a <code>break</code> in a switch case?',
 '<p>Execution falls through to the next case, all subsequent cases until a <code>break</code> or the end of the switch block. This is called "fallthrough" and is a common source of bugs.</p>',
 ARRAY['control-flow']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='control-flow' LIMIT 1),
 'What is the difference between <code>while</code> and <code>do-while</code> loops?',
 '<p><code>while</code> the condition before the body (may execute 0 times). <code>do-while</code> executes the body first, then the condition (always executes at least once).</p>',
 ARRAY['control-flow']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'What is the comma operator in C?',
 '<p>The comma operator <code>(expr1, expr2)</code> evaluates both expressions left to right and returns the value of the rightmost. Example: <code>int x = (1, 2, 3);</code> → x = 3. Lowest precedence of all operators.</p>',
 ARRAY['c-basics']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'What does <code>x & (x-1)</code> do?',
 '<p>Clears the lowest set bit of x. Example: 12 (1100) & 11 (1011) = 8 (1000). If the result is 0, x is a power of 2. Used in Brian Kernighan''s bit-counting algorithm.</p>',
 ARRAY['c-basics']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'What is implicit type promotion in C?',
 '<p>When mixing types in expressions, smaller types are promoted to larger: char→int, int→unsigned int (if mixed), float→double. Critically: <code>-1 > 1u</code> is TRUE because -1 becomes UINT_MAX.</p>',
 ARRAY['c-basics']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='macros-scope' LIMIT 1),
 'Why is <code>#define SQR(x) ((x)*(x))</code> safer than <code>#define SQR(x) x*x</code>?',
 '<p>Without parentheses, <code>SQR(a+b)</code> expands to <code>a+b*a+b</code> which evaluates incorrectly due to precedence. Parenthesized version expands to <code>((a+b)*(a+b))</code>. Always parenthesize macro arguments.</p>',
 ARRAY['macros']),

-- Chapter 2: Functions & Recursion
((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'Does C support pass-by-reference?',
 '<p>No. C only supports pass-by-value. To simulate pass-by-reference, pass pointers: <code>void swap(int *a, int *b)</code>. The pointer itself is passed by value, but you can dereference it to modify the original.</p>',
 ARRAY['functions']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'What does <code>static</code> mean for a local variable?',
 '<p>The variable is initialized once (at program start) and retains its value between function calls. It lives in the data segment, not the stack. Scope remains local to the function.</p>',
 ARRAY['functions']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'What does <code>extern</code> mean?',
 '<p>Declares a variable or function defined in another translation unit. <code>extern int x;</code> is a declaration (no memory allocated). The definition (memory allocation) must exist elsewhere. Used for cross-file linking.</p>',
 ARRAY['functions']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'What is tail recursion?',
 '<p>A recursive function where the recursive call is the last operation. Example: <code>return f(n-1)</code> (tail) vs <code>return n * f(n-1)</code> (not tail — multiplication happens after). Tail calls can be optimized to loops by compilers.</p>',
 ARRAY['recursion']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recursion-mechanics' LIMIT 1),
 'How many moves does Tower of Hanoi need for n disks?',
 '<p>$2^n - 1$ moves. Recurrence: $T(n) = 2T(n-1) + 1$, $T(1) = 1$. For 3 disks: 7 moves. For 4 disks: 15 moves. Exponential time complexity: $O(2^n)$.</p>',
 ARRAY['recursion']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'What is a function pointer?',
 '<p>A variable that stores the address of a function. Declaration: <code>int (*fp)(int, int);</code>. The parentheses around <code>*fp</code> are crucial. Without them, <code>int *fp(int, int)</code> declares a function returning <code>int*</code>.</p>',
 ARRAY['functions','pointers']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-functions-recursion' LIMIT 1),
 (SELECT id FROM topics WHERE slug='function-params' LIMIT 1),
 'What is the <code>volatile</code> qualifier?',
 '<p>Tells the compiler not to optimize away reads/writes to a variable because its value may change unexpectedly (hardware registers, signal handlers, multi-threaded access). Every access reads from memory, not a cached register value.</p>',
 ARRAY['c-basics']),

-- Chapter 3: Pointers & Arrays
((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'What is a dangling pointer?',
 '<p>A pointer that references memory that has been freed or is out of scope. Created by: <code>free(p)</code> (then using p), or returning address of a local variable. Dereferencing is undefined behavior.</p>',
 ARRAY['pointers','memory-management']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'What is the difference between <code>const int *p</code> and <code>int * const p</code>?',
 '<p><code>const int *p</code>: pointer to constant int (cannot change <code>*p</code>, can change <code>p</code>). <code>int * const p</code>: constant pointer to int (cannot change <code>p</code>, can change <code>*p</code>). Read declarations right-to-left.</p>',
 ARRAY['pointers']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'What does <code>&a</code> mean when <code>a</code> is an array?',
 '<p><code>&a</code> is a pointer to the entire array (type: <code>int(*)[N]</code>). <code>&a + 1</code> jumps past the whole array (N elements). This differs from <code>a</code> which decays to <code>&a[0]</code> (type: <code>int*</code>), where <code>a + 1</code> moves by one element.</p>',
 ARRAY['arrays','pointer-arithmetic']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='strings-handling' LIMIT 1),
 'What is the difference between <code>char s[]</code> and <code>char *s</code> for strings?',
 '<p><code>char s[] = "abc"</code>: creates a modifiable array on the stack (copies the string). <code>char *s = "abc"</code>: creates a pointer to a read-only string literal. Modifying <code>*s</code> in the pointer version is undefined behavior.</p>',
 ARRAY['pointers','arrays']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='strings-handling' LIMIT 1),
 'What is the difference between <code>strlen(s)</code> and <code>sizeof(s)</code>?',
 '<p><code>strlen</code>: counts characters until null terminator (runtime, O(n)). <code>sizeof</code>: total allocated bytes including null (compile-time for arrays). For <code>char s[] = "abc"</code>: strlen=3, sizeof=4.</p>',
 ARRAY['arrays']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'How does pointer subtraction work?',
 '<p>Subtracting two pointers of the same type gives the number of elements between them, NOT bytes. <code>&a[5] - &a[2] = 3</code>. The byte distance is divided by <code>sizeof(element)</code> automatically.</p>',
 ARRAY['pointer-arithmetic']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='arrays-matrices' LIMIT 1),
 'How does 2D array indexing work with pointers?',
 '<p><code>a[i][j]</code> is equivalent to <code>*(*(a+i)+j)</code>. For <code>int a[M][N]</code>: <code>a+i</code> is type <code>int(*)[N]</code>, <code>*(a+i)</code> decays to <code>int*</code> pointing to row i, adding j offsets within that row.</p>',
 ARRAY['arrays','pointer-arithmetic']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-pointers-arrays' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pointer-arithmetic' LIMIT 1),
 'What is a <code>void*</code> pointer?',
 '<p>A generic pointer that can hold any address. Cannot be dereferenced or used in arithmetic without casting. <code>malloc</code> returns <code>void*</code>. In C, <code>void*</code> implicitly converts to other pointer types (no cast needed).</p>',
 ARRAY['pointers']),

-- Chapter 4: Structs & Memory
((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'What is structure padding?',
 '<p>Compilers insert unused bytes between struct members to satisfy alignment requirements. <code>struct { char c; int i; }</code> is 8 bytes on 32-bit (3 bytes padding after char). Reorder members largest-first to minimize padding.</p>',
 ARRAY['structs']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'What is the difference between a <code>struct</code> and a <code>union</code>?',
 '<p>Struct: each member has its own memory; size ≥ sum of members. Union: all members share the same memory starting at offset 0; size = largest member. Only one union member holds a valid value at a time.</p>',
 ARRAY['structs']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'What are bit fields in C?',
 '<p>Members of a struct with a specified bit-width: <code>unsigned int flag : 1;</code> (1 bit, values 0-1). Used for compact data. Cannot take address of bit fields. Width must not exceed the base type''s bit count.</p>',
 ARRAY['structs']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'What is the difference between <code>malloc</code>, <code>calloc</code>, and <code>realloc</code>?',
 '<p><code>malloc(size)</code>: allocates uninitialized memory. <code>calloc(count, size)</code>: allocates and zero-initializes. <code>realloc(ptr, new_size)</code>: resizes existing allocation, preserving old data. All return <code>void*</code> or NULL on failure.</p>',
 ARRAY['memory-management']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'What is a memory leak?',
 '<p>When dynamically allocated memory (via malloc/calloc) is never freed and the pointer to it is lost (reassigned or goes out of scope). The memory remains allocated but inaccessible until program termination.</p>',
 ARRAY['memory-management']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'What is double-free? Why is it dangerous?',
 '<p>Calling <code>free(ptr)</code> twice on the same address. It''s undefined behavior that can corrupt heap metadata, cause crashes, or create security vulnerabilities. Prevention: set <code>ptr = NULL</code> after freeing (<code>free(NULL)</code> is safe).</p>',
 ARRAY['memory-management']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'What is a self-referential structure?',
 '<p>A struct containing a pointer to its own type: <code>struct Node { int data; struct Node *next; };</code>. The keyword <code>struct</code> is required inside the definition. Used to build linked lists, trees, and graphs.</p>',
 ARRAY['structs','pointers']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dynamic-memory' LIMIT 1),
 'What are the four storage durations in C?',
 '<p>1. <strong>Automatic</strong> (local vars, stack). 2. <strong>Static</strong> (global/static vars, data segment). 3. <strong>Allocated</strong> (malloc/calloc, heap). 4. <strong>Thread</strong> (C11 _Thread_local). Storage duration determines lifetime.</p>',
 ARRAY['memory-management']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'What are the four storage class specifiers in C?',
 '<p><code>auto</code> (default for locals), <code>register</code> (hint to use CPU register), <code>static</code> (persists between calls / internal linkage), <code>extern</code> (declares external linkage). Only one specifier per declaration.</p>',
 ARRAY['c-basics']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'What is the difference between signed and unsigned integer overflow?',
 '<p>Signed overflow: undefined behavior (compiler may optimize assuming it never happens). Unsigned overflow: well-defined — wraps around modulo $2^n$. Example: <code>UINT_MAX + 1 = 0</code>. Always use unsigned for bitwise operations.</p>',
 ARRAY['c-basics']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='macros-scope' LIMIT 1),
 'What are include guards?',
 '<p>Preprocessor pattern to prevent multiple inclusion of headers:<br><code>#ifndef HEADER_H<br>#define HEADER_H<br>/* contents */<br>#endif</code><br>Alternatively: <code>#pragma once</code> (non-standard but widely supported).</p>',
 ARRAY['macros']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'What is the XOR swap algorithm?',
 '<p><code>a ^= b; b ^= a; a ^= b;</code> — swaps a and b without a temporary variable. Works because XOR is self-inverse. Caveat: fails if a and b are the same variable (both become 0). Rarely used in practice.</p>',
 ARRAY['c-basics']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-basics-flow' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-types-operators' LIMIT 1),
 'What is the <code>~</code> (bitwise NOT) operator?',
 '<p>Flips every bit: 0→1, 1→0. For signed integers in 2''s complement: <code>~x = -(x+1)</code>. Example: <code>~0 = -1</code> (all bits set). <code>~5 = -6</code>. Used in bitmask creation: <code>~0 << n</code>.</p>',
 ARRAY['c-basics']),

((SELECT id FROM subjects WHERE slug='cprog'),
 (SELECT id FROM chapters WHERE slug='c-structs-memory' LIMIT 1),
 (SELECT id FROM topics WHERE slug='structs-unions' LIMIT 1),
 'What is endianness?',
 '<p><strong>Little-endian</strong>: stores least significant byte first (x86, ARM). <strong>Big-endian</strong>: stores most significant byte first (network byte order). Test with union: store int, read bytes. Affects binary file portability.</p>',
 ARRAY['memory-management']);

-- ═══════════════════════════════════════════════════════════════════════════
-- STATS SUMMARY
-- ═══════════════════════════════════════════════════════════════════════════
-- Subject: C Programming (cprog)
-- MCQ: Q1-Q56 (56 questions across p2-p5)
-- NAT: Q57-Q76 (20 questions in p6)
-- MSQ: Q77-Q90 (14 questions in p7)
-- Flashcards: 40 unique cards in p8
-- Total Questions: 90
-- Total Flashcards: 40
-- ═══════════════════════════════════════════════════════════════════════════

-- Part 8 Complete.