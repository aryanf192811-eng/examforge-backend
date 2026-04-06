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
