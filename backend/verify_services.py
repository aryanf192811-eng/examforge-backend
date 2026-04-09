import os
import asyncio
import google.generativeai as genai
from supabase import create_client
from dotenv import load_dotenv

load_dotenv()

async def test_supabase():
    print("Testing Supabase...")
    try:
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_SERVICE_KEY")
        if not url or not key:
            print("MISSING SUPABASE CREDENTIALS")
            return
        supabase = create_client(url, key)
        # Check if we can reach subjects
        res = supabase.table("subjects").select("slug").limit(1).execute()
        print(f"SUCCESS: Supabase connected. Data: {res.data}")
    except Exception as e:
        print(f"FAILURE: Supabase Error: {e}")

async def test_gemini():
    print("Testing Gemini...")
    try:
        key = os.getenv("GEMINI_API_KEY")
        if not key:
            print("MISSING GEMINI_API_KEY")
            return
        genai.configure(api_key=key)
        model = genai.GenerativeModel("gemini-1.5-flash")
        res = model.generate_content("Say 'Gemini OK'")
        print(f"SUCCESS: Gemini response: {res.text.strip()}")
    except Exception as e:
        print(f"FAILURE: Gemini Error: {e}")

async def main():
    await test_supabase()
    await test_gemini()

if __name__ == "__main__":
    asyncio.run(main())
