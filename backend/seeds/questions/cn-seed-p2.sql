-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CN PYQ SEED v2  (Part 2 / 8)
-- MCQ Questions Q1–Q14 (Data Link Layer)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q1 — Hamming distance for error correction (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='framing' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'To detect up to $d$ errors in a codeword, the minimum Hamming distance required between any two valid codewords is:',
  '$d$',
  '$d + 1$',
  '$2d$',
  '$2d + 1$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> To detect $d$ errors, codewords must differ in at least $d+1$ bit positions. To both detect and correct $d$ errors, the Hamming distance must be at least $2d+1$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q2 — CRC purpose (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='framing' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which error detection technique divides the data bits by a generator polynomial and appends the remainder as a checksum?',
  'Parity Check',
  'Checksum (Internet)',
  'Cyclic Redundancy Check (CRC)',
  'Hamming Code',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> CRC treats the data as a binary polynomial, divides it by a generator polynomial, and appends the non-zero remainder to the frame. The receiver performs the same division and checks for a zero remainder.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q3 — Stop-and-Wait efficiency (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='error-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In Stop-and-Wait ARQ, the channel utilization is determined by the propagation delay and frame transmission time. If $a = T_{prop}/T_{frame}$, which expression gives the efficiency?',
  '$1/(1 + a)$',
  '$1/(1 + 2a)$',
  '$a/(1 + 2a)$',
  '$2a/(1 + 2a)$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In Stop-and-Wait, the sender must wait one full round-trip before sending the next frame. Efficiency = $T_{frame}/(T_{frame} + 2T_{prop}) = 1/(1 + 2a)$ where $a = T_{prop}/T_{frame}$.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q4 — Go-Back-N window size (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='error-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In Go-Back-N ARQ with $n$-bit sequence numbers, the maximum sender window size is:',
  '$2^n$',
  '$2^n - 1$',
  '$2^{n-1}$',
  '$2^n / 2$',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Go-Back-N allows a window of up to $2^n - 1$ frames. Using a full $2^n$ window would make it impossible to distinguish new frames from retransmissions after a full-window send.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q5 — Selective Repeat window size (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='error-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'In Selective Repeat ARQ with $n$-bit sequence numbers, the maximum sender (and receiver) window size is:',
  '$2^n - 1$',
  '$2^n$',
  '$2^{n-1}$',
  '$2^{n+1} - 1$',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Selective Repeat requires receiver buffers equal in size to the sender window. The maximum safe window is $2^{n-1}$. Using a larger window makes old and new frames indistinguishable.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q6 — CSMA/CD collision domain (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mac' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In CSMA/CD, a station must detect a collision while still transmitting. What minimum frame size does this requirement impose?',
  'The frame must be at least as large as the MTU',
  'The frame transmission time must be at least twice the end-to-end propagation delay',
  'The frame size must equal the bandwidth-delay product',
  'No minimum size is imposed — detection is instantaneous',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> For a station to detect a collision it caused, it must still be transmitting when the collision signal arrives back. This requires frame transmission time ≥ 2 × propagation delay of the medium.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q7 — Ethernet MAC address length (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mac' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'An Ethernet MAC address is how many bits long?',
  '32 bits',
  '64 bits',
  '48 bits',
  '128 bits',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Ethernet MAC (hardware) addresses are 48 bits (6 bytes), typically written as 6 hex octets separated by colons (e.g., AA:BB:CC:DD:EE:FF).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q8 — Switch vs Hub (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='switching' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'A network switch, unlike a hub, forwards frames based on:',
  'IP addresses learned from ARP tables',
  'MAC addresses learned from incoming frames',
  'Port numbers from TCP connections',
  'Broadcasting to all ports always',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A switch maintains a MAC address table and forwards frames only to the port associated with the destination MAC. A hub blindly floods all frames to all ports.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q9 — Spanning Tree Protocol purpose (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='switching' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The Spanning Tree Protocol (STP) is used in switched Ethernet networks to:',
  'Assign IP addresses to all switches automatically',
  'Prevent broadcast storms by eliminating loops in the switch topology',
  'Route packets between different subnets',
  'Encrypt frame payloads for secure transmission',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Redundant switch links create loops, causing broadcast storms where frames circulate indefinitely. STP disables redundant links while keeping them as backups, creating a loop-free logical tree.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q10 — CSMA/CA vs CSMA/CD usage (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mac' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'CSMA/CA (Collision Avoidance) is used in 802.11 WiFi instead of CSMA/CD because:',
  'WiFi operates at higher speeds than Ethernet',
  'Collisions cannot be reliably detected during wireless transmission',
  'WiFi frames are too small for CSMA/CD to work',
  'CD requires fewer sequence numbers than CA',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A wireless transmitter cannot reliably hear its own signal while transmitting due to signal power differences. Since detection is infeasible, 802.11 uses RTS/CTS and random backoff to avoid collisions before they occur.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q11 — HDLC / Sliding Window efficiency (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='error-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'A sliding window protocol with window size $W$ achieves 100% channel utilization only when:',
  '$W \geq 1 + 2a$',
  '$W \leq 1 + 2a$',
  '$W = a$',
  '$W = 2a$',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> Channel utilization reaches 100% when the window is large enough to keep transmitting through the full round-trip delay. The "pipeline" length is $1 + 2a$ frames; if $W \geq 1 + 2a$, all slots are filled.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q12 — VLAN purpose (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='switching' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Virtual LANs (VLANs) primarily provide which benefit in a switched network?',
  'They eliminate the need for routers entirely',
  'They logically partition a single physical switch into multiple isolated broadcast domains',
  'They increase the physical bandwidth of each port',
  'They replace the MAC addressing scheme with IP',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> VLANs allow a single physical switch to host multiple logically separate networks. Traffic from one VLAN cannot reach another VLAN without a router (or Layer-3 switch), improving security and reducing broadcast traffic.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q13 — Token Ring vs CSMA (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mac' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In Token Ring networks, a station may transmit only when it holds the token. This guarantees which property absent in CSMA?',
  'Higher bandwidth per station',
  'Collision-free, deterministic access to the medium',
  'Automatic encryption of all frames',
  'No need for error detection',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Token passing ensures only one station transmits at a time, completely eliminating collisions. CSMA-based systems are contention-based and cannot guarantee collision-free access.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q14 — Framing: byte stuffing (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='framing' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Byte stuffing (character stuffing) in data link framing is used to:',
  'Compress frame payloads for faster transmission',
  'Escape delimiter bytes appearing in the payload so the receiver can correctly identify frame boundaries',
  'Encrypt the frame header using a shared key',
  'Add redundancy bits for error correction',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> If a frame delimiter byte value appears in the payload data, the receiver would incorrectly interpret it as the end of the frame. Byte stuffing prepends an escape byte before any such data byte, allowing the receiver to distinguish data from delimiters.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Part 2 Complete.
