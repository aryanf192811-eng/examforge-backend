-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COA PYQ SEED v2  (Part 3 / 8)
-- MCQ Questions Q15–Q28 (Memory Hierarchy & I/O)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — Temporal locality concept (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Cache memory relies heavily on the Principle of Locality. Which of the following best describes "Temporal Locality"?',
  'Code that accesses memory addresses that are numerically close together',
  'Data items that are grouped in the same cache line',
  'If a memory location is referenced, it will likely be referenced again in the near future',
  'Instructions executing in sequential order without branching',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Temporal locality refers to time. If an item (like a loop variable) is accessed, it is highly probable it will be accessed again soon. Spatial locality refers to space (items nearby in memory will likely be accessed soon).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q16 — Direct Mapped Cache mapping (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-mapping' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a Direct-Mapped cache organization, how is a memory block assigned to a cache line?',
  'A block can be placed in any available cache line',
  'A block is placed based on its Least Recently Used (LRU) status',
  'A block $M$ can only be placed in cache line $L$ where $L = M \mod (\text{number of cache lines})$',
  'A block is stored in fully associative tags based on its page number',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Direct mapping uses the modulo operation to map every memory block to exactly one specific cache line. This makes lookups very fast, as only one tag needs to be checked, but increases conflict fault rates.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache-mapping');

-- Q17 — Cache replacement policy LRU (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-mapping' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which cache mapping technique absolutely requires a replacement policy (such as LRU or FIFO)?',
  'Direct-Mapped Cache',
  'Only Set-Associative Cache',
  'Fully-Associative and Set-Associative Caches',
  'Neither; cache hardware handles replacement automatically without policies',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> In a direct-mapped cache, a block maps to one specific line, so there is no choice of which line to evict. In fully-associative or set-associative caches, the new block can go into one of multiple lines within a set, thus requiring a replacement policy to choose the "victim."</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache-mapping');

-- Q18 — Write-through vs Write-back (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a cache memory system, what is the defining characteristic of a "Write-back" policy?',
  'Every write operation simultaneously updates the cache and the main memory',
  'Writes only update the cache; main memory is updated only when the modified cache block is evicted',
  'Writes are written directly to main memory bypassing the cache entirely',
  'Writes cause the cache line to be invalidated immediately',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Write-back keeps the modified data in cache without slowing down the CPU by writing to slow RAM. A "dirty bit" is used to track modification. The block is only written back to RAM when it must be replaced.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q19 — Memory interleaving (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='main-memory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Memory interleaving is primarily used to:',
  'Increase the maximum addressable memory space',
  'Provide virtual memory support for multiprogramming',
  'Increase the effective memory bandwidth by accessing multiple memory chips in parallel',
  'Reduce the power consumption of RAM',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> By dividing memory into $N$ independently accessible banks and distributing sequential addresses across them (low-order interleaving), the CPU can fetch $N$ consecutive words simultaneously, greatly multiplying bandwidth.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('coa-performance');

-- Q20 — DMA concept (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Direct Memory Access (DMA) allows which operation to occur without continuous CPU involvement?',
  'Floating point arithmetic operations',
  'Bulk data transfer directly between an I/O peripheral and Main Memory',
  'Instruction decoding and pipeline management',
  'Translation of logical addresses to physical addresses',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> DMA offloads the slow, tedious process of moving blocks of data (e.g., from a hard drive to RAM) to a dedicated DMA controller. The CPU initiates the transfer and can perform other tasks until the DMA issues an interrupt upon completion.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q21 — Cycle stealing in DMA (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In the context of DMA, what is meant by "Cycle Stealing"?',
  'The CPU stealing clock cycles from the system timer',
  'The DMA controller taking control of the system bus for one memory cycle to transfer a single word, forcing the CPU to pause briefly',
  'The operating system prioritizing background tasks over active processes',
  'Two DMA controllers fighting for bus mastery',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In cycle stealing mode, the DMA controller transfers data one word at a time by requesting the bus. The CPU is delayed for just that one memory cycle ("stealing" it), allowing the CPU to execute instructions in parallel with the transfer.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q22 — Memory-Mapped I/O vs Isolated I/O (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which of the following statements characterizes Memory-Mapped I/O?',
  'Special instructions like IN and OUT are required to access peripherals',
  'The same CPU instructions used to access memory (e.g., LOAD, STORE) are used to access I/O devices',
  'It provides a separate address space exclusively for I/O ports',
  'It cannot be used in systems with DMA controllers',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In Memory-Mapped I/O, device registers are assigned addresses within the single unified main memory address space. Any instruction capable of operating on memory can operate on an I/O device without needing specialized I/O instructions (unlike Isolated/Port-based I/O).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q23 — Interrupt acknowledge vector (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'When a vectored interrupt occurs, the interrupting device sends the CPU:',
  'The complete interrupt service routine code',
  'An address (or offset) pointing to the start of the interrupt service routine',
  'A special HALT signal',
  'A floating-point error code',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In a vectored interrupt system, the device identifies itself by providing an interrupt vector. The CPU uses this vector as an index into an Interrupt Vector Table to find the memory address of the specific ISR to execute.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Q24 — TLB matching phase (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a system combining virtual memory and cache, checking the TLB occurs:',
  'Before the cache accesses the data',
  'After the cache access fails',
  'In parallel with the cache index lookup if the cache is virtually indexed and physically tagged',
  'Only when a disk page fault occurs',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> To maximize speed, Modern CPUs often use a VIPT (Virtually Indexed, Physically Tagged) cache. The virtual index bits are used to start retrieving the cache line simultaneously while the TLB translates the virtual tag into a physical tag. The tags are then compared.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q25 — Cache conflict miss (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A cache miss that occurs because too many active blocks map to the exact same cache set, even though there is still empty space elsewhere in the cache, is called a:',
  'Compulsory Miss',
  'Capacity Miss',
  'Conflict Miss',
  'Coherence Miss',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Conflict (or collision) misses happen in direct-mapped or set-associative caches when the specific mapped set fills up, forcing evictions, despite the cache as a whole not being full. Fully associative caches avoid conflict misses.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q26 — Flash memory wear leveling (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='main-memory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'SSDs use "wear leveling" algorithms primarily to solve which fundamental limitation of NAND flash memory?',
  'Flash memory is volatile and loses data without constant refreshing',
  'Flash memory cells endure physical degradation and can only sustain a limited number of erase/write cycles',
  'Flash memory has a significantly higher read latency than magnetic disks',
  'Flash memory suffers from destructive reads',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> NAND flash insulating oxide degrades with every high-voltage tunnel-release (erase cycle). Wear leveling continuously remaps logical addresses to different physical cells to ensure all cells degrade evenly, preventing premature drive failure.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q27 — Virtual Memory Page Table location (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='main-memory' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Where is the complete Page Table for a process stored in a virtual memory system?',
  'In the CPU Translation Lookaside Buffer (TLB)',
  'In the L1 Cache',
  'In Main Memory (RAM)',
  'Hardcoded into the Memory Management Unit (MMU) hardware',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Page tables for modern operating systems are large (often megabytes). They are stored in Main Memory. The CPU hardware only contains a small register (like PTBR in x86) pointing to the table''s base address in RAM, and caches active entries in the TLB.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cache');

-- Q28 — Bus Arbitration Daisy Chaining (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In a daisy-chained bus arbitration scheme, how is priority determined among multiple requesting I/O devices?',
  'Priority is assigned randomly by the CPU every cycle',
  'Priority is determined solely by the physical proximity (electrical connection order) to the bus arbiter',
  'Devices use a token ring mechanism to pass fairness tickets',
  'The devices negotiate using priority priority-codes on a dedicated polling bus',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In daisy-chaining, the Bus Grant signal passes serially from the arbiter to the first device, then to the second, etc. The device physically closest to the arbiter intercepts the grant signal first, giving it inherently higher priority.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dma');

-- Part 3 Complete.
