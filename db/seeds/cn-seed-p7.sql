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
