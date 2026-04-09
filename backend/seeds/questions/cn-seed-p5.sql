-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CN PYQ SEED v2  (Part 5 / 8)
-- NAT Questions Q46–Q55 (Numerical Calculations)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q46 — Channel utilization Stop-and-Wait (medium)
-- Given: Bandwidth = 1 Mbps, frame = 1000 bits, propagation delay = 270 ms
-- T_frame = 1000 / 1,000,000 = 1 ms
-- a = 270 / 1 = 270
-- Efficiency = 1 / (1 + 2×270) = 1/541 ≈ 0.00185 → ~0.185%
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='error-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A Stop-and-Wait ARQ link has bandwidth 1 Mbps, frame size 1000 bits, and one-way propagation delay 270 ms. What is the channel utilization efficiency (as a percentage, rounded to 2 decimal places)?',
  0.18,0.19,NULL,
  '<p><strong>✓ Answer: ≈ 0.185%</strong></p><p><strong>Rationale:</strong> T<sub>frame</sub> = 1000 / 10⁶ = 1 ms. a = T<sub>prop</sub>/T<sub>frame</sub> = 270/1 = 270. Efficiency = 1/(1 + 2a) = 1/541 ≈ 0.00185 = <strong>0.185%</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q47 — Usable subnets and hosts from /27 (medium)
-- /27 → 5 host bits → 2^5 = 32 addresses per subnet → 30 usable hosts
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-addr' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A /27 subnet is assigned to a LAN. How many usable host IP addresses does this subnet provide?',
  30.00,30.00,NULL,
  '<p><strong>✓ Answer: 30.</strong></p><p><strong>Rationale:</strong> Prefix /27 leaves 32 − 27 = 5 host bits. Total addresses = 2⁵ = 32. Subtract network (all 0s) and broadcast (all 1s) addresses: 32 − 2 = <strong>30</strong> usable hosts.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip','subnetting');

-- Q48 — TCP sliding window throughput (medium)
-- Window = 64 KB = 65536 bytes, RTT = 100 ms
-- Throughput = Window / RTT = 65536 / 0.1 = 655360 bytes/s ≈ 5.24 Mbps
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flow-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A TCP connection has a receiver window size of 64 KB and an RTT of 100 ms. What is the maximum achievable throughput in Kbps?',
  5242.00,5243.00,NULL,
  '<p><strong>✓ Answer: ≈ 5242 Kbps.</strong></p><p><strong>Rationale:</strong> Throughput = Window / RTT = 65536 bytes / 0.1 s = 655,360 bytes/s = 5,242,880 bits/s ≈ <strong>5242 Kbps</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tcp');

-- Q49 — Go-Back-N window size with 4-bit sequence numbers (easy)
-- max GBN window = 2^4 - 1 = 15
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='error-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'In Go-Back-N ARQ with 4-bit sequence numbers, what is the maximum permissible sender window size?',
  15.00,15.00,NULL,
  '<p><strong>✓ Answer: 15.</strong></p><p><strong>Rationale:</strong> With n = 4 bits, 2ⁿ = 16 sequence numbers exist (0–15). Go-Back-N maximum window = 2ⁿ − 1 = <strong>15</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q50 — IP fragmentation: number of fragments (medium)
-- Datagram = 4000 bytes, MTU = 1500 bytes, IP header = 20 bytes
-- Data per fragment = 1500 - 20 = 1480 bytes. Total data = 4000 - 20 = 3980 bytes
-- Fragments = ceil(3980 / 1480) = ceil(2.689...) = 3
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-proto' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'An IPv4 datagram carrying 3980 bytes of data (plus 20 bytes IP header) must traverse a link with MTU = 1500 bytes. How many fragments are created?',
  3.00,3.00,NULL,
  '<p><strong>✓ Answer: 3.</strong></p><p><strong>Rationale:</strong> Maximum data per fragment = 1500 − 20 = 1480 bytes. Fragment 1: bytes 0–1479 (1480 bytes). Fragment 2: bytes 1480–2959 (1480 bytes). Fragment 3: bytes 2960–3979 (1020 bytes). Total = <strong>3 fragments</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip');

-- Q51 — Bandwidth-delay product (medium)
-- Bandwidth = 10 Mbps = 10^7 bps, RTT = 40 ms = 0.04 s
-- BDP = 10^7 × 0.04 = 400,000 bits = 50,000 bytes = 50 KB
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tcp-basics' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A network link has a bandwidth of 10 Mbps and a round-trip time of 40 ms. What is the bandwidth-delay product in bits?',
  400000.00,400000.00,NULL,
  '<p><strong>✓ Answer: 400,000 bits.</strong></p><p><strong>Rationale:</strong> BDP = Bandwidth × RTT = 10 × 10⁶ bps × 0.04 s = <strong>400,000 bits</strong>. This represents the number of bits "in flight" needed to fully utilise the pipe.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tcp');

-- Q52 — Number of subnets from /22 split into /25 (medium)
-- /22 to /25 difference = 3 bits → 2^3 = 8 subnets
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-addr' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A /22 network block is to be divided into /25 subnets. How many /25 subnets can be created?',
  8.00,8.00,NULL,
  '<p><strong>✓ Answer: 8.</strong></p><p><strong>Rationale:</strong> The difference in prefix length is 25 − 22 = 3 bits borrowed for subnetting. Number of subnets = 2³ = <strong>8</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip','subnetting');

-- Q53 — Selective Repeat window size with 3-bit sequence numbers (easy)
-- max SR window = 2^(n-1) = 2^2 = 4
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='error-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'NAT','easy',1,
  'In Selective Repeat ARQ with 3-bit sequence numbers, what is the maximum permissible sender window size?',
  4.00,4.00,NULL,
  '<p><strong>✓ Answer: 4.</strong></p><p><strong>Rationale:</strong> With n = 3 bits, 2ⁿ = 8 sequence numbers. Selective Repeat maximum window = 2ⁿ⁻¹ = 2² = <strong>4</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q54 — HTTP non-persistent connections RTT count (medium)
-- Fetching a page with 1 base HTML + 10 objects, non-persistent HTTP
-- Per object: 2 RTTs (1 for TCP handshake + 1 for HTTP req/resp) + 1 transmission
-- With parallel connections, total RTTs for all objects = 2 + 2 = 4 (if serial: 2 + 2×10 = 22)
-- Q asks: non-persistent, serial — base HTML: 2 RTTs. Each of 10 objects: 2 RTTs. Total = 2 + 20 = 22
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='http-ftp' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A web page consists of 1 base HTML file and 10 referenced image objects. Using HTTP/1.0 (non-persistent, serial connections), and ignoring transmission time, how many total RTTs are needed to fetch the entire page?',
  22.00,22.00,NULL,
  '<p><strong>✓ Answer: 22 RTTs.</strong></p><p><strong>Rationale:</strong> Non-persistent HTTP requires a new TCP connection (1 RTT handshake) + 1 RTT HTTP request = 2 RTTs per object. Base HTML: 2 RTTs. Each of 10 images: 2 RTTs. Total = 2 + (10 × 2) = <strong>22 RTTs</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dns-http');

-- Q55 — Minimum frame size for CSMA/CD (medium)
-- Speed = 100 Mbps, propagation delay = 50 μs (one way), round-trip = 100 μs
-- min frame bits = speed × 2 × prop delay = 100×10^6 × 100×10^-6 = 10,000 bits = 1250 bytes
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,nat_answer_min,nat_answer_max,nat_unit,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mac' LIMIT 1),
  'gate-cse',false,NULL,'NAT','medium',2,
  'A CSMA/CD network operates at 100 Mbps. The maximum end-to-end propagation delay is 50 µs (one-way). What is the minimum frame size in bytes required for collision detection to work correctly?',
  1250.00,1250.00,NULL,
  '<p><strong>✓ Answer: 1250 bytes.</strong></p><p><strong>Rationale:</strong> Min frame transmission time ≥ 2 × propagation delay = 2 × 50 µs = 100 µs. Min frame bits = 100 Mbps × 100 µs = 10,000 bits = <strong>1250 bytes</strong>.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Part 5 Complete.
