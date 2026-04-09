
import re
import glob

files = ["em-seed-p4.sql", "em-seed-p5.sql", "em-seed-p6.sql"]
words_to_strip = [
    "strictly", "purely", "solidly", "definitively", "explicitly", "precisely", "firmly", 
    "cleanly", "flawlessly", "safely", "identically", "correctly", "efficiently", 
    "uniquely", "absolutely", "rigorously", "completely", "securely", "inherently", 
    "distinctly", "expressly", "unconditionally", "reliably", "deeply", "strongly", 
    "thoroughly", "conclusively", "genuinely", "neatly", "decisively", "positively",
    "consistently", "tightly", "smoothly", "squarely", "uniformly", "universally",
    "heavily", "comprehensively", "robustly", "entirely", "seamlessly", "intensely", "powerfully", "profundly", "profoundly", "vividly", "vigorously", "solely", "undeniably", "independently"
]

pattern = re.compile(r"\b(?:" + "|".join(words_to_strip) + r")\b\s*", re.IGNORECASE)

for f in files:
    with open(f, "r", encoding="utf-8") as file:
        content = file.read()
    
    # regex replace
    content = pattern.sub("", content)
    # clean up any leftover double spaces
    content = re.sub(r" +", " ", content)
    
    with open(f, "w", encoding="utf-8") as file:
        file.write(content)
        
    print(f"Cleaned up {f}")

