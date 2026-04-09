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
