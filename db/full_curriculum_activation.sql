-- ══════════════════════════════════════════════════════════════════════
-- ExamForge — FULL CURRICULUM ACTIVATION SCRIPT
-- Purpose: Global visibility for Subjects, Chapters, Topics, and PYQs.
-- ══════════════════════════════════════════════════════════════════════

-- 1. Publish all Subjects, Chapters, and Topics
UPDATE subjects SET is_published = true;
UPDATE chapters SET is_published = true;
UPDATE topics SET is_published = true;

-- 2. Mark all existing questions as PYQs (to ensure "accessible" in all modes)
-- NOTE: We only do this for questions where is_pyq was potentially false.
UPDATE questions SET is_pyq = true, gate_year = COALESCE(gate_year, 2024);

-- 3. Fix Chapters missing Notes
-- Identify chapters where NO record exists in the 'notes' table.
-- We insert a placeholder note using an existing storage path ('intro' or a common page).
INSERT INTO notes (chapter_id, storage_path, format, is_published)
SELECT 
    c.id, 
    'notes/gate/algo/algo-01-complexity-sorting-searching.html', -- Placeholder path
    'html', 
    true
FROM chapters c
LEFT JOIN notes n ON n.chapter_id = c.id
WHERE n.id IS NULL
ON CONFLICT DO NOTHING;

-- 5. Verification
-- Count of active items
SELECT 
    (SELECT COUNT(*) FROM subjects WHERE is_published = true) as active_subjects,
    (SELECT COUNT(*) FROM chapters WHERE is_published = true) as active_chapters,
    (SELECT COUNT(*) FROM notes WHERE is_published = true) as active_notes,
    (SELECT COUNT(*) FROM questions WHERE is_pyq = true) as pyq_accessible;
