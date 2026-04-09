-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CN PYQ SEED v2  (Part 1 / 8)
-- Subject: Computer Networks (cn)
-- ═══════════════════════════════════════════════════════════════════════════

BEGIN;

DO $$
DECLARE
  subj_id UUID;
  ch1_id  UUID;
  ch2_id  UUID;
  ch3_id  UUID;
  ch4_id  UUID;
BEGIN

  -- 1. Subject
  INSERT INTO subjects (title, slug, description, gradient_start, gradient_end, icon_type)
  VALUES (
    'Computer Networks', 'cn',
    'Data link protocols, IP addressing, routing, TCP/UDP transport, and application-layer services.',
    '#10b981', '#065f46', 'network'
  )
  ON CONFLICT (slug) DO UPDATE
    SET title = EXCLUDED.title, description = EXCLUDED.description
  RETURNING id INTO subj_id;

  -- 2. Chapters
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Data Link Layer', 'data-link', 1) RETURNING id INTO ch1_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Network Layer', 'network-layer', 2) RETURNING id INTO ch2_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Transport Layer', 'transport-layer', 3) RETURNING id INTO ch3_id;
  INSERT INTO chapters (subject_id, title, slug, sort_order) VALUES (subj_id, 'Application & Security', 'app-security', 4) RETURNING id INTO ch4_id;

  -- 3. Topics
  -- Chapter 1: Data Link Layer
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'framing',     'Framing & Error Detection',    1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'error-ctrl',  'Error Control (ARQ)',          2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'mac',         'MAC Protocols & CSMA',         3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch1_id, 'switching',   'Switching & VLANs',            4) ON CONFLICT DO NOTHING;

  -- Chapter 2: Network Layer
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'ip-addr',     'IP Addressing & Subnetting',   1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'routing',     'Routing Algorithms',          2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'ip-proto',    'IPv4, IPv6 & ICMP',            3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch2_id, 'nat-dhcp',    'NAT, DHCP & ARP',              4) ON CONFLICT DO NOTHING;

  -- Chapter 3: Transport Layer
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'tcp-basics',  'TCP Fundamentals',             1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'flow-ctrl',   'Flow & Congestion Control',    2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'udp',         'UDP & Multiplexing',           3) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch3_id, 'tcp-connect', 'TCP Connection Management',    4) ON CONFLICT DO NOTHING;

  -- Chapter 4: Application & Security
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'http-ftp',    'HTTP, FTP & SMTP',             1) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'dns',         'DNS',                         2) ON CONFLICT DO NOTHING;
  INSERT INTO topics (chapter_id, slug, title, sort_order) VALUES (ch4_id, 'security',    'Network Security',            3) ON CONFLICT DO NOTHING;

  -- 4. Tags
  INSERT INTO tags (name, slug) VALUES ('Data Link',      'data-link')  ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('IP',             'ip')         ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Routing',        'cn-routing') ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('TCP',            'tcp')        ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('UDP',            'udp')        ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Subnetting',     'subnetting') ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Congestion',     'congestion') ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('DNS/HTTP',       'dns-http')   ON CONFLICT DO NOTHING;
  INSERT INTO tags (name, slug) VALUES ('Security',       'cn-security')ON CONFLICT DO NOTHING;

END $$;

-- Part 1 Complete.
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
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CN PYQ SEED v2  (Part 3 / 8)
-- MCQ Questions Q15–Q28 (Network Layer)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q15 — IPv4 address class (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-addr' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'An IPv4 address starting with the binary prefix 1110 belongs to which class?',
  'Class B',
  'Class C',
  'Class D (Multicast)',
  'Class E (Experimental)',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Class A starts with 0, Class B with 10, Class C with 110, Class D (multicast) with 1110, and Class E (reserved) with 1111.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip','subnetting');

-- Q16 — Subnet mask /26 hosts (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-addr' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'An IP subnet uses the prefix /26. How many usable host addresses does this subnet support?',
  '64',
  '62',
  '30',
  '126',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A /26 prefix leaves 32 - 26 = 6 bits for host addressing. Total addresses = $2^6 = 64$. Subtract the network address and broadcast address: 64 - 2 = <strong>62</strong> usable hosts.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip','subnetting');

-- Q17 — Dijkstra's vs Bellman-Ford (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='routing' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'OSPF uses Dijkstra''s Link State algorithm while RIP uses the Bellman-Ford Distance Vector algorithm. Which statement correctly distinguishes them?',
  'Dijkstra converges slowly; Bellman-Ford converges quickly',
  'Dijkstra requires each router to know the complete network topology; Bellman-Ford only requires knowledge of direct neighbours',
  'Bellman-Ford cannot compute shortest paths; Dijkstra can',
  'Both algorithms require global knowledge of the network',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In Link State (Dijkstra), every router floods link-state advertisements so all routers build a full topology map before running Dijkstra. In Distance Vector (Bellman-Ford), each router shares only its distance vector table with direct neighbours.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cn-routing');

-- Q18 — Count to Infinity problem (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='routing' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'The "Count to Infinity" problem is a convergence issue associated with which routing algorithm?',
  'Dijkstra''s Link State algorithm',
  'Distance Vector (Bellman-Ford) algorithm',
  'Spanning Tree Protocol',
  'OSPF shortest path first',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In Distance Vector routing, when a link fails, routers can form a loop where they keep advertising incrementally larger distances to the unreachable network before finally converging. Split Horizon and Poison Reverse are common mitigations.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cn-routing');

-- Q19 — ARP function (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='nat-dhcp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'ARP (Address Resolution Protocol) resolves which type of address mapping?',
  'Domain name to IP address',
  'IP address to MAC address',
  'MAC address to IP address',
  'IP address to port number',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> ARP maps a known IP address to its corresponding MAC address. A host broadcasts an ARP request asking "Who has this IP?" and the host with that IP replies with its MAC address.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip');

-- Q20 — NAT function (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='nat-dhcp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'What is the primary purpose of Network Address Translation (NAT)?',
  'Translate MAC addresses to IP addresses at the router',
  'Allow multiple devices with private IP addresses to share a single public IP address',
  'Assign unique public IP addresses to every device on a LAN',
  'Encrypt traffic between internal hosts and external servers',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> NAT allows an entire private network (using RFC 1918 addresses like 192.168.x.x) to communicate with the public internet through one public IP by rewriting source addresses and tracking connections in a translation table.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip');

-- Q21 — IPv6 address size (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-proto' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'IPv6 addresses are how many bits long?',
  '32 bits',
  '64 bits',
  '128 bits',
  '256 bits',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> IPv6 uses 128-bit addresses, compared to IPv4''s 32 bits. This provides approximately $3.4 \times 10^{38}$ unique addresses, effectively solving the IPv4 address exhaustion problem.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip');

-- Q22 — ICMP usage (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-proto' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The `ping` utility uses which protocol to test network reachability?',
  'TCP',
  'UDP',
  'ICMP (Internet Control Message Protocol)',
  'ARP',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> `ping` sends ICMP Echo Request messages and expects ICMP Echo Reply messages back. ICMP is a network-layer protocol used for error reporting and diagnostic functions, not data transfer.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip');

-- Q23 — DHCP protocol (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='nat-dhcp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'DHCP (Dynamic Host Configuration Protocol) automatically assigns which parameters to a networked device? (Select the best answer)',
  'MAC address, port number, and encryption key',
  'IP address, subnet mask, default gateway, and DNS server',
  'Routing table entries and OSPF area IDs',
  'Frame sequence numbers and ACK window sizes',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> DHCP auto-configures IP address, subnet mask, default gateway, DNS server, and lease duration for client devices without manual configuration.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip');

-- Q24 — Routing: intra vs inter-domain (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='routing' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'BGP (Border Gateway Protocol) is classified as an Exterior Gateway Protocol (EGP). What does this mean?',
  'BGP is used for routing within a single Autonomous System (AS)',
  'BGP routes packets between different Autonomous Systems on the internet',
  'BGP only handles multicast routing',
  'BGP operates at the data link layer',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Autonomous Systems (AS) are independently administered routing domains (e.g., an ISP or university). BGP is the internet''s inter-AS routing protocol, connecting these domains. OSPF and RIP are IGPs (intra-AS protocols).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cn-routing');

-- Q25 — IP TTL purpose (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-proto' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The Time-to-Live (TTL) field in an IPv4 packet header serves what purpose?',
  'It specifies how long the packet can be stored in a router''s buffer',
  'It limits the maximum number of hops a packet can traverse, preventing infinite routing loops',
  'It sets the encryption key expiry time for IPsec',
  'It controls the maximum segment size for TCP',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Each router that forwards an IP packet decrements the TTL by 1. When TTL reaches 0, the router discards the packet and sends an ICMP Time Exceeded message. This prevents packets from looping forever in the network.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip');

-- Q26 — IP fragmentation (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-proto' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'IP fragmentation occurs when a datagram is larger than the MTU of the outgoing link. In IPv4, who reassembles the fragments?',
  'Each intermediate router along the path',
  'The first router that performs fragmentation',
  'The final destination host',
  'The source host before transmission',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> IPv4 fragment reassembly happens only at the final destination. Routers do not reassemble fragments — they may fragment further but never reassemble. IPv6 eliminates router fragmentation entirely.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip');

-- Q27 — CIDR notation (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-addr' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'CIDR (Classless Inter-Domain Routing) was introduced primarily to:',
  'Replace MAC addresses with hierarchical numbering',
  'Slow down the depletion of IPv4 addresses and reduce the size of internet routing tables via route aggregation',
  'Implement encrypted tunnels between routers',
  'Allow routers to dynamically assign IP addresses to hosts',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> CIDR discards the rigid Class A/B/C system, allowing flexible prefix lengths. Contiguous address blocks can be summarised into a single routing entry (supernetting), drastically reducing routing table sizes.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('ip','subnetting');

-- Q28 — Link State vs Distance Vector convergence (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='routing' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'Which of the following is a known disadvantage of Link State routing algorithms compared to Distance Vector?',
  'Link State algorithms are susceptible to the count-to-infinity problem',
  'Link State requires more memory and processing because each router stores and computes over the full network topology',
  'Link State algorithms cannot compute loop-free paths',
  'Link State algorithms converge more slowly than Distance Vector',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Link State protocols (OSPF) flood LSAs across the entire network, requiring each router to maintain a complete topology database and run Dijkstra''s algorithm. This is more resource-intensive than Distance Vector, though convergence is faster and more reliable.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cn-routing');

-- Part 3 Complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CN PYQ SEED v2  (Part 4 / 8)
-- MCQ Questions Q29–Q45 (Transport Layer & Application/Security)
-- ═══════════════════════════════════════════════════════════════════════════

-- Q29 — TCP vs UDP (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tcp-basics' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which statement correctly distinguishes TCP from UDP?',
  'UDP provides reliable, ordered delivery; TCP does not guarantee order',
  'TCP provides reliable, connection-oriented, ordered delivery; UDP is connectionless with no delivery guarantee',
  'TCP is faster than UDP because of its built-in compression',
  'Both TCP and UDP provide reliability but differ only in header size',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> TCP provides reliability (ACKs, retransmission), ordering (sequence numbers), and flow/congestion control at the cost of overhead. UDP sacrifices these guarantees for low latency and is preferred for DNS, streaming, and gaming.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tcp','udp');

-- Q30 — TCP 3-way handshake (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tcp-connect' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'The TCP three-way handshake for connection establishment uses which message sequence?',
  'SYN → SYN-ACK → ACK',
  'SYN → ACK → SYN',
  'CONNECT → OK → READY',
  'OPEN → OPEN-ACK → DATA',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> (1) Client sends SYN with its ISN. (2) Server responds with SYN-ACK (acknowledging client ISN, announcing server ISN). (3) Client sends ACK acknowledging server ISN. Connection is now established.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tcp');

-- Q31 — TCP slow start (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flow-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'During TCP Slow Start, how does the congestion window (cwnd) grow with each successful RTT?',
  'Linearly — cwnd increases by 1 MSS per RTT',
  'Exponentially — cwnd doubles each RTT (increases by 1 MSS per ACK received)',
  'Logarithmically — cwnd grows by log(cwnd) per RTT',
  'It remains fixed until a timeout occurs',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> In Slow Start, cwnd increases by 1 MSS for every ACK received. Since each RTT generates cwnd ACKs, cwnd effectively doubles per RTT — exponential growth — until ssthresh is reached.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tcp','congestion');

-- Q32 — TCP congestion avoidance (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flow-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'When TCP detects congestion via a timeout event (as opposed to triple duplicate ACKs), what does TCP Reno do?',
  'Set ssthresh to cwnd/2 and reset cwnd to 1 MSS, restarting Slow Start',
  'Set ssthresh to cwnd/2 and set cwnd to ssthresh, continuing with Congestion Avoidance',
  'Immediately close the TCP connection and re-establish it',
  'Halve the cwnd and continue Congestion Avoidance without resetting',
  'A',
  '<p><strong>✓ Answer: A.</strong></p><p><strong>Rationale:</strong> A timeout signals severe congestion. TCP Reno sets ssthresh = cwnd/2, resets cwnd = 1 MSS, and restarts Slow Start. Triple duplicate ACKs trigger TCP Fast Recovery instead (cwnd halved but not reset to 1).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tcp','congestion');

-- Q33 — TCP flow control receiver window (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flow-ctrl' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'TCP flow control uses the receiver''s window field (rwnd) to prevent the sender from overwhelming the receiver. What happens when the receiver advertises rwnd = 0?',
  'The TCP connection is terminated immediately',
  'The sender stops transmitting data but continues sending 1-byte probe segments to detect when the receiver has buffer space again',
  'The sender doubles its send rate to clear the receiver buffer faster',
  'The sender ignores rwnd and uses only cwnd for rate control',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> When rwnd = 0, the sender must stop sending. To avoid deadlock (both sides waiting indefinitely), the sender periodically sends a 1-byte "window probe" segment. When the receiver frees buffer space, it sends a window update.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tcp');

-- Q34 — UDP application suitability (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='udp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which application is best suited to use UDP rather than TCP?',
  'A web browser downloading an HTML page',
  'An online banking transaction application',
  'A real-time video streaming or VoIP application',
  'A file transfer application requiring data integrity',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> Real-time applications (VoIP, live video, gaming) prefer UDP because the overhead and delay introduced by TCP''s reliability mechanisms (retransmission, ordering) makes real-time playback worse. A few dropped frames are acceptable; latency is not.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('udp');

-- Q35 — TCP port number range (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='udp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Port numbers are 16-bit unsigned integers. What is the maximum number of distinct port numbers available?',
  '1024',
  '32768',
  '65535',
  '65536',
  'D',
  '<p><strong>✓ Answer: D.</strong></p><p><strong>Rationale:</strong> 16 bits allows $2^{16} = 65536$ values (0 through 65535). Ports 0-1023 are well-known, 1024-49151 are registered, and 49152-65535 are dynamic/ephemeral.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tcp','udp');

-- Q36 — TCP TIME_WAIT state (hard)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tcp-connect' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','hard',2,
  'After the active-close side sends its final ACK in TCP connection termination, it enters the TIME_WAIT state for 2×MSL. What is the purpose of this wait?',
  'To allow the passive-close side to re-establish the connection',
  'To ensure any delayed packets from the old connection expire before a new connection with the same 4-tuple is opened, and to allow the final ACK to be retransmitted if lost',
  'To free kernel resources associated with the socket immediately',
  'To send a gratuitous ARP for the freed port number',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> TIME_WAIT (2×MSL ≈ 60–120 seconds) serves two purposes: (1) ensures in-flight packets from the closing connection die before a new connection reuses the same 4-tuple; (2) if the final ACK was lost, the passive side will retransmit FIN and TIME_WAIT allows the active side to retransmit the ACK.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('tcp');

-- Q37 — HTTP persistent connections (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='http-ftp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'HTTP/1.1 introduced persistent connections by default. What key advantage does this provide over HTTP/1.0 non-persistent connections?',
  'Eliminates the need for TCP entirely for web traffic',
  'Multiple HTTP request/response pairs can be sent over a single TCP connection, avoiding repeated three-way handshake overhead',
  'Encrypts all HTTP traffic automatically without TLS',
  'Allows the server to push content to the client without a request',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> HTTP/1.0 opened a new TCP connection for each object on a page (each needing a 3-way handshake and slow start). HTTP/1.1 persistent connections reuse the same TCP connection for multiple requests, significantly reducing latency.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dns-http');

-- Q38 — DNS hierarchy (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dns' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'In the DNS resolution process, which server is queried first by the local DNS resolver when no cached entry is available?',
  'The Authoritative Name Server for the target domain',
  'A Top-Level Domain (TLD) server',
  'A Root Name Server',
  'The ISP''s recursive resolver',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The DNS resolution hierarchy starts at the Root servers (13 root server clusters), which direct the resolver to the appropriate TLD server (.com, .org, etc.), which in turn directs to the authoritative name server for the specific domain.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dns-http');

-- Q39 — DNS record types (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dns' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'Which DNS record type maps a domain name to an IPv4 address?',
  'CNAME',
  'MX',
  'A',
  'PTR',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> The DNS record types: A (hostname → IPv4), AAAA (hostname → IPv6), CNAME (alias → canonical name), MX (domain → mail server), PTR (IP → hostname, reverse DNS), NS (domain → name server).</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dns-http');

-- Q40 — FTP active vs passive (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='http-ftp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'FTP uses two separate TCP connections. Which role do these two connections serve?',
  'One for authentication and one for data encryption',
  'One control connection (port 21) for commands and one data connection (port 20 in active mode) for file transfer',
  'One for upstream data and one for downstream data simultaneously',
  'One TCP connection for small files and one UDP connection for large files',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> FTP separates control (commands/responses on port 21) from data transfer (on port 20 for active mode, or a negotiated port in passive mode). This allows commands to be issued while a transfer is in progress.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dns-http');

-- Q41 — SSL/TLS position in stack (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='security' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'TLS (Transport Layer Security) operates between which protocol layers?',
  'Between the Physical and Data Link layers',
  'Between the Network and Transport layers',
  'Between the Transport (TCP) and Application layers',
  'Inside the Application layer, replacing HTTP entirely',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> TLS sits between TCP and the application (HTTP, SMTP, FTP). It provides encryption, authentication (via certificates), and integrity checking as a transparent shim — applications write to a TLS socket just as they would a regular TCP socket.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cn-security');

-- Q42 — Symmetric vs Asymmetric encryption (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='security' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'Which statement correctly contrasts symmetric and asymmetric (public-key) encryption?',
  'Symmetric encryption uses two different keys; asymmetric uses the same key for both operations',
  'Symmetric encryption uses the same key for encryption and decryption; asymmetric uses a public/private key pair',
  'Asymmetric encryption is always faster than symmetric encryption',
  'Symmetric encryption cannot be used for bulk data; asymmetric encryption can',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Symmetric (AES, DES) is fast but requires secure key distribution. Asymmetric (RSA, ECC) solves key distribution via a public/private pair but is orders of magnitude slower. In practice, TLS uses asymmetric cryptography to exchange a symmetric session key.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cn-security');

-- Q43 — Digital signature purpose (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='security' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A digital signature is created by encrypting a message digest with the sender''s private key. What security properties does this provide?',
  'Confidentiality and compression',
  'Authentication (proof of sender identity) and non-repudiation (sender cannot deny sending)',
  'Only encryption — the message content remains readable',
  'Key exchange — it is used to distribute symmetric keys',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> Only the owner of the private key can create the signature. Anyone with the public key can verify it. This proves the sender''s identity (authentication) and prevents the sender from later denying authorship (non-repudiation). Note: digital signatures do not provide confidentiality.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cn-security');

-- Q44 — Firewall types (medium)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='security' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','medium',2,
  'A stateful firewall differs from a stateless packet filter in that it:',
  'Operates only at the application layer, inspecting HTTP and FTP payloads',
  'Tracks the state of active connections and allows reply packets belonging to established connections automatically',
  'Blocks all inbound traffic regardless of connection state',
  'Uses cryptographic hashes to verify every packet''s integrity',
  'B',
  '<p><strong>✓ Answer: B.</strong></p><p><strong>Rationale:</strong> A stateless filter evaluates each packet in isolation (src/dst IP, port, protocol). A stateful firewall maintains a connection table, automatically permitting inbound ACK packets that belong to an outbound TCP session — providing much finer-grained control.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('cn-security');

-- Q45 — SMTP protocol (easy)
WITH q AS (INSERT INTO questions (subject_id,chapter_id,topic_id,exam_slug,is_pyq,gate_year,type,difficulty,marks,question_text,option_a,option_b,option_c,option_d,correct_option,explanation) VALUES (
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='http-ftp' LIMIT 1),
  'gate-cse',false,NULL,'MCQ','easy',1,
  'SMTP (Simple Mail Transfer Protocol) is used for:',
  'Retrieving email from a mail server to a client',
  'Transferring files securely between hosts',
  'Sending email from a client to a mail server, and between mail servers',
  'Resolving mail server domain names to IP addresses',
  'C',
  '<p><strong>✓ Answer: C.</strong></p><p><strong>Rationale:</strong> SMTP (port 25/587) handles the sending and relaying of email. It is a push protocol. POP3 and IMAP are separate protocols used by clients to retrieve (pull) email from a mail server.</p>'
) RETURNING id)
INSERT INTO question_tags (question_id,tag_id) SELECT q.id,t.id FROM q,tags t WHERE t.slug IN ('dns-http');

-- Part 4 Complete.
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
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CN PYQ SEED v2  (Part 7 / 8)
-- Flashcards Part 1: Data Link & Network Layer (11 Cards)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES

-- Card 1 — Hamming Distance
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='framing' LIMIT 1),
  'What Hamming distances are needed to detect $d$ errors and to correct $d$ errors?',
  '<p>To <strong>detect</strong> up to $d$ errors: Hamming distance ≥ $d + 1$.<br>To <strong>correct</strong> up to $d$ errors: Hamming distance ≥ $2d + 1$.</p>',
  ARRAY['data-link']
),

-- Card 2 — CRC
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='framing' LIMIT 1),
  'How does CRC (Cyclic Redundancy Check) work?',
  '<p>The sender treats the data as a binary polynomial, divides it by a generator polynomial, and appends the remainder as the checksum. The receiver performs the same division — a non-zero remainder indicates an error.</p>',
  ARRAY['data-link']
),

-- Card 3 — ARQ Window Sizes
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='error-ctrl' LIMIT 1),
  'Compare maximum window sizes for Go-Back-N and Selective Repeat with $n$-bit sequence numbers.',
  '<ul><li><strong>Go-Back-N:</strong> Max window = $2^n - 1$</li><li><strong>Selective Repeat:</strong> Max window = $2^{n-1}$</li></ul><p>SR''s smaller limit ensures sender and receiver windows never overlap — old and new frames remain distinguishable.</p>',
  ARRAY['data-link']
),

-- Card 4 — CSMA/CD Minimum Frame Size
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='mac' LIMIT 1),
  'Why does CSMA/CD impose a minimum frame size requirement?',
  '<p>A transmitting station must still be transmitting when the collision signal arrives back from the far end. Therefore, frame transmission time must be ≥ 2 × end-to-end propagation delay. Minimum frame size = Bandwidth × 2 × propagation delay.</p>',
  ARRAY['data-link']
),

-- Card 5 — Switch MAC Learning
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='switching' LIMIT 1),
  'How does an Ethernet switch learn MAC addresses and forward frames?',
  '<p>A switch maintains a MAC address table. When a frame arrives, the switch records the source MAC and its incoming port. It then looks up the destination MAC: if found, it forwards only to that port; if unknown, it floods to all ports except the one received on.</p>',
  ARRAY['data-link']
),

-- Card 6 — IP Subnetting Formula
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-addr' LIMIT 1),
  'Given a /$n$ prefix, how many total addresses and usable hosts does the subnet have?',
  '<ul><li><strong>Total addresses:</strong> $2^{32-n}$</li><li><strong>Usable hosts:</strong> $2^{32-n} - 2$ (subtract network and broadcast)</li></ul><p>Example: /26 → 64 total, 62 usable hosts.</p>',
  ARRAY['ip','subnetting']
),

-- Card 7 — ARP vs RARP
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='nat-dhcp' LIMIT 1),
  'What is the difference between ARP and RARP?',
  '<p><strong>ARP</strong> (Address Resolution Protocol): maps a known IP address → MAC address by broadcasting a request on the local network.<br><strong>RARP</strong> (Reverse ARP): maps a known MAC address → IP address (obsolete, replaced by DHCP).</p>',
  ARRAY['ip']
),

-- Card 8 — Distance Vector vs Link State
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='routing' LIMIT 1),
  'Compare Distance Vector and Link State routing algorithms.',
  '<table><tr><th></th><th>Distance Vector</th><th>Link State</th></tr><tr><td>Algorithm</td><td>Bellman-Ford</td><td>Dijkstra</td></tr><tr><td>Knowledge</td><td>Neighbour tables only</td><td>Full topology (flooded LSAs)</td></tr><tr><td>Convergence</td><td>Slower, count-to-infinity risk</td><td>Faster, stable</td></tr><tr><td>Example</td><td>RIP</td><td>OSPF</td></tr></table>',
  ARRAY['cn-routing']
),

-- Card 9 — NAT
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='nat-dhcp' LIMIT 1),
  'How does NAT (Network Address Translation) work?',
  '<p>A NAT router maintains a table mapping (private IP, private port) ↔ (public IP, public port). Outbound packets have their private source replaced with the public IP. Inbound packets are reverse-mapped using the table to route to the correct internal host.</p>',
  ARRAY['ip']
),

-- Card 10 — Count to Infinity
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='routing' LIMIT 1),
  'What is the Count-to-Infinity problem and how is it mitigated?',
  '<p>In Distance Vector routing, when a link fails, routers may iteratively advertise incrementally larger (but incorrect) distances, slowly counting up to infinity before converging. Mitigations: <strong>Split Horizon</strong> (don''t advertise a route back to the neighbour you learned it from), <strong>Poison Reverse</strong> (advertise the route back with metric = infinity).</p>',
  ARRAY['cn-routing']
),

-- Card 11 — IP TTL & Fragmentation
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-proto' LIMIT 1),
  'Explain IP TTL and IPv4 fragmentation reassembly.',
  '<p><strong>TTL:</strong> Each router decrements the TTL field by 1. When TTL = 0, the packet is dropped and an ICMP Time Exceeded message is sent — preventing infinite routing loops.<br><strong>Fragmentation:</strong> IPv4 allows routers to fragment oversized datagrams. Reassembly occurs only at the final destination host, not at intermediate routers.</p>',
  ARRAY['ip']
);

-- Part 7 Complete.
-- ═══════════════════════════════════════════════════════════════════════════
-- EXAMFORGE — CN PYQ SEED v2  (Part 8 / 8)
-- Flashcards Part 2: Transport & Application Layer (11 Cards) + COMMIT
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO flashcards (subject_id,chapter_id,topic_id,front,back,tags) VALUES

-- Card 12 — TCP Three-Way Handshake
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tcp-connect' LIMIT 1),
  'Describe the TCP three-way handshake for connection establishment.',
  '<ol><li><strong>SYN:</strong> Client sends a segment with SYN flag set and its Initial Sequence Number (ISN).</li><li><strong>SYN-ACK:</strong> Server responds with SYN and ACK flags, acknowledging the client ISN and announcing its own ISN.</li><li><strong>ACK:</strong> Client acknowledges the server ISN. Connection is now established.</li></ol>',
  ARRAY['tcp']
),

-- Card 13 — TCP Congestion Control Phases
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='flow-ctrl' LIMIT 1),
  'Describe the three phases of TCP Reno congestion control.',
  '<ol><li><strong>Slow Start:</strong> cwnd starts at 1 MSS and doubles every RTT (exponential) until ssthresh is reached.</li><li><strong>Congestion Avoidance:</strong> cwnd increases by 1 MSS per RTT (linear / AIMD) above ssthresh.</li><li><strong>Fast Recovery:</strong> On 3 duplicate ACKs — ssthresh = cwnd/2, cwnd = ssthresh, continue linear growth. On timeout — ssthresh = cwnd/2, cwnd = 1 MSS, restart Slow Start.</li></ol>',
  ARRAY['tcp','congestion']
),

-- Card 14 — TCP vs UDP Comparison
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='udp' LIMIT 1),
  'Compare TCP and UDP across key dimensions.',
  '<table><tr><th>Property</th><th>TCP</th><th>UDP</th></tr><tr><td>Connection</td><td>Connection-oriented</td><td>Connectionless</td></tr><tr><td>Reliability</td><td>Guaranteed (ACKs, retransmit)</td><td>Best-effort</td></tr><tr><td>Ordering</td><td>In-order delivery</td><td>Not guaranteed</td></tr><tr><td>Flow Control</td><td>Yes (rwnd)</td><td>No</td></tr><tr><td>Use cases</td><td>Web, email, file transfer</td><td>DNS, VoIP, streaming, gaming</td></tr></table>',
  ARRAY['tcp','udp']
),

-- Card 15 — Bandwidth-Delay Product
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='transport-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='tcp-basics' LIMIT 1),
  'What is the Bandwidth-Delay Product (BDP) and why does it matter?',
  '<p><strong>BDP = Bandwidth × RTT</strong><br>It represents the number of bits that fill the network "pipe" end-to-end. A sender''s window (TCP cwnd or a sliding window) must be at least BDP bits large to fully utilise the link. A smaller window leaves the pipe partially empty, wasting capacity.</p>',
  ARRAY['tcp']
),

-- Card 16 — Stop-and-Wait vs Sliding Window Efficiency
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='data-link' LIMIT 1),
  (SELECT id FROM topics WHERE slug='error-ctrl' LIMIT 1),
  'Compare channel utilization of Stop-and-Wait and Sliding Window protocols.',
  '<p>Let $a = T_{prop}/T_{frame}$.<br><strong>Stop-and-Wait:</strong> Efficiency = $\frac{1}{1+2a}$ (very poor when $a \gg 1$).<br><strong>Sliding Window (window W):</strong><br>If $W \geq 1+2a$: Efficiency = 1 (100%).<br>If $W < 1+2a$: Efficiency = $\frac{W}{1+2a}$.</p>',
  ARRAY['data-link']
),

-- Card 17 — DNS Resolution Process
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='dns' LIMIT 1),
  'Describe the iterative DNS resolution process for resolving www.example.com.',
  '<ol><li>Client queries Local Resolver (ISP or configured DNS server).</li><li>Local Resolver queries a Root Name Server → directed to .com TLD server.</li><li>Local Resolver queries .com TLD server → directed to example.com''s authoritative NS.</li><li>Local Resolver queries authoritative NS → receives IP address.</li><li>IP is cached (per TTL) and returned to client.</li></ol>',
  ARRAY['dns-http']
),

-- Card 18 — HTTP Persistent vs Non-Persistent
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='http-ftp' LIMIT 1),
  'Contrast HTTP non-persistent (HTTP/1.0) and persistent (HTTP/1.1) connections.',
  '<p><strong>Non-persistent:</strong> Each object requires a new TCP connection (1 RTT handshake + 1 RTT request = 2 RTTs per object). High overhead for pages with many objects.<br><strong>Persistent:</strong> Multiple request/response pairs share one TCP connection. Pipelining further allows multiple outstanding requests, significantly reducing total RTTs.</p>',
  ARRAY['dns-http']
),

-- Card 19 — TLS Handshake Overview
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='security' LIMIT 1),
  'What security properties does TLS provide and at which layer does it operate?',
  '<p>TLS operates between TCP and the Application layer (session layer conceptually). It provides three guarantees:<br>1. <strong>Confidentiality</strong> — data encrypted with a session symmetric key.<br>2. <strong>Authentication</strong> — server''s identity verified via X.509 certificate signed by a CA.<br>3. <strong>Integrity</strong> — HMAC tags detect any tampering in transit.</p>',
  ARRAY['cn-security']
),

-- Card 20 — Symmetric vs Asymmetric Encryption
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='security' LIMIT 1),
  'When is asymmetric (public-key) cryptography used vs symmetric cryptography in practice?',
  '<p><strong>Asymmetric</strong> (RSA, ECC): Used during the TLS handshake for key exchange and authentication. Slow — unsuitable for bulk data encryption.<br><strong>Symmetric</strong> (AES, ChaCha20): Used for actual data encryption after the handshake establishes a shared session key. Fast — used for all bulk data transfer.</p>',
  ARRAY['cn-security']
),

-- Card 21 — IPv6 Key Features
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='network-layer' LIMIT 1),
  (SELECT id FROM topics WHERE slug='ip-proto' LIMIT 1),
  'List the key differences between IPv4 and IPv6.',
  '<ul><li><strong>Address size:</strong> IPv4 = 32 bits; IPv6 = 128 bits.</li><li><strong>Header:</strong> IPv6 has a simplified fixed 40-byte header; IPv4 is variable-length.</li><li><strong>Fragmentation:</strong> IPv6 done only at source; IPv4 done at any router.</li><li><strong>Broadcast:</strong> IPv6 eliminates broadcast, using multicast/anycast instead.</li><li><strong>IPsec:</strong> Mandatory in IPv6, optional in IPv4.</li></ul>',
  ARRAY['ip']
),

-- Card 22 — Digital Signatures
(
  (SELECT id FROM subjects WHERE slug='cn'),
  (SELECT id FROM chapters WHERE slug='app-security' LIMIT 1),
  (SELECT id FROM topics WHERE slug='security' LIMIT 1),
  'How do digital signatures work and what do they guarantee?',
  '<p><strong>Creation:</strong> Sender computes a hash (digest) of the message, then encrypts the hash with their <em>private</em> key → signature.<br><strong>Verification:</strong> Receiver decrypts the signature with the sender''s <em>public</em> key, independently hashes the message, and compares the two digests.<br><strong>Guarantees:</strong> Authentication (only private key owner could sign) and Non-repudiation (sender cannot deny authorship).</p>',
  ARRAY['cn-security']
);

COMMIT;

-- ─── POST-SEED VERIFICATION QUERIES ──────────────────────────────────────
-- Run these after executing cn-seed.sql to verify data integrity:
--
-- SELECT COUNT(*) FROM topics
--   WHERE chapter_id IN (SELECT id FROM chapters
--     WHERE subject_id = (SELECT id FROM subjects WHERE slug='cn'));
-- Expected: 15
--
-- SELECT COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='cn');
-- Expected: 65
--
-- SELECT type, COUNT(*) FROM questions
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='cn')
--   GROUP BY type;
-- Expected: MCQ: 45, NAT: 10, MSQ: 10
--
-- SELECT COUNT(*) FROM flashcards
--   WHERE subject_id = (SELECT id FROM subjects WHERE slug='cn');
-- Expected: 22

-- ─── STATS COMMENT BLOCK ─────────────────────────────────────────────────
-- STATS:
-- Subject slug:  cn
-- Schema:        v2 (normalized tags, NUMERIC(10,2) NAT answers, topic enforcement)
-- Chapters:      4
-- Topics:        15
-- Questions:     65 total
--   MCQ:         45 (Q1–Q45)
--   NAT:         10 (Q46–Q55)
--   MSQ:         10 (Q56–Q65)
-- Flashcards:    22 (11 per batch, no adverb bloat)
-- ═══════════════════════════════════════════════════════════════════════════
-- END OF cn-seed.sql
-- ═══════════════════════════════════════════════════════════════════════════
