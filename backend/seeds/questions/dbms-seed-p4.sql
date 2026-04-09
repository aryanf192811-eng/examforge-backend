-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DBMS PYQ SEED v2  (Part 4 / 7)
-- SECTION 2A ctd: MCQ — ER Model (Q25–Q30), Transactions (Q31–Q35), Indexing (Q36–Q40)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q25 — Weak Entity (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='er-model' LIMIT 1),
  (SELECT id FROM topics WHERE slug='weak-entities-keys' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following best describes a weak entity set in an ER model?',
  'An entity set with no attributes',
  'An entity set that does not have a primary key of its own and depends on an identifying entity set',
  'An entity set whose primary key is shared with another entity set',
  'An entity set that participates in only optional (partial) relationships',
  'B',
  '<p><strong>✓ Answer: B.</strong> A weak entity cannot be uniquely identified by its own attributes alone. It depends on an identifying (strong) entity set and uses a discriminator (partial key) along with the identifying entity''s key to form its full key.</p><p><strong>Why wrong:</strong> A — weak entities do have attributes (including discriminators); the issue is key uniqueness; C — shared primary keys describe entity inheritance/subclasses, not weak entities; D — weak entities have a total participation in the identifying relationship (not optional).</p><p><strong>GATE trap:</strong> Weak entities always have TOTAL participation in their identifying relationship. The relationship is drawn with a double diamond (double rectangle for the weak entity).</p><p><strong>Rule:</strong> Weak entity key = (identifying entity''s primary key) + (discriminator/partial key).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('er-model','weak-entity');

-- Q26 — ER many-to-many mapping (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='er-model' LIMIT 1),
  (SELECT id FROM topics WHERE slug='er-to-relational' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'When converting a many-to-many (M:N) relationship in an ER diagram to the relational model, the standard approach is:',
  'Add a foreign key to one of the participating entity tables',
  'Create a new relation (junction table) containing the primary keys of both participating entities',
  'Merge both entity sets into a single relation',
  'Store one entity''s primary key as a multivalued attribute in the other',
  'B',
  '<p><strong>✓ Answer: B.</strong> An M:N relationship is represented by creating a separate junction/bridge table. This table has foreign keys referencing both participating entities, and together those FKs form the primary key of the junction table.</p><p><strong>Why wrong:</strong> A — adding a single FK to one entity only works for 1:N relationships; C — merging causes severe redundancy and anomalies if the M:N relationship has its own attributes; D — relational model does not support multivalued attributes directly.</p><p><strong>GATE trap:</strong> Many-to-many ≠ simple FK. The junction table is required. Its PK is (FK1, FK2) and it can have additional relationship attributes.</p><p><strong>Rule:</strong> M:N relationship → 3 tables: E1, E2, and Junction(E1_pk, E2_pk, [relationship attributes]).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('er-model','foreign-key');

-- Q27 — ISA hierarchy (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='er-model' LIMIT 1),
  (SELECT id FROM topics WHERE slug='isa-aggregation' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In an ISA hierarchy with superclass Person and subclasses Student and Employee, which mapping strategy stores all attributes in a single table with a type discriminator column?',
  'Table per subclass (vertical partitioning)',
  'Table per concrete class',
  'Single table inheritance (table per hierarchy)',
  'Table per class with delegation',
  'C',
  '<p><strong>✓ Answer: C — Single table inheritance.</strong> All subclass attributes are stored in one wide table. A discriminator column (e.g., person_type) indicates which subclass each row belongs to. Subclass-specific columns are NULL for rows of other subclasses.</p><p><strong>Why wrong:</strong> A — table per subclass creates separate tables for each subclass, joined via PK-FK; B — only concrete/leaf classes get separate tables, no table for superclass; D — not a standard ER mapping strategy name.</p><p><strong>GATE trap:</strong> Trade-offs: Single table → simple queries, many NULLs; Table per subclass → normalized, requires joins; Table per class → mix of both.</p><p><strong>Rule:</strong> Single table inheritance: 1 table + discriminator column. Trade-off: storage waste (NULLs) for query simplicity.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('er-model','isa-hierarchy');

-- Q28 — Total vs Partial participation (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='er-model' LIMIT 1),
  (SELECT id FROM topics WHERE slug='relationships-cardinality' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In an ER diagram, total participation of entity set E in relationship set R means:',
  'Every entity in E must participate in at least one relationship in R',
  'E participates in exactly one relationship in R',
  'Some entities in E may not participate in R',
  'R is mandatory for all entities across all participating entity sets',
  'A',
  '<p><strong>✓ Answer: A.</strong> Total participation (double line in ER diagram) means every entity in E must participate in at least one instance of the relationship R. It corresponds to a NOT NULL foreign key constraint.</p><p><strong>Why wrong:</strong> B — "exactly one" is a cardinality constraint (1:1), not participation; C — describes partial participation (single line); D — total participation applies to one entity set at a time, not necessarily to all.</p><p><strong>GATE trap:</strong> Total participation → double line in ER → NOT NULL FK in relational schema. Partial participation → single line → NULL allowed.</p><p><strong>Rule:</strong> Total (double line): every entity participates ≥ 1 time. Partial (single line): participation is optional (≥ 0 times).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('er-model');

-- Q29 — ACID: Isolation (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='acid-props' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which ACID property ensures that the intermediate states of a transaction are not visible to other concurrently executing transactions?',
  'Atomicity',
  'Consistency',
  'Isolation',
  'Durability',
  'C',
  '<p><strong>✓ Answer: C — Isolation.</strong> Isolation ensures that concurrent transactions execute as if they were serialized — each transaction''s intermediate state is hidden from others until it commits.</p><p><strong>Why wrong:</strong> A — Atomicity means all-or-nothing execution (either all operations succeed or all are rolled back); B — Consistency means a transaction brings the DB from one valid state to another; D — Durability ensures committed transactions survive system failures.</p><p><strong>GATE trap:</strong> Isolation is enforced by concurrency control mechanisms (locking, MVCC). Without isolation, dirty reads, non-repeatable reads, and phantom reads can occur.</p><p><strong>Rule:</strong> ACID: Atomicity (all-or-nothing), Consistency (valid states), Isolation (no interference), Durability (committed = permanent).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('acid','transactions');

-- Q30 — Conflict Serializability (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='conflict-serial' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Two operations conflict in a schedule if:',
  'They belong to different transactions and both read the same data item',
  'They belong to different transactions, access the same data item, and at least one is a write',
  'They belong to the same transaction and access the same data item in different orders',
  'They access different data items but in an inconsistent order',
  'B',
  '<p><strong>✓ Answer: B.</strong> Two operations conflict if: (1) they belong to different transactions, (2) they access the same data item, AND (3) at least one of them is a write (RW, WR, or WW conflict).</p><p><strong>Why wrong:</strong> A — Read-Read (RR) conflicts do NOT conflict; two reads from different transactions never cause inconsistency; C — same-transaction operations are never "conflicting" in the serialization sense; D — conflicts require accessing the same data item.</p><p><strong>GATE trap:</strong> Read-Read (RR) is NOT a conflict. Only RW, WR, and WW pairs conflict. Conflict equivalence → conflict serializability → acyclic precedence graph.</p><p><strong>Rule:</strong> Conflict types: RW, WR, WW (on SAME data item, DIFFERENT transactions). RR is never a conflict.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('conflict-serializability','serializability','transactions');

-- Q31 — 2PL Theorem (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='2pl-protocol' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following statements about Two-Phase Locking (2PL) is TRUE?',
  '2PL guarantees freedom from deadlock',
  'Every schedule produced by transactions following 2PL is conflict-serializable',
  '2PL requires all locks to be acquired before any transaction begins',
  '2PL allows a transaction to acquire new locks after releasing some locks',
  'B',
  '<p><strong>✓ Answer: B.</strong> The 2PL theorem: if all transactions in a schedule follow 2PL (growing phase then shrinking phase with no new lock acquisitions after first unlock), then every resulting schedule is conflict-serializable.</p><p><strong>Why wrong:</strong> A — 2PL can cause deadlocks (addressed by strict 2PL + deadlock detection/prevention); C — this describes "conservative 2PL" (a variant), not standard 2PL; D — standard 2PL PROHIBITS acquiring new locks after releasing any lock.</p><p><strong>GATE trap:</strong> 2PL ensures conflict-serializability but does NOT prevent deadlock. Strict 2PL (hold all locks until commit) also ensures recoverability.</p><p><strong>Rule:</strong> 2PL phases: Growing (acquire locks only) → Shrinking (release locks only, no new acquisitions). Result: conflict-serializable schedule.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('two-phase-locking','serializability','transactions');

-- Q32 — View Serializability (hard, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='view-serial' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Which of the following is TRUE about the relationship between conflict serializability and view serializability?',
  'Every view-serializable schedule is also conflict-serializable',
  'Every conflict-serializable schedule is also view-serializable',
  'View serializability and conflict serializability are equivalent',
  'Neither implies the other; they are completely disjoint sets',
  'B',
  '<p><strong>✓ Answer: B.</strong> Every conflict-serializable schedule is also view-serializable. Conflict serializability is a sufficient (but not necessary) condition for view serializability. The reverse does not hold — some view-serializable schedules are NOT conflict-serializable.</p><p><strong>Why wrong:</strong> A — incorrect direction; view-serial is the broader set; C — conflict-serial ⊂ view-serial (strict subset, not equal); D — they are not disjoint; conflict-serial schedules are a proper subset of view-serial schedules.</p><p><strong>GATE trap:</strong> Conflict-serial ⊂ View-serial ⊂ Serializable. Testing view-serializability is NP-complete; testing conflict-serializability (acyclic precedence graph) is polynomial.</p><p><strong>Rule:</strong> Relationship: conflict-serial → view-serial → serializable (each subset of the next). None implies the reverse.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('view-serializability','conflict-serializability','serializability');

-- Q33 — Timestamp ordering (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='timestamp-protocols' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the timestamp-ordering protocol, if transaction Ti with timestamp TS(Ti) wants to write data item Q and W-timestamp(Q) > TS(Ti), then:',
  'Ti waits until the transaction that wrote Q commits',
  'Ti proceeds and updates W-timestamp(Q)',
  'Ti is rolled back (aborted)',
  'Ti''s timestamp is updated to W-timestamp(Q) and it retries',
  'C',
  '<p><strong>✓ Answer: C — Ti is rolled back.</strong> If W-timestamp(Q) &gt; TS(Ti), a newer transaction has already written Q. Ti''s write is "too late" (obsolete) and would cause an inconsistency. Ti must be rolled back and restarted with a new timestamp.</p><p><strong>Why wrong:</strong> A — timestamp ordering does NOT use waiting/blocking (unlike locking-based protocols); B — proceeding would overwrite a newer value, violating the timestamp order; D — timestamps are assigned at transaction start and are not reassigned during execution.</p><p><strong>GATE trap:</strong> Timestamp ordering is non-blocking (no waits) but may cause cascading aborts. It guarantees conflict-serializability in the order of transaction timestamps.</p><p><strong>Rule:</strong> Ti writes Q: if W-TS(Q) &gt; TS(Ti) → abort Ti. If R-TS(Q) &gt; TS(Ti) → abort Ti. Else: write proceeds, update W-TS(Q) = TS(Ti).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('timestamp-protocol','transactions','serializability');

-- Q34 — B+ Tree order (easy, practice)  
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='b-plus-tree-topic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A B+-tree of order p (where p is the order of internal nodes) stores at most how many search-key values in each INTERNAL node?',
  'p',
  'p - 1',
  '2p',
  '⌈p/2⌉',
  'B',
  '<p><strong>✓ Answer: B — p − 1.</strong> An internal node of order p has at most p pointers (to child nodes) and p−1 search key values. The keys separate the pointer ranges.</p><p><strong>Why wrong:</strong> A — p is the number of pointers (fan-out), not key values; C — 2p is not a standard B+-tree bound; D — ⌈p/2⌉ is the MINIMUM number of pointers (for non-root internal nodes), not the maximum keys.</p><p><strong>GATE trap:</strong> In a B+-tree: internal nodes hold keys as separators; leaf nodes hold actual search keys + data pointers + a sibling pointer. Order p means max p pointers and p−1 keys per internal node.</p><p><strong>Rule:</strong> Internal node: max p pointers, max p−1 keys. Leaf node: max (p−1) key-pointer pairs + 1 sibling pointer.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('b-plus-tree','indexing');

-- Q35 — Dense vs Sparse Index (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='index-types' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which of the following correctly distinguishes a dense index from a sparse index?',
  'A dense index has one entry per distinct key value; a sparse index has one entry per data block',
  'A dense index stores actual data records; a sparse index stores only key values',
  'A dense index requires sorted data; a sparse index works on unsorted data',
  'A dense index is always a primary index; a sparse index is always secondary',
  'A',
  '<p><strong>✓ Answer: A.</strong> A dense index has one index entry for EVERY search key value (i.e., every record). A sparse index has one index entry per BLOCK of records (not every record), requiring data to be sorted by the index key.</p><p><strong>Why wrong:</strong> B — both types store key-pointer pairs, not actual data records (that''s a clustered/heap file); C — sparse index REQUIRES sorted data (to interpolate between entries), while dense index works with sorted or ordered files; D — primary indexes can be either dense or sparse; secondary indexes are always dense.</p><p><strong>GATE trap:</strong> Sparse indexes require the file to be sorted on the index key. Dense indexes do not have this requirement but take more space.</p><p><strong>Rule:</strong> Dense: 1 entry per record. Sparse: 1 entry per block (needs sorted file). Sparse = smaller index, faster to scan but requires sequential access.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('indexing');

-- Q36 — Hashing collision (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='hashing-topic' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In static hashing, if a bucket overflows, the standard solution is:',
  'Rehash all records into a larger hash table',
  'Use an overflow chain (linked list of overflow buckets)',
  'Reject the insertion and report an error',
  'Compress existing records to make room',
  'B',
  '<p><strong>✓ Answer: B.</strong> Static hashing handles bucket overflow using overflow chaining: additional overflow buckets are linked to the primary bucket via a pointer chain. This avoids rehashing all data.</p><p><strong>Why wrong:</strong> A — rehashing all records is done in dynamic hashing (extendible/linear hashing), not static hashing; C — databases don''t reject valid insertions on overflow; D — compression is not a used technique for overflow handling in hashing.</p><p><strong>GATE trap:</strong> Static hashing = fixed number of buckets + overflow chains. Dynamic hashing (extendible / linear) = adapts the number of buckets as data grows, avoiding long overflow chains.</p><p><strong>Rule:</strong> Static hash overflow → overflow chain. Dynamic hash overflow → split bucket / double directory (extendible) or split next pointer bucket (linear).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hashing','indexing');

-- Q37 — Query optimization: selection pushdown (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='query-processing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='query-optimization' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In query optimization, "pushing selections down" in a query tree means:',
  'Moving SELECT statements below FROM clauses in the SQL text',
  'Applying selection operations (σ) as early as possible in the operator tree to reduce intermediate result sizes',
  'Evaluating selection conditions only after all joins are computed',
  'Replacing selection operators with projection operators for efficiency',
  'B',
  '<p><strong>✓ Answer: B.</strong> Selection pushdown is a key heuristic in query optimization: apply σ (filter) operations as early as possible in the operator tree. This reduces the number of tuples fed into expensive operations (like joins), minimizing intermediate result sizes and I/O cost.</p><p><strong>Why wrong:</strong> A — this is about SQL text syntax, not logical operator trees; C — the opposite of pushdown; D — projection and selection are different operations with different effects.</p><p><strong>GATE trap:</strong> Query optimization heuristics in order of importance: (1) push selections down, (2) push projections down, (3) use the most selective join first. These reduce intermediate sizes before expensive Cartesian products.</p><p><strong>Rule:</strong> Selection pushdown: σ(p)(R ⋈ S) → σ(p)(R) ⋈ S when p involves only R''s attributes. Reduces I/O and CPU cost.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('indexing','b-plus-tree');

-- Q38 — Deadlock (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='transactions' LIMIT 1),
  (SELECT id FROM topics WHERE slug='deadlock-recovery' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a wait-for graph used for deadlock detection, a deadlock exists if and only if:',
  'There is at least one node with two outgoing edges',
  'There is a cycle in the wait-for graph',
  'All transactions appear in the graph',
  'The number of edges exceeds the number of nodes',
  'B',
  '<p><strong>✓ Answer: B.</strong> A deadlock is a circular wait: T1 waits for T2, T2 waits for T3, ..., Tn waits for T1. This circular dependency is exactly a cycle in the wait-for graph. Deadlock detection algorithms search for such cycles.</p><p><strong>Why wrong:</strong> A — two outgoing edges means one transaction waits for two others (not a deadlock by itself); C — not all transactions need to appear; D — edges &gt; nodes is neither sufficient nor necessary for a cycle.</p><p><strong>GATE trap:</strong> Wait-for graph edge: Ti → Tj means Ti is waiting for a lock held by Tj. A cycle in this graph → deadlock. DB then aborts one victim transaction to break the cycle.</p><p><strong>Rule:</strong> Wait-for graph: node per transaction, edge Ti→Tj if Ti waits for a resource held by Tj. Cycle → deadlock.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('deadlock','two-phase-locking','transactions');

-- Q39 — Extendible hashing (medium, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='indexing-hashing' LIMIT 1),
  (SELECT id FROM topics WHERE slug='extendible-hashing' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In extendible hashing, when a bucket splits, which of the following always happens?',
  'The global depth is always incremented by 1',
  'The local depth of the split bucket is incremented by 1',
  'All buckets are redistributed across a new hash table',
  'A new overflow bucket is chained to the split bucket',
  'B',
  '<p><strong>✓ Answer: B.</strong> When a bucket splits in extendible hashing, the local depth of that specific bucket is always incremented by 1 (from d to d+1). The global depth is only incremented if the splitting bucket''s local depth equals the current global depth (directory doubling).</p><p><strong>Why wrong:</strong> A — global depth only increases when local depth of split bucket equals global depth; C — only the split bucket''s records are redistributed (based on the new distinguishing bit), not all buckets; D — chaining is the static hashing approach; extendible hashing splits buckets instead.</p><p><strong>GATE trap:</strong> In extendible hashing: Local depth ≤ Global depth always. Splitting when local_depth = global_depth → directory doubles AND local_depth++. Splitting when local_depth &lt; global_depth → only local_depth++, no directory change.</p><p><strong>Rule:</strong> Split: local_depth++ (always). If before split: local_depth == global_depth → global_depth++ and directory doubles.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('hashing','indexing');

-- Q40 — Referential Integrity (easy, practice)
WITH q AS (INSERT INTO questions
  (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,
   question_text,option_a,option_b,option_c,option_d,correct_option,explanation)
VALUES(
  (SELECT id FROM subjects WHERE slug='dbms'),
  (SELECT id FROM chapters WHERE slug='relational-model' LIMIT 1),
  (SELECT id FROM topics WHERE slug='foreign-key-integrity' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Referential integrity is enforced by the FOREIGN KEY constraint. Which action, if triggered on DELETE of a referenced row, sets the referencing attribute(s) to NULL?',
  'ON DELETE CASCADE',
  'ON DELETE SET DEFAULT',
  'ON DELETE RESTRICT',
  'ON DELETE SET NULL',
  'D',
  '<p><strong>✓ Answer: D — ON DELETE SET NULL.</strong> When a referenced row is deleted, all referencing rows have their FK attribute(s) set to NULL (if the FK column allows NULLs).</p><p><strong>Why wrong:</strong> A — CASCADE deletes all referencing rows too; B — SET DEFAULT sets the FK to its default value; C — RESTRICT (or NO ACTION) prevents the delete if any referencing rows exist.</p><p><strong>GATE trap:</strong> Know all four referential actions: CASCADE (delete children), SET NULL (null FK), SET DEFAULT (default FK), RESTRICT or NO ACTION (block parent delete).</p><p><strong>Rule:</strong> FK actions on DELETE/UPDATE: CASCADE | SET NULL | SET DEFAULT | RESTRICT | NO ACTION.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('foreign-key','relational-algebra');

-- Part 4 complete. Continue with dbms-seed-p5.sql (NAT + MSQ Questions Q41–Q65)
