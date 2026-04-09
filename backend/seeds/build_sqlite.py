#!/usr/bin/env python3
"""
ExamForge SQLite Builder
Converts all seed SQL files into content.db
Successfully handles Postgres-specific syntax and mapping to the new simplified schema.
"""

import sqlite3
import pathlib
import json
import re
import sys

# Paths
ROOT = pathlib.Path(__file__).parent.parent
DB_PATH = ROOT / "content.db"
SCHEMA_PATH = ROOT / "seeds" / "schema.sql"
SEEDS_DIR = ROOT / "seeds" / "questions"

# Registry (Authored from prompt spec)
SUBJECTS = [
    {"id": "algo", "name": "Algorithms", "slug": "algo", "category": "GATE", "icon": "psychology", "order_index": 1},
    {"id": "cd", "name": "Compiler Design", "slug": "cd", "category": "GATE", "icon": "code", "order_index": 2},
    {"id": "cn", "name": "Computer Networks", "slug": "cn", "category": "GATE", "icon": "lan", "order_index": 3},
    {"id": "coa", "name": "Computer Organisation & Architecture", "slug": "coa", "category": "GATE", "icon": "memory", "order_index": 4},
    {"id": "cprog", "name": "C Programming", "slug": "cprog", "category": "GATE", "icon": "terminal", "order_index": 5},
    {"id": "dbms", "name": "Database Management Systems", "slug": "dbms", "category": "GATE", "icon": "database", "order_index": 6},
    {"id": "dl", "name": "Digital Logic", "slug": "dl", "category": "GATE", "icon": "schema", "order_index": 7},
    {"id": "dm", "name": "Discrete Mathematics", "slug": "dm", "category": "GATE", "icon": "functions", "order_index": 8},
    {"id": "dsa", "name": "Data Structures & Algorithms", "slug": "dsa", "category": "GATE", "icon": "account_tree", "order_index": 9},
    {"id": "em", "name": "Engineering Mathematics", "slug": "em", "category": "GATE", "icon": "calculate", "order_index": 10},
    {"id": "ga", "name": "General Aptitude", "slug": "ga", "category": "GATE", "icon": "quiz", "order_index": 11},
    {"id": "os", "name": "Operating Systems", "slug": "os", "category": "GATE", "icon": "computer", "order_index": 12},
    {"id": "toc", "name": "Theory of Computation", "slug": "toc", "category": "GATE", "icon": "auto_awesome", "order_index": 13},
    {"id": "cpp", "name": "C++ Mastery", "slug": "cpp", "category": "SKILL", "icon": "code_blocks", "order_index": 14},
    {"id": "python", "name": "Python Essentials", "slug": "python", "category": "SKILL", "icon": "terminal", "order_index": 15},
]

CHAPTERS = [
    {"id":"algo-ch-01","subject_id":"algo","slug":"algo-01-complexity-sorting-searching","title":"Complexity, Sorting & Searching","order_index":1,"has_notes":1,"notes_file":"algo-01-complexity-sorting-searching.html","has_questions":1},
    {"id":"algo-ch-02","subject_id":"algo","slug":"algo-02-graph-algorithms","title":"Graph Algorithms","order_index":2,"has_notes":1,"notes_file":"algo-02-graph-algorithms.html","has_questions":1},
    {"id":"algo-ch-03","subject_id":"algo","slug":"algo-03-dp-greedy-divide-conquer","title":"DP, Greedy & Divide-Conquer","order_index":3,"has_notes":1,"notes_file":"algo-03-dp-greedy-divide-conquer.html","has_questions":1},
    {"id":"cd-ch-01", "subject_id":"cd", "slug":"compiler-design-complete","title":"Compiler Design Complete","order_index":1,"has_notes":1,"notes_file":"compiler-design-complete.html","has_questions":1},
    {"id":"cn-ch-01", "subject_id":"cn", "slug":"cn-01-datalink-network-routing","title":"Data Link & Network Routing","order_index":1,"has_notes":1,"notes_file":"cn-01-datalink-network-routing.html","has_questions":1},
    {"id":"cn-ch-02", "subject_id":"cn", "slug":"cn-02-transport-application-1","title":"Transport & Application Layer","order_index":2,"has_notes":1,"notes_file":"cn-02-transport-application-1.html","has_questions":1},
    {"id":"coa-ch-01","subject_id":"coa", "slug":"coa-01-number-systems-boolean-circuits","title":"Number Systems & Boolean Circuits","order_index":1,"has_notes":1,"notes_file":"coa-01-number-systems-boolean-circuits.html","has_questions":1},
    {"id":"coa-ch-02","subject_id":"coa", "slug":"coa-02-cpu-isa-pipeline-memory","title":"CPU, ISA, Pipeline & Memory","order_index":2,"has_notes":1,"notes_file":"coa-02-cpu-isa-pipeline-memory.html","has_questions":1},
    {"id":"cprog-ch-01","subject_id":"cprog","slug":"c-programming-complete-1","title":"C Programming Complete","order_index":1,"has_notes":1,"notes_file":"c-programming-complete-1.html","has_questions":1},
    {"id":"dbms-ch-01","subject_id":"dbms","slug":"dbms-gate-notes-v2-1","title":"Relational Model, FDs & Normal Forms","order_index":1,"has_notes":1,"notes_file":"dbms-gate-notes-v2-1.html","has_questions":1},
    {"id":"dbms-ch-02","subject_id":"dbms","slug":"dbms-02-sql-relational-algebra-3","title":"SQL & Relational Algebra","order_index":2,"has_notes":1,"notes_file":"dbms-02-sql-relational-algebra-3.html","has_questions":1},
    {"id":"dbms-ch-03","subject_id":"dbms","slug":"dbms-03-transactions-concurrency-1","title":"Transactions & Concurrency","order_index":3,"has_notes":1,"notes_file":"dbms-03-transactions-concurrency-1.html","has_questions":1},
    {"id":"dbms-ch-04","subject_id":"dbms","slug":"dbms-04-er-indexing-relational-calculus","title":"ER, Indexing & Relational Calculus","order_index":4,"has_notes":1,"notes_file":"dbms-04-er-indexing-relational-calculus.html","has_questions":1},
    {"id":"dl-ch-01", "subject_id":"dl", "slug":"dl-01-gates-combinational","title":"Gates & Combinational Circuits","order_index":1,"has_notes":0,"notes_file":None,"has_questions":1},
    {"id":"dm-ch-01", "subject_id":"dm", "slug":"dm-01-logic-sets-relations-functions-2","title":"Logic, Sets, Relations & Functions","order_index":1,"has_notes":1,"notes_file":"dm-01-logic-sets-relations-functions-2.html","has_questions":1},
    {"id":"dm-ch-02", "subject_id":"dm", "slug":"dm-02-graph-theory-combinatorics","title":"Graph Theory & Combinatorics","order_index":2,"has_notes":1,"notes_file":"dm-02-graph-theory-combinatorics.html","has_questions":1},
    {"id":"dsa-ch-01", "subject_id":"dsa", "slug":"ds-01-linear-data-structures-2","title":"Linear Data Structures","order_index":1,"has_notes":1,"notes_file":"ds-01-linear-data-structures-2.html","has_questions":1},
    {"id":"dsa-ch-02", "subject_id":"dsa", "slug":"ds-02-trees-heaps","title":"Trees & Heaps","order_index":2,"has_notes":1,"notes_file":"ds-02-trees-heaps.html","has_questions":1},
    {"id":"em-ch-01", "subject_id":"em", "slug":"em-01-calculus-linear-algebra-probability-2","title":"Calculus, LA & Probability","order_index":1,"has_notes":1,"notes_file":"em-01-calculus-linear-algebra-probability-2.html","has_questions":1},
    {"id":"em-ch-02", "subject_id":"em", "slug":"em-02-differential-equations-numerical-methods","title":"DE & Numerical Methods","order_index":2,"has_notes":1,"notes_file":"em-02-differential-equations-numerical-methods.html","has_questions":1},
    {"id":"os-ch-01", "subject_id":"os", "slug":"os-01-processes-scheduling-synchronization","title":"Processes & Synchronization","order_index":1,"has_notes":1,"notes_file":"os-01-processes-scheduling-synchronization.html","has_questions":1},
    {"id":"os-ch-02", "subject_id":"os", "slug":"os-02-memory-filesystems-io","title":"Memory & Filesystems","order_index":2,"has_notes":1,"notes_file":"os-02-memory-filesystems-io.html","has_questions":1},
    {"id":"toc-ch-01", "subject_id":"toc", "slug":"toc-01-automata-grammars","title":"Automata & Grammars","order_index":1,"has_notes":1,"notes_file":"toc-01-automata-grammars.html","has_questions":1},
    {"id":"toc-ch-02", "subject_id":"toc", "slug":"toc-02-turing-decidability","title":"Turing & Decidability","order_index":2,"has_notes":1,"notes_file":"toc-02-turing-decidability.html","has_questions":1},
    {"id":"ga-ch-01", "subject_id":"ga", "slug":"aptitude-quantitative-master","title":"Quantitative Aptitude","order_index":1,"has_notes":1,"notes_file":"aptitude-quantitative-master.html","has_questions":1},
    {"id":"ga-ch-02", "subject_id":"ga", "slug":"aptitude-verbal-master","title":"Verbal Aptitude","order_index":2,"has_notes":1,"notes_file":"aptitude-verbal-master.html","has_questions":1},
    {"id":"cpp-ch-01", "subject_id":"cpp", "slug":"cpp-01-foundations","title":"C++ Foundations","order_index":1,"has_notes":1,"notes_file":"cpp-01-foundations.html","has_questions":1},
    {"id":"cpp-ch-02", "subject_id":"cpp", "slug":"cpp-02-oop","title":"Object Oriented Programming","order_index":2,"has_notes":1,"notes_file":"cpp-02-oop.html","has_questions":1},
]

def build():
    if DB_PATH.exists():
        DB_PATH.unlink()
    
    conn = sqlite3.connect(str(DB_PATH))
    cursor = conn.cursor()

    # 1. Initialize Schema
    print(f"[*] Initializing schema from {SCHEMA_PATH.name}...")
    with open(SCHEMA_PATH, 'r', encoding='utf-8') as f:
        cursor.executescript(f.read())
    
    # 2. Insert Subjects
    print(f"[*] Seeding {len(SUBJECTS)} subjects...")
    for s in SUBJECTS:
        cursor.execute("""
            INSERT INTO subjects (id, name, slug, category, icon, order_index)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (s['id'], s['name'], s['slug'], s['category'], s['icon'], s['order_index']))

    # 3. Insert Chapters
    print(f"[*] Seeding {len(CHAPTERS)} chapters...")
    for c in CHAPTERS:
        cursor.execute("""
            INSERT INTO chapters (id, subject_id, slug, title, order_index, has_notes, notes_file, has_questions)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """, (c['id'], c['subject_id'], c['slug'], c['title'], c['order_index'], c['has_notes'], c['notes_file'], c['has_questions']))

    # 4. Process Seed Files
    print(f"[*] Scanning {SEEDS_DIR} for question seeds...")
    seed_files = sorted(list(SEEDS_DIR.glob("*.sql")))
    
    # Pre-map slugs to IDs for faster lookup
    subject_slug_to_id = {s['slug']: s['id'] for s in SUBJECTS}
    chapter_slug_to_id = {c['slug']: c['id'] for c in CHAPTERS}

    total_questions = 0
    for seed_file in seed_files:
        print(f"    [-] Processing {seed_file.name}...")
        with open(seed_file, 'r', encoding='utf-8') as f:
            content = f.read()

        # Transformation Regexes
        # a) Remove Postgres blocks (DO $$ ... END $$;)
        content = re.sub(r'DO \$\$.*?END \$\$;', '', content, flags=re.DOTALL)
        
        # b) Handle WITH q AS (INSERT INTO questions ...) RETURNING id
        # This is a bit tricky. We want to extract the INSERT part and simplify it.
        # We'll use a regex to pick out the columns and values from the legacy format.
        
        # Extract individual INSERTs
        # Legacy: WITH q AS (INSERT INTO questions (subj, chap, topic, exam, pyq, year, type, diff, marks, text, a, b, c, d, correct, expl) VALUES (...) RETURNING id)
        # Target: INSERT INTO questions (subject_id, chapter_id, stem, type, option_a, option_b, option_c, option_d, correct_option, explanation, difficulty, gate_year, marks, is_pyq)
        
        q_pattern = re.compile(r'WITH q AS \(INSERT INTO questions \((.*?)\) VALUES \((.*?)\) RETURNING id\)', re.DOTALL)
        matches = q_pattern.findall(content)
        
        for cols_str, values_str in matches:
            cols = [c.strip() for c in cols_str.split(',')]
            
            # Use a smart value splitter that respects quoted strings
            values = []
            curr = ""
            in_quote = False
            for char in values_str:
                if char == "'" and (not curr or curr[-1] != "\\"):
                    in_quote = not in_quote
                if char == "," and not in_quote:
                    values.append(curr.strip())
                    curr = ""
                else:
                    curr += char
            values.append(curr.strip())

            # Map legacy columns to new values
            val_map = dict(zip(cols, values))
            
            # Resolve subject_id and chapter_id from (SELECT id FROM ...) parts
            subj_match = re.search(r"slug\s*=\s*'([^']+)'", val_map.get('subject_id', ''))
            subj_id = None
            if subj_match:
                subj_slug = subj_match.group(1)
                subj_id = subject_slug_to_id.get(subj_slug)
            
            chap_match = re.search(r"slug\s*=\s*'([^']+)'", val_map.get('chapter_id', ''))
            chap_id = None
            if chap_match:
                chap_slug = chap_match.group(1)
                # Some slugs in seeds might be partial or different, try to match
                chap_id = chapter_slug_to_id.get(chap_slug)
                if not chap_id:
                    # Fallback: find chapter starting with this slug or similar
                    for c_slug, c_id in chapter_slug_to_id.items():
                        if chap_slug in c_slug:
                            chap_id = c_id
                            break

            # If still no subj/chap, try to guess from filename
            if not subj_id:
                file_slug = seed_file.name.split('-')[0]
                subj_id = subject_slug_to_id.get(file_slug)

            # Cleanup values (remove '::text', etc.)
            def clean_val(v):
                v = v.strip()
                if v.lower() == 'null': return None
                v = re.sub(r'::[a-zA-Z]+', '', v)
                if v.startswith("'") and v.endswith("'"):
                    return v[1:-1].replace("''", "'")
                return v

            # Construct new insert
            new_data = {
                "subject_id": subj_id or "algo", # Default fallback
                "chapter_id": chap_id,
                "stem": clean_val(val_map.get('question_text', '')),
                "type": clean_val(val_map.get('type', 'MCQ')),
                "option_a": clean_val(val_map.get('option_a', '')),
                "option_b": clean_val(val_map.get('option_b', '')),
                "option_c": clean_val(val_map.get('option_c', '')),
                "option_d": clean_val(val_map.get('option_d', '')),
                "correct_option": clean_val(val_map.get('correct_option', '')),
                "explanation": clean_val(val_map.get('explanation', '')),
                "difficulty": clean_val(val_map.get('difficulty', 'medium')).lower(),
                "gate_year": int(clean_val(val_map.get('gate_year', '0'))) if clean_val(val_map.get('gate_year', '0')) and clean_val(val_map.get('gate_year', '0')).isdigit() else None,
                "marks": float(clean_val(val_map.get('marks', '1.0'))) if clean_val(val_map.get('marks', '1.0')) else 1.0,
                "is_pyq": 1 if clean_val(val_map.get('is_pyq', 'false')).lower() == 'true' else 0
            }

            cursor.execute("""
                INSERT INTO questions (
                    subject_id, chapter_id, stem, type, 
                    option_a, option_b, option_c, option_d, 
                    correct_option, explanation, difficulty, gate_year, marks, is_pyq
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                new_data["subject_id"], new_data["chapter_id"], new_data["stem"], new_data["type"],
                new_data["option_a"], new_data["option_b"], new_data["option_c"], new_data["option_d"],
                new_data["correct_option"], new_data["explanation"], new_data["difficulty"],
                new_data["gate_year"], new_data["marks"], new_data["is_pyq"]
            ))
            total_questions += 1

    conn.commit()
    print(f"\n[+] SUCCESS! Build complete.")
    print(f"    - Database: {DB_PATH}")
    print(f"    - Questions loaded: {total_questions}")
    conn.close()

if __name__ == "__main__":
    build()
