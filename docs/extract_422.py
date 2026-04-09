import json

with open(r'C:\Users\aryan\.gemini\antigravity\brain\9f0706d5-8a45-4d49-ad77-35667b4e1685\.system_generated\steps\890\output.txt', 'r') as f:
    data = json.load(f)

logs = data.get('result', {}).get('result', [])
for log in logs:
    if log.get('status_code') == 422:
        print(f"ID: {log.get('id')} | Method: {log.get('method')} | Path: {log.get('path')} | Msg: {log.get('event_message')}")
