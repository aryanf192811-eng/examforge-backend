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
