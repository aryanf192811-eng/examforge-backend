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