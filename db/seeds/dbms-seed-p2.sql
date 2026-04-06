-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DBMS PYQ SEED v2  (Part 2 / 7)
-- SECTION 2A: MCQ Questions — Normalization (Q1–Q12)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — BCNF Definition (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bcnf-decomp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A relation R is in Boyce–Codd Normal Form (BCNF) if and only if:',
  'For every non-trivial FD X→Y, X is a superkey of R',
  'Every non-prime attribute is fully functionally dependent on the primary key',
  'There are no transitive dependencies among non-prime attributes',
  'Every non-prime attribute depends only on candidate keys, not on each other',
  'A',
  '<p><strong>✓ Answer: A.</strong> BCNF requires that the left-hand side of every non-trivial FD must be a superkey — no exceptions.</p><p><strong>Why wrong:</strong> B describes 2NF (no partial dependencies); C describes 3NF (no transitive dependencies from non-prime to non-prime); D is an informal paraphrase of 3NF.</p><p><strong>GATE trap:</strong> 3NF has an extra escape clause — X→Y is also allowed if Y is a prime attribute. BCNF has NO such escape clause.</p><p><strong>Rule:</strong> BCNF: ∀ non-trivial FD X→Y, X is a superkey. 3NF: ∀ non-trivial FD X→Y, X is a superkey OR Y is prime.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bcnf','normalization');

-- Q2 — 3NF vs BCNF Property (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='3nf-synthesis' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following properties is guaranteed by the 3NF Synthesis algorithm but NOT always by BCNF decomposition?',
  'Lossless-join decomposition',
  'Elimination of all partial dependencies',
  'Dependency preservation',
  'Elimination of transitive dependencies',
  'C',
  '<p><strong>✓ Answer: C.</strong> The 3NF synthesis algorithm (Bernstein''s algorithm) always produces a dependency-preserving, lossless-join decomposition in 3NF. BCNF decomposition may fail to preserve dependencies.</p><p><strong>Why wrong:</strong> A — both 3NF synthesis and BCNF decomposition produce lossless-join results; B — 3NF synthesis eliminates partial dependencies as part of normalization; D — 3NF eliminates transitive dependencies among non-prime attributes by definition.</p><p><strong>GATE trap:</strong> Students confuse "lossless" (preserved by both) with "dependency preserving" (only guaranteed by 3NF, not BCNF).</p><p><strong>Rule:</strong> BCNF: always lossless, NOT always dependency-preserving. 3NF synthesis: always both.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('3nf','bcnf','normalization');

-- Q3 — GATE 2014: Student_Performance schema (medium, pyq)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,set_code,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bcnf-decomp' LIMIT 1),
  'gate-cse',true,2014,'Set-3','MCQ','medium',2,
  'The relation schema Student_Performance(name, courseNo, rollNo, grade) has the following FDs: {name, courseNo} → grade; {rollNo, courseNo} → grade; name → rollNo; rollNo → name. The highest normal form of this relation schema is:',
  '1NF',
  '2NF',
  '3NF',
  'BCNF',
  'C',
  '<p><strong>✓ Answer: C — 3NF.</strong> Candidate keys: {name,courseNo} and {rollNo,courseNo}. Prime attributes: name, courseNo, rollNo. Non-prime: grade.</p><p><strong>Analysis:</strong> FD name→rollNo — LHS (name) is NOT a superkey, but RHS (rollNo) IS a prime attribute → 3NF satisfied (prime attribute on RHS). FD rollNo→name — same logic, 3NF satisfied. But name→rollNo violates BCNF (LHS not a superkey). So schema is in 3NF but NOT BCNF.</p><p><strong>GATE trap:</strong> Always identify ALL candidate keys before deciding NF. With two candidate keys, more attributes become prime, which can satisfy 3NF even when BCNF is violated.</p><p><strong>Rule:</strong> 3NF escape clause: X→Y is OK if Y is prime (part of any candidate key).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bcnf','3nf','normalization','candidate-key');

-- Q4 — Armstrong's Axioms (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='fd-axioms' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following is NOT one of Armstrong''s three axioms for functional dependencies?',
  'Reflexivity: if Y ⊆ X then X → Y',
  'Augmentation: if X → Y then XZ → YZ',
  'Transitivity: if X → Y and Y → Z then X → Z',
  'Union: if X → Y and X → Z then X → YZ',
  'D',
  '<p><strong>✓ Answer: D.</strong> Union is a derived rule (inference rule), not one of the three base axioms. Armstrong''s three axioms are: Reflexivity, Augmentation, and Transitivity.</p><p><strong>Why wrong:</strong> A (Reflexivity), B (Augmentation), C (Transitivity) are the three axiomatic rules — they are sound and complete for FD inference.</p><p><strong>GATE trap:</strong> Union, Decomposition, and Pseudotransitivity are inference rules derivable from the three axioms — they are NOT Armstrong''s axioms themselves.</p><p><strong>Rule:</strong> Armstrong''s axioms: Reflexivity, Augmentation, Transitivity. All other FD rules are derived from these.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('functional-dependency','closure');

-- Q5 — Attribute Closure (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='attr-closure' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Given relation R(A,B,C,D,E) with FDs: {A→BC, CD→E, B→D, E→A}. Which of the following is a candidate key of R?',
  'A',
  'BC',
  'AC',
  'CD',
  'A',
  '<p><strong>✓ Answer: A.</strong> Compute A⁺: A→BC (so A⁺={A,B,C}), B→D (so A⁺={A,B,C,D}), CD→E (C,D ∈ A⁺, so A⁺={A,B,C,D,E}). A⁺ = ABCDE = R, so A is a superkey. Since no proper subset of A can be a key (A is a single attribute), A is a candidate key.</p><p><strong>Why wrong:</strong> B (BC): B⁺={B,D} ≠ R; C⁺=? need to compute — C⁺ alone doesn''t reach all attributes; D (CD): CD⁺={A,B,C,D,E} via CD→E,E→A,A→BC — CD is a superkey but is it minimal? C alone: C⁺=C, D alone: D⁺=D — so CD is also a candidate key. Both A and CD are candidate keys.</p><p><strong>GATE trap:</strong> Always compute the full closure step-by-step. Multiple candidate keys may exist.</p><p><strong>Rule:</strong> X is a candidate key iff X⁺ = R AND no proper subset of X has the same closure = R.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('candidate-key','closure','functional-dependency');

-- Q6 — Lossless Join Decomposition (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bcnf-decomp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A decomposition {R1, R2} of relation R is lossless-join if and only if:',
  'FDs are preserved across R1 and R2',
  'R1 ∩ R2 → R1 or R1 ∩ R2 → R2 (the common attributes form a superkey of at least one part)',
  'R1 and R2 are each in BCNF',
  'Every FD in R appears in either R1 or R2',
  'B',
  '<p><strong>✓ Answer: B.</strong> By the lossless-join test (Ullman): decomposition {R1,R2} is lossless iff R1∩R2 → R1 (i.e., the intersection is a superkey of R1) OR R1∩R2 → R2 in F⁺.</p><p><strong>Why wrong:</strong> A — dependency preservation is separate from lossless-join; C — BCNF does not guarantee lossless-join on its own without the intersection superkey condition; D— describes dependency preservation, not lossless-join.</p><p><strong>GATE trap:</strong> Lossless-join and dependency-preservation are independent properties. A decomposition can be lossless but not dependency-preserving (BCNF case) or dependency-preserving but lossy.</p><p><strong>Rule:</strong> Lossless test for binary decomposition: (R1 ∩ R2) is a superkey of R1 or R2.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bcnf','normalization','functional-dependency');

-- Q7 — 2NF Violation (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='1nf-2nf' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Relation R(A,B,C,D) has FDs: {AB→CD, A→C}. The primary key is AB. Which normal form does R violate?',
  'R is in 1NF but not 2NF',
  'R is in 2NF but not 3NF',
  'R is in 3NF but not BCNF',
  'R is in BCNF',
  'A',
  '<p><strong>✓ Answer: A — 1NF but not 2NF.</strong> Primary key is AB. FD A→C: LHS (A) is a proper subset of the primary key AB, and C is a non-prime attribute. This is a PARTIAL dependency → violates 2NF.</p><p><strong>Why wrong:</strong> B — 2NF requires no partial dependencies; we have one here; C,D — R cannot be in 2NF without first satisfying the partial dependency check.</p><p><strong>GATE trap:</strong> 2NF is only relevant when the key is composite. Single-attribute keys cannot have partial dependencies, so such relations are always in 2NF.</p><p><strong>Rule:</strong> 2NF violation: a non-prime attribute is functionally dependent on a proper subset of some candidate key (partial dependency).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('2nf','normalization','functional-dependency');

-- Q8 — Minimal Cover (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='minimal-cover' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Given FD set F = {A→BC, B→C, A→B, AB→C}. Which is the minimal cover (canonical cover) of F?',
  '{A→BC, B→C}',
  '{A→B, B→C}',
  '{A→B, A→C, B→C}',
  '{AB→C, B→C}',
  'B',
  '<p><strong>✓ Answer: B — {A→B, B→C}.</strong> Steps: (1) RHS singleton: A→B, A→C, B→C, AB→C. (2) Remove redundant LHS attributes: AB→C — check if A→C in F⁺ without B: A→BC yes, so AB→C becomes A→C (but A→C is already covered). Remove AB→C. (3) Remove redundant FDs: A→C is redundant since A→B and B→C gives A→C by transitivity. Remove A→C. Result: {A→B, B→C}.</p><p><strong>GATE trap:</strong> The minimal cover computation has 3 steps in order: (1) make all RHS singletons, (2) remove extraneous LHS attributes, (3) remove redundant FDs. Skipping any step gives wrong answers.</p><p><strong>Rule:</strong> Minimal cover F<sub>c</sub>: (1) all RHS are single attributes, (2) no extraneous attribute in any LHS, (3) no FD is redundant.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('minimal-cover','functional-dependency','normalization');

-- Q9 — MVD and 4NF (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mvd-4nf' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A relation R(A,B,C) has a multivalued dependency A ↠ B. Which of the following is TRUE?',
  'R must also have the FD A→B',
  'A ↠ C also holds (the complementary MVD)',
  'R is automatically in BCNF',
  'This MVD implies R can have at most 2 tuples for any value of A',
  'B',
  '<p><strong>✓ Answer: B.</strong> By the complementation rule for MVDs: if A ↠ B holds in R(A,B,C), then A ↠ C also holds (the complementary MVD over the remaining attributes).</p><p><strong>Why wrong:</strong> A — an MVD A↠B does NOT imply the FD A→B; MVDs allow multiple B values per A; C — BCNF is about FDs, not MVDs; a relation with a non-trivial MVD can violate 4NF even while satisfying BCNF; D — MVDs don''t limit tuple count this way.</p><p><strong>GATE trap:</strong> Every FD is also an MVD (F→D implies F↠D), but NOT every MVD is an FD. 4NF is strictly stronger than BCNF.</p><p><strong>Rule:</strong> If A ↠ B in R(A,B,C), then A ↠ C (complementation axiom for MVDs).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('4nf','normalization','functional-dependency');

-- Q10 — GATE 2015 pattern: NF identification (medium, pyq-pattern)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='3nf-synthesis' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Relation R(A,B,C) has FDs: {A→B, B→C}. The only candidate key is A. Which is the highest normal form R satisfies?',
  '1NF',
  '2NF',
  '3NF',
  'BCNF',
  'B',
  '<p><strong>✓ Answer: B — 2NF.</strong> Key is A (single attribute, no partial dependency possible → 2NF satisfied). Check 3NF: B→C — LHS B is not a superkey; RHS C is non-prime. This is a TRANSITIVE dependency → 3NF violated.</p><p><strong>Step-by-step:</strong> Key = {A}. Prime attributes = {A}. Non-prime = {B,C}. FD B→C: LHS not a superkey, RHS not prime → violates 3NF. FD A→B: A is a superkey → OK.</p><p><strong>GATE trap:</strong> A single-attribute key can never cause a 2NF violation (no partial dependency), so start checking from 3NF in such cases.</p><p><strong>Rule:</strong> 3NF violation: X→Y where X is not a superkey AND Y is not prime (non-prime attribute on RHS).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('3nf','2nf','normalization','candidate-key');

-- Q11 — BCNF always lossless (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='bcnf-decomp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'When decomposing a relation into BCNF by repeatedly applying the BCNF decomposition rule, which property is always guaranteed?',
  'Dependency preservation',
  'Lossless-join decomposition',
  'Reduction in the number of FDs',
  'At most one relation in the decomposition will be in 3NF but not BCNF',
  'B',
  '<p><strong>✓ Answer: B.</strong> The standard BCNF decomposition algorithm always produces a lossless-join decomposition. Each split is done using a BCNF-violating FD X→Y where X is a superkey of one of the resulting relations, ensuring lossless reconstruction.</p><p><strong>Why wrong:</strong> A — BCNF decomposition can lose FDs that cannot be expressed in any single resulting relation; C — FD count reduction is not guaranteed; D — BCNF algorithm doesn''t make this guarantee.</p><p><strong>GATE trap:</strong> The classic exam pitfall: "BCNF is always lossless but may not preserve dependencies." This is tested repeatedly.</p><p><strong>Rule:</strong> BCNF decomposition: always lossless-join, NOT always dependency-preserving.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('bcnf','normalization');

-- Q12 — Candidate keys count (hard, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='normalization' LIMIT 1),
  (SELECT id FROM topics WHERE slug='attr-closure' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Relation R(A,B,C,D) has FDs: {A→B, B→C, C→D, D→A}. How many candidate keys does R have?',
  '1',
  '2',
  '4',
  '6',
  'C',
  '<p><strong>✓ Answer: C — 4 candidate keys.</strong> The FDs form a cycle: A→B→C→D→A. This means A, B, C, D each determine all others.</p><p><strong>Verification:</strong> A⁺={A,B,C,D}=R ✓; B⁺={B,C,D,A}=R ✓; C⁺={C,D,A,B}=R ✓; D⁺={D,A,B,C}=R ✓. Each is minimal (single attribute → no proper subset). So all 4 are candidate keys.</p><p><strong>GATE trap:</strong> A cyclic FD chain makes every attribute in the cycle a candidate key. This is a well-known GATE question pattern — always compute the full closure for each candidate.</p><p><strong>Rule:</strong> If FDs form a cycle over all attributes, each attribute in the cycle is a candidate key.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('candidate-key','closure','functional-dependency','normalization');

-- Part 2 complete. Continue with dbms-seed-p3.sql (SQL & Relational Algebra MCQs Q13–Q24)
