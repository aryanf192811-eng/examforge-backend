import os
import re
import sys
import glob
import json
import urllib.request

def load_env_manual(filepath):
    if not os.path.exists(filepath):
        return
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if '=' in line and not line.startswith('#'):
                key, val = line.split('=', 1)
                val = val.strip("'\"")
                os.environ[key.strip()] = val

load_env_manual(".env")
load_env_manual("examforge-backend/.env")

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_SERVICE_KEY = os.getenv("SUPABASE_SERVICE_KEY")

if not SUPABASE_URL or not SUPABASE_SERVICE_KEY:
    print("❌ Error: SUPABASE_URL or SUPABASE_SERVICE_KEY not found.")
    sys.exit(1)

SUPABASE_URL = SUPABASE_URL.strip("/")

def transform_val(val):
    val = val.strip()
    if not val:
        return None
    # Handle (SELECT id FROM subjects WHERE slug='...')
    m = re.search(r"slug='([^']+)'", val)
    if m:
        return m.group(1)
    # Handle NULL
    if val.upper() == "NULL":
        return None
    # Handle BOOLEAN
    if val.lower() == "true":
        return True
    if val.lower() == "false":
        return False
    # Handle String cleanup
    if val.startswith("'") and val.endswith("'"):
        val = val[1:-1].replace("''", "'")
    return val

def parse_sql(content):
    # This regex is specifically for the WITH q AS (INSERT INTO questions ... VALUES (...) RETURNING id) format
    pattern = re.compile(
        r"INSERT INTO questions\s*\([^)]+\)\s*VALUES\s*\((.*?)\)\s*RETURNING id",
        re.DOTALL | re.IGNORECASE
    )
    
    matches = pattern.findall(content)
    parsed = []
    
    for m in matches:
        tokens = []
        current = ""
        in_string = False
        i = 0
        while i < len(m):
            c = m[i]
            if c == "'":
                if i + 1 < len(m) and m[i+1] == "'": # Escaped quote
                    current += "'"
                    i += 1 # Skip next
                else:
                    in_string = not in_string
                    current += "'"
            elif c == "," and not in_string:
                tokens.append(current.strip())
                current = ""
            else:
                current += c
            i += 1
        tokens.append(current.strip())
        
        if len(tokens) >= 16:
            # Indices for ExamForge v2 seeds:
            # 0:subj_id, 1:chap_id, 2:topic_id, 3:exam, 4:pyq, 5:year, 6:type, 7:diff, 8:marks, 9:text, 10:a, 11:b, 12:c, 13:d, 14:cor, 15:expl
            
            try:
                def to_int(v):
                    if v is None: return None
                    v_clean = str(v).strip("'").strip()
                    if v_clean.upper() == "NULL" or not v_clean: return None
                    return int(v_clean)

                q = {
                    "subject_slug": transform_val(tokens[0]),
                    "chapter_slug": transform_val(tokens[1]),
                    "question_text": transform_val(tokens[9]),
                    "option_a": transform_val(tokens[10]),
                    "option_b": transform_val(tokens[11]),
                    "option_c": transform_val(tokens[12]),
                    "option_d": transform_val(tokens[13]),
                    "correct_option": (transform_val(tokens[14]) or "A")[:1],
                    "explanation": transform_val(tokens[15]),
                    "difficulty": str(transform_val(tokens[7]) or "medium").lower(),
                    "marks": to_int(transform_val(tokens[8])) or 1,
                    "is_pyq": transform_val(tokens[4]) == True,
                    "gate_year": to_int(transform_val(tokens[5]))
                }
                parsed.append(q)
            except Exception as e:
                print(f"    ⚠️ Skipping row due to parse error: {e}")
            
    return parsed

def post_to_supabase(questions):
    url = f"{SUPABASE_URL}/rest/v1/questions"
    headers = {
        "apikey": SUPABASE_SERVICE_KEY,
        "Authorization": f"Bearer {SUPABASE_SERVICE_KEY}",
        "Content-Type": "application/json",
        "Prefer": "return=minimal"
    }
    
    req = urllib.request.Request(url, data=json.dumps(questions).encode(), headers=headers, method="POST")
    try:
        with urllib.request.urlopen(req) as res:
            return res.status
    except Exception as e:
        # Check for body
        if hasattr(e, 'read'):
            print(f"    ❌ DB Error: {e.read().decode()}")
        else:
            print(f"    ❌ Error: {e}")
        return None

def main():
    sql_files = glob.glob("seeds/questions/*.sql")
    sql_files.sort()
    
    print(f"🚀 Starting zero-dependency seed ingestion for {len(sql_files)} files...")
    
    total_processed = 0
    for fpath in sql_files:
        fname = os.path.basename(fpath)
        with open(fpath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        questions = parse_sql(content)
        if not questions:
            continue
            
        print(f"  📦 {fname}: {len(questions)} questions. Sending...")
        
        batch_size = 40
        for i in range(0, len(questions), batch_size):
            batch = questions[i:i+batch_size]
            status = post_to_supabase(batch)
            if status in [200, 201, 204]:
                total_processed += len(batch)
            else:
                print(f"    ⚠️ Failed batch at index {i}")

    print(f"\n✨ Ingestion complete. Total questions processed: {total_processed}")

if __name__ == "__main__":
    main()
