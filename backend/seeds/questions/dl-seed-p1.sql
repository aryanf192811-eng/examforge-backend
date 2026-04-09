-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — DL PYQ SEED v2  (Part 1 / 8)
-- Subject: Digital Logic (dl)
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
    'Digital Logic', 'dl',
    'Boolean algebra, K-maps, combinational & sequential circuits, and number representations.',
    '#10b981', '#059669', 'cpu' -- emerald
  )
  ON CONFLICT (slug) DO UPDATE
    SET title = EXCLUDED.title, description = EXCLUDED.description
  RETURNING id INTO subj_id;

  -- 2. Chapters
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Boolean Algebra & Logic Gates', 'boolean-logic', 1) RETURNING id INTO ch1_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Combinational Circuits', 'combinational', 2) RETURNING id INTO ch2_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Sequential Circuits & Counters', 'sequential', 3) RETURNING id INTO ch3_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Number Systems & Converters', 'numbers-converters', 4) RETURNING id INTO ch4_id;

  -- 3. Topics
  -- Chapter 1: Boolean Algebra & Logic Gates
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'logic-gates',     'Basic & Universal Logic Gates',     1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'boolean-laws',    'Boolean Laws & Theorems',           2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'k-maps',          'Karnaugh Maps & Minimization',      3) ON CONFLICT DO NOTHING;

  -- Chapter 2: Combinational Circuits
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'adders-sub',      'Adders & Subtractors',              1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'multiplexers',    'Multiplexers & Demultiplexers',     2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'decoders',        'Decoders & Encoders',               3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'circuit-delay',   'Combinational Circuit Delays',      4) ON CONFLICT DO NOTHING;

  -- Chapter 3: Sequential Circuits & Counters
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'flip-flops',      'Latches & Flip-Flops',              1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'state-machines',  'Finite State Machines (Mealy/Moore)',2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'counters',        'Synchronous & Asynchronous Counters',3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'registers',       'Shift Registers',                   4) ON CONFLICT DO NOTHING;

  -- Chapter 4: Number Systems & Converters
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'number-systems',  'Base Conversions & Number Systems', 1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'signed-numbers',  'Signed Numbers & 2s Complement',    2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'adc-dac',         'ADC & DAC Converters',              3) ON CONFLICT DO NOTHING;

  -- 4. Tags
  INSERT INTO tags (name, slug) VALUES ('Boolean Algebra', 'boolean-algebra') ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('K-Map',           'k-map')           ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Multiplexer',     'multiplexer')     ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Flip-Flop',       'flip-flop')       ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Counter',         'counter')         ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('State Machine',   'state-machine')   ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Delay',           'dl-delay')        ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Number System',   'number-system')   ON CONFLICT DO NOTHING;

END $$;

-- Part 1 Complete.
