import sys
import os
import json
import base64
from unittest.mock import MagicMock, patch

# Add the current directory to sys.path so we can import 'app'
sys.path.append(os.getcwd())

# Mock firebase_admin before importing app.core.firebase
mock_firebase_admin = MagicMock()
mock_credentials = MagicMock()

with patch.dict("sys.modules", {"firebase_admin": mock_firebase_admin, "firebase_admin.credentials": mock_credentials}):
    from app.core.firebase import init_firebase
    from app.core.config import settings

def test_init_from_file():
    print("Testing initialization from file path...")
    settings.FIREBASE_CREDENTIALS_B64 = ""
    settings.FIREBASE_CREDENTIALS_JSON = "firebase-key.json"
    
    mock_firebase_admin._apps = []
    
    try:
        init_firebase()
        print("✅ Successfully called init_firebase with file path.")
    except Exception as e:
        print(f"❌ Failed to call init_firebase with file path: {e}")

def test_init_from_json_string():
    print("\nTesting initialization from raw JSON string...")
    settings.FIREBASE_CREDENTIALS_B64 = ""
    dummy_json = json.dumps({"type": "service_account", "project_id": "test-project"})
    settings.FIREBASE_CREDENTIALS_JSON = dummy_json
    
    mock_firebase_admin._apps = []
    
    try:
        init_firebase()
        print("✅ Successfully called init_firebase with JSON string.")
    except Exception as e:
        print(f"❌ Failed to call init_firebase with JSON string: {e}")

def test_init_from_b64():
    print("\nTesting initialization from Base64 string...")
    dummy_json = json.dumps({"type": "service_account", "project_id": "b64-project"})
    dummy_b64 = base64.b64encode(dummy_json.encode()).decode()
    settings.FIREBASE_CREDENTIALS_B64 = dummy_b64
    settings.FIREBASE_CREDENTIALS_JSON = ""
    
    mock_firebase_admin._apps = []
    
    try:
        init_firebase()
        print("✅ Successfully called init_firebase with Base64 string.")
    except Exception as e:
        print(f"❌ Failed to call init_firebase with Base64 string: {e}")

if __name__ == "__main__":
    test_init_from_file()
    test_init_from_json_string()
    test_init_from_b64()
    print("\nVerification complete.")
