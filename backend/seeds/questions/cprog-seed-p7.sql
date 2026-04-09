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
