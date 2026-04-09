-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CN PYQ SEED v2  (Part 6 / 8)
-- MSQ Questions Q56–Q65 (Multi-Select)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q56 — MSQ: Properties of TCP (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tcp-basics' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'Which of the following are properties of TCP? (Select all that apply)',
  'Connection-oriented — requires a three-way handshake before data transfer',
  'Provides reliable, in-order delivery via sequence numbers and ACKs',
  'Is a connectionless protocol like UDP',
  'Implements flow control using a receiver window (rwnd)',
  ARRAY['A','B','D'],
  '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> TCP is connection-oriented (A), provides reliability and ordering (B), and uses rwnd for flow control (D). It is decidedly NOT connectionless — that is UDP''s property.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tcp');

-- Q57 — MSQ: Error detection techniques (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='framing' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following techniques can both detect AND correct bit errors in transmitted data? (Select all that apply)',
  'Even Parity Check (single bit)',
  'Hamming Code',
  'CRC (Cyclic Redundancy Check)',
  'Reed-Solomon Codes',
  ARRAY['B','D'],
  '<p><strong>✓ Answers: B, D.</strong></p><p><strong>Rationale:</strong> Simple parity (A) only detects single-bit errors but cannot correct. CRC (C) detects errors but cannot correct them — it only identifies that an error occurred. Hamming Code (B) and Reed-Solomon (D) provide both error detection and correction capability.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q58 — MSQ: Routing protocol types (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='routing' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following are classified as Interior Gateway Protocols (IGPs) — used for routing within a single Autonomous System? (Select all that apply)',
  'BGP (Border Gateway Protocol)',
  'OSPF (Open Shortest Path First)',
  'RIP (Routing Information Protocol)',
  'IS-IS (Intermediate System to Intermediate System)',
  ARRAY['B','C','D'],
  '<p><strong>✓ Answers: B, C, D.</strong></p><p><strong>Rationale:</strong> BGP (A) is the only Exterior Gateway Protocol (EGP) used between Autonomous Systems. OSPF (B), RIP (C), and IS-IS (D) are all IGPs used for intra-AS routing.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cn-routing');

-- Q59 — MSQ: TCP congestion control phases (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flow-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','hard',2,
  'In TCP Reno''s congestion control, which phases/mechanisms are part of the standard algorithm? (Select all that apply)',
  'Slow Start — exponential cwnd growth from 1 MSS',
  'Congestion Avoidance — linear (additive increase) cwnd growth after ssthresh',
  'Immediate connection closure upon any packet loss',
  'Fast Retransmit — retransmit the lost segment after 3 duplicate ACKs without waiting for timeout',
  ARRAY['A','B','D'],
  '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> TCP Reno implements Slow Start (A), Congestion Avoidance (B), and Fast Retransmit/Fast Recovery (D). Immediate connection closure (C) is not a TCP mechanism — TCP does not close the connection simply because a packet is lost.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tcp','congestion');

-- Q60 — MSQ: Private IPv4 address ranges (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-addr' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'Which of the following IPv4 address ranges are defined as private (RFC 1918) and not routable on the public internet? (Select all that apply)',
  '10.0.0.0/8',
  '172.16.0.0/12',
  '192.168.0.0/16',
  '200.100.50.0/24',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> RFC 1918 defines three private ranges: 10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16. The address 200.100.50.0/24 (D) is a public address block routable on the internet.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip','subnetting');

-- Q61 — MSQ: IPv6 improvements over IPv4 (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-proto' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following are genuine improvements that IPv6 provides over IPv4? (Select all that apply)',
  '128-bit address space enabling vastly more unique IP addresses',
  'Fragmentation is handled only by the source host, not by intermediate routers',
  'IPsec (security) support is mandatory rather than optional',
  'IPv6 supports broadcast addressing just like IPv4',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> IPv6 expands to 128-bit addresses (A), moves fragmentation responsibility to the source (B), and mandates IPsec support (C). IPv6 eliminates broadcast entirely, replacing it with multicast and anycast — making D incorrect.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip');

-- Q62 — MSQ: DNS resolution types (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dns' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which statements about DNS caching are correct? (Select all that apply)',
  'DNS responses are cached at local resolvers to reduce repeat query latency',
  'Each DNS record has a TTL (Time-to-Live) value that controls how long it can be cached',
  'DNS caching can cause stale IP addresses to be returned after a DNS record is updated',
  'DNS responses are never cached — every query always contacts the root server',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> DNS caching reduces query latency (A), controlled by TTL values (B), but can serve stale records after changes propagate (C) — the downside of caching. D is incorrect: caching is fundamental to DNS scalability.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dns-http');

-- Q63 — MSQ: MAC protocol categories (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mac' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','medium',2,
  'Which of the following are contention-based (random access) MAC protocols? (Select all that apply)',
  'ALOHA (Pure and Slotted)',
  'CSMA/CD (Ethernet)',
  'TDMA (Time Division Multiple Access)',
  'CSMA/CA (WiFi 802.11)',
  ARRAY['A','B','D'],
  '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> ALOHA, CSMA/CD, and CSMA/CA are all random-access (contention) protocols where multiple stations compete for the channel. TDMA (C) is a channelisation (fixed-assignment) protocol that pre-allocates time slots, eliminating contention.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('data-link');

-- Q64 — MSQ: HTTPS/TLS security properties (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='security' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','hard',2,
  'TLS (as used in HTTPS) provides which of the following security properties? (Select all that apply)',
  'Confidentiality — data is encrypted and unreadable to eavesdroppers',
  'Server authentication — the server''s identity is verified via a digital certificate',
  'Data integrity — any tampering with data in transit is detectable',
  'Anonymity — the client''s IP address is hidden from the server',
  ARRAY['A','B','C'],
  '<p><strong>✓ Answers: A, B, C.</strong></p><p><strong>Rationale:</strong> TLS provides confidentiality (A) via symmetric encryption, server (and optionally client) authentication (B) via X.509 certificates, and integrity (C) via HMAC/MAC tags on every record. TLS does NOT hide the client''s IP address from the server — that requires a VPN or Tor.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cn-security');

-- Q65 — MSQ: Reasons why UDP is used over TCP (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_options,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='udp' LIMIT 1),
  'gate-cse',false,NULL,'MSQ','easy',1,
  'Which of the following are legitimate reasons to choose UDP over TCP for a network application? (Select all that apply)',
  'The application requires finer-grained control over when data is sent',
  'The application can tolerate some data loss but cannot tolerate the added latency of TCP''s reliability mechanisms',
  'The application requires guaranteed ordered delivery of all packets',
  'The application performs its own application-level retransmission logic',
  ARRAY['A','B','D'],
  '<p><strong>✓ Answers: A, B, D.</strong></p><p><strong>Rationale:</strong> UDP is chosen for low-latency control (A), loss-tolerant real-time media (B), and applications that implement custom reliability at the application layer (D) such as QUIC or some game engines. Guaranteed ordered delivery (C) is a reason to choose TCP, not UDP.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('udp');

-- Part 6 Complete.
