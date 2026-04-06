import psycopg2

configs = [
    {'host': 'aws-0-ap-south-1.pooler.supabase.com', 'port': 6543, 'user': 'postgres.ahcgguknfkuapsfakmiy'},
    {'host': 'aws-0-ap-south-1.pooler.supabase.com', 'port': 5432, 'user': 'postgres.ahcgguknfkuapsfakmiy'},
    {'host': 'db.ahcgguknfkuapsfakmiy.supabase.co',  'port': 5432, 'user': 'postgres'},
]

for c in configs:
    try:
        conn = psycopg2.connect(
            host=c['host'], port=c['port'],
            dbname='postgres', user=c['user'],
            password='fy@/8uzPzTwrnAM',
            connect_timeout=10, sslmode='require'
        )
        print(f"SUCCESS: {c['host']}:{c['port']} user={c['user']}")
        conn.close()
    except Exception as e:
        print(f"FAIL {c['host']}:{c['port']}: {e}")
