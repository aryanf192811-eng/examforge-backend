-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — ALGORITHMS PYQ SEED v2 (Part 1 / 8)
-- Subject: Algorithms (algo)
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

 -- 1. Subject
 INSERT INTO subjects (title, slug, description, gradient_start, gradient_end, icon_type)
 VALUES (
 'Design & Analysis of Algorithms', 'algo',
 'Asymptotic analysis, greedy methods, dynamic programming, and divide-and-conquer paradigms.',
 '#f59e0b', '#d97706', 'code' -- amber
 )
 ON CONFLICT (slug) DO UPDATE
 SET title = EXCLUDED.title, description = EXCLUDED.description
 RETURNING id INTO subj_id;

 -- 2. Chapters
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Asymptotic Analysis & Recurrences', 'asymptotics', 1) RETURNING id INTO ch1_id;
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Divide & Conquer', 'divide-conquer', 2) RETURNING id INTO ch2_id;
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Greedy Algorithms', 'greedy', 3) RETURNING id INTO ch3_id;
 INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Dynamic Programming', 'dynamic-programming', 4) RETURNING id INTO ch4_id;

 -- 3. Topics
 -- Chapter 1: Asymptotic Analysis & Recurrences
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'time-complexity', 'Time & Space Complexity', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'asymptotic-notations', 'Big-O, Omega, Theta Notations', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'recurrence-relations', 'Solving Recurrences (Master Theorem)', 3) ON CONFLICT DO NOTHING;

 -- Chapter 2: Divide & Conquer
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'dac-paradigm', 'Divide and Conquer Paradigm', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'binary-search-algo', 'Binary Search Applications', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'merge-quick-sort', 'Merge Sort & Quick Sort Analysis', 3) ON CONFLICT DO NOTHING;

 -- Chapter 3: Greedy Algorithms
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'greedy-basics', 'Greedy Choice Property', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'huffman-coding', 'Huffman Coding', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'fractional-knapsack', 'Fractional Knapsack', 3) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'mst-shortest-path', 'Greedy Graphs (Kruskal, Prim, Dijkstra)', 4) ON CONFLICT DO NOTHING;

 -- Chapter 4: Dynamic Programming
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'dp-basics', 'Overlapping Subproblems & Optimal Substructure', 1) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'mcm', 'Matrix Chain Multiplication', 2) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'lcs', 'Longest Common Subsequence (LCS)', 3) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, '01-knapsack', '0/1 Knapsack Problem', 4) ON CONFLICT DO NOTHING;
 INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'bellman-ford-floyd', 'Bellman-Ford & Floyd-Warshall', 5) ON CONFLICT DO NOTHING;

 -- 4. Tags
 INSERT INTO tags (name, slug) VALUES ('Asymptotic Notation', 'asymptotic-notation') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Master Theorem', 'master-theorem') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Divide and Conquer', 'divide-conquer') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Greedy Algorithm', 'greedy') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Dynamic Programming', 'dp') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Shortest Path', 'shortest-path') ON CONFLICT DO NOTHING;
 INSERT INTO tags (name, slug) VALUES ('Knapsack', 'knapsack') ON CONFLICT DO NOTHING;

END $$;

-- Part 1 Complete.
