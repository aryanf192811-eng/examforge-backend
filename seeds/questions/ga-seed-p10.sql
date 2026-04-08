-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — GENERAL APTITUDE PYQ SEED v2 (Part 10 / 10)
-- Flashcards (50 unique) & Final Stats
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id, chapter_id, topic_id, front, back, tags) VALUES
-- ═══════ VERBAL: Grammar ═══════
((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='articles-prepositions' LIMIT 1),
 'When do you use "an" instead of "a"?',
 '<p>Use <strong>"an"</strong> before words that begin with a <em>vowel sound</em> (not necessarily a vowel letter). Examples: an hour (silent h), an MBA (starts with "em" sound), but a university (starts with "yoo" sound), a European (starts with "yoor").</p>',
 ARRAY['grammar','articles']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='articles-prepositions' LIMIT 1),
 'Since vs For vs From — when to use each?',
 '<p><strong>Since</strong>: specific point in time (since 2020, since Monday).<br><strong>For</strong>: duration (for 3 years, for 2 hours).<br><strong>From</strong>: starting point of a range, used with "to/till" (from 9 to 5).<br>GATE trap: "He has been working here <em>since</em> 2018" ✓ (not "from").</p>',
 ARRAY['grammar','prepositions']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='tenses-voice' LIMIT 1),
 'What are the three conditionals in English?',
 '<p><strong>First</strong> (real future): If + present, will + base → "If it rains, I will stay."<br><strong>Second</strong> (unreal present): If + past, would + base → "If I were rich, I would travel."<br><strong>Third</strong> (unreal past): If + past perfect, would have + PP → "If I had known, I would have helped."<br>Key: "would" NEVER goes in the if-clause.</p>',
 ARRAY['grammar','tenses']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='subject-verb-agreement' LIMIT 1),
 'Subject-Verb Agreement: "Neither...nor" rule',
 '<p>With "neither...nor" and "either...or," the verb agrees with the <strong>nearer subject</strong>.<br>• "Neither the boys nor the girl <em>is</em> present." (girl = singular → is)<br>• "Neither the girl nor the boys <em>are</em> present." (boys = plural → are)<br>Also: "Each," "every," "neither," "either" take singular verbs.</p>',
 ARRAY['grammar','subject-verb']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='error-correction' LIMIT 1),
 'Common uncountable nouns tested in GATE',
 '<p>These have NO plural form: <strong>information</strong> (not informations), <strong>advice</strong> (not advices), <strong>furniture</strong> (not furnitures), <strong>luggage</strong> (not luggages), <strong>equipment</strong>, <strong>news</strong> (takes singular verb: "the news IS"), <strong>knowledge</strong>, <strong>progress</strong>, <strong>research</strong>.<br>Use: "a piece of advice," "two items of furniture."</p>',
 ARRAY['grammar','vocabulary']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='tenses-voice' LIMIT 1),
 'Active to Passive voice conversion rules',
 '<p><strong>Formula:</strong> Object + be (matching tense) + Past Participle + by + Subject.<br>• Simple Present: writes → is written<br>• Present Continuous: is writing → is being written<br>• Past Perfect: had written → had been written<br>• Modal: can write → can be written<br>Key: only transitive verbs (with objects) can be passive.</p>',
 ARRAY['grammar','tenses']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='error-correction' LIMIT 1),
 'What is a dangling modifier?',
 '<p>A modifier that doesn''t attach to the intended subject.<br>❌ "Walking to class, <em>the rain</em> started." (rain wasn''t walking)<br>✓ "Walking to class, <em>I</em> got caught in the rain."<br>Rule: the subject after the comma must be the one performing the action in the opening phrase.</p>',
 ARRAY['grammar']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-grammar' LIMIT 1),
 (SELECT id FROM topics WHERE slug='error-correction' LIMIT 1),
 'Parallel structure rule',
 '<p>Items in a list or joined by conjunctions must have the same grammatical form.<br>❌ "She likes reading, writing, and <em>to swim</em>."<br>✓ "She likes reading, writing, and <em>swimming</em>."<br>Also applies to "not only...but also," "both...and," "either...or."</p>',
 ARRAY['grammar']),

-- ═══════ VERBAL: Vocabulary ═══════
((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='word-meaning' LIMIT 1),
 'Top 10 GATE vocabulary words',
 '<p>1. <strong>Ubiquitous</strong> = everywhere<br>2. <strong>Verbose</strong> = wordy<br>3. <strong>Pragmatic</strong> = practical<br>4. <strong>Equivocal</strong> = ambiguous<br>5. <strong>Benevolent</strong> = kind, generous<br>6. <strong>Ephemeral</strong> = short-lived<br>7. <strong>Exacerbate</strong> = make worse<br>8. <strong>Mitigate</strong> = make less severe<br>9. <strong>Unprecedented</strong> = never done before<br>10. <strong>Anomaly</strong> = deviation from normal</p>',
 ARRAY['vocabulary','synonyms-antonyms']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='word-meaning' LIMIT 1),
 'Affect vs Effect',
 '<p><strong>Affect</strong> (verb) = to influence. "The weather <em>affects</em> mood."<br><strong>Effect</strong> (noun) = result. "The <em>effect</em> of rain is flooding."<br>Exception: <em>effect</em> as a verb = to bring about. "The new CEO <em>effected</em> major changes."<br>Mnemonic: <strong>A</strong>ffect = <strong>A</strong>ction (verb), <strong>E</strong>ffect = <strong>E</strong>nd result (noun).</p>',
 ARRAY['vocabulary']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='verbal-analogies' LIMIT 1),
 'Types of verbal analogy relationships',
 '<p>1. <strong>Synonym/Antonym</strong>: Happy:Elated, Hot:Cold<br>2. <strong>Degree</strong>: Warm:Hot, Cool:Freezing<br>3. <strong>Part:Whole</strong>: Wheel:Car, Page:Book<br>4. <strong>Worker:Workplace</strong>: Doctor:Hospital<br>5. <strong>Tool:User</strong>: Stethoscope:Doctor<br>6. <strong>Product:Source</strong>: Milk:Cow<br>7. <strong>Symbol:Concept</strong>: Dove:Peace<br>Identify the relationship FIRST, then find the match.</p>',
 ARRAY['analogies']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='idioms-phrases' LIMIT 1),
 'Common GATE idioms and their meanings',
 '<p>• <strong>Burning midnight oil</strong> = studying/working late<br>• <strong>Break the ice</strong> = start a conversation<br>• <strong>Hit the nail on the head</strong> = exactly right<br>• <strong>A piece of cake</strong> = very easy<br>• <strong>Bite the bullet</strong> = endure something painful<br>• <strong>The ball is in your court</strong> = it''s your decision<br>• <strong>Cost an arm and a leg</strong> = very expensive</p>',
 ARRAY['idioms']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-vocabulary' LIMIT 1),
 (SELECT id FROM topics WHERE slug='word-meaning' LIMIT 1),
 'Greek/Latin plurals tested in GATE',
 '<p><strong>Singular → Plural:</strong><br>• criterion → criteria<br>• phenomenon → phenomena<br>• datum → data<br>• curriculum → curricula<br>• medium → media<br>• alumnus → alumni<br>• nucleus → nuclei<br>• thesis → theses<br>GATE trap: "The <em>criteria</em> IS..." ❌ → "The criteria ARE..." ✓</p>',
 ARRAY['vocabulary','grammar']),

-- ═══════ VERBAL: Reading & Reasoning ═══════
((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='passage-comprehension' LIMIT 1),
 'How to approach GATE Reading Comprehension',
 '<p>1. Read the question FIRST, then the passage.<br>2. Answer must be supported BY the passage (not your knowledge).<br>3. Eliminate options that go beyond the text.<br>4. Watch for "always/never" (too extreme) vs "some/may" (safer).<br>5. Main idea ≠ a detail from one line.<br>6. Author''s tone: positive, negative, neutral, or critical?</p>',
 ARRAY['reading-comprehension']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='para-rearrangement' LIMIT 1),
 'Para Jumble solving strategy',
 '<p>1. Find the <strong>opening sentence</strong> (introduces topic, no pronouns like "this/that").<br>2. Find the <strong>closing sentence</strong> (conclusion, consequence, or call to action).<br>3. Look for <strong>connectors</strong>: "However" (contrast), "Therefore" (conclusion), "Moreover" (addition), "As a result" (cause-effect).<br>4. Pronoun chains: "This" or "Such" points to the previous sentence.<br>5. Time sequence: dates, "first/then/finally."</p>',
 ARRAY['para-jumbles']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='critical-arguments' LIMIT 1),
 'Modus Ponens vs Modus Tollens',
 '<p><strong>Modus Ponens:</strong> If P → Q, and P is true, then Q is true.<br>"If it rains, the ground is wet. It rained. → Ground is wet."<br><br><strong>Modus Tollens:</strong> If P → Q, and Q is false, then P is false.<br>"If it rains, ground is wet. Ground is NOT wet. → It did NOT rain."<br><br>⚠️ Affirming the consequent is a FALLACY: "Ground is wet → It rained" (could be sprinkler).</p>',
 ARRAY['logical-deduction','critical-reasoning']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-reading' LIMIT 1),
 (SELECT id FROM topics WHERE slug='inference-assumption' LIMIT 1),
 'Assumption vs Inference vs Conclusion',
 '<p><strong>Assumption</strong>: Unstated premise that MUST be true for argument to hold. Test: negate it — if argument collapses, it''s an assumption.<br><strong>Inference</strong>: What can be derived from the given info (may not be stated).<br><strong>Conclusion</strong>: The final claim the argument is trying to prove.<br>GATE tip: assumptions are hidden; inferences are derivable; conclusions are the "therefore."</p>',
 ARRAY['critical-reasoning']),

-- ═══════ QUANT: Arithmetic ═══════
((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='number-divisibility' LIMIT 1),
 'Divisibility rules cheat sheet',
 '<p>• <strong>2</strong>: last digit even<br>• <strong>3</strong>: digit sum divisible by 3<br>• <strong>4</strong>: last 2 digits divisible by 4<br>• <strong>5</strong>: ends in 0 or 5<br>• <strong>6</strong>: divisible by BOTH 2 and 3<br>• <strong>8</strong>: last 3 digits divisible by 8<br>• <strong>9</strong>: digit sum divisible by 9<br>• <strong>11</strong>: alternating sum of digits divisible by 11<br>• <strong>7</strong>: double last digit, subtract from rest — result div by 7</p>',
 ARRAY['number-systems']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='number-divisibility' LIMIT 1),
 'LCM and HCF — Key identity',
 '<p><strong>LCM × HCF = Product of two numbers</strong><br>LCM(a,b) × HCF(a,b) = a × b<br><br>• HCF: take lowest powers of common prime factors<br>• LCM: take highest powers of all prime factors<br><br>Example: 12 = 2²×3, 18 = 2×3²<br>HCF = 2¹×3¹ = 6, LCM = 2²×3² = 36<br>Verify: 6 × 36 = 216 = 12 × 18 ✓</p>',
 ARRAY['number-systems']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pct-profit-loss' LIMIT 1),
 'Successive percentage change formula',
 '<p>Net effect of two successive changes a% and b%:<br>$\text{Net} = a + b + \frac{ab}{100}\%$<br><br>Examples:<br>• +20% then −20%: 20−20+(20×−20)/100 = <strong>−4%</strong> (always a loss!)<br>• +10% then +10%: 10+10+100/100 = <strong>21%</strong><br>• −20% then −10%: −20−10+200/100 = <strong>−28%</strong><br>This is the fastest formula for successive discounts or markups.</p>',
 ARRAY['percentages']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pct-profit-loss' LIMIT 1),
 'Profit & Loss key formulas',
 '<p>• Profit = SP − CP, Loss = CP − SP<br>• Profit% = (Profit/CP) × 100<br>• SP = CP × (1 + P/100) or CP × (1 − L/100)<br>• CP = SP × 100/(100 + P%) = SP × 100/(100 − L%)<br>• If a person sells at cost price of n items for price of m items: Profit% = ((m−n)/n) × 100<br><br>Remember: all percentages are on <strong>Cost Price</strong> unless stated otherwise.</p>',
 ARRAY['profit-loss']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='interest-calc' LIMIT 1),
 'Simple vs Compound Interest formulas',
 '<p><strong>Simple Interest:</strong> SI = $\frac{P \times R \times T}{100}$. Amount = P + SI.<br><br><strong>Compound Interest:</strong> A = $P(1 + \frac{R}{100})^T$. CI = A − P.<br><br><strong>Shortcut for CI−SI (2 years):</strong> CI − SI = $P \times (\frac{R}{100})^2$<br>Example: P=10000, R=10%, T=2: CI−SI = 10000 × 0.01 = ₹100.</p>',
 ARRAY['si-ci']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='ratio-mixtures' LIMIT 1),
 'Allegation method for mixtures',
 '<p>To find the mixing ratio for a weighted average:<br><pre>Cheaper(c)——Mean(m)——Costlier(d)
Ratio = (d − m) : (m − c)</pre><br>Example: Mix tea at ₹30/kg with ₹50/kg to get ₹35/kg.<br>Ratio = (50−35):(35−30) = 15:5 = <strong>3:1</strong><br>Works for prices, speeds, concentrations, ages — any weighted average.</p>',
 ARRAY['ratio-proportion','averages']),

-- ═══════ QUANT: Time & Work ═══════
((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='time-work-pipes' LIMIT 1),
 'Time & Work: LCM method',
 '<p><strong>Best approach:</strong> Take LCM of all individual times as total work units.<br>Example: A does in 12 days, B in 18 days.<br>LCM(12,18) = 36 units of work.<br>A''s rate = 36/12 = 3 units/day. B = 36/18 = 2 units/day.<br>Together = 5 units/day → Time = 36/5 = 7.2 days.<br>Avoids fractions in computation.</p>',
 ARRAY['time-work']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='time-work-pipes' LIMIT 1),
 'Pipes & Cisterns — Key concept',
 '<p>Filling pipe = <strong>positive</strong> rate. Emptying pipe = <strong>negative</strong> rate.<br>If pipe fills in F hours and drain empties in E hours:<br>Net rate = 1/F − 1/E.<br>If F < E: tank fills. If F > E: tank empties.<br><br>GATE twist: "A pipe fills in 6h, leak empties in 12h. Net fill time = ?"<br>Rate = 1/6 − 1/12 = 1/12. Time = <strong>12 hours</strong>.</p>',
 ARRAY['time-work']),

-- ═══════ QUANT: Speed & Distance ═══════
((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='speed-distance' LIMIT 1),
 'Speed, Distance, Time — Conversion & Traps',
 '<p><strong>Conversions:</strong><br>• km/h to m/s: multiply by 5/18<br>• m/s to km/h: multiply by 18/5<br><br><strong>Trains:</strong><br>• Crossing a pole: distance = train length<br>• Crossing a platform: distance = train + platform<br>• Crossing another train (opposite): relative speed = sum<br>• Crossing another train (same dir): relative speed = difference<br><br><strong>Average speed:</strong> same distance at two speeds → harmonic mean = $\frac{2S_1 S_2}{S_1+S_2}$</p>',
 ARRAY['time-speed-distance']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='speed-distance' LIMIT 1),
 'Boats & Streams formulas',
 '<p>Let boat speed = B, stream speed = S.<br>• <strong>Downstream speed</strong> = B + S<br>• <strong>Upstream speed</strong> = B − S<br>• <strong>Boat speed</strong> = (downstream + upstream) / 2<br>• <strong>Stream speed</strong> = (downstream − upstream) / 2<br><br>If given time instead: speed = distance/time for each direction, then apply formulas.</p>',
 ARRAY['time-speed-distance']),

-- ═══════ QUANT: P&C and Probability ═══════
((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pnc-probability' LIMIT 1),
 'Permutation vs Combination — When to use which?',
 '<p><strong>Permutation</strong> (order matters): arrangements, rankings, passwords.<br>$P(n,r) = \frac{n!}{(n-r)!}$<br><br><strong>Combination</strong> (order doesn''t matter): teams, committees, selections.<br>$C(n,r) = \frac{n!}{r!(n-r)!}$<br><br>Test: "Is AB different from BA?" Yes → permutation. No → combination.<br>Example: Forming a 3-letter code from 5 letters vs choosing 3 people from 5.</p>',
 ARRAY['permutation-combination']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pnc-probability' LIMIT 1),
 'Probability key rules',
 '<p>• $0 \leq P(A) \leq 1$<br>• $P(A'') = 1 - P(A)$ (complement)<br>• $P(A \cup B) = P(A) + P(B) - P(A \cap B)$ (always true)<br>• $P(A \cap B) = P(A) \times P(B)$ (only if INDEPENDENT)<br>• At least one = $1 - P(\text{none})$ (complement trick)<br><br><strong>With/without replacement:</strong><br>With: probabilities don''t change.<br>Without: total decreases by 1 each draw.</p>',
 ARRAY['probability']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pnc-probability' LIMIT 1),
 'Arrangements with repeated letters',
 '<p>BANANA: 6 letters, A repeats 3×, N repeats 2×.<br>Total = $\frac{6!}{3! \times 2!} = \frac{720}{12} = 60$<br><br>General formula: $\frac{n!}{p_1! \times p_2! \times ...}$<br>where $p_i$ = frequency of each repeated element.<br><br>Other examples: MISSISSIPPI = $\frac{11!}{4! \times 4! \times 2!} = 34,650$</p>',
 ARRAY['permutation-combination']),

-- ═══════ QUANT: Algebra & Geometry ═══════
((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'Arithmetic & Geometric Progression formulas',
 '<p><strong>AP:</strong> a, a+d, a+2d, ...<br>nth term: $a_n = a + (n-1)d$<br>Sum: $S_n = \frac{n}{2}(2a + (n-1)d) = \frac{n}{2}(a + l)$<br><br><strong>GP:</strong> a, ar, ar², ...<br>nth term: $a_n = ar^{n-1}$<br>Sum (finite): $S_n = \frac{a(r^n - 1)}{r - 1}$<br>Sum (infinite, |r|<1): $S = \frac{a}{1-r}$</p>',
 ARRAY['series-sequences']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'Quadratic equation: Vieta''s formulas',
 '<p>For $ax^2 + bx + c = 0$ with roots $\alpha, \beta$:<br>• Sum of roots: $\alpha + \beta = -b/a$<br>• Product of roots: $\alpha \beta = c/a$<br>• Discriminant: $D = b^2 - 4ac$<br> - D > 0: two distinct real roots<br> - D = 0: one repeated root<br> - D < 0: no real roots (complex)<br><br>Quick: $x^2 - (\text{sum})x + (\text{product}) = 0$</p>',
 ARRAY['algebra']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'Geometry formulas for GATE',
 '<p><strong>Triangle:</strong> Area = ½bh. Equilateral: $\frac{\sqrt{3}}{4}a^2$<br><strong>Circle:</strong> Area = πr², Circumference = 2πr<br><strong>Rectangle:</strong> Area = l×b, Perimeter = 2(l+b)<br><strong>Square:</strong> Area = a², Diagonal = a√2, Area from diagonal = d²/2<br><strong>Cylinder:</strong> Volume = πr²h, CSA = 2πrh<br><strong>Sphere:</strong> Volume = $\frac{4}{3}\pi r^3$, SA = 4πr²<br><strong>Cone:</strong> Volume = $\frac{1}{3}\pi r^2 h$<br>Use π = 22/7 or 3.14 as specified.</p>',
 ARRAY['geometry-mensuration']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'Logarithm rules cheat sheet',
 '<p>• $\log_b a = c \Leftrightarrow b^c = a$<br>• $\log(ab) = \log a + \log b$<br>• $\log(a/b) = \log a - \log b$<br>• $\log a^n = n \log a$<br>• $\log_b a = \frac{\log a}{\log b}$ (change of base)<br>• $\log_b b = 1$, $\log_b 1 = 0$<br>• $\log_2 8 = 3$ ($2^3=8$), $\log_{10} 1000 = 3$</p>',
 ARRAY['algebra']),

-- ═══════ QUANT: DI & Logic ═══════
((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='chart-interpretation' LIMIT 1),
 'Data Interpretation strategy',
 '<p>1. <strong>Read labels</strong> — units, scale, time period.<br>2. <strong>Percentage change</strong> = (New−Old)/Old × 100. Always use the OLD value as base.<br>3. <strong>Ratio from chart</strong> — compute, don''t estimate.<br>4. <strong>Approximations</strong> — round to nearest 5 or 10 for speed.<br>5. In bar charts, the HEIGHT represents the value.<br>6. In pie charts, angles/percentages represent proportions of total.</p>',
 ARRAY['data-interpretation']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='venn-sets' LIMIT 1),
 'Venn Diagram formulas',
 '<p><strong>Two sets:</strong><br>$|A \cup B| = |A| + |B| - |A \cap B|$<br>Neither = Total − |A ∪ B|<br>Exactly one = |A| + |B| − 2|A ∩ B|<br><br><strong>Three sets:</strong><br>$|A \cup B \cup C| = |A|+|B|+|C| - |A \cap B| - |B \cap C| - |A \cap C| + |A \cap B \cap C|$<br><br>Draw the Venn diagram and fill from the INSIDE OUT (start with intersection).</p>',
 ARRAY['venn-diagrams']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='clocks-puzzles' LIMIT 1),
 'Clock angle formula',
 '<p><strong>Angle</strong> = $|30H - 5.5M|$ degrees<br>where H = hour, M = minutes.<br><br>• Hour hand: 0.5°/min (360°/12h = 30°/hr)<br>• Minute hand: 6°/min (360°/60min)<br>• Relative speed: 5.5°/min<br><br>Coincidence (0° angle): every $\frac{720}{11}$ ≈ 65.45 min.<br>They coincide <strong>11 times</strong> in 12 hours (not 12).<br>They are at 180° <strong>11 times</strong> in 12 hours.</p>',
 ARRAY['clocks-calendars']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='clocks-puzzles' LIMIT 1),
 'Calendar: Odd days method',
 '<p>To find the day of the week for a date:<br>• Count <strong>odd days</strong> (remainder when total days ÷ 7).<br>• 1 ordinary year = 1 odd day (365 mod 7 = 1)<br>• 1 leap year = 2 odd days (366 mod 7 = 2)<br>• 100 years = 5 odd days, 200 = 3, 300 = 1, 400 = 0<br><br>Month codes: Jan=0, Feb=3, Mar=3, Apr=6, May=1, Jun=4, Jul=6, Aug=2, Sep=5, Oct=0, Nov=3, Dec=5.<br>0=Sun, 1=Mon, 2=Tue, ... 6=Sat.</p>',
 ARRAY['clocks-calendars']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-sufficiency' LIMIT 1),
 'Data Sufficiency — Approach',
 '<p>Given a question and two statements I and II:<br>(A) I alone sufficient<br>(B) II alone sufficient<br>(C) Both together needed<br>(D) Neither sufficient<br><br><strong>Strategy:</strong><br>1. Test Statement I alone. Can you answer ?<br>2. Test Statement II alone.<br>3. If neither works alone, combine them.<br>4. "Sufficient" means ONE definite answer, not just a possibility.<br><br>Trick: For yes/no questions, finding BOTH "yes" and "no" examples means INSUFFICIENT.</p>',
 ARRAY['logical-deduction']),

-- ═══════ STRATEGY: GATE GA Tips ═══════
((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-di-logic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='data-sufficiency' LIMIT 1),
 'GATE GA: Time management strategy',
 '<p><strong>15 marks in ~15 minutes</strong> (recommended allocation):<br>• 5 one-mark questions: aim for <2 min each<br>• 5 two-mark questions: aim for <2 min each<br><br><strong>Prioritize:</strong> Verbal (fastest) → Easy quant → DI → Hard quant<br><br><strong>No negative marking for NATs</strong> — always attempt them!<br><strong>Negative marking for MCQs:</strong> −1/3 for 1-mark, −2/3 for 2-mark.<br>Only guess if you can eliminate 2+ options.</p>',
 ARRAY['data-interpretation']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='pct-profit-loss' LIMIT 1),
 'Percentage → Fraction quick conversion',
 '<p>Memorize these for speed:<br>• 10% = 1/10<br>• 12.5% = 1/8<br>• 16.67% = 1/6<br>• 20% = 1/5<br>• 25% = 1/4<br>• 33.33% = 1/3<br>• 37.5% = 3/8<br>• 50% = 1/2<br>• 62.5% = 5/8<br>• 66.67% = 2/3<br>• 75% = 3/4<br>• 87.5% = 7/8<br>These save precious seconds in GATE calculations.</p>',
 ARRAY['percentages']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-arithmetic' LIMIT 1),
 (SELECT id FROM topics WHERE slug='number-divisibility' LIMIT 1),
 'Squares and cubes to memorize for GATE',
 '<p><strong>Squares:</strong> 11²=121, 12²=144, 13²=169, 14²=196, 15²=225, 16²=256, 17²=289, 18²=324, 19²=361, 20²=400, 25²=625, 30²=900<br><br><strong>Cubes:</strong> 2³=8, 3³=27, 4³=64, 5³=125, 6³=216, 7³=343, 8³=512, 9³=729, 10³=1000, 11³=1331, 12³=1728<br><br>These eliminate calculation time in NAT questions.</p>',
 ARRAY['number-systems']),

((SELECT id FROM subjects WHERE slug='ga'),
 (SELECT id FROM chapters WHERE slug='ga-quant' LIMIT 1),
 (SELECT id FROM topics WHERE slug='algebra-geometry' LIMIT 1),
 'Pythagorean triplets to memorize',
 '<p>Common right triangle sides:<br>• (3, 4, 5) and multiples: (6,8,10), (9,12,15), (12,16,20)<br>• (5, 12, 13) and (10, 24, 26)<br>• (8, 15, 17)<br>• (7, 24, 25)<br><br>Formula: For any m>n>0:<br>$a = m^2 - n^2$, $b = 2mn$, $c = m^2 + n^2$<br>Example: m=2, n=1 → (3, 4, 5).</p>',
 ARRAY['geometry-mensuration']);

-- ═══════════════════════════════════════════════════════════════════════════
-- FINAL STATS SUMMARY
-- ═══════════════════════════════════════════════════════════════════════════
-- Subject: General Aptitude (ga)
-- MCQ: Q1-Q70 + Q116-Q130 = 85 questions (p2-p6, p9)
-- NAT: Q71-Q95 = 25 questions (p7)
-- MSQ: Q96-Q115 = 20 questions (p8)
-- Flashcards: 50 unique cards (p10)
-- Total Questions: 130
-- Total Flashcards: 50
-- ═══════════════════════════════════════════════════════════════════════════

-- Part 10 Complete.
