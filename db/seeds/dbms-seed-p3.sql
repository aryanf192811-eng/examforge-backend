-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DBMS PYQ SEED v2  (Part 3 / 7)
-- SECTION 2A ctd: MCQ — SQL & Relational Algebra (Q13–Q24)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q13 — SQL NULL in WHERE (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='basic-sql' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Consider table T(A,B). B contains some NULL values. What does the query SELECT COUNT(*) FROM T WHERE B = NULL return?',
  'The number of rows where B is NULL',
  '0',
  'An error because NULL comparison is undefined in SQL',
  'The total number of rows in T',
  'B',
  '<p><strong>✓ Answer: B — 0.</strong> In SQL, any comparison with NULL using = results in UNKNOWN (not TRUE). The WHERE clause only passes rows where the condition is TRUE, so no rows pass, returning 0.</p><p><strong>Why wrong:</strong> A — to find NULLs, use IS NULL not = NULL; C — it does not raise an error, it simply returns 0; D — rows are NOT returned because = NULL evaluates to UNKNOWN.</p><p><strong>GATE trap:</strong> NULL = NULL evaluates to UNKNOWN in SQL, not TRUE. To test for NULL, always use IS NULL or IS NOT NULL.</p><p><strong>Rule:</strong> WHERE B = NULL → always 0 rows. Use WHERE B IS NULL to filter NULLs.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sql-queries','subquery');

-- Q14 — NOT IN with NULLs (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='subqueries-topic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Table R has values (1,2,3) and table S has values (2,3,NULL). Query: SELECT * FROM R WHERE A NOT IN (SELECT A FROM S). What is the result?',
  '{1}',
  '{1, 2, 3}',
  'Empty set',
  '{2, 3}',
  'C',
  '<p><strong>✓ Answer: C — Empty set.</strong> NOT IN checks if A is not equal to any value in the subquery result. When S contains NULL, 1 NOT IN (2,3,NULL) → 1≠2 (TRUE) AND 1≠3 (TRUE) AND 1≠NULL (UNKNOWN). The AND of TRUE,TRUE,UNKNOWN = UNKNOWN → row excluded. Same for 2 and 3. Result: no rows.</p><p><strong>Why wrong:</strong> A — ignores NULL semantics; B — ignores the NOT IN filtering; D — same problem.</p><p><strong>GATE trap:</strong> NOT IN with NULLs in the subquery returns an empty result. Use NOT EXISTS instead to handle NULLs correctly — this is a classic GATE trap.</p><p><strong>Rule:</strong> NOT IN (subquery with NULLs) → always empty result. Use NOT EXISTS for NULL-safe negation.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sql-queries','subquery');

-- Q15 — GROUP BY + HAVING (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='aggregation-sql' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What does the following query compute? SELECT dept, COUNT(*) FROM Employees GROUP BY dept HAVING COUNT(*) > 5 ORDER BY COUNT(*) DESC',
  'Total number of employees per department for all departments',
  'Departments with more than 5 employees, listed in decreasing order of employee count',
  'Employees who work in departments with more than 5 people',
  'The 5 largest departments by employee count',
  'B',
  '<p><strong>✓ Answer: B.</strong> GROUP BY groups rows by dept, COUNT(*) counts employees per group, HAVING COUNT(*) &gt; 5 filters groups (not rows), ORDER BY DESC sorts remaining groups by count descending.</p><p><strong>Why wrong:</strong> A — HAVING filters out groups with ≤5 employees; C — result is per department (dept, count), not individual employees; D — ORDER BY DESC is applied but there is no LIMIT clause, so all qualifying departments are returned.</p><p><strong>GATE trap:</strong> HAVING filters GROUPS (after aggregation); WHERE filters ROWS (before aggregation). They cannot be swapped.</p><p><strong>Rule:</strong> Query execution order: FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('aggregation','sql-queries');

-- Q16 — Relational Algebra: division (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ra-expressions' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In relational algebra, the DIVISION operation R ÷ S is used to find:',
  'Tuples in R that match at least one tuple in S',
  'Tuples whose projection on R''s attributes match ALL tuples in S',
  'Tuples in R but not in S (set difference)',
  'The Cartesian product of R restricted to S''s attributes',
  'B',
  '<p><strong>✓ Answer: B.</strong> Division R(A,B) ÷ S(B) returns all values of A such that for every value of B in S, the pair (A,B) exists in R. It answers "for ALL" queries.</p><p><strong>Why wrong:</strong> A — describes semijoin or "exists" queries; C — describes set difference (R − S); D — describes a form of Cartesian product or join, not division.</p><p><strong>GATE trap:</strong> Division is used for "find entities that are related to ALL entities in another set" — e.g., students who took ALL required courses. Think "for all" → use division.</p><p><strong>Rule:</strong> R(A,B) ÷ S(B) = {t[A] | ∀ s ∈ S, ∃ r ∈ R such that r[B] = s[B] and r[A] = t[A]}.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relational-algebra','sql-queries');

-- Q17 — Natural join vs equijoin (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sql-joins-topic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'How does a Natural Join differ from an Equijoin on common attributes?',
  'Natural join eliminates duplicate columns for the joined attributes; equijoin keeps both',
  'Natural join uses != as the join condition; equijoin uses =',
  'Natural join is always lossless; equijoin may not be',
  'Natural join only works on primary key-foreign key pairs',
  'A',
  '<p><strong>✓ Answer: A.</strong> Both natural join and equijoin match rows where common attribute values are equal. The difference: natural join eliminates the duplicate column(s) for joined attribute(s), while equijoin includes both (with possible column renaming).</p><p><strong>Why wrong:</strong> B — both use equality; C — whether a join is lossless depends on FDs, not the join type name; D — natural join works on any common attribute name, not only PK-FK.</p><p><strong>GATE trap:</strong> Natural join automatically matches on ALL attributes with the same name. This can cause unintentional joins if tables share attribute names not meant for joining.</p><p><strong>Rule:</strong> Natural Join = Equijoin on all common attribute names, with duplicate columns removed.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sql-joins','relational-algebra');

-- Q18 — SQL correlated subquery (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='subqueries-topic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following SQL queries correctly finds all employees who earn more than the average salary of their own department?',
  'SELECT * FROM Emp E WHERE salary > AVG(salary)',
  'SELECT * FROM Emp E WHERE salary > (SELECT AVG(salary) FROM Emp WHERE dept = E.dept)',
  'SELECT * FROM Emp E WHERE salary > (SELECT AVG(salary) FROM Emp)',
  'SELECT * FROM Emp E, Emp F WHERE E.salary > AVG(F.salary) AND E.dept = F.dept',
  'B',
  '<p><strong>✓ Answer: B.</strong> Option B uses a correlated subquery — for each outer row E, the inner query computes AVG(salary) for that specific department (WHERE dept = E.dept) and compares.</p><p><strong>Why wrong:</strong> A — AVG() cannot appear directly in a WHERE clause without a subquery; C — computes the overall average salary (not per-department); D — invalid use of AVG in WHERE without GROUP BY or subquery structure.</p><p><strong>GATE trap:</strong> A correlated subquery re-executes for each outer row and references the outer query''s columns. It''s the standard way to compare each row against its group''s aggregate.</p><p><strong>Rule:</strong> Correlated subquery: inner query references outer query''s alias (E.dept), re-evaluated for each outer row.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('subquery','sql-queries','aggregation');

-- Q19 — Relational algebra equivalence (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ra-expressions' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which relational algebra expression is equivalent to SELECT * FROM R WHERE A > 5 AND B = ''X''?',
  'σ(A>5)(σ(B=''X'')(R))',
  'π(A,B)(σ(A>5 ∧ B=''X'')(R))',
  'σ(A>5 ∧ B=''X'')(R)',
  'Both A and C',
  'D',
  '<p><strong>✓ Answer: D — Both A and C.</strong> σ(A&gt;5)(σ(B=''X'')(R)) applies conditions sequentially (cascading selections); σ(A&gt;5 ∧ B=''X'')(R) applies the conjunction in one step. Both are equivalent by the selection cascade rule.</p><p><strong>Why wrong:</strong> B — adds a projection π(A,B) which would eliminate all other columns not in {A,B}; SELECT * returns all columns so projection cannot be part of the equivalent expression.</p><p><strong>GATE trap:</strong> SELECT * means no projection. σ (selection) corresponds to WHERE; π (projection) corresponds to SELECT with specified columns.</p><p><strong>Rule:</strong> Cascading selections: σ(p∧q)(R) ≡ σ(p)(σ(q)(R)) ≡ σ(q)(σ(p)(R)).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relational-algebra','sql-queries');

-- Q20 — SQL outer join NULLs (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='sql-joins-topic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Table Emp(eid, name, deptid) has 10 rows. Table Dept(deptid, dname) has 5 rows. 3 employees have deptid values not present in Dept. Query: SELECT * FROM Emp LEFT OUTER JOIN Dept ON Emp.deptid = Dept.deptid. How many rows does this return?',
  '7',
  '10',
  '5',
  '15',
  'B',
  '<p><strong>✓ Answer: B — 10 rows.</strong> LEFT OUTER JOIN preserves ALL rows from the left table (Emp). For 7 employees with matching depts, columns from Dept are filled. For the 3 unmatched employees, Dept columns are NULL. Total = 10.</p><p><strong>Why wrong:</strong> A — 7 is the inner join result (only matched rows); C — 5 is the number of Dept rows; D — 15 would suggest cross-join behavior.</p><p><strong>GATE trap:</strong> LEFT OUTER JOIN always returns at least as many rows as the left table. Unmatched left rows appear with NULLs on the right side.</p><p><strong>Rule:</strong> LEFT JOIN result count = (inner join rows) + (unmatched left rows). Here: 7 + 3 = 10.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sql-joins','sql-queries');

-- Q21 — Tuple Relational Calculus safety (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relational-calculus-topic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A TRC (Tuple Relational Calculus) query is called "safe" if:',
  'It produces a finite result on any finite database',
  'It uses only existential quantifiers, no universal quantifiers',
  'All domain values used come from the active domain of the database',
  'It is equivalent to some SQL query',
  'C',
  '<p><strong>✓ Answer: C.</strong> A TRC expression is safe if all values that appear in the result are values that appear in the database (active domain). This prevents infinite results caused by referencing values not in any relation.</p><p><strong>Why wrong:</strong> A — finite databases always produce finite results for safe queries; B — universal quantifiers (∀) are allowed in safe queries; D — safety is a semantic property, not equivalent to SQL translatability.</p><p><strong>GATE trap:</strong> TRC and DRC are Turing-complete (unsafe expressions exist), so the concept of "safety" limits expressions to those that always give finite, domain-bounded results.</p><p><strong>Rule:</strong> Safe TRC: every value mentioned in the result must come from a relation in the query (active domain restriction).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relational-calculus','sql-queries');

-- Q22 — Views in SQL (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='views-triggers' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following statements about SQL views is CORRECT?',
  'A view stores a physical copy of the data in a separate table',
  'A view can be used to simplify complex queries and provide data abstraction',
  'Updates to a view are never allowed in SQL',
  'A view always recomputes its result when created, not when queried',
  'B',
  '<p><strong>✓ Answer: B.</strong> A SQL view is a stored query definition (virtual table). Querying a view executes the underlying query at that time. Views provide abstraction, simplify complex queries, and can restrict column/row access.</p><p><strong>Why wrong:</strong> A — a standard view does NOT store data; a materialized view does; C — some views are updatable when they satisfy certain conditions (single base table, no aggregation, no DISTINCT, etc.); D — a view is a stored definition; the result is computed when the view is queried, not when it''s created.</p><p><strong>GATE trap:</strong> Views vs. Materialized Views: regular views are virtual (query re-executed), materialized views store the result physically.</p><p><strong>Rule:</strong> View = stored query definition. Query a view → underlying SELECT executes at query time.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('sql-queries');

-- Q23 — Relational completeness (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ra-expressions' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A query language is called "relationally complete" if:',
  'It can express all possible SQL queries including recursive ones',
  'It is at least as expressive as First-Order Predicate Logic',
  'It can express all queries that can be expressed in Relational Algebra',
  'It supports all six basic RA operators: σ, π, ∪, −, ×, ρ',
  'C',
  '<p><strong>✓ Answer: C.</strong> A language is relationally complete if it can express every query expressible in relational algebra. This is the standard benchmark set by Codd. SQL, TRC, and DRC all satisfy this criterion.</p><p><strong>Why wrong:</strong> A — SQL can''t express all recursive queries without WITH RECURSIVE; relational algebra itself is not recursive; B — relational algebra corresponds to FOPL, but relational completeness is defined w.r.t. RA specifically; D — relational completeness is about expressive power, not the syntax of operators.</p><p><strong>GATE trap:</strong> Relational completeness doesn''t mean the language can do everything SQL can — it specifically means it can do everything RA can (no more, no less).</p><p><strong>Rule:</strong> Relational completeness: can express all RA queries. SQL adds aggregation, ordering, recursion beyond RA.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('relational-algebra','relational-calculus');

-- Q24 — SQL EXISTS vs COUNT (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='sql-ra' LIMIT 1),
  (SELECT id FROM topics WHERE slug='subqueries-topic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following SQL expressions correctly retrieves departments that have at least one employee?',
  'SELECT deptid FROM Dept WHERE COUNT(SELECT eid FROM Emp WHERE Emp.deptid = Dept.deptid) > 0',
  'SELECT deptid FROM Dept WHERE EXISTS (SELECT 1 FROM Emp WHERE Emp.deptid = Dept.deptid)',
  'SELECT deptid FROM Dept WHERE deptid IN (SELECT AVG(deptid) FROM Emp)',
  'SELECT deptid FROM Dept HAVING COUNT(Emp.eid) > 0',
  'B',
  '<p><strong>✓ Answer: B.</strong> EXISTS returns TRUE if the correlated subquery returns at least one row. It is the idiomatic SQL way to test for "at least one matching row" and correctly handles NULLs.</p><p><strong>Why wrong:</strong> A — COUNT() cannot be used directly in a WHERE clause; must use a subquery or HAVING; C — AVG(deptid) returns a single average value, not a list of deptids; D — cannot use HAVING without GROUP BY (and in this context it is syntactically wrong).</p><p><strong>GATE trap:</strong> EXISTS is preferred over IN for correlated checks because: (1) EXISTS short-circuits on first match (performance), (2) handles NULLs correctly, (3) is semantically clearer for existence tests.</p><p><strong>Rule:</strong> EXISTS (subquery) → TRUE if subquery returns ≥1 row, else FALSE. Never UNKNOWN, unlike IN with NULLs.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('subquery','sql-queries','aggregation');

-- Part 3 complete. Continue with dbms-seed-p4.sql (ER Model + Transactions + Indexing MCQs Q25–Q35)
