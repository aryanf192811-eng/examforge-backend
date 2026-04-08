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
