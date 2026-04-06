
try:
    import fastapi
    from slowapi import Limiter
    import firebase_admin
    from supabase import create_client
    import google.generativeai as genai
    import structlog
    print("SUCCESS: Core imports are working.")
except ImportError as e:
    print(f"FAILURE: Import error: {e}")
except Exception as e:
    print(f"FAILURE: Unexpected error during import: {e}")
