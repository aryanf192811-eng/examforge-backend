-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DBMS PYQ SEED v2  (Part 6 / 7)
-- SECTION 3: FLASHCARDS (45 cards, SM-2 compatible)
-- ═══════════════════════════════════════════════════════════════════════════

-- ─── Normalization Flashcards (15) ───────────────────────────────────────
INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bcnf-decomp' LIMIT 1),
  'What is the BCNF condition?',
  '<p>For every non-trivial FD <strong>X → Y</strong> in the relation, <strong>X must be a superkey</strong>.</p><p>BCNF is stricter than 3NF — there is NO exception clause for prime attributes on the RHS.</p><p><code>BCNF ⊂ 3NF</code> (every BCNF relation is in 3NF, but not vice versa).</p>',
  ARRAY['bcnf','normalization']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='3nf-synthesis' LIMIT 1),
  'What is the 3NF condition? What is the escape clause BCNF does not have?',
  '<p>For every non-trivial FD <strong>X → Y</strong>: either <strong>X is a superkey</strong> OR <strong>Y is a prime attribute</strong> (part of some candidate key).</p><p>The <em>escape clause</em>: Y is prime. This is what BCNF lacks — in BCNF, X must be a superkey, period.</p>',
  ARRAY['3nf','normalization','bcnf']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='1nf-2nf' LIMIT 1),
  'What is a partial dependency and which normal form eliminates it?',
  '<p><strong>Partial dependency:</strong> A non-prime attribute is functionally dependent on a <em>proper subset</em> of some candidate key (only possible when the key is composite).</p><p><strong>2NF</strong> eliminates all partial dependencies.</p><p><em>Example:</em> Key = AB, FD B→C → C partially depends on AB (via B alone). Violates 2NF.</p>',
  ARRAY['2nf','normalization','functional-dependency']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='fd-axioms' LIMIT 1),
  'State Armstrong''s three axioms for Functional Dependencies.',
  '<ol><li><strong>Reflexivity:</strong> If Y ⊆ X, then X → Y</li><li><strong>Augmentation:</strong> If X → Y, then XZ → YZ</li><li><strong>Transitivity:</strong> If X → Y and Y → Z, then X → Z</li></ol><p><em>Derived rules:</em> Union, Decomposition, Pseudotransitivity — all derivable from the 3 above.</p>',
  ARRAY['functional-dependency','closure']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='attr-closure' LIMIT 1),
  'How do you compute the closure X⁺ of a set of attributes X under FD set F?',
  '<p><strong>Algorithm:</strong></p><ol><li>Start: X⁺ = X</li><li>Repeat: for each FD A→B in F, if A ⊆ X⁺, add B to X⁺</li><li>Until X⁺ stops changing</li></ol><p><em>Use:</em> X is a superkey if X⁺ = all attributes of R. X is a candidate key if X⁺ = R and no proper subset of X also determines R.</p>',
  ARRAY['closure','candidate-key','functional-dependency']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='minimal-cover' LIMIT 1),
  'What are the 3 steps to compute the minimal cover (canonical cover) of an FD set F?',
  '<ol><li><strong>RHS Singleton:</strong> Replace each FD A→BC with A→B and A→C</li><li><strong>Remove extraneous LHS attributes:</strong> For FD XA→B, check if X→B already follows from F. If yes, remove A from LHS.</li><li><strong>Remove redundant FDs:</strong> For each FD X→Y, check if X→Y follows from the remaining FDs. If yes, remove it.</li></ol>',
  ARRAY['minimal-cover','functional-dependency','normalization']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bcnf-decomp' LIMIT 1),
  'BCNF decomposition: what is guaranteed and what may be lost?',
  '<p><strong>✓ Always guaranteed:</strong> Lossless-join decomposition</p><p><strong>✗ Not always guaranteed:</strong> Dependency preservation (some FDs may not be checkable without joining)</p><p><em>Example: R(A,B,C), FDs: AB→C, C→A. BCNF violator: C→A (C not a superkey). Decomposing loses AB→C.</em></p>',
  ARRAY['bcnf','normalization']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='3nf-synthesis' LIMIT 1),
  '3NF synthesis (Bernstein''s algorithm): what does it guarantee?',
  '<p><strong>Algorithm output guarantees:</strong></p><ul><li>✓ Every resulting relation is in 3NF</li><li>✓ Decomposition is lossless-join</li><li>✓ Decomposition is dependency-preserving</li></ul><p><em>How:</em> Compute minimal cover → create one relation per FD → add a relation containing a candidate key if none exists yet.</p>',
  ARRAY['3nf','normalization']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mvd-4nf' LIMIT 1),
  'What is a Multivalued Dependency (MVD) and when does it cause a 4NF violation?',
  '<p><strong>MVD X ↠ Y:</strong> For each value of X, the set of Y values is independent of all other attributes Z in the relation (where R = X ∪ Y ∪ Z).</p><p><strong>4NF violation:</strong> A non-trivial MVD X ↠ Y exists where X is NOT a superkey.</p><p><em>Complementation rule:</em> If X ↠ Y in R(X,Y,Z), then X ↠ Z also holds.</p><p>Every FD X→Y implies MVD X ↠ Y, but not vice versa.</p>',
  ARRAY['4nf','normalization','functional-dependency']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='attr-closure' LIMIT 1),
  'How do you identify ALL candidate keys of a relation from its FDs?',
  '<p><strong>Strategy:</strong></p><ol><li>Identify attributes not in any FD RHS → MUST be in every candidate key</li><li>Identify attributes not in any FD LHS → those may not be needed in the key (already implied)</li><li>Compute closures of small attribute combinations starting with must-have attributes</li><li>A candidate key is minimal: removing any attribute makes it no longer a superkey</li></ol>',
  ARRAY['candidate-key','closure','functional-dependency']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='1nf-2nf' LIMIT 1),
  'What is 1NF and what does it prohibit?',
  '<p><strong>1NF:</strong> All attribute values must be <em>atomic</em> (indivisible, single-valued).</p><p><strong>Prohibits:</strong></p><ul><li>Multivalued attributes (e.g., {phone1, phone2} in one cell)</li><li>Composite attributes stored as a single column</li><li>Repeating groups or nested relations</li></ul><p>All relations in the relational model are assumed to be in 1NF.</p>',
  ARRAY['2nf','normalization']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bcnf-decomp' LIMIT 1),
  'Give an example of a relation in 3NF but NOT in BCNF.',
  '<p><strong>Classic example:</strong> R(name, courseNo, rollNo, grade)</p><p><strong>FDs:</strong> {name,courseNo}→grade; {rollNo,courseNo}→grade; name→rollNo; rollNo→name</p><p><strong>Candidate keys:</strong> {name,courseNo} and {rollNo,courseNo}</p><p><strong>FD name→rollNo:</strong> LHS not a superkey, but RHS (rollNo) is prime → satisfies 3NF, violates BCNF.</p><p>Result: in 3NF, NOT in BCNF. (GATE 2014)</p>',
  ARRAY['bcnf','3nf','normalization','candidate-key']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='fd-axioms' LIMIT 1),
  'What does it mean for an attribute to be "extraneous" in an FD?',
  '<p><strong>Extraneous attribute:</strong> An attribute A in FD X→Y is extraneous if removing A from the LHS (or RHS) still allows the same set of FDs to be implied.</p><p><strong>In LHS:</strong> A is extraneous in XA→Y if X→Y is already implied by F.</p><p><strong>In RHS:</strong> A is extraneous in X→YA if X→Y is still implied by the remaining FDs.</p><p>Removing extraneous attributes is Step 2 of computing the minimal cover.</p>',
  ARRAY['minimal-cover','functional-dependency']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='attr-closure' LIMIT 1),
  'Relation R(A,B,C,D) with FDs: {A→B, B→C, C→D, D→A}. How many candidate keys?',
  '<p><strong>Answer: 4</strong> — A, B, C, D are all candidate keys.</p><p><strong>Reason:</strong> The FDs form a cycle: A→B→C→D→A. Each single attribute determines ALL others.</p><ul><li>A⁺ = ABCDA = ABCD ✓</li><li>B⁺ = BCDAB = ABCD ✓</li><li>C⁺ = CDABC = ABCD ✓</li><li>D⁺ = DABCD = ABCD ✓</li></ul><p>All are minimal (single attributes) → all 4 are candidate keys.</p>',
  ARRAY['candidate-key','closure','functional-dependency']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='1nf-2nf' LIMIT 1),
  'A relation with a single-attribute primary key: can it violate 2NF?',
  '<p><strong>No.</strong> 2NF violations require a PARTIAL dependency — a non-prime attribute depending on a <em>proper subset</em> of the primary key.</p><p>A single-attribute key has NO proper subsets (other than the empty set), so no partial dependency is possible.</p><p><strong>Rule:</strong> If the primary key is a single attribute, the relation is automatically in 2NF. Start checking 3NF violations directly.</p>',
  ARRAY['2nf','normalization','candidate-key']
);

-- ─── SQL & Relational Algebra Flashcards (10) ────────────────────────────
INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='basic-sql' LIMIT 1),
  'What does SQL''s three-valued logic (3VL) say about comparisons with NULL?',
  '<p>SQL uses three truth values: <strong>TRUE, FALSE, UNKNOWN</strong>.</p><ul><li><code>NULL = NULL</code> → UNKNOWN (not TRUE!)</li><li><code>NULL &lt;&gt; NULL</code> → UNKNOWN</li><li><code>NULL + 5</code> → NULL</li><li>WHERE filters only <strong>TRUE</strong> rows; UNKNOWN rows are excluded</li></ul><p><strong>To test NULL:</strong> Use <code>IS NULL</code> or <code>IS NOT NULL</code>.</p>',
  ARRAY['sql-queries']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='subqueries-topic' LIMIT 1),
  'What is the danger of using NOT IN when the subquery may return NULLs?',
  '<p><strong>NOT IN with NULLs → always empty result.</strong></p><p>Example: <code>WHERE A NOT IN (SELECT B FROM T)</code></p><p>If any value in the subquery is NULL, then for any x:<br><code>x NOT IN (..., NULL, ...)</code> evaluates to UNKNOWN → row excluded.</p><p><strong>Fix:</strong> Use <code>NOT EXISTS</code> instead — it handles NULLs correctly:<br><code>WHERE NOT EXISTS (SELECT 1 FROM T WHERE T.B = outer.A)</code></p>',
  ARRAY['subquery','sql-queries']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='aggregation-sql' LIMIT 1),
  'What is the difference between WHERE and HAVING in SQL?',
  '<p><strong>WHERE:</strong> Filters individual ROWS before grouping. Cannot use aggregate functions.</p><p><strong>HAVING:</strong> Filters GROUPS after GROUP BY and aggregation. Can use aggregate functions.</p><p><em>Execution order:</em> FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY</p><p><em>Example:</em><br><code>SELECT dept, COUNT(*) FROM Emp<br>WHERE salary &gt; 50000  ← filters rows first<br>GROUP BY dept<br>HAVING COUNT(*) &gt; 3  ← filters groups after</code></p>',
  ARRAY['aggregation','sql-queries']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sql-joins-topic' LIMIT 1),
  'What is the result of a LEFT OUTER JOIN?',
  '<p><strong>LEFT OUTER JOIN:</strong> Returns ALL rows from the LEFT table, matched with rows from the right table. Unmatched left rows have NULLs in right-table columns.</p><p><em>Formula:</em> |Result| = (matching rows) + (unmatched left rows)</p><p><em>Similarly:</em><br>RIGHT JOIN → all right rows preserved<br>FULL OUTER JOIN → all rows from both tables, NULLs on unmatched sides</p>',
  ARRAY['sql-joins','sql-queries']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ra-expressions' LIMIT 1),
  'What are the 6 basic Relational Algebra operators?',
  '<p><strong>6 basic RA operators:</strong></p><ol><li><strong>σ</strong> (Selection) — filters rows by condition</li><li><strong>π</strong> (Projection) — selects columns, removes duplicates</li><li><strong>∪</strong> (Union) — all tuples from either (compatible schemas)</li><li><strong>−</strong> (Difference) — tuples in R but not in S</li><li><strong>×</strong> (Cartesian Product) — all combinations</li><li><strong>ρ</strong> (Rename) — renames relation or attributes</li></ol><p>Join, Intersection, Division are derived from these 6.</p>',
  ARRAY['relational-algebra']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ra-expressions' LIMIT 1),
  'What does the Division operation (R ÷ S) compute in Relational Algebra?',
  '<p><strong>R(A,B) ÷ S(B)</strong> returns all values of A such that for <em>every</em> B value in S, the pair (A,B) exists in R.</p><p><em>Use case:</em> "For all" queries — find students who took ALL required courses.</p><p><em>Equivalent expression:</em><br>R ÷ S = π<sub>A</sub>(R) − π<sub>A</sub>((π<sub>A</sub>(R) × S) − R)</p>',
  ARRAY['relational-algebra']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='subqueries-topic' LIMIT 1),
  'What is a correlated subquery? How does it differ from a non-correlated one?',
  '<p><strong>Correlated subquery:</strong> Inner query references columns from the outer query. Re-evaluated for <em>each row</em> of the outer query.</p><p><em>Example:</em> Find employees earning above their dept average:<br><code>WHERE salary &gt; (SELECT AVG(salary) FROM Emp WHERE dept = e.dept)</code></p><p><strong>Non-correlated:</strong> Inner query runs once, result reused.<br><em>Example:</em> <code>WHERE salary &gt; (SELECT AVG(salary) FROM Emp)</code></p><p>Correlated = slower (per-row), non-correlated = faster (once).</p>',
  ARRAY['subquery','sql-queries']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='aggregation-sql' LIMIT 1),
  'Which SQL aggregate functions ignore NULL values?',
  '<p><strong>All aggregate functions EXCEPT COUNT(*) ignore NULLs:</strong></p><ul><li><code>COUNT(*)</code> → counts ALL rows (including those with NULLs)</li><li><code>COUNT(col)</code> → counts non-NULL values in col</li><li><code>SUM(col)</code> → sums non-NULL values</li><li><code>AVG(col)</code> → averages non-NULL values (numerator: sum, denominator: non-NULL count)</li><li><code>MIN(col), MAX(col)</code> → ignore NULLs</li></ul>',
  ARRAY['aggregation','sql-queries']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ra-expressions' LIMIT 1),
  'State the cascading selection equivalence rule in Relational Algebra.',
  '<p><strong>Cascading Selections:</strong><br>σ<sub>p ∧ q</sub>(R) ≡ σ<sub>p</sub>(σ<sub>q</sub>(R)) ≡ σ<sub>q</sub>(σ<sub>p</sub>(R))</p><p><strong>Use:</strong> Push the more selective condition first to reduce intermediate size (query optimization).</p><p><strong>Other key equivalences:</strong><br>σ<sub>p</sub>(R ⋈ S) ≡ σ<sub>p</sub>(R) ⋈ S (if p involves only R''s attributes — selection pushdown)<br>π<sub>A</sub>(π<sub>B</sub>(R)) ≡ π<sub>A</sub>(R) if A ⊆ B (projection cascade)</p>',
  ARRAY['relational-algebra']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='views-triggers' LIMIT 1),
  'What is a SQL View? Differentiate from a Materialized View.',
  '<p><strong>View (virtual table):</strong><br>- Stored <em>definition</em> (SQL query), not data<br>- Recomputed every time the view is queried<br>- No extra storage for data<br>- Automatically reflects latest base table changes</p><p><strong>Materialized View:</strong><br>- Stores the query <em>result</em> physically<br>- Faster to query (no recomputation)<br>- Must be refreshed when base tables change (stale data risk)</p>',
  ARRAY['sql-queries']
);

-- ─── Transactions Flashcards (10) ────────────────────────────────────────
INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='acid-props' LIMIT 1),
  'Define all four ACID properties and state what enforces each.',
  '<p><strong>A — Atomicity:</strong> All-or-nothing. Either all operations succeed or all are undone. Enforced by: <em>Recovery manager (undo logs)</em>.</p><p><strong>C — Consistency:</strong> Transaction takes DB from one valid state to another. Enforced by: <em>Application logic + integrity constraints</em>.</p><p><strong>I — Isolation:</strong> Concurrent transactions don''t interfere. Enforced by: <em>Concurrency control (locking, MVCC)</em>.</p><p><strong>D — Durability:</strong> Committed changes persist despite failures. Enforced by: <em>Recovery manager (redo logs, WAL)</em>.</p>',
  ARRAY['acid','transactions']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='conflict-serial' LIMIT 1),
  'What are the three types of conflicting operation pairs?',
  '<p><strong>Two operations conflict if:</strong> Same data item + different transactions + at least one WRITE.</p><p><strong>3 conflict types:</strong></p><ul><li><strong>RW:</strong> Ti reads X, Tj writes X (Tj after Ti)</li><li><strong>WR:</strong> Ti writes X, Tj reads X (dirty read danger)</li><li><strong>WW:</strong> Ti writes X, Tj writes X (lost update danger)</li></ul><p><strong>NOT a conflict:</strong> RR (Ti reads X, Tj reads X) — reading doesn''t cause inconsistency.</p>',
  ARRAY['conflict-serializability','transactions','serializability']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='conflict-serial' LIMIT 1),
  'How do you test if a schedule is conflict-serializable?',
  '<p><strong>Precedence (Conflict) Graph method:</strong></p><ol><li>Create one node per transaction</li><li>For each conflicting pair (Oi from Ti, Oj from Tj, Oi before Oj): add edge Ti → Tj</li><li>If the graph is <strong>acyclic</strong> → conflict-serializable ✓</li><li>If the graph has a <strong>cycle</strong> → NOT conflict-serializable ✗</li></ol><p>Topological sort of the acyclic graph gives the equivalent serial order.</p>',
  ARRAY['conflict-serializability','serializability']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='2pl-protocol' LIMIT 1),
  'Explain Two-Phase Locking (2PL) and its guarantee.',
  '<p><strong>2PL phases:</strong></p><ol><li><strong>Growing phase:</strong> Transaction can acquire locks but CANNOT release any</li><li><strong>Shrinking phase:</strong> Transaction releases locks but CANNOT acquire new ones</li></ol><p><strong>Lock point:</strong> The moment the transaction acquires its last lock (transition point).</p><p><strong>Guarantee:</strong> Any schedule produced by transactions following 2PL is <em>conflict-serializable</em>.</p><p><strong>Limitation:</strong> Does NOT prevent deadlocks.</p>',
  ARRAY['two-phase-locking','serializability','transactions']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='view-serial' LIMIT 1),
  'How does view serializability relate to conflict serializability?',
  '<p><strong>Relationship (subset):</strong><br>Conflict-serializable ⊂ View-serializable ⊂ All serializable schedules</p><p><strong>Key facts:</strong><br>- Every conflict-serializable schedule is view-serializable (not vice versa)<br>- Testing view-serializability is NP-complete<br>- Testing conflict-serializability (acyclic precedence graph) is polynomial</p><p><strong>Extra condition for view-serial (not conflict-serial):</strong> Blind writes — a transaction writes a value that it never read and no other Tx reads it.</p>',
  ARRAY['view-serializability','conflict-serializability','serializability']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='deadlock-recovery' LIMIT 1),
  'What is a deadlock and how is it detected using a wait-for graph?',
  '<p><strong>Deadlock:</strong> A set of transactions each waiting for a lock held by another in the set — circular wait.</p><p><strong>Wait-for graph:</strong><br>- Node per transaction<br>- Edge Ti → Tj: Ti is waiting for a resource held by Tj<br>- <strong>Cycle in graph = Deadlock</strong></p><p><strong>Recovery:</strong> Abort one "victim" transaction to break the cycle. Victim selection criteria: minimum cost (youngest, fewest resources, minimum rollback cost).</p>',
  ARRAY['deadlock','two-phase-locking','transactions']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='timestamp-protocols' LIMIT 1),
  'Describe the timestamp-ordering protocol rules for READ and WRITE.',
  '<p><strong>Each data item Q has:</strong> R-timestamp(Q) and W-timestamp(Q).</p><p><strong>Ti wants to READ Q:</strong><br>- If TS(Ti) &lt; W-TS(Q): Ti is too late → <strong>ABORT Ti</strong><br>- Else: read proceeds; update R-TS(Q) = max(R-TS(Q), TS(Ti))</p><p><strong>Ti wants to WRITE Q:</strong><br>- If TS(Ti) &lt; R-TS(Q): ABORT Ti (a newer Tx already read Q)<br>- If TS(Ti) &lt; W-TS(Q): ABORT Ti (a newer Tx already wrote Q)<br>- Else: write proceeds; W-TS(Q) = TS(Ti)</p>',
  ARRAY['timestamp-protocol','transactions','serializability']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='schedules' LIMIT 1),
  'What anomalies can occur without proper isolation? Name all four.',
  '<p><strong>Concurrency anomalies (without isolation):</strong></p><ol><li><strong>Dirty Read:</strong> T2 reads data written by T1 before T1 commits. If T1 rolls back, T2 has invalid data.</li><li><strong>Non-repeatable Read:</strong> T1 reads X, T2 modifies and commits X, T1 reads X again and gets different value.</li><li><strong>Phantom Read:</strong> T1 reads a set of rows, T2 inserts/deletes rows matching T1''s filter, T1 re-reads and gets different rows.</li><li><strong>Lost Update:</strong> T1 and T2 both update X; one update overwrites the other.</li></ol>',
  ARRAY['transactions','acid','serializability']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='conflict-serial' LIMIT 1),
  'What is the difference between a recoverable and a cascadeless schedule?',
  '<p><strong>Recoverable schedule:</strong> For any two transactions Ti and Tj where Tj reads a value written by Ti, Ti must commit before Tj commits. Prevents reading "dirty" committed data.</p><p><strong>Cascadeless (ACA) schedule:</strong> Transactions can only read values written by already-committed transactions. Prevents cascading aborts.</p><p><strong>Hierarchy:</strong> Cascadeless ⊂ Recoverable ⊂ All Schedules</p><p>Strict 2PL produces cascadeless schedules.</p>',
  ARRAY['transactions','serializability','two-phase-locking']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='2pl-protocol' LIMIT 1),
  'What is Strict 2PL and how does it differ from basic 2PL?',
  '<p><strong>Basic 2PL:</strong> Two phases (growing + shrinking). May release locks before commit → can cause cascading aborts.</p><p><strong>Strict 2PL:</strong> Hold ALL exclusive (write) locks until the transaction commits or aborts.</p><p><strong>Rigorous 2PL:</strong> Hold ALL locks (shared + exclusive) until commit.</p><p><strong>Guarantees:</strong> Strict 2PL → conflict-serializable + cascadeless (recoverable without cascades).<br>Rigorous 2PL → conflict-serializable + equivalent serial order = commit order.</p>',
  ARRAY['two-phase-locking','transactions','serializability']
);

-- ─── Indexing Flashcards (10) ────────────────────────────────────────────
INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='index-types' LIMIT 1),
  'What is the difference between a dense index and a sparse index?',
  '<p><strong>Dense Index:</strong> One index entry per search-key value (i.e., per record). Works on unsorted files.</p><p><strong>Sparse Index:</strong> One index entry per <em>block</em> of records. Requires file to be sorted on the index key. Smaller index but requires sequential search within a block.</p><p><strong>Trade-off:</strong> Dense → larger, faster point queries. Sparse → smaller, requires sorted data, good for range queries.</p>',
  ARRAY['indexing']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='b-plus-tree-topic' LIMIT 1),
  'What are the key properties of a B+-tree of order p?',
  '<p><strong>Internal nodes:</strong><br>- Max p pointers, max p−1 keys<br>- Min ⌈p/2⌉ pointers (except root)</p><p><strong>Leaf nodes:</strong><br>- Max p−1 key-pointer pairs + 1 sibling pointer<br>- Min ⌈(p−1)/2⌉ key-pointer pairs<br>- All leaves at the same depth</p><p><strong>Root:</strong> Min 2 pointers (if not leaf)</p><p><strong>All data pointers are at leaf level. Leaves are linked in sorted order.</strong></p>',
  ARRAY['b-plus-tree','indexing']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='b-plus-tree-topic' LIMIT 1),
  'Why are B+-trees preferred over B-trees for database indexing?',
  '<p><strong>B+-tree advantages:</strong></p><ul><li>All data at leaf level → internal nodes store more keys (higher fan-out)</li><li>Leaf linked list enables efficient <em>range queries</em> and sequential scans</li><li>Consistent lookup time (always reaches leaf)</li></ul><p><strong>B-tree advantage over B+-tree:</strong> Some data pointers at internal nodes → slightly fewer levels for point queries (but at the cost of fewer keys per internal node).</p><p><strong>In practice:</strong> B+-trees are used in almost all DB engines (MySQL InnoDB, PostgreSQL).</p>',
  ARRAY['b-plus-tree','indexing']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='hashing-topic' LIMIT 1),
  'Compare static hashing and extendible hashing.',
  '<p><strong>Static Hashing:</strong><br>- Fixed number of buckets<br>- Overflow → chain of overflow buckets<br>- Can degrade to linear search if many overflows<br>- Cannot grow dynamically</p><p><strong>Extendible Hashing:</strong><br>- Uses a directory of pointers to buckets<br>- Buckets split when full (directory doubles if needed)<br>- Global depth and local depth control splitting<br>- No overflow chains; grows dynamically</p>',
  ARRAY['hashing','indexing']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='extendible-hashing' LIMIT 1),
  'In extendible hashing, when does the directory double?',
  '<p><strong>Directory doubles when:</strong> A bucket that needs to split has its local depth equal to the global depth.</p><p><strong>Splitting rules:</strong></p><ol><li>Local depth &lt; Global depth: only local depth+1 and records redistribute. Directory unchanged.</li><li>Local depth = Global depth: directory doubles (global depth+1), then local depth+1 and records redistribute.</li></ol><p><em>Key invariant:</em> local_depth ≤ global_depth always.</p>',
  ARRAY['hashing','indexing']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='clustering-index' LIMIT 1),
  'What is the difference between a clustered and a non-clustered index?',
  '<p><strong>Clustered (Primary) index:</strong> The physical order of data records on disk matches the index key order. At most ONE clustered index per table.</p><p><strong>Non-clustered (Secondary) index:</strong> Data records are physically unordered relative to the index. Multiple non-clustered indexes allowed per table.</p><p><strong>Clustered advantages:</strong> Excellent for range queries (sequential I/O). Expensive to maintain on inserts/updates.</p>',
  ARRAY['indexing']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='b-plus-tree-topic' LIMIT 1),
  'A B+-tree has order 4; leaf nodes hold max 3 keys. What is the minimum number of keys in a non-root leaf?',
  '<p><strong>Answer: ⌈(3)/2⌉ = 2 keys.</strong></p><p><strong>Rule:</strong> Non-root leaf nodes must be at least half full.</p><p><em>Minimum keys in leaf = ⌈(p_leaf − 1) / 2⌉</em> where p_leaf = max keys in leaf + 1 (order for leaves).</p><p><em>With max 3 keys:</em> min = ⌈3/2⌉ = 2 keys.</p><p><em>For internal non-root nodes:</em> min pointers = ⌈p/2⌉ = ⌈4/2⌉ = 2 pointers, so min 1 key.</p>',
  ARRAY['b-plus-tree','indexing']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='index-types' LIMIT 1),
  'What is a secondary index and why must it always be dense?',
  '<p><strong>Secondary (non-clustering) index:</strong> An index on an attribute whose order does not match the physical order of records on disk.</p><p><strong>Why always dense:</strong> Since records are NOT sorted by the secondary index key, there is no sequential locality to exploit. A sparse index entry per block would miss records in the same block that have different key values. Therefore every record needs its own index entry (dense).</p>',
  ARRAY['indexing']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='hashing-topic' LIMIT 1),
  'What is linear hashing and how does it avoid directory doubling?',
  '<p><strong>Linear hashing:</strong> A dynamic hashing scheme that splits buckets in a <em>linear order</em> (one at a time) regardless of which bucket overflows.</p><p><strong>Key property:</strong> No directory needed. Uses a "split pointer" that cycles through all buckets.</p><p><strong>Split trigger:</strong> When load factor exceeds a threshold, the bucket pointed to by the split pointer is split (not necessarily the overflowing one).</p><p><strong>Advantage over extendible:</strong> No directory → smaller metadata. Splits are smoother (one at a time).</p>',
  ARRAY['hashing','indexing']
),
(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='query-cost' LIMIT 1),
  'What factors determine the cost of a join operation in query processing?',
  '<p><strong>Join cost factors:</strong></p><ul><li>Number of tuples in each relation (|R|, |S|)</li><li>Number of disk blocks (b_R, b_S)</li><li>Available buffer memory (M pages)</li><li>Join algorithm used:<br>- Nested-loop join: b_R + |R|×b_S (worst case)<br>- Block nested-loop: b_R + (b_R/M)×b_S<br>- Sort-merge join: cost to sort R + sort S + merge<br>- Hash join: 3(b_R + b_S) for simple hash join</li></ul>',
  ARRAY['indexing','b-plus-tree']
);

-- Part 6 complete. Continue with dbms-seed-p7.sql (COMMIT + Stats block)
