import re
import glob

files = glob.glob("algo-seed-p*.sql")
# Sort files to ensure p1 to p8 order
files.sort()

words_to_strip = [
    "strictly", "purely", "solidly", "definitively", "explicitly", "precisely", "firmly", 
    "cleanly", "flawlessly", "safely", "identically", "correctly", "efficiently", 
    "uniquely", "absolutely", "rigorously", "completely", "securely", "inherently", 
    "distinctly", "expressly", "unconditionally", "reliably", "deeply", "strongly", 
    "thoroughly", "conclusively", "genuinely", "neatly", "decisively", "positively",
    "consistently", "tightly", "smoothly", "squarely", "uniformly", "universally",
    "heavily", "comprehensively", "robustly", "entirely", "seamlessly", "intensely", 
    "powerfully", "profundly", "profoundly", "vividly", "vigorously", "solely", "undeniably", 
    "independently", "tracking", "checking", "mapping", "structurally", "evaluating", 
    "defining", "validating", "analyzing", "measuring", "identifying", "computations", 
    "resolving", "configurations", "parameters", "executing", "generating", "combinations", 
    "determining", "essentially", "logically", "formally", "parsing", "lengths", "sizes", "boundaries"
]

pattern = re.compile(r"\b(?:" + "|".join(words_to_strip) + r")\b\s*", re.IGNORECASE)

combined_content = ""

for f in files:
    try:
        with open(f, "r", encoding="utf-8") as file:
            content = file.read()
            
        content = pattern.sub("", content)
        content = re.sub(r" +", " ", content)
        
        with open(f, "w", encoding="utf-8") as file:
            file.write(content)
            
        print(f"Cleaned up {f}")
        
        combined_content += "\n\n" + content
    except Exception as e:
        print(f"Error on {f}: {e}")

with open("algo-seed.sql", "w", encoding="utf-8") as f:
    f.write(combined_content.strip())
print("Successfully generated combined algo-seed.sql")
