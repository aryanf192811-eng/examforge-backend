import os
import re
from supabase import create_client, Client
from dotenv import load_dotenv

load_dotenv("c:/Users/aryan/Desktop/examforge final/examforge-backend/.env")

url: str = os.getenv("VITE_SUPABASE_URL", os.getenv("SUPABASE_URL"))
key: str = os.getenv("VITE_SUPABASE_SERVICE_ROLE_KEY", os.getenv("SUPABASE_SERVICE_ROLE_KEY"))

if not url or not key:
    print("Missing URL or KEY")
    exit(1)

supabase: Client = create_client(url, key)

seeds_dir = r"c:\Users\aryan\Desktop\examforge final\db\seeds"

def transform_sql(content):
    # Subjects
    content = re.sub(r'INSERT INTO subjects \(title, slug, description, gradient_start, gradient_end, icon_type\)', 
                     r'INSERT INTO subjects (name, slug, description, gradient_start, gradient_end, icon)', content)
    # Chapters
    content = re.sub(r'INSERT INTO chapters \(subject_id, title, slug, sort_order\)', 
                     r'INSERT INTO chapters (subject_id, name, slug, order_index)', content)
    # Topics
    content = re.sub(r'INSERT INTO topics \(chapter_id, slug, title, sort_order\)', 
                     r'INSERT INTO topics (chapter_id, slug, name, order_index)', content)

    # Strip transaction controls
    content = re.sub(r'\bBEGIN;\b', '', content, flags=re.IGNORECASE)
    content = re.sub(r'\bCOMMIT;\b', '', content, flags=re.IGNORECASE)
    content = re.sub(r'\bROLLBACK;\b', '', content, flags=re.IGNORECASE)
    
    return content

success = 0
failed = 0

files = sorted([f for f in os.listdir(seeds_dir) if f.endswith('.sql')])
for idx, filename in enumerate(files):
    filepath = os.path.join(seeds_dir, filename)
    with open(filepath, 'r', encoding='utf-8') as f:
        query = transform_sql(f.read())
        
    try:
        response = supabase.rpc('execute_sql_script', {'sql_query': query}).execute()
        print(f"[{idx+1}/{len(files)}] Executed {filename}")
        success += 1
    except Exception as e:
        print(f"[{idx+1}/{len(files)}] Failed {filename}: {e}")
        failed += 1

print(f"Done. Success: {success}, Failed: {failed}")
