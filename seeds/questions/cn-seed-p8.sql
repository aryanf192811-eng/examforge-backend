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
