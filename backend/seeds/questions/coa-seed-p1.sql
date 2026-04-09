-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — COA PYQ SEED v2  (Part 1 / 8)
-- Subject: Computer Organization & Architecture (coa)
-- ═══════════════════════════════════════════════════════════════════════════

BEGIN;

DO $$
DECLARE
  subj_id UUID;
  ch1_id  UUID;
  ch2_id  UUID;
  ch3_id  UUID;
  ch4_id  UUID;
BEGIN

  -- 1. Subject
  INSERT INTO subjects (title, slug, description, gradient_start, gradient_end, icon_type)
  VALUES (
    'Computer Organization & Architecture', 'coa',
    'Machine instructions, addressing modes, ALU, data path, pipelining, and memory hierarchy.',
    '#f59e0b', '#d97706', 'hardware' -- amber
  )
  ON CONFLICT (slug) DO UPDATE
    SET title = EXCLUDED.title, description = EXCLUDED.description
  RETURNING id INTO subj_id;

  -- 2. Chapters
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Machine Instructions & ALU', 'instructions-alu', 1) RETURNING id INTO ch1_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Datapath & Control Unit', 'datapath-control', 2) RETURNING id INTO ch2_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Instruction Pipelining', 'pipelining', 3) RETURNING id INTO ch3_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Memory Hierarchy & I/O', 'memory-io', 4) RETURNING id INTO ch4_id;

  -- 3. Topics
  -- Chapter 1: Machine Instructions & ALU
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'instruction-formats', 'Instruction Formats',          1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'addressing-modes',  'Addressing Modes',               2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'alu-design',        'ALU & Number Representation',    3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'floating-point',    'Floating Point Arithmetic',      4) ON CONFLICT DO NOTHING;

  -- Chapter 2: Datapath & Control Unit
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'datapath',          'Datapath Design',                1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'hardwired-cu',      'Hardwired Control',              2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'microprogrammed-cu','Microprogrammed Control',        3) ON CONFLICT DO NOTHING;

  -- Chapter 3: Instruction Pipelining
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'pipeline-basics',   'Pipeline Concepts & Performance', 1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'data-hazards',      'Data Hazards & Forwarding',       2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'control-hazards',   'Control Hazards & Branching',     3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'superscalar',       'Superscalar & ILP Basics',        4) ON CONFLICT DO NOTHING;

  -- Chapter 4: Memory Hierarchy & I/O
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'cache-basics',      'Cache Memory Fundamentals',       1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'cache-mapping',     'Cache Mapping Techniques',        2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'main-memory',       'Main Memory & Interleaving',      3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'io-dma',            'I/O Interfaces, Interrupts & DMA',4) ON CONFLICT DO NOTHING;

  -- 4. Tags
  INSERT INTO tags (name, slug) VALUES ('Addressing Modes','addressing-modes') ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Instruction Pipeline','instruction-pipeline') ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Hazards',         'hazards')         ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Cache Memory',    'cache')           ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Cache Mapping',   'cache-mapping')   ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('DMA',             'dma')             ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Microprogramming','microprogramming') ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Floating Point',  'floating-point')  ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Performance',     'coa-performance') ON CONFLICT DO NOTHING;

END $$;

-- Part 1 Complete.
