-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COA PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2: Memory & I/O (11 Cards) + COMMIT
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES

-- Card 12
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'Explain Temporal vs Spatial Locality.',
  '<p><strong>Temporal:</strong> If a memory location is accessed, it will likely be accessed again soon (e.g., loops/variables). Exploited by caching.<br><strong>Spatial:</strong> If a location is accessed, nearby locations will likely be accessed soon (e.g., arrays). Exploited by larger cache block sizes.</p>',
  ARRAY['cache']
),

-- Card 13
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-mapping' LIMIT 1),
  'How is a physical address strictly partitioned for Direct-Mapped vs Set-Associative Cache?',
  '<ul><li><strong>Direct-Mapped:</strong> Tag | Line Index | Block Offset</li><li><strong>Set-Associative:</strong> Tag | Set Index | Block Offset</li></ul><p>Number of Index bits = log₂ of (Number of Lines or Sets). Offset bits = log₂ of (Block Size in Bytes).</p>',
  ARRAY['cache-mapping']
),

-- Card 14
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'Define AMAT (Average Memory Access Time).',
  '<p><strong>AMAT = Hit Time + (Miss Rate × Miss Penalty)</strong><br>Where hit time is the cache access time, and miss penalty is the time taken to fetch the block from lower-level memory.</p>',
  ARRAY['cache','coa-performance']
),

-- Card 15
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'What are the 3 C''s of Cache Misses?',
  '<p><strong>Compulsory (Cold):</strong> First-time access. Inevitable.<br><strong>Capacity:</strong> Cache is full. Solved by larger cache.<br><strong>Conflict (Collision):</strong> Set/Line is full due to mapping collisions, though cache has empty space elsewhere. Solved by higher associativity.</p>',
  ARRAY['cache']
),

-- Card 16
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'Compare Write-Through vs Write-Back cache policies.',
  '<p><strong>Write-Through:</strong> Updates cache and main memory simultaneously. Slower, but mathematically consistent.<br><strong>Write-Back:</strong> Updates only cache. Sets a "Dirty Bit". Main memory is updated only when the block is evicted. Faster, uses less bus bandwidth.</p>',
  ARRAY['cache']
),

-- Card 17
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='main-memory' LIMIT 1),
  'What is Memory Interleaving and why is High-Order vs Low-Order different?',
  '<p>Interleaving divides memory into multiple independently accessed banks to increase bandwidth.<br><strong>High-Order:</strong> MSBs select bank. Contiguous addresses are in the same bank (good for module isolation).<br><strong>Low-Order:</strong> LSBs select bank. Contiguous addresses are spread across banks (allows parallel fetching).</p>',
  ARRAY['coa-performance']
),

-- Card 18
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'Define Direct Memory Access (DMA).',
  '<p>A hardware controller that transfers blocks of data directly between an I/O device and Main Memory without CPU intervention, utilizing bus cycles only when the CPU doesn''t need them (or cycle-stealing).</p>',
  ARRAY['dma']
),

-- Card 19
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'What is the difference between Memory-Mapped I/O and Isolated I/O?',
  '<p><strong>Memory-Mapped:</strong> I/O registers share address space with RAM. Standard CPU instructions (LOAD/STORE) access them.<br><strong>Isolated (Port-Mapped):</strong> I/O uses a separate address space. Requires special instructions (IN/OUT) and a distinct control pin on the CPU.</p>',
  ARRAY['dma']
),

-- Card 20
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='cache-basics' LIMIT 1),
  'What is a TLB and what does it cache?',
  '<p><strong>Translation Lookaside Buffer:</strong> A specialized, ultra-fast fully-associative hardware cache inside the CPU ''s MMU. It caches recent Virtual-to-Physical page table translations to speed up virtual memory execution.</p>',
  ARRAY['cache']
),

-- Card 21
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='io-dma' LIMIT 1),
  'What is a Vectored Interrupt?',
  '<p>An interrupt where the hardware device asserts an IRQ and simultaneously provides an ID (vector) on the data bus. The CPU uses this vector to index an Interrupt Vector Table and directly jump to the specific ISR, skipping polling.</p>',
  ARRAY['dma']
),

-- Card 22
(
  (SELECT id FROM subjects WHERE slug='coa'),
  (SELECT id FROM chapters WHERE slug='memory-io' LIMIT 1),
  (SELECT id FROM topics WHERE slug='main-memory' LIMIT 1),
  'Why do SSDs use Wear Leveling?',
  '<p>NAND flash cells degrade physically with each erase/write cycle. Wear leveling algorithms dynamically remap logical blocks to different physical cells to ensure all cells degrade evenly, maximizing the drive''s total lifespan.</p>',
  ARRAY['cache']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing coa-seed.sql to verify data integrity:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='coa'));
-- Expected: 15
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='coa');
-- Expected: 65
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='coa')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='coa');
-- Expected: 22

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug:  coa
-- Schema:        v2 (normalized tags, NUMERIC(10,2) NAT answers, topic enforcement)
-- Chapters:      4
-- Topics:        15
-- Questions:     65 total
--   MCQ:         45 (Q1–Q45)
--   NAT:         10 (Q46–Q55)
--   MSQ:         10 (Q56–Q65)
-- Flashcards:    22 (11 per batch)
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF coa-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
