WITH subject_expected(slug, expected_questions, expected_flashcards, expected_published) AS (
  VALUES
    ('algo', 95, 50, true),
    ('cd', 65, 22, true),
    ('cn', 65, 22, true),
    ('coa', 65, 22, true),
    ('cprog', 90, 39, true),
    ('dbms', 55, 45, true),
    ('dl', 65, 22, false),
    ('dm', 65, 22, true),
    ('dsa', 65, 40, true),
    ('em', 65, 22, true),
    ('ga', 130, 43, true),
    ('os', 65, 22, true),
    ('toc', 65, 22, true)
)
SELECT
  s.slug,
  COUNT(DISTINCT c.id) AS chapters,
  COUNT(DISTINCT t.id) AS topics,
  COUNT(DISTINCT q.id) AS questions,
  e.expected_questions,
  COUNT(DISTINCT f.id) AS flashcards,
  e.expected_flashcards,
  COUNT(DISTINCT n.id) AS notes,
  s.is_published,
  e.expected_published,
  COUNT(DISTINCT q.id) = e.expected_questions AS questions_ok,
  COUNT(DISTINCT f.id) = e.expected_flashcards AS flashcards_ok,
  s.is_published = e.expected_published AS published_ok
FROM subjects s
JOIN subject_expected e ON e.slug = s.slug
LEFT JOIN chapters c ON c.subject_id = s.id
LEFT JOIN topics t ON t.chapter_id = c.id
LEFT JOIN questions q ON q.subject_id = s.id
LEFT JOIN flashcards f ON f.subject_id = s.id
LEFT JOIN notes n ON n.chapter_id = c.id
GROUP BY s.slug, e.expected_questions, e.expected_flashcards, e.expected_published, s.is_published
ORDER BY s.slug;

SELECT
  'questions_missing_topic' AS check_name,
  COUNT(*)::int AS count
FROM questions
WHERE topic_id IS NULL
UNION ALL
SELECT
  'orphan_question_tags',
  COUNT(*)::int
FROM question_tags qt
LEFT JOIN questions q ON q.id = qt.question_id
LEFT JOIN tags t ON t.id = qt.tag_id
WHERE q.id IS NULL OR t.id IS NULL
UNION ALL
SELECT
  'orphan_notes',
  COUNT(*)::int
FROM notes n
LEFT JOIN chapters c ON c.id = n.chapter_id
WHERE c.id IS NULL
UNION ALL
SELECT
  'distinct_note_paths',
  COUNT(DISTINCT storage_path)::int
FROM notes
UNION ALL
SELECT
  'published_subjects',
  COUNT(*)::int
FROM subjects
WHERE is_published = true
  AND slug <> 'dl';

SELECT
  s.slug,
  q.type,
  COUNT(*)::int AS count
FROM questions q
JOIN subjects s ON s.id = q.subject_id
WHERE s.slug IN ('algo','cd','cn','coa','cprog','dbms','dl','dm','dsa','em','ga','os','toc')
GROUP BY s.slug, q.type
ORDER BY s.slug, q.type;
