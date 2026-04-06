import asyncio
import os
import httpx
import google.generativeai as genai
from supabase import create_client
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_SERVICE_KEY = os.getenv("SUPABASE_SERVICE_KEY")
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")

async def test_supabase():
    print("\n--- Testing Supabase ---")
    try:
        supabase = create_client(SUPABASE_URL, SUPABASE_SERVICE_KEY)
        # Try to list profiles (or subjects)
        response = supabase.table("subjects").select("count").execute()
        print(f"SUCCESS: Supabase connected. Subjects count: {response.data}")
    except Exception as e:
        print(f"FAILURE: Supabase test failed: {e}")

async def test_gemini():
    print("\n--- Testing Google Gemini ---")
    try:
        genai.configure(api_key=GEMINI_API_KEY)
        model = genai.GenerativeModel("gemini-1.5-flash")
        response = model.generate_content("Hello, are you functional? Answer in 5 words.")
        print(f"SUCCESS: Gemini response: {response.text}")
    except Exception as e:
        print(f"FAILURE: Gemini test failed: {e}")

async def test_piston():
    print("\n--- Testing Piston API (Code Execution) ---")
    try:
        PISTON_URL = "https://emkc.org/api/v2/piston/execute"
        payload = {
            "language": "python",
            "version": "*",
            "files": [{"name": "main.py", "content": "print('Hello from Piston!')"}],
            "stdin": "",
            "args": []
        }
        async with httpx.AsyncClient(timeout=10) as client:
            response = await client.post(PISTON_URL, json=payload)
            if response.status_code == 200:
                result = response.json()
                print(f"SUCCESS: Piston result: {result['run']['stdout'].strip()}")
            else:
                print(f"FAILURE: Piston status code: {response.status_code}")
    except Exception as e:
        print(f"FAILURE: Piston test failed: {e}")

async def main():
    await test_supabase()
    await test_gemini()
    await test_piston()

if __name__ == "__main__":
    asyncio.run(main())
