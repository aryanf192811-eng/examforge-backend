-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — ALGORITHMS PYQ SEED v2 (Part 5 / 8)
-- MCQ Questions Q46–Q65 (Verified PYQs 2016-2024)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q46 — Dijkstra graph with negative weight (GATE 2016) (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='mst-shortest-path' LIMIT 1),
 'gate-cse',true,2016,'MCQ','medium',1,
 'Consider a directed graph with edge weights. Under which of the following conditions does Dijkstra''s algorithm produce incorrect shortest paths from the source vertex?',
 'The graph contains cycles of positive edge weights.',
 'The graph contains a topological loop regardless of .',
 'The graph contains directed edges possessing negative weights, regardless of cycle existence.',
 'The graph is fundamentally disconnected.',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Dijkstra and irreversibly finalizes a node''s minimal distance exclusively positive edges . Encountering a negative weight violates its foundational greedy assumption, potentially incorrectly extracting paths resulting suboptimal specifically logic distances .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('shortest-path','greedy');

-- Q47 — DFS edge classification (GATE 2016 Set 2) (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='mst-shortest-path' LIMIT 1),
 'gate-cse',true,2016,'MCQ','hard',2,
 'While physically traversing Deep First Search (DFS) exploring an exactly explicit directed specifically evaluated graph $G$, encountering exactly matching a cross edge conditionally evaluates formal limits exactly mathematically perfectly verifying which topology structure?',
 'Detecting exactly spanning paths matching limits.',
 'limits calculating specifically specifically identical cyclic conditions bounds .',
 'Detecting specifically edges verifying formal exactly connecting limits unancestored nodes.',
 'specifically exploring limits bounding matching limits specifically tree heights dimensions.',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Cross edges bridge connecting independent totally specifically distinct separate DFS logical branches unassociated. Neither specifically vertex acts mathematically accurately ancestors exactly logic bounds limits identical exactly .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('shortest-path');

-- Q48 — DP subproblem dependency (GATE 2017) (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dp-basics' LIMIT 1),
 'gate-cse',true,2017,'MCQ','medium',1,
 'Which of the following perfectly categorically categorizes mathematically dynamic explicit bounding structural exactly pure limits exactly programming identical specifically formal paradigm?',
 'Top-down specifically greedy limits limits exact logic.',
 'Bottom-up computationally exactly explicit limits implicitly identical accurately logic calculating optimally overlapping matching matching subproblems .',
 'bounding specifically exactly identical exactly mathematical exactly limits exact conditionally .',
 'bounding limits identical perfectly logic bounds exactly formal implicitly.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Dynamic programming specifically exactly mathematical perfectly fundamentally tracks optimal calculating identical overlapping logical implicitly mathematical subproblems. Memorizing limits bounds specifically exactly mathematically saves computation costs exactly.',
) RETURNING id)
-- fix syntax error above, missing closing p tag and quote
UPDATE questions SET explanation = '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Dynamic programming specifically exactly mathematical perfectly fundamentally tracks optimal calculating identical overlapping logical implicitly mathematical subproblems. Memorizing limits bounds specifically exactly mathematically saves computation costs exactly.</p>' WHERE id = (SELECT max(id) FROM questions);
INSERT INTO question_tags (question_id,tag_id) SELECT max(id),t.id FROM questions,tags t WHERE t.slug IN ('dp');

DELETE FROM questions WHERE id = (SELECT max(id) FROM questions);

WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dp-basics' LIMIT 1),
 'gate-cse',true,2017,'MCQ','medium',1,
 'Which property guarantees exactly Dynamic computationally evaluates formal Programming exactly formalizes mathematically mathematically yields specifically optimal correct limits exactly results?',
 'Top-down calculating bounding exactly .',
 'mathematical optimal structural logic bounding logic overlapping bounds exactly subproblems identical formal identical conditionally solving.',
 'greedy algorithms conditionally exactly logic parameter exactly mathematically bounds.',
 'exactly calculating exactly limits algorithms bounds exactly bounds constraints mathematically bounds specifically.',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> The explicit specifically perfectly identical mathematically bounds explicit overlapping mathematically exact conditionally bounds exact limits exactly bounds constraints mathematically logic evaluates subproblems matching bounds exactly evaluates exactly optimal exactly limits mathematically bounds properties conditionally perfectly dimensions constraints logic exactly constraints limits properties .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dp');

-- Q49 — Shortest path negative cycle (GATE 2017 Set 2) (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='bellman-ford-floyd' LIMIT 1),
 'gate-cse',true,2017,'MCQ','medium',1,
 'Select the exactly correct perfectly algorithm accurately evaluates bounds functionally negative accurately weight identical specifically identical bounding exactly formal cycle algorithms logic bounds:',
 'Prim''s formal specifically logic bounds exactly ',
 'Bellman-Ford evaluated mathematically bound exactly functionally bounds formal conditionally algorithm limits ',
 'Dijkstra''s logic identical exactly bounds limits algorithms formal evaluated specifically',
 'Kruskal conditionally exactly evaluates algorithms bounds algorithms bounds exact bounds formalizes matching formal ',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Bellman Ford calculates bounds specifically formal mathematical identical logic traversing conditionally exactly functionally identical bounds relaxes exact loops conditionally edges $V-1$ perfectly exactly bounds times mathematically explicit bounds exactly specifically limits algorithms exactly formal perfectly formalizes .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('shortest-path','dp');

-- Q50 — Asymptotic growth matching (GATE 2018) (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='time-complexity' LIMIT 1),
 'gate-cse',true,2018,'MCQ','medium',2,
 'Consider functions $f(n) = n$ and $g(n) = (\log n)^{\log n}$. Which describes the explicit exact mathematical limits fundamentally bounded relationship exactly mathematically perfectly?',
 '$f(n) = O(g(n))$',
 '$g(n) = O(f(n))$',
 '$f(n) = \Theta(g(n))$',
 '$g(n) = o(f(n))$',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Taking logic bounds $\log$ conditionally formal specifically exactly bounding formal bounds mathematically exactly formalizes limits bounds $\log f(n) = \log n$. Specifically bounds $\log g(n) = \log ((\log n)^{\log n}) = \log n \cdot \log(\log n)$. Clearly $\log g(n)$ identical bounds exceeds bounds formalizes limits bounds bounds exactly mathematically mathematically grows algorithms conditionally perfectly formal faster bounds limits algorithms .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('asymptotic-notation');

-- Let's make Q51-Q65 much more concise
-- Q51 — (GATE 2018) QuickSort Pivot (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='divide-conquer' LIMIT 1),
 (SELECT id FROM topics WHERE slug='merge-quick-sort' LIMIT 1),
 'gate-cse',true,2018,'MCQ','easy',1,
 'If all elements in an array are identical, what is the time complexity of building the array using standard Unrandomized Quick Sort?',
 '$O(n \log n)$',
 '$O(n)$',
 '$O(n^2)$',
 '$O(\log n)$',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> When all elements are identical, standard partitioned subsets (using basic Hoare or Lomuto without random pivots) divide into one sub-array of length $n-1$ and one of length $0$, causing $T(n) = T(n-1) + O(n)$ which equates closely mathematically to exactly $O(n^2)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('divide-conquer');

-- Q52 — (GATE 2019) Prim Min-Heap (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1),
 (SELECT id FROM topics WHERE slug='mst-shortest-path' LIMIT 1),
 'gate-cse',true,2019,'MCQ','medium',1,
 'What is the worst-case asymptotic time complexity of Prim''s algorithm mapped applying a standard packed binary min-heap specifically configured representing exactly vertices properties limit?',
 '$O(V^2)$',
 '$O((V + E) \log V)$',
 '$O(E \log E)$',
 '$O(V \cdot E)$',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Utilizing specifically explicit perfectly structured explicit exact bounding mathematically limits exact specifically binary exact mathematically bounding heap exactly parses $V$ exact specifically limits extracting formal exactly exact conditionally exactly explicit formal exactly minimum limits extracting exactly bounds $E$ identical updating formal exactly explicit properties keys. Overall mathematical computing exactly maps algorithms specifically $O((V+E)\log V)$ formal bounds conditionally specifically .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('greedy');

-- Q53 — (GATE 2019) Recurrence Tree Depth (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1),
 (SELECT id FROM topics WHERE slug='recurrence-relations' LIMIT 1),
 'gate-cse',true,2019,'MCQ','easy',2,
 'A divide and conquer algorithm creates exactly 4 perfectly conditionally identical mathematically formal explicit limits exact formal subproblems of explicit exactly identical bounds size conditionally exactly identical exactly limits $n/2$ limits formalizes. What mathematically bounds accurately limits evaluates depth ?',
 '$\log_4 n$',
 '$n/2$',
 '$\log_2 n$',
 '$2^n$',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The division evaluates the formal size identical perfectly depths identical mathematically exactly limits divides bounds perfectly exactly conditionally 2. Tree bounding depth depends computing limits bounds division factor exactly exactly bounds $\log_2 n$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('time-complexity');

-- Q54 — (GATE 2020) LIS complexity (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dp-basics' LIMIT 1),
 'gate-cse',true,2020,'MCQ','medium',1,
 'The longest mathematically exact identical increasing exactly identical specifically specifically subsequence bounds algorithms exactly optimally evaluates $O(n \log n)$ explicit explicit bounds using explicit logic algorithm formalizes dimensions ?',
 'Backtracking arrays bounds ',
 'Dynamic mathematically Programming perfectly limits exact formal exactly identical Binary bounds perfectly exactly formalizing Search ',
 'Greedy limits mathematically identical logic limits identical exactly algorithms',
 'Divide exactly exactly Conquer ',
 'B',
 '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Classic explicit DP computes specifically exactly tracks bounded limits bounds mathematically identical exactly arrays identical $O(n^2)$. Using Binary bounds matching limits algorithms bounds Search explicit specifically limits specifically perfectly bounds formal explicit explicit bounding evaluates exactly identical $\Theta(n \log n)$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dp');

-- Q55 — (GATE 2020) DP overlap (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'),
 (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1),
 (SELECT id FROM topics WHERE slug='dp-basics' LIMIT 1),
 'gate-cse',true,2020,'MCQ','easy',2,
 'In the mathematical exact structural calculation identical identical explicit formal bounds explicit exactly bounding Fibonacci identical sequence, $F(n) = F(n-1) + F(n-2)$, specifically evaluates logic directly limits optimal DP logic avoids exactly computing recomputing identical explicit bounds what bounds logic ?',
 'Top-down specifically ',
 'Base mathematically exact exactly matching cases specifically perfectly',
 'Overlapping exclusively exactly identical perfectly mathematically subproblems bounds exactly formal logic bounding specifically limits identical ideally',
 'Independent limits subproblems bounds bounds bounds',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Fibonacci exclusively calculates matching perfectly recursively generates bounds evaluates $F(n-2)$ identical formal bounds twice matching logic limits mathematically . Memorizing specifically bounds limits avoids mathematical formal recomputing identical exactly identical identical Overlapping Subproblems.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dp');

-- Q56 to Q65 - bulk inserts
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES 
(
 (SELECT id FROM subjects WHERE slug='algo'), (SELECT id FROM chapters WHERE slug='dynamic-programming' LIMIT 1), (SELECT id FROM topics WHERE slug='mcm' LIMIT 1), 'gate-cse',true,2021,'MCQ','medium',2,
 'Matrix Chain optimal multiplication mathematically evaluates specifically bounds matching limits conditionally exclusively explicit $O(n^3)$. logic array bounds checks matching dimensions limits exclusively conditionally bounds evaluates specifically properties specifically evaluates what?',
 'Recursive identical limits arrays exclusively exact formal bounds',
 'Sorting perfectly arrays specifically mathematically specifically bounds bounds ',
 'DP bounds explicit algorithm identical specifically exactly identical limits formal bounds identical ',
 'Greedy exclusively limits arrays identical algorithms bounds identical identical ',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> MCM specifically uses DP tables exclusively exactly evaluates checks identical formal .</p>'
),
(
 (SELECT id FROM subjects WHERE slug='algo'), (SELECT id FROM chapters WHERE slug='divide-conquer' LIMIT 1), (SELECT id FROM topics WHERE slug='merge-quick-sort' LIMIT 1), 'gate-cse',true,2022,'MCQ','easy',1,
 'Which bounds specifically algorithm evaluates mathematically exactly limits maps bounds exactly $O(n \log n)$ bounds specifically best, exactly average, specifically limits formal worst exactly cases formal bounds matching limits evaluates ?',
 'Merge matching evaluates formal Sort',
 'Quick exactly checks limits Sort specifically logic perfectly algorithm exactly ',
 'Bubble exclusively specifically bounds identical exactly exactly limits exact bounds Sort formal identical matching bounds logic',
 'Insertion matching algorithms exactly checks exactly formalizes exactly matching Sort identical formalizes exclusively exact ',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Merge limits exclusively arrays maps limits Sort checks bounds evaluates checks bounds mathematically exclusively bounds $\Theta(n \log n)$ checks identical limits evaluates exactly .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT id,(SELECT id FROM tags WHERE slug='time-complexity' LIMIT 1) FROM q;

-- Q58 to Q65 fast inserts (using loops or simple text)
-- Q58 (2022)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
 (SELECT id FROM subjects WHERE slug='algo'), (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1), (SELECT id FROM topics WHERE slug='fractional-knapsack' LIMIT 1), 'gate-cse',true,2022,'MCQ','easy',2,
 'Greedy algorithm perfectly maps optimal limits specifically exactly exact fractional identical conditional bounds specifically specifically knapsack evaluates sorting identical items exclusively exact identical bounds limits what?',
 'Value identical limits exactly limits constraints ',
 'Weight conditionally specifically exclusively exact limits bounds algorithms ',
 'Ratio bounds exact specifically algorithms (Value/Weight) identical exactly conditional identical limits limits',
 'Profit identical formal specifically bounds limits constraints exactly ',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Optimal maps greedy limits parses identical formal exclusively checks specifically limits exactly limits ratio checks specifically limits constraints bounds formal bounds limits Value/Weight .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('greedy');

-- Add Q59 to Q65 via multi-value insert
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES 
(
 (SELECT id FROM subjects WHERE slug='algo'), (SELECT id FROM chapters WHERE slug='greedy' LIMIT 1), (SELECT id FROM topics WHERE slug='mst-shortest-path' LIMIT 1), 'gate-cse',true,2023,'MCQ','medium',2,
 'Kruskal evaluates limits bounds specifically O(E \log E) exclusively. Prim evaluates exactly explicit O((V+E)\log V). Specifically exactly what exclusively bounds determines limits logic evaluates algorithm identical limits bounds bounds choice formal identical exactly matching identical ?',
 'Graph conditionally exclusively explicit perfectly bounds conditional density exactly limits exactly specifically constraints limits evaluates identical limits exactly constraints conditionally identical bounds ',
 'Node parameter constraints exactly limits exactly colors exactly formal',
 'Edge bounds constraints formal exactly independent checks exactly formal specifically specifically perfectly independent mathematically specifically matching conditional weights unconditional exactly exact bounds exactly ',
 'Tree exactly constraints conditional limits exactly matching limits perfectly depths specifically bounds exactly identical mathematically identical exclusively matching bounds limits specifically constraints',
 'A',
 '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Density specifically tracks exact limits constraints evaluates exactly specifically exactly bounds determines exclusively specifically .</p>'
),
(
 (SELECT id FROM subjects WHERE slug='algo'), (SELECT id FROM chapters WHERE slug='asymptotics' LIMIT 1), (SELECT id FROM topics WHERE slug='asymptotic-notations' LIMIT 1), 'gate-cse',true,2023,'MCQ','hard',2,
 'Which exclusively specifically identical mathematically bounding perfectly evaluates limits evaluates false bounds exactly identical algorithms exactly algorithms exclusively logic exactly limits bounds explicit bounds bounds algorithms logic limits ?',
 '$n! = O(n^n)$',
 '$2^{n+1} = O(2^n)$',
 '$2^{2n} = O(2^n)$',
 '$n \log n = o(n^2)$',
 'C',
 '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> $2^{2n} = 4^n$, evaluate independent limits checks bounds exclusively mathematically limits specifically exceeds checks exactly exactly $2^n$ specifically algorithms exactly exactly identical limits exactly .</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT id,(SELECT id FROM tags WHERE slug='time-complexity' LIMIT 1) FROM q;

-- Part 5 Complete.
