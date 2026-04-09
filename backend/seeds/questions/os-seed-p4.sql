-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — OS PYQ SEED v2  (Part 4 / 8)
-- MCQ Questions Q29–Q45 (Memory Management & Storage/IO)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q29 — Internal Fragmentation in paging (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='paging' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A paged memory system suffers from which type of fragmentation?',
  'External Fragmentation only',
  'Internal Fragmentation only',
  'Both Internal and External Fragmentation',
  'Neither Internal nor External Fragmentation',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Paging uses fixed-size frames. If a process does not fill its last frame completely, the unused space within that frame is wasted — this is Internal Fragmentation.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q30 — Best-Fit vs First-Fit allocation (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='paging' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In contiguous variable-partition memory management, which allocation strategy produces the smallest leftover hole after each allocation?',
  'First-Fit',
  'Best-Fit',
  'Worst-Fit',
  'Next-Fit',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Best-Fit selects the smallest hole large enough to satisfy the request, minimizing the leftover fragment at that specific location. However, this tends to create many tiny unusable holes overall.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q31 — Belady's Anomaly (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='page-replacement' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which page replacement algorithm(s) are immune to Belady''s Anomaly?',
  'FIFO',
  'Random Replacement',
  'LRU and Optimal (OPT)',
  'Clock (Second-Chance)',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> LRU and OPT are "Stack Algorithms." For stack algorithms, adding more frames can never cause more page faults — immunity to Belady''s Anomaly is guaranteed.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q32 — Page size trade-offs (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='paging' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'If the OS decreases the page size (e.g., from 4KB to 1KB), what structural trade-off results?',
  'Page table grows larger; internal fragmentation decreases',
  'Page table shrinks; internal fragmentation increases',
  'Page table grows larger; internal fragmentation increases',
  'Page table shrinks; internal fragmentation decreases',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Smaller pages mean more pages exist for the same address space → page table grows. However, the last-page waste per process shrinks → internal fragmentation decreases.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q33 — Optimal (OPT) algorithm strategy (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='page-replacement' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The Optimal (OPT) page replacement algorithm evicts the page that:',
  'Was loaded longest ago',
  'Was used least recently',
  'Will not be used for the longest time in the future',
  'Has the largest page frame number',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> OPT has perfect future knowledge and always evicts the page with the furthest next-use time. It achieves the minimum possible page faults but is unrealizable in practice.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q34 — TLB miss memory accesses (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='virtual' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a paged system with single-level page tables, how many main memory accesses are needed to service a TLB miss and ultimately fetch the data word?',
  'Zero (the TLB handles it)',
  'One',
  'Two',
  'Three',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Access 1: Read the page table entry from main memory to translate the address. Access 2: Read the actual data from the resulting physical address. Total = 2.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tlb','paging');

-- Q35 — Demand paging concept (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='virtual' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Virtual memory systems allow programs larger than physical RAM to execute via which mechanism?',
  'Compressed in-memory caching',
  'Demand paging — loading only active pages into RAM as needed',
  'Compiler-level code size optimization',
  'CPU clock scaling to reduce memory bandwidth',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Demand paging keeps only the currently needed pages in physical frames, swapping in pages from disk on fault and swapping out idle pages to disk.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q36 — SSTF analogous CPU algorithm (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Disk scheduling via SSTF is analogous to which CPU scheduling algorithm?',
  'Priority Scheduling with Preemption',
  'Shortest Job First (SJF)',
  'Round Robin',
  'FCFS',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Both SSTF (disk) and SJF (CPU) always service the locally shortest pending request next. Both achieve lower average service times but suffer from starvation of distant/long requests.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q37 — Disk access time formula (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Total disk access time is the sum of which three components?',
  'Seek Time + File Size + OS Transfer Overhead',
  'Seek Time + Cache Latency + Swap Space Size',
  'Seek Time + Rotational Latency + Transfer Time',
  'Transfer Time + TLB Hit Ratio + Page Fault Rate',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Disk Access Time = Seek Time (head to correct track) + Rotational Latency (drum spin to correct sector) + Transfer Time (streaming bits off the platter).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q38 — SCAN Elevator Algorithm (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The disk scheduling algorithm nicknamed the "Elevator Algorithm" is formally known as:',
  'SSTF',
  'LOOK',
  'SCAN',
  'C-SCAN',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> SCAN moves the disk head from one end to the other, servicing requests on the way, then reverses — exactly like an elevator travelling between floors.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q39 — Unix inode indirect pointers (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='unix-inode' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the UNIX inode structure, which mechanism allows the filesystem to support files much larger than the 12 direct block pointers can address?',
  'Contiguous allocation extension tables',
  'FAT chaining at the end of the inode',
  'Single, Double, and Triple Indirect pointer blocks',
  'In-memory cache stacking only',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Beyond 12 direct blocks, an inode references single, double, and triple indirect blocks — each level adding another layer of indirection to support massive file sizes.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q40 — Contiguous allocation weakness (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='file-alloc' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Contiguous file allocation offers fast sequential access but suffers from which major drawback?',
  'High internal fragmentation',
  'Cannot support file deletion',
  'External fragmentation requiring periodic disk compaction',
  'TLB invalidation on every access',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Storing each file as a contiguous run results in external fragmentation — free space becomes scattered into non-contiguous gaps that cannot satisfy new large file requests.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q41 — FAT as linked allocation (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='file-alloc' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A File Allocation Table (FAT) implements which underlying disk allocation strategy?',
  'Contiguous allocation, stored inline',
  'Linked allocation — with the chain table stored separately in memory',
  'Indexed allocation using inodes',
  'Hashed bucket allocation',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> FAT is linked allocation where the chain of next-block pointers is stored in a centralized table (the FAT) in memory, rather than within each block itself.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q42 — LOOK vs SCAN difference (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What is the key difference between LOOK and SCAN disk scheduling?',
  'LOOK travels all the way to cylinder 0 before reversing; SCAN does not',
  'LOOK reverses direction as soon as there are no more pending requests in the current direction; SCAN always travels to the disk end',
  'LOOK only services requests in one direction',
  'SCAN is a version of LOOK that uses a priority queue',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> SCAN blindly travels to the physical disk end before reversing. LOOK checks whether any pending requests remain further out and reverses early if not, saving unnecessary head movement.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q43 — RAID 1 storage capacity (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='storage-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='disk' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'A RAID Level 1 (Mirroring) array uses N identical disks. What is the effective usable storage capacity?',
  'N × disk capacity (full sum)',
  '(N-1) × disk capacity',
  '1 × disk capacity (equivalent to one disk)',
  '(N/2) × disk capacity',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> RAID 1 mirrors every write to all N disks identically. The usable capacity equals only 1 disk''s worth of data, regardless of how many disks are in the mirror set.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('disk');

-- Q44 — Page fault interrupt trigger (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='virtual' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A Page Fault interrupt is triggered when a process attempts to access a page that:',
  'Is already resident in physical RAM',
  'Exceeds the maximum memory allocation for the process',
  'Is not currently loaded in physical memory (the valid bit is 0)',
  'Has been written to more than a threshold number of times',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The MMU checks the valid/invalid bit of each page table entry. If the bit indicates the page is absent from RAM, it generates a page fault trap, allowing the OS to load the page from disk.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Q45 — Pure demand paging characteristic (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='os'),
  (SELECT id FROM chapters WHERE slug='memory-management' LIMIT 1),
  (SELECT id FROM topics WHERE slug='virtual' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Under "pure" demand paging, how many pages are loaded into memory when a process first starts executing?',
  'All pages the process will ever access',
  'Zero pages — the first page fault loads the first needed page',
  'A fixed working set pre-loaded by the OS',
  'Exactly one page — the process entry point',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Pure demand paging loads no pages initially. The very first instruction access triggers a page fault, and from there the OS handles each fault lazily as references occur.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('paging');

-- Part 4 Complete.
