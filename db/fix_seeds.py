import os
import re

seeds_dir = r"c:\Users\aryan\Desktop\examforge final\db\seeds"

def fix_subjects(content):
    # 'INSERT INTO subjects (title, slug, description, gradient_start, gradient_end, icon_type)' 
    # to 'INSERT INTO subjects (name, slug, icon)' and drop the extra values.
    # Wait, simpler: replace 'title' with 'name' in column list, and let's just make sure DB has the other columns.
    content = content.replace("INSERT INTO subjects (title, slug, description, gradient_start, gradient_end, icon_type)", "INSERT INTO subjects (name, slug, description, gradient_start, gradient_end, icon_type)")
    return content

def fix_chapters(content):
    # 'INSERT INTO chapters (subject_id, title, slug, sort_order)'
    content = content.replace("INSERT INTO chapters (subject_id, title, slug, sort_order)", "INSERT INTO chapters (subject_id, title, slug, order_index)")
    return content

def fix_topics(content):
    # 'INSERT INTO topics (chapter_id, slug, title, sort_order)'
    content = content.replace("INSERT INTO topics (chapter_id, slug, title, sort_order)", "INSERT INTO topics (chapter_id, slug, name, order_index)")
    return content

# Also some questions might have issues? No, questions look okay.

for filename in os.listdir(seeds_dir):
    if not filename.endswith(".sql"): continue
    if filename == "ga-seed.sql": continue # this one is already v2
    
    filepath = os.path.join(seeds_dir, filename)
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        
    orig = content
    content = fix_subjects(content)
    content = fix_chapters(content)
    content = fix_topics(content)
    
    if orig != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Fixed schema in {filename}")

print("Done fixing sql files.")
