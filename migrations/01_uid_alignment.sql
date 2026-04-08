-- EXAMFORGE — HYBRID CONTENT ARCHITECTURE MIGRATION (uid alignment)
-- Date: 2026-04-08

-- 1. Align Profiles
ALTER TABLE public.profiles RENAME COLUMN id TO uid;
ALTER TABLE public.profiles RENAME COLUMN firebase_uid TO external_id; -- Keep both for safe join
ALTER TABLE public.profiles RENAME COLUMN total_score TO total_points;
ALTER TABLE public.profiles RENAME COLUMN streak_days TO current_streak;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS accuracy_pct FLOAT DEFAULT 0.0;
CREATE INDEX IF NOT EXISTS idx_profiles_uid ON public.profiles(uid);

-- 2. Align user_progress
ALTER TABLE public.user_progress RENAME COLUMN user_id TO uid;
ALTER TABLE public.user_progress RENAME COLUMN chapter_id TO chapter_slug; -- Match flat logic
ALTER TABLE public.user_progress ADD COLUMN IF NOT EXISTS subject_slug TEXT;
ALTER TABLE public.user_progress ADD COLUMN IF NOT EXISTS last_read_at TIMESTAMPTZ DEFAULT now();

-- 3. Align study_sessions & quiz_sessions
ALTER TABLE public.study_sessions RENAME COLUMN user_id TO uid;
ALTER TABLE public.quiz_sessions RENAME COLUMN user_id TO uid;
ALTER TABLE public.quiz_sessions ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'active';

-- 4. Align leaderboard
ALTER TABLE public.leaderboard_scores RENAME COLUMN user_id TO uid;
