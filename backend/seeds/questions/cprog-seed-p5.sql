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
