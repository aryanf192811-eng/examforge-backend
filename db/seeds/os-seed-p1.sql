-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — OS PYQ SEED v2 (Part 1 / 8)
-- Subject: Operating Systems (os)
-- ═══════════════════════════════════════════════════════════════════════════

BEGIN;

DO $$ 
DECLARE
 subj_id UUID;
 ch1_id UUID;
 ch2_id UUID;
 ch3_id UUID;
 ch4_id UUID;
BEGIN

 -- 1. Subject Insertion
 INSERT INTO subjects (title, slug, description, gradient_start, gradient_end, icon_type)
 VALUES (
 'Operating Systems', 
 'os', 
 'Process management, concurrency, memory translation, and file systems.', 
 '#3b82f6', '#1d4ed8', 'terminal'
 )
 ON CONFLICT (slug) DO UPDATE 
 SET title = EXCLUDED.title, description = EXCLUDED.description
 RETURNING id INTO subj_id;

 -- 2. Chapters Insertion
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES
 (subj_id, 'Process & Thread Management', 'process-management', 1) RETURNING id INTO ch1_id;
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES
 (subj_id, 'Concurrency & Deadlocks', 'concurrency', 2) RETURNING id INTO ch2_id;
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES
 (subj_id, 'Memory Management', 'memory-management', 3) RETURNING id INTO ch3_id;
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES
 (subj_id, 'Storage & File Systems', 'storage-io', 4) RETURNING id INTO ch4_id;

 -- 3. Topics Insertion
 -- Chapter 1: Process & Thread Management
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'concept', 'Process Concepts & States', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'scheduling', 'CPU Scheduling Algorithms', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'threads', 'User vs Kernel Threads', 3) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'system-calls', 'System Calls & Fork', 4) ON CONFLICT DO NOTHING;

 -- Chapter 2: Concurrency & Deadlocks
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'sync-tools', 'Semaphores & Mutex', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'classical-problems', 'Classical Sync Problems', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'deadlock-concept', 'Deadlock Characterization', 3) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'bankers', 'Banker''s Algorithm', 4) ON CONFLICT DO NOTHING;

 -- Chapter 3: Memory Management
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'paging', 'Paging & TLB', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'segmentation', 'Segmentation', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'virtual', 'Virtual Memory & Page Faults', 3) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'page-replacement', 'Page Replacement Algorithms', 4) ON CONFLICT DO NOTHING;

 -- Chapter 4: Storage & File Systems
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'disk', 'Disk Scheduling', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'file-alloc', 'File Allocation Methods', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'unix-inode', 'UNIX Inodes', 3) ON CONFLICT DO NOTHING;

 -- 4. Global Tags Insertion
 INSERT INTO tags (name, slug) VALUES ('Process', 'process') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Threads', 'threads') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Scheduling', 'scheduling') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Semaphores', 'semaphores') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Deadlock', 'deadlock') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Paging', 'paging') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('TLB', 'tlb') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Disk', 'disk') ON CONFLICT DO NOTHING;

END $$;
-- Part 1 Complete.
