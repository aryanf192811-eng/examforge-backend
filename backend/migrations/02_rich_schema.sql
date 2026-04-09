-- EXAMFORGE — RICH ARCHITECTURE SCHEMA
-- Date: 2026-04-08

-- 1. Subjects Table
CREATE TABLE IF NOT EXISTS public.subjects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    description TEXT,
    gradient_start TEXT DEFAULT '#4F46E5',
    gradient_end TEXT DEFAULT '#7C3AED',
    icon_type TEXT DEFAULT 'school',
    is_published BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Chapters Table
CREATE TABLE IF NOT EXISTS public.chapters (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subject_id UUID REFERENCES public.subjects(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    slug TEXT NOT NULL,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now(),
    UNIQUE(subject_id, slug)
);

-- 3. Topics Table
CREATE TABLE IF NOT EXISTS public.topics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    chapter_id UUID REFERENCES public.chapters(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    slug TEXT NOT NULL,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now(),
    UNIQUE(chapter_id, slug)
);

-- 4. Tags Table
CREATE TABLE IF NOT EXISTS public.tags (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 5. Junction Table for Question Tags
CREATE TABLE IF NOT EXISTS public.question_tags (
    question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE,
    tag_id UUID REFERENCES public.tags(id) ON DELETE CASCADE,
    PRIMARY KEY (question_id, tag_id)
);

-- 6. Update Questions Table
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS subject_id UUID REFERENCES public.subjects(id);
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS chapter_id UUID REFERENCES public.chapters(id);
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS topic_id UUID REFERENCES public.topics(id);
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS exam_slug TEXT DEFAULT 'gate-cse';

-- 7. Doubts Table (AI Cite & Ask)
CREATE TABLE IF NOT EXISTS public.doubts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id TEXT REFERENCES public.profiles(uid) ON DELETE CASCADE,
    chapter_id UUID REFERENCES public.chapters(id),
    selected_text TEXT,
    question TEXT NOT NULL,
    answer TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 8. Flashcards Table
CREATE TABLE IF NOT EXISTS public.flashcards (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subject_id UUID REFERENCES public.subjects(id) ON DELETE CASCADE,
    chapter_id UUID REFERENCES public.chapters(id) ON DELETE CASCADE,
    topic_id UUID REFERENCES public.topics(id),
    front TEXT NOT NULL,
    back TEXT NOT NULL,
    difficulty TEXT DEFAULT 'medium',
    next_review_at TIMESTAMPTZ DEFAULT now(),
    srs_level INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 9. Enable RLS (simplified for now to allow migration/seeding)
ALTER TABLE public.subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.chapters ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.topics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.question_tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.doubts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.flashcards ENABLE ROW LEVEL SECURITY;

-- Select policies
CREATE POLICY "Allow public read on subjects" ON public.subjects FOR SELECT USING (true);
CREATE POLICY "Allow public read on chapters" ON public.chapters FOR SELECT USING (true);
CREATE POLICY "Allow public read on topics" ON public.topics FOR SELECT USING (true);
CREATE POLICY "Allow public read on tags" ON public.tags FOR SELECT USING (true);
CREATE POLICY "Allow public read on question_tags" ON public.question_tags FOR SELECT USING (true);
CREATE POLICY "Allow users to manage their own doubts" ON public.doubts FOR ALL USING (auth.uid()::text = user_id);
