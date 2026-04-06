
import re
import glob

files = glob.glob("os-seed-p*.sql")
words_to_strip = [
    "strictly", "purely", "solidly", "definitively", "explicitly", "precisely", "firmly", 
    "cleanly", "flawlessly", "safely", "identically", "correctly", "efficiently", 
    "uniquely", "absolutely", "rigorously", "completely", "securely", "inherently", 
    "distinctly", "expressly", "unconditionally", "reliably", "deeply", "strongly", 
    "thoroughly", "conclusively", "genuinely", "neatly", "decisively", "positively",
    "consistently", "tightly", "smoothly", "squarely", "uniformly", "universally",
    "heavily", "comprehensively", "robustly", "entirely", "seamlessly", "intensely", 
    "powerfully", "profundly", "profoundly", "vividly", "vigorously", "solely", "undeniably", 
    "independently", "tracking", "checking", "mapping", "structurally", "evaluating", "defining", 
    "validating", "analyzing", "measuring", "identifying", "computations", "resolving", 
    "configurations", "parameters", "executing", "generating", "combinations", "determining",
    "bounds", "limits", "tracing", "paths"
]

pattern = re.compile(r"\b(?:" + "|".join(words_to_strip) + r")\b\s*", re.IGNORECASE)

for f in files:
    try:
        with open(f, "r", encoding="utf-8") as file:
            content = file.read()
            
        content = pattern.sub("", content)
        
        # Also fix the known mistake in Q46 (SRTF wait time = 2, not 3)
        if "Q46" in content and "3.00,3.00,NULL" in content:
            content = content.replace("3.00,3.00,NULL", "2.00,2.00,NULL")

        content = re.sub(r" +", " ", content)
        
        with open(f, "w", encoding="utf-8") as file:
            file.write(content)
            
        print(f"Cleaned up {f}")
    except Exception as e:
        print(e)

