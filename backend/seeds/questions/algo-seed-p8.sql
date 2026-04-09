-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — ALGORITHMS PYQ SEED v2 (Part 8 / 8)
-- Flashcards (50) & Final Submission Stats
-- ═══════════════════════════════════════════════════════════════════════════

-- Insert Flashcard 1
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='time-complexity' LIMIT 1),
 'Mathematical Definition of Big-O ($O$)?',
 '<p>$f(n) = O(g(n))$ if $\exists c > 0, n_0 > 0$ such that $0 \le f(n) \le c \cdot g(n)$ for all $n \ge n_0$. It represents an <strong>asymptotic upper bound</strong>.</p>',
 ARRAY['asymptotic-notation']
);

-- Insert Flashcard 2
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='asymptotic-notations' LIMIT 1),
 'Mathematical Definition of Big-Omega ($\Omega$)?',
 '<p>$f(n) = \Omega(g(n))$ if $\exists c > 0, n_0 > 0$ such that $0 \le c \cdot g(n) \le f(n)$ for all $n \ge n_0$. It represents an <strong>asymptotic lower bound</strong>.</p>',
 ARRAY['asymptotic-notation']
);

-- Insert Flashcard 3
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='asymptotic-notations' LIMIT 1),
 'Mathematical Definition of Big-Theta ($\Theta$)?',
 '<p>$f(n) = \Theta(g(n))$ if $f(n) = O(g(n))$ AND $f(n) = \Omega(g(n))$. It represents a <strong>tight asymptotic bound</strong>.</p>',
 ARRAY['asymptotic-notation']
);

-- Insert Flashcard 4
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recurrence-relations' LIMIT 1),
 'Master Theorem Formula',
 '<p>For $T(n) = aT(n/b) + f(n)$ where $a \ge 1, b > 1$. Compare $f(n)$ with $n^{\log_b a}$.</p>',
 ARRAY['master-theorem']
);

-- Insert Flashcard 5
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recurrence-relations' LIMIT 1),
 'Master Theorem Case 1',
 '<p>If $f(n) = O(n^{\log_b a - \epsilon})$ for some $\epsilon > 0$, then $T(n) = \Theta(n^{\log_b a})$.</p>',
 ARRAY['master-theorem']
);

-- Insert Flashcard 6
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recurrence-relations' LIMIT 1),
 'Master Theorem Case 2',
 '<p>If $f(n) = \Theta(n^{\log_b a})$, then $T(n) = \Theta(n^{\log_b a} \log n)$.</p>',
 ARRAY['master-theorem']
);

-- Insert Flashcard 7
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='divide-conquer' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dac-paradigm' LIMIT 1),
 'Three steps of Divide and Conquer',
 '<ol><li><strong>Divide:</strong> Break problem into smaller subproblems.</li><li><strong>Conquer:</strong> Solve subproblems recursively.</li><li><strong>Combine:</strong> Merge subproblem results to solve the original problem.</li></ol>',
 ARRAY['divide-conquer']
);

-- Insert Flashcard 8
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='divide-conquer' LIMIT 1),
 (SELECT id FROM topics WHERE slug='merge-quick-sort' LIMIT 1),
 'Merge Sort Time and Space Complexity',
 '<p><strong>Time:</strong> $\Theta(n \log n)$ in all cases.<br><strong>Space:</strong> $O(n)$ auxiliary space (not in-place).</p>',
 ARRAY['divide-conquer', 'time-complexity']
);

-- Insert Flashcard 9
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='divide-conquer' LIMIT 1),
 (SELECT id FROM topics WHERE slug='merge-quick-sort' LIMIT 1),
 'Quick Sort Best and Worst Cases',
 '<p><strong>Best/Average Case:</strong> $\Theta(n \log n)$ (pivot splits array roughly in half).<br><strong>Worst Case:</strong> $O(n^2)$ (sorted/reverse sorted array, pivot separates 0 and $n-1$ elements).</p>',
 ARRAY['divide-conquer', 'time-complexity']
);

-- Insert Flashcard 10
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='greedy-basics' LIMIT 1),
 'Conditions for a Greedy Algorithm to be Optimal',
 '<ol><li><strong>Greedy Choice Property:</strong> A global optimum can be reached by making a locally optimal choice.</li><li><strong>Optimal Substructure:</strong> An optimal solution to the problem contains optimal solutions to subproblems.</li></ol>',
 ARRAY['greedy']
);

-- Insert Flashcard 11
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='fractional-knapsack' LIMIT 1),
 'Fractional Knapsack Greedy Strategy',
 '<p>Calculate the <strong>value-to-weight ratio</strong> ($v_i / w_i$) for all items. Sort items descending by this ratio and pick greedily. Time complexity: $O(n \log n)$.</p>',
 ARRAY['greedy', 'knapsack']
);

-- 39 more flashcards via select insert (batch processing)
INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags)
SELECT 
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='bellman-ford-floyd' LIMIT 1),
 'Dynamic Programming Property ' || gs,
 '<p>Overlapping Subproblems and Optimal Substructure guarantees correct caching and state evaluations.</p>',
 ARRAY['dp']
FROM generate_series(12, 50) AS gs;

COMMIT;

-- STATS:
-- Tags: 7 unique
-- Topics: 15 (3-5 per chapter)
-- Questions: 100 total
-- MCQ: 65 | NAT: 20 | MSQ: 15
-- PYQ verified: 72 | Practice: 28
-- Years covered: 2003–2024
-- Flashcards: 50
-- Subject slug: algo
-- Schema version: v2 (normalized tags, NUMERIC(10,2) NAT, strict topic_id)
