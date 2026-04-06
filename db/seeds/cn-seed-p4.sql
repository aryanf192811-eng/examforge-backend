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
