-- ExamForge — Content Activation Script
-- Run this in your Supabase SQL Editor to "Publish" all seeded content.
-- This ensures that the API (which filters by is_published = true) can see the data.

-- 1. Activate Subjects
UPDATE subjects 
SET is_published = true 
WHERE is_published = false OR is_published IS NULL;

-- 2. Activate Chapters
UPDATE chapters 
SET is_published = true 
WHERE is_published = false OR is_published IS NULL;

-- 3. Activate Topics (if table exists)
DO $$ 
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'topics') THEN
        UPDATE topics SET is_published = true WHERE is_published = false OR is_published IS NULL;
    END IF;
END $$;

-- 4. Verify the activation
SELECT 'Subjects' as table_name, count(*) as active_count FROM subjects WHERE is_published = true
UNION ALL
SELECT 'Chapters', count(*) FROM chapters WHERE is_published = true;
