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
