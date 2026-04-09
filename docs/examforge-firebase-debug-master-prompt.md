# ══════════════════════════════════════════════════════════════════════════════
# EXAMFORGE — FIREBASE AUTH DEBUG & CODEBASE AUDIT PROMPT
# Senior Debugger Mode · 30+ Years Experience · Zero Assumptions
# Goal: Fix `auth/configuration-not-found` · Preserve all deps · No rewrites
# ══════════════════════════════════════════════════════════════════════════════

---

## 🚨 SITUATION BRIEF

You are a senior developer and debugger with 30+ years of production experience.
You are parachuting into a broken ExamForge deployment with ONE goal:

**Fix the Firebase `auth/configuration-not-found` error** blocking the signup/login
page — without touching the database, seed files, notes HTML, or backend logic.

The error banner visible in the browser reads:
> `Firebase: Error (auth/configuration-not-found).`

This is a **frontend configuration error**, not a Firebase project issue.
The Firebase project exists. The app is deployed on Vercel. The error is local to
the frontend environment or initialization code.

---

## 🧠 CONTEXT — WHAT HAS BEEN BUILT

```
Stack:
  Frontend:    React 18 + Vite + TypeScript → deployed on Vercel
  Auth:        Firebase Authentication (Email/Password + Google OAuth)
  Database:    Supabase PostgreSQL
  Storage:     Supabase Storage (bucket: notes-content)
  Backend:     FastAPI → deployed on Render
  AI:          Gemini 1.5 Flash (via backend, GEMINI_API_KEY)
  Code Exec:   Piston API (via backend, no key needed)

Frontend folder: examforge/
Config file:     src/lib/firebase.ts
Env file:        .env (local) + Vercel Environment Variables (deployed)
```

What is DONE and must NOT be touched:
- 126 SQL seed files in `examforge-backend/db/seeds/`
- 25 notes HTML files in `Gate Cse notes/`
- All Supabase schema, slugs, storage paths
- Backend FastAPI code (separate repo, deployed on Render)
- All npm dependencies — DO NOT add or remove packages without explicit reasoning
- Stitch design system tokens, CSS variables, component structure

---

## ❶ IMMEDIATE DIAGNOSIS PROTOCOL

Before touching any file, run this full audit in sequence.
Do NOT skip steps. Do NOT assume. Read every value.

### STEP 1 — Read `src/lib/firebase.ts` completely

Output the FULL file content. Look for:

```
□ Is `initializeApp(firebaseConfig)` called exactly once?
□ Is `getAuth(app)` called AFTER `initializeApp`?
□ Are ALL 6 required config keys present and non-empty?
    apiKey, authDomain, projectId, storageBucket, messagingSenderId, appId
□ Are the values hardcoded strings OR `import.meta.env.VITE_*` references?
□ Is there a second call to `initializeApp()` anywhere (even in another file)?
□ Is `getAuth()` called without arguments (missing the app instance)?
□ Is the file exported correctly — are `auth`, `db`, `app` all exported?
□ Is there any conditional guard like `if (!firebase.apps.length)` that may
  be interfering with how the app instance is created?
```

### STEP 2 — Find ALL Firebase initialization locations

Run a search across the ENTIRE `src/` directory:

```bash
grep -r "initializeApp\|getAuth\|firebase/app\|firebase/auth" src/ --include="*.ts" --include="*.tsx" -l
```

**Expected:** only `src/lib/firebase.ts` should appear.

If `initializeApp` or `getAuth` appears in more than one file → you have found
the root cause: **duplicate Firebase initialization**.

### STEP 3 — Read `.env` (or `.env.local`) in the project root

Output every `VITE_FIREBASE_*` variable name (NOT the values — just check they exist).

Expected variables:
```
VITE_FIREBASE_API_KEY
VITE_FIREBASE_AUTH_DOMAIN
VITE_FIREBASE_PROJECT_ID
VITE_FIREBASE_STORAGE_BUCKET
VITE_FIREBASE_MESSAGING_SENDER_ID
VITE_FIREBASE_APP_ID
VITE_SUPABASE_URL
VITE_SUPABASE_ANON_KEY
VITE_API_URL
```

Flag any of the following:
```
□ Missing VITE_FIREBASE_* variable → env not configured
□ Variable present but empty string → ""  (most common cause)
□ Variable name typo (VITE_FIREBASE_APIKEY vs VITE_FIREBASE_API_KEY)
□ Variable present in .env but NOT in Vercel dashboard
□ .env.local overriding .env with wrong values
□ .env file not committed (in .gitignore) — Vercel won't see it
```

### STEP 4 — Verify Vercel environment variables

Ask the developer to open Vercel dashboard → Project Settings → Environment Variables.

Verify these are ALL set and non-empty for the **Production** environment:
```
VITE_FIREBASE_API_KEY          → must match Firebase project
VITE_FIREBASE_AUTH_DOMAIN      → format: your-project-id.firebaseapp.com
VITE_FIREBASE_PROJECT_ID       → must match Firebase console project ID
VITE_FIREBASE_STORAGE_BUCKET   → format: your-project-id.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID → 12-digit number
VITE_FIREBASE_APP_ID           → format: 1:123456:web:abcdef...
VITE_SUPABASE_URL              → https://xxxx.supabase.co
VITE_SUPABASE_ANON_KEY         → long JWT string
VITE_API_URL                   → https://your-backend.onrender.com
```

**Critical Vercel gotcha:** After adding/editing env vars in Vercel dashboard,
you MUST trigger a new deployment for them to take effect. A redeployment is
NOT automatic.

### STEP 5 — Read `vite.config.ts`

Check:
```
□ Is `envPrefix: 'VITE_'` set? (default is fine, but explicit is safer)
□ Are there any define: {} blocks that hardcode config values to undefined?
□ Is there a proxy config that could strip headers or interfere?
```

### STEP 6 — Read `src/main.tsx` and `src/App.tsx`

Check:
```
□ Is firebase.ts imported at the top before any component that uses auth?
□ Is there a <React.StrictMode> wrapping that could cause double-initialization?
   (StrictMode in dev causes effects to run twice — but should NOT cause
   auth/configuration-not-found in production)
□ Is there any dynamic import() of firebase that could cause a race condition?
```

### STEP 7 — Check for duplicate or stale firebase packages

```bash
cat package.json | grep firebase
```

Expected: exactly one `"firebase"` entry in dependencies.

```bash
ls node_modules | grep firebase
```

If you see both `firebase` and `@firebase/*` packages, the versions may conflict.

```bash
cat node_modules/firebase/package.json | grep '"version"' | head -1
```

Output the version. Acceptable: `^9.x`, `^10.x` (modular SDK).
If version is `^8.x` or below → the import style in `firebase.ts` is wrong
(old compat API vs new modular API — this causes configuration-not-found).

---

## ❷ THE THREE MOST LIKELY ROOT CAUSES

After 30 years of debugging Firebase auth failures, `auth/configuration-not-found`
has three dominant causes ranked by frequency:

### CAUSE A — Missing or empty `authDomain` in config (most common)

```ts
// BROKEN — authDomain is missing or empty
const firebaseConfig = {
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
  authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN,  // ← empty string = BROKEN
  projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID,
  // ...
};
```

Firebase Auth **requires** `authDomain` to be set correctly.
If `VITE_FIREBASE_AUTH_DOMAIN` is not in Vercel env vars, it becomes `undefined`,
and `initializeApp` silently accepts it but `getAuth()` fails at runtime.

**Fix:** Ensure `VITE_FIREBASE_AUTH_DOMAIN` = `your-project-id.firebaseapp.com`
is in Vercel Environment Variables, then redeploy.

### CAUSE B — Firebase app initialized before env vars are available

```ts
// BROKEN — module-level initialization before Vite injects env
export const app = initializeApp({
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
  // ...
});

export const auth = getAuth(app);
```

In Vite, `import.meta.env` is statically replaced at **build time**.
If the build ran without the env vars set → all values become `undefined` in the
compiled bundle → Firebase config is all-undefined → `auth/configuration-not-found`.

**Fix:** Ensure env vars exist in Vercel BEFORE the build runs. Then force a
fresh deployment (don't just re-deploy the same build).

### CAUSE C — Duplicate `initializeApp` call

```ts
// firebase.ts
export const app = initializeApp(config);  // app created

// AuthContext.tsx or somewhere else
const app2 = initializeApp(config);  // ← SECOND call without name → throws
export const auth = getAuth(app2);   // broken auth instance
```

If `initializeApp` is called twice with the same config and no app name,
Firebase v9+ throws and the auth instance is broken.

**Fix:** Delete the duplicate. Import `auth` from `firebase.ts` everywhere.

---

## ❸ THE CANONICAL CORRECT `firebase.ts`

This is the exact implementation that must exist at `src/lib/firebase.ts`.
Replace the current file content with this if it deviates:

```ts
// src/lib/firebase.ts
// ExamForge Firebase initialization — single source of truth
// DO NOT call initializeApp or getAuth anywhere else in the codebase

import { initializeApp, getApps, getApp } from 'firebase/app';
import { getAuth, GoogleAuthProvider } from 'firebase/auth';

const firebaseConfig = {
  apiKey:            import.meta.env.VITE_FIREBASE_API_KEY            as string,
  authDomain:        import.meta.env.VITE_FIREBASE_AUTH_DOMAIN        as string,
  projectId:         import.meta.env.VITE_FIREBASE_PROJECT_ID         as string,
  storageBucket:     import.meta.env.VITE_FIREBASE_STORAGE_BUCKET     as string,
  messagingSenderId: import.meta.env.VITE_FIREBASE_MESSAGING_SENDER_ID as string,
  appId:             import.meta.env.VITE_FIREBASE_APP_ID             as string,
};

// Guard against double-initialization (React StrictMode, HMR, etc.)
const app = getApps().length === 0
  ? initializeApp(firebaseConfig)
  : getApp();

export const auth = getAuth(app);
export const googleProvider = new GoogleAuthProvider();
export default app;
```

**Why `getApps().length === 0`?**
This guard prevents the "app already initialized" crash in React StrictMode
(dev) and during Vite HMR. It's the Firebase v9 idiomatic pattern.

---

## ❹ AUTHORIZED DOMAINS IN FIREBASE CONSOLE

Even with perfect config, Google OAuth fails if the domain isn't whitelisted.

Go to: Firebase Console → Authentication → Settings → Authorized Domains

Ensure these domains are in the list:
```
localhost
examforge-kohl.vercel.app          ← your Vercel domain (from URL bar)
[any custom domain if configured]
```

If `examforge-kohl.vercel.app` is NOT in the authorized domains list →
Google sign-in will fail with `auth/unauthorized-domain` even if basic
email/password works. Add it.

---

## ❺ FULL FILE AUDIT — DUPLICATES & ORPHANS

Run these searches across the frontend codebase:

```bash
# 1. All files importing Firebase
grep -r "from 'firebase" src/ --include="*.ts" --include="*.tsx" -l

# 2. Find any stale firebase config objects (should ONLY be in firebase.ts)
grep -r "apiKey\|authDomain\|projectId\|storageBucket\|messagingSenderId\|appId" \
  src/ --include="*.ts" --include="*.tsx" | grep -v "firebase.ts" | grep -v ".env"

# 3. Find any getAuth() calls outside firebase.ts
grep -r "getAuth" src/ --include="*.ts" --include="*.tsx"

# 4. Find any initializeApp calls outside firebase.ts
grep -r "initializeApp" src/ --include="*.ts" --include="*.tsx"

# 5. Find duplicate .env files
find . -name ".env*" -not -path "*/node_modules/*"

# 6. Find any hardcoded Firebase config strings (security + config risk)
grep -r "AIza\|firebaseapp.com\|appspot.com" src/ --include="*.ts" --include="*.tsx"
```

Any result from search #2, #3, #4 outside of `firebase.ts` → immediate fix.
Any result from search #6 → hardcoded keys → move to env vars immediately.

---

## ❻ DEPENDENCY PRESERVATION RULES

**DO NOT touch these. Preserve as-is.**

```
firebase                    ← auth, core
@supabase/supabase-js       ← database + storage
zustand                     ← state management
react-router-dom            ← routing
framer-motion               ← animations
recharts                    ← charts
@monaco-editor/react        ← code editor
dompurify                   ← notes sanitization
react-draggable             ← calculator widget
vite-plugin-pwa             ← PWA support
```

Do NOT `npm install` anything new to fix the Firebase error.
The error is configuration, not missing packages.

---

## ❼ VERCEL DEPLOYMENT CHECKLIST

After fixing the code, verify deployment:

```
□ All VITE_FIREBASE_* env vars are set in Vercel → Settings → Environment Variables
□ Environment is set to "Production" (not just Preview or Development)
□ After adding/editing env vars → click "Redeploy" from Deployments tab
  → Choose "Redeploy with existing build cache" OFF for a clean rebuild
□ Build logs show no "undefined" warnings for env substitution
□ After deploy → open DevTools → Console → check for Firebase errors
□ Network tab → check that /signup page loads without CORS or 401 errors
```

**Force a clean build on Vercel:**
```
Vercel Dashboard → Deployments → Latest → "..." menu → Redeploy
Uncheck "Use existing build cache"
This forces Vite to rebuild with fresh env var injection.
```

---

## ❽ QUICK SELF-TEST AFTER FIX

Add this temporarily to `src/lib/firebase.ts` (remove after confirming):

```ts
// TEMP DEBUG — remove after verifying fix
if (import.meta.env.DEV) {
  console.log('[ExamForge] Firebase config check:', {
    apiKey:            import.meta.env.VITE_FIREBASE_API_KEY ? '✅ set' : '❌ missing',
    authDomain:        import.meta.env.VITE_FIREBASE_AUTH_DOMAIN ? '✅ set' : '❌ missing',
    projectId:         import.meta.env.VITE_FIREBASE_PROJECT_ID ? '✅ set' : '❌ missing',
    storageBucket:     import.meta.env.VITE_FIREBASE_STORAGE_BUCKET ? '✅ set' : '❌ missing',
    messagingSenderId: import.meta.env.VITE_FIREBASE_MESSAGING_SENDER_ID ? '✅ set' : '❌ missing',
    appId:             import.meta.env.VITE_FIREBASE_APP_ID ? '✅ set' : '❌ missing',
  });
}
```

Run `npm run dev` locally. Open browser console.
If any show `❌ missing` → that env var is the culprit.
Fix `.env.local` locally, fix Vercel dashboard for production.

---

## ❾ WHAT NOT TO DO

```
❌ Do NOT rebuild the entire frontend — the design is working
❌ Do NOT swap Firebase for Supabase Auth — the spec mandates Firebase
❌ Do NOT add a new auth library
❌ Do NOT delete node_modules and reinstall unless package versions conflict
❌ Do NOT change any slug, schema, or seed file
❌ Do NOT modify the backend (this is a pure frontend config issue)
❌ Do NOT add try/catch around initializeApp to silence the error
   — fix the root cause, don't mask it
❌ Do NOT hardcode Firebase config values in source code
   — they must come from import.meta.env.*
```

---

## ❿ EXPECTED OUTCOME

After completing this audit and fix:

```
□ /signup page loads with no Firebase error banner
□ Email/password registration works → user appears in Firebase Console → Users
□ Google OAuth button → opens Google sign-in popup → redirects back correctly
□ After login → user is redirected to /dashboard
□ Firebase idToken is correctly sent as Authorization: Bearer {token}
  to the FastAPI backend on Render
□ Backend verifies token → returns 200 → dashboard data loads
```

---

## HANDOFF LINE

Once Firebase auth is working, return to the ExamForge Master Binding Prompt v2.0
at **Section ❸, Step 14 — Full End-to-End Verification** and run the SQL health
check queries against Supabase to confirm database state before testing the full
subject/notes/practice flow.

---

*ExamForge Firebase Auth Debug Prompt · Senior Debugger Mode*
*Error: auth/configuration-not-found · Root cause: env var injection or duplicate init*
*Preserve: all deps, seeds, notes, backend, Stitch design system*
*Stack: Firebase + Supabase + Piston + Gemini + Render + Vercel*
