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

async def main():
    await test_supabase()
    await test_gemini()

if __name__ == "__main__":
    asyncio.run(main())
