╔══════════════════════════════════════════════════════════════════════════════╗
║  EXAMFORGE — FRONTEND BUILD PROMPT v7.0                                     ║
║  The Academic Atelier · Zero Shortcuts · All v6 Architectural Bugs Patched  ║
╚══════════════════════════════════════════════════════════════════════════════╝

═══════════════════════════════════════════════════════════════
  ❶ MISSION BRIEF
═══════════════════════════════════════════════════════════════

You are a senior frontend engineer. Build the complete production-grade frontend
for ExamForge — a premium GATE CSE exam preparation platform.

Design language: "The Academic Atelier" / "The Scholarly Sanctuary."
Stack is locked. Every architectural decision below is non-negotiable.
Read this entire prompt before writing one line of code.

NON-NEGOTIABLE RULES — VIOLATION IS A BUILD FAILURE:
1.  NEVER use `any` TypeScript type — use `unknown` then narrow with type guards
2.  NEVER use placeholder content or lorem ipsum — real components only
3.  NEVER expose signed Supabase URLs in client state, devtools, or console logs
4.  NEVER watermark or overlay notes content
5.  NEVER lock individual notes — role check happens at login level only
6.  NEVER re-style the paper content area (#faf7f2 bg, Lora font, #1a1a1a ink)
7.  NEVER use alert(), confirm(), prompt() — Modal + Toast components only
8.  NEVER use <form> HTML element — use <div role="form"> with React handlers
9.  NEVER use lucide-react or any npm icon package for visible UI icons
10. NEVER use dimension polling for DevTools detection — debugger trap only
11. NEVER inject notes HTML into the React DOM — use the CDN-direct iframe protocol
    defined in Section ❺ EXACTLY — no DOMPurify, no dangerouslySetInnerHTML
12. NEVER call KaTeX render manually — notes have pre-rendered KaTeX HTML;
    only load KaTeX CSS globally so it displays correctly
13. EVERY async state needs a Skeleton loader — no layout shift, no spinners alone
14. EVERY destructive action needs a confirmation Modal
15. EVERY stat field read from API must be null-coalesced: value ?? 0 or value ?? ''
16. NEVER use noUnusedLocals in production tsconfig — set it to false

═══════════════════════════════════════════════════════════════
  ❷ TECH STACK (LOCKED)
═══════════════════════════════════════════════════════════════

Frontend:     React 18 + Vite + TypeScript (strict: true, noUnusedLocals: FALSE)
Styling:      Tailwind CSS v3 — darkMode: "class" — html.dark toggle
State:        Zustand (never store signed URLs in any store)
Auth:         Firebase Auth (Email/Password + Google OAuth)
              Roles: "student" | "admin" | "free" | "pro"
DB:           Supabase (PostgreSQL only — no client-side storage calls)
Animations:   Framer Motion
Charts:       Recharts
Icons:        Material Symbols Outlined ONLY (Google Fonts CDN, NOT npm)
Fonts:        Fraunces · Newsreader · Inter · Lora · Fira Code (Google Fonts)
Math:         KaTeX CSS loaded globally in index.html (pre-rendered notes only)
PWA:          vite-plugin-pwa

REMOVED FROM STACK (do not install, do not reference):
- DOMPurify (notes use iframe isolation, not DOM injection)
- @monaco-editor/react (code runner removed from this build)
- react-draggable (virtual calculator removed from this build)
- Redis (backend concern only, not a frontend dependency)
- Judge0 / Piston (code execution removed from this build)

═══════════════════════════════════════════════════════════════
  ❸ DESIGN SYSTEM — THE ACADEMIC ATELIER
═══════════════════════════════════════════════════════════════

TWO THEMES, ONE TOGGLE.
Stored in localStorage key `ef_theme`. Applied via html.dark class.
Default: dark (Tokyo Night).

THEME FLASH PREVENTION — place in index.html BEFORE the React script tag:
<script>
  (function() {
    const t = localStorage.getItem('ef_theme') || 'dark';
    if (t === 'dark') document.documentElement.classList.add('dark');
    else document.documentElement.classList.remove('dark');
  })();
</script>

━━━ 3A COLOR TOKENS (wire tailwind.config.js → CSS variables) ━━━

In tailwind.config.js, extend.colors with these CSS-var-backed tokens:
  surface-dim, surface, surface-bright,
  surface-container-lowest, surface-container-low, surface-container,
  surface-container-high, surface-container-highest, surface-variant,
  background, primary, primary-dim, primary-fixed, primary-fixed-dim,
  primary-container, on-primary, on-primary-container, inverse-primary,
  secondary, secondary-dim, secondary-fixed, secondary-fixed-dim,
  secondary-container, on-secondary, on-secondary-container,
  tertiary, tertiary-dim, tertiary-fixed, tertiary-fixed-dim,
  tertiary-container, on-tertiary,
  on-background, on-surface, on-surface-variant,
  inverse-surface, inverse-on-surface,
  outline, outline-variant, surface-tint,
  error, error-dim, error-container, on-error, on-error-container

Each token maps to var(--color-<token-name>).

━━━ 3B CSS VARIABLES in src/index.css ━━━

/* ── LIGHT THEME (Sakura Pastel) ── */
:root {
  --color-surface-dim: #f8f9ff;
  --color-surface: #fdf8ff;
  --color-surface-bright: #ffffff;
  --color-surface-container-lowest: #ffffff;
  --color-surface-container-low: #f1f3f9;
  --color-surface-container: #f1f0f4;
  --color-surface-container-high: #e8e8ec;
  --color-surface-container-highest: #e2e2e6;
  --color-surface-variant: #e0e2ec;
  --color-background: #fdf8ff;
  --color-primary: #6834eb;
  --color-primary-dim: #7e51ff;
  --color-primary-fixed: #a98fff;
  --color-primary-fixed-dim: #9c7eff;
  --color-primary-container: #b6a0ff;
  --color-on-primary: #ffffff;
  --color-on-primary-container: #ffffff;
  --color-inverse-primary: #b6a0ff;
  --color-secondary: #006879;
  --color-secondary-dim: #40d2ee;
  --color-secondary-fixed: #5be2ff;
  --color-secondary-fixed-dim: #45d4f1;
  --color-secondary-container: #ebfaff;
  --color-on-secondary: #ffffff;
  --color-on-secondary-container: #001f26;
  --color-tertiary: #9c4060;
  --color-tertiary-dim: #e85e88;
  --color-tertiary-fixed: #ffb2c8;
  --color-tertiary-fixed-dim: #ff87aa;
  --color-tertiary-container: #ffd9e4;
  --color-on-tertiary: #ffffff;
  --color-on-background: #1a1b23;
  --color-on-surface: #1a1b23;
  --color-on-surface-variant: #44475a;
  --color-inverse-surface: #2f3044;
  --color-inverse-on-surface: #f1f0f7;
  --color-outline: #75778a;
  --color-outline-variant: #c5c6d8;
  --color-surface-tint: #6834eb;
  --color-error: #ba1a1a;
  --color-error-dim: #de3730;
  --color-error-container: #ffdad6;
  --color-on-error: #ffffff;
  --color-on-error-container: #410002;
}

/* ── DARK THEME (Tokyo Night) ── */
html.dark {
  --color-surface-dim: #10141a;
  --color-surface: #13171e;
  --color-surface-bright: #1e2330;
  --color-surface-container-lowest: #0b0e14;
  --color-surface-container-low: #191d28;
  --color-surface-container: #1e2330;
  --color-surface-container-high: #252a38;
  --color-surface-container-highest: #2d3245;
  --color-surface-variant: #3a3f56;
  --color-background: #10141a;
  --color-primary: #d0c1ff;
  --color-primary-dim: #b9a8f5;
  --color-primary-fixed: #6834eb;
  --color-primary-fixed-dim: #5a28d4;
  --color-primary-container: #4a1db8;
  --color-on-primary: #1a0d40;
  --color-on-primary-container: #e8e0ff;
  --color-inverse-primary: #6834eb;
  --color-secondary: #5be2ff;
  --color-secondary-dim: #45d4f1;
  --color-secondary-fixed: #006879;
  --color-secondary-fixed-dim: #004f5d;
  --color-secondary-container: #003642;
  --color-on-secondary: #001f26;
  --color-on-secondary-container: #b8eaf6;
  --color-tertiary: #ff87aa;
  --color-tertiary-dim: #f06890;
  --color-tertiary-fixed: #9c4060;
  --color-tertiary-fixed-dim: #7a2f4a;
  --color-tertiary-container: #5c1f35;
  --color-on-tertiary: #2d0014;
  --color-on-background: #e4e1f0;
  --color-on-surface: #e4e1f0;
  --color-on-surface-variant: #a8abbe;
  --color-inverse-surface: #e4e1f0;
  --color-inverse-on-surface: #2f3044;
  --color-outline: #6b6d82;
  --color-outline-variant: #3a3f56;
  --color-surface-tint: #d0c1ff;
  --color-error: #ffb4ab;
  --color-error-dim: #ff897d;
  --color-error-container: #7f1d1d;
  --color-on-error: #690005;
  --color-on-error-container: #ffdad6;
}

━━━ 3C TYPOGRAPHY SCALE ━━━

fontFamily in tailwind.config.js:
  display: ['Fraunces', 'Georgia', 'serif']
  headline: ['Newsreader', 'Georgia', 'serif']
  body: ['Inter', 'system-ui', 'sans-serif']
  paper: ['Lora', 'Georgia', 'serif']       ← notes content ONLY
  mono: ['Fira Code', 'monospace']

Custom fontSize tokens (extend.fontSize):
  'display-lg':  ['3.5rem',  { lineHeight: '1.1', letterSpacing: '-0.02em', fontWeight: '700' }]
  'display-md':  ['2.75rem', { lineHeight: '1.15', letterSpacing: '-0.015em', fontWeight: '600' }]
  'headline-lg': ['2rem',    { lineHeight: '1.2', letterSpacing: '-0.01em', fontWeight: '700' }]
  'headline-md': ['1.5rem',  { lineHeight: '1.25', letterSpacing: '-0.01em', fontWeight: '600' }]
  'headline-sm': ['1.25rem', { lineHeight: '1.3', fontWeight: '600' }]
  'title-lg':    ['1.125rem',{ lineHeight: '1.4', fontWeight: '600' }]
  'title-md':    ['1rem',    { lineHeight: '1.5', fontWeight: '600' }]
  'body-lg':     ['1rem',    { lineHeight: '1.6' }]
  'body-md':     ['0.875rem',{ lineHeight: '1.5' }]
  'body-sm':     ['0.8125rem',{ lineHeight: '1.4' }]
  'label-lg':    ['0.875rem',{ lineHeight: '1.25', fontWeight: '500', letterSpacing: '0.006em' }]
  'label-md':    ['0.75rem', { lineHeight: '1.25', fontWeight: '500', letterSpacing: '0.031em' }]
  'label-sm':    ['0.6875rem',{ lineHeight: '1.25', fontWeight: '500', letterSpacing: '0.031em' }]

━━━ 3D DESIGN RULES (from DESIGN.md — enforce in every component) ━━━

1. NO 1px BORDERS. EVER. Use tonal shifts (surface-container vs surface).
   Ghost border exception: outline-variant at 10% opacity only.
2. GLASSMORPHISM: backdrop-filter blur(24px) + surface color at 70% opacity.
3. GRADIENT PRIMARY CTA: linear-gradient(135deg, primary, primary-container).
4. ELEVATION via tonal layering, not drop shadows.
5. SMOOTH SPRING easing on all transitions: cubic-bezier(0.34, 1.56, 0.64, 1).
6. STAGGERED ENTRY: content sections fade-in + 20px upward slide, 60ms stagger.
7. Inter font is ONLY for labels and UI metadata. Never body copy.

═══════════════════════════════════════════════════════════════
  ❹ BACKEND API CONTRACT
═══════════════════════════════════════════════════════════════

Backend: FastAPI running at VITE_API_URL (env var)
All requests include: Authorization: Bearer <firebase-id-token>
All error responses: RFC 7807 { type, title, status, detail }

ENDPOINTS (consume exactly, never call Supabase directly from frontend):

Auth:
  POST /api/auth/sync          body: {firebase_uid, email, name, picture}
  GET  /api/auth/me            returns: ProfileResponse

Subjects:
  GET  /api/subjects           returns: SubjectResponse[]

Chapters:
  GET  /api/chapters?subject_id=<uuid>   returns: ChapterResponse[]

Notes:
  GET  /api/notes/<chapter_id>/url       returns: { signed_url: string }
  ← This is the ONLY notes endpoint. signed_url is valid for 1 hour.
  ← Frontend fetches the signed_url directly from Supabase CDN.
  ← NEVER store signed_url in Zustand. Fetch fresh per session.

Practice:
  GET  /api/quiz/start?subject_id=<uuid>&mode=<str>&count=<int>
  POST /api/quiz/submit        body: QuizSubmitRequest
  GET  /api/quiz/history       returns: QuizSession[]

Progress:
  GET  /api/progress/stats     returns: UserStats
  POST /api/progress/chapter   body: { chapter_id, completed: bool }

Leaderboard:
  GET  /api/leaderboard        returns: LeaderboardEntry[]

Flashcards:
  GET  /api/flashcards?subject_id=<uuid>
  POST /api/flashcards/review  body: { card_id, rating: 0|1|2|3|4|5 }

Doubts:
  POST /api/doubts/ask         body: { chapter_title, subject_name,
                                        selected_text, question }
  returns: { answer: string }

Profile:
  GET  /api/profile            returns: ProfileResponse
  PUT  /api/profile            body: { name?, bio?, avatar_url? }

═══════════════════════════════════════════════════════════════
  ❺ NOTES RENDERING — THE IFRAME PROTOCOL (READ CAREFULLY)
═══════════════════════════════════════════════════════════════

This section defines the ONLY correct way to render notes HTML.
Every other approach (dangerouslySetInnerHTML, DOMPurify injection,
srcdoc direct assignment) is BANNED. Reason: they all cause either
CSS bleed or KaTeX failure.

THE PROTOCOL:

Step 1 — Fetch signed URL from backend:
  const { data } = await api.get(`/api/notes/${chapterId}/url`);
  // data.signed_url is a Supabase CDN URL — valid 1 hour
  // NEVER store this in Zustand. Keep in local component state only.

Step 2 — Fetch the raw HTML string from CDN:
  const html = await fetch(data.signed_url).then(r => r.text());
  // This is raw HTML. Do NOT inject into React DOM.

Step 3 — Inject into a sandboxed iframe via blob URL:
  const blob = new Blob([html], { type: 'text/html' });
  const blobUrl = URL.createObjectURL(blob);
  iframeRef.current.src = blobUrl;
  // On unmount: URL.revokeObjectURL(blobUrl)

  WHY BLOB URL, NOT SRCDOC:
  - srcdoc has a ~512KB size limit in some browsers.
  - Blob URL creates a real document context — fonts + external CSS load correctly.
  - Blob URL allows postMessage height negotiation (srcdoc same-origin trick is fragile).

Step 4 — Auto-height via postMessage (eliminates double scrollbars):
  Inside the iframe's HTML, the notes template already contains this script:
  (If not present, inject it into the blob before creating the URL)

  <script>
    window.addEventListener('load', function() {
      window.parent.postMessage(
        { type: 'ef-notes-height', height: document.body.scrollHeight },
        '*'
      );
    });
    // Also fire on any content change (MathJax, images loading)
    const ro = new ResizeObserver(function() {
      window.parent.postMessage(
        { type: 'ef-notes-height', height: document.body.scrollHeight },
        '*'
      );
    });
    ro.observe(document.body);
  </script>

  In the parent React component (NotesViewer.tsx):
  useEffect(() => {
    const handler = (e: MessageEvent) => {
      if (e.data?.type === 'ef-notes-height') {
        setIframeHeight(e.data.height + 40); // 40px padding
      }
    };
    window.addEventListener('message', handler);
    return () => window.removeEventListener('message', handler);
  }, []);

  Apply to iframe: style={{ height: iframeHeight, border: 'none', width: '100%' }}
  The outer container has overflow-y: auto with a max-height.
  The iframe itself has NO scrollbar — the parent page scrolls.

Step 5 — KaTeX rendering:
  Notes have PRE-RENDERED KaTeX HTML (class="katex" elements already in DOM).
  You only need KaTeX CSS loaded globally. Add to index.html:
  <link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/katex@0.16.9/dist/katex.min.css">
  That is ALL. Do NOT call katex.renderMathInElement(). It is not needed.

THE COMPLETE NotesViewer.tsx COMPONENT SHAPE:

interface NotesViewerProps {
  chapterId: string;
  chapterTitle: string;
  subjectName: string;
}

States needed:
  signedUrl: string | null        ← fetch from /api/notes/:id/url
  htmlContent: string | null      ← fetch from signedUrl (raw HTML)
  iframeHeight: number            ← set via postMessage from iframe
  isLoading: boolean
  error: string | null
  blobUrl: string | null          ← created from htmlContent, revoked on unmount

Load sequence:
  1. setIsLoading(true)
  2. GET /api/notes/${chapterId}/url → signedUrl
  3. fetch(signedUrl) → htmlContent
  4. Inject postMessage height script into htmlContent if not present
  5. Create blob URL → set on iframe.src
  6. iframe fires postMessage → setIframeHeight
  7. setIsLoading(false)

On unmount: URL.revokeObjectURL(blobUrl)

═══════════════════════════════════════════════════════════════
  ❻ NULL-SAFETY CONTRACT — APPLY EVERYWHERE
═══════════════════════════════════════════════════════════════

Every single numeric stat field that comes from the API must be null-coalesced.
This prevents NaN display and crashes on new user accounts.

RULE: Never render a raw API numeric value. Always:
  user.total_score ?? 0
  user.streak_days ?? 0
  entry.total_points ?? entry.total_score ?? 0
  entry.weekly_points ?? 0
  stats.questions_attempted ?? 0
  stats.accuracy_percent ?? 0
  chapter.progress_percent ?? 0

For string fields:
  user.name || 'Student'
  user.bio || 'No bio yet'
  user.avatar_url || '/default-avatar.png'

For arrays:
  subjects ?? []
  questions ?? []
  leaderboard ?? []

In Leaderboard specifically:
  NEVER compute rank or score without null-coalescing first.
  Use: const score = (entry.total_points ?? entry.total_score ?? 0)

═══════════════════════════════════════════════════════════════
  ❼ TYPESCRIPT CONFIG — FIX THE BUILD PIPELINE
═══════════════════════════════════════════════════════════════

tsconfig.app.json — use these exact settings:
{
  "compilerOptions": {
    "strict": true,
    "noUnusedLocals": false,        ← CRITICAL: was true, caused CI failures
    "noUnusedParameters": false,    ← CRITICAL: was true, caused CI failures
    "noImplicitAny": true,
    "strictNullChecks": true,
    "skipLibCheck": true,
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "react-jsx"
  }
}

The contract: strict null checks stay ON (catches real bugs).
Unused variable warnings stay OFF (prevents CI blocks from dead imports).

═══════════════════════════════════════════════════════════════
  ❽ TYPE SYSTEM — src/types/index.ts
═══════════════════════════════════════════════════════════════

Define all interfaces here. Downstream components import from here only.
No inline interface definitions in component files.

interface ProfileResponse {
  id: string;
  email: string;
  name: string;
  role: 'free' | 'pro' | 'admin';
  bio?: string;
  avatar_url?: string;
  total_score?: number | null;     ← Optional + nullable — backend may omit
  streak_days?: number | null;
  created_at: string;
}

interface SubjectResponse {
  id: string;
  name: string;
  slug: string;
  description?: string;
  icon?: string;
  category?: string;              ← Optional — may be absent on fresh DB
  chapter_count?: number | null;
  is_published?: boolean;
}

interface ChapterResponse {
  id: string;
  subject_id: string;
  slug: string;
  title: string;
  order_index?: number | null;
  has_notes?: boolean | null;
  progress_percent?: number | null;
}

interface QuizQuestion {
  id: string;
  stem: string;
  type: 'MCQ' | 'MSQ' | 'NAT';
  marks?: number | null;          ← Optional — prevents crash on malformed rows
  options?: Record<string, string> | null;
  correct_option?: string | null;
  correct_options?: string[] | null;
  nat_answer_min?: number | null;
  nat_answer_max?: number | null;
  explanation?: string | null;
  difficulty?: string | null;
  gate_year?: number | null;
}

interface UserStats {
  questions_attempted?: number | null;
  questions_correct?: number | null;
  accuracy_percent?: number | null;
  study_time_minutes?: number | null;
  streak_days?: number | null;
  subjects_started?: number | null;
}

interface LeaderboardEntry {
  user_id: string;
  name: string;
  avatar_url?: string | null;
  total_points?: number | null;
  total_score?: number | null;    ← Fallback field — use total_points ?? total_score ?? 0
  weekly_points?: number | null;
  rank?: number | null;
}

interface QuizSession {
  id: string;
  subject_id: string;
  mode?: string | null;
  score?: number | null;
  total_questions?: number | null;
  started_at?: string | null;
  completed_at?: string | null;
}

interface FlashCard {
  id: string;
  front: string;
  back: string;
  subject_id: string;
  ease_factor?: number | null;
  next_review?: string | null;
}

interface NoteUrlResponse {
  signed_url: string;
}

═══════════════════════════════════════════════════════════════
  ❾ API LAYER — src/lib/api.ts
═══════════════════════════════════════════════════════════════

Build a typed fetch wrapper. Structure:

const BASE = import.meta.env.VITE_API_URL;

async function request<T>(
  method: string,
  path: string,
  body?: unknown,
  token?: string
): Promise<T>

- Reads Firebase token from authStore (getState().idToken)
- Sets Authorization: Bearer <token>
- On 401: triggers signOut() + redirect to /login
- On non-OK: throws ApiError with { status, title, detail } from RFC 7807 body
- Returns typed T

Export named functions:
  getSubjects(): Promise<SubjectResponse[]>
  getChapters(subjectId: string): Promise<ChapterResponse[]>
  getNoteUrl(chapterId: string): Promise<NoteUrlResponse>
  startQuiz(subjectId: string, mode: string, count: number): Promise<QuizSession>
  submitQuiz(payload: QuizSubmitRequest): Promise<void>
  getProgress(): Promise<UserStats>
  getLeaderboard(): Promise<LeaderboardEntry[]>
  getFlashcards(subjectId: string): Promise<FlashCard[]>
  reviewFlashcard(cardId: string, rating: number): Promise<void>
  askDoubt(payload: DoubtRequest): Promise<{ answer: string }>
  getProfile(): Promise<ProfileResponse>
  updateProfile(payload: Partial<ProfileResponse>): Promise<ProfileResponse>
  syncAuth(payload: AuthSyncPayload): Promise<ProfileResponse>

═══════════════════════════════════════════════════════════════
  ❿ STATE MANAGEMENT — src/lib/store/
═══════════════════════════════════════════════════════════════

authStore.ts:
  { user: ProfileResponse | null, idToken: string | null,
    firebaseUser: FirebaseUser | null,
    setUser, setIdToken, setFirebaseUser, signOut }
  signOut: clears store + calls Firebase signOut() + navigates to /login

notesStore.ts:
  { currentChapterId: string | null, setCurrentChapter }
  NOTE: NEVER store signed URLs here. signedUrl lives in NotesViewer local state.

themeStore.ts:
  { theme: 'dark' | 'light', toggleTheme, setTheme }
  setTheme: updates localStorage 'ef_theme' + toggles html.dark class

quizStore.ts:
  { sessionId: string | null, questions: QuizQuestion[],
    answers: Record<string, unknown>, currentIndex: number,
    setSession, setQuestions, recordAnswer, nextQuestion, reset }

═══════════════════════════════════════════════════════════════
  ⓫ SKELETON SYSTEM — src/components/ui/Skeleton.tsx
═══════════════════════════════════════════════════════════════

All loading states use Skeleton, never raw spinners.

Base skeleton: shimmer animation on surface-container-high.
Custom variants:
  <Skeleton variant="text" lines={3} />
  <Skeleton variant="card" />
  <Skeleton variant="chapter-list" count={6} />
  <Skeleton variant="stat-ring" />
  <Skeleton variant="table-row" count={10} />

Animation: CSS keyframe shimmer from surface-container to
           surface-container-high and back. Duration: 1.5s infinite.

Every page that fetches data must show its Skeleton variant
while isLoading === true, BEFORE any data attempt to render.

═══════════════════════════════════════════════════════════════
  ⓬ PAGES & COMPONENTS
═══════════════════════════════════════════════════════════════

Pages: Landing, Login, Signup, Dashboard, Notes, Practice,
       Skills, Leaderboard, Profile, Settings

AppShell wraps all authenticated pages:
  Desktop: Fixed sidebar (240px) + TopBar (56px) + scrollable content
  Mobile:  TopBar + scrollable content + BottomTabBar (fixed, 64px)
  Breakpoint: md (768px)

━━━ DASHBOARD ━━━
Widgets (all with Skeleton loading state):
- Welcome card with name (user.name || 'Student')
- Study streak badge (user.streak_days ?? 0 days)
- Subject mastery radar (Recharts Radar — subjects from API)
- Recent activity heatmap (53 weeks × 7 days grid)
- Prediction Score Estimator (formula: accuracy * weight per subject)
- Session Depth Score (questions/session trend)
- Quick-action buttons: Continue Notes, Start Quiz, Review Flashcards

━━━ NOTES PAGE ━━━
Left panel: Subject list → Chapter list (collapsible)
Right panel: NotesViewer (implements the iframe protocol from Section ❺)
Mobile: Full-screen chapter list → tap to open NotesViewer full page

The right panel has:
- Focus Mode button (hides sidebar, expands notes to full width)
- Doubt Drawer: select text → floating button → POST /api/doubts/ask → show answer
- Bookmark button (header level, not per-paragraph)

━━━ PRACTICE PAGE ━━━
Filter bar: Subject, Mode (topic/mixed/mock/PYQ), Difficulty
Quiz card: one question at a time, keyboard shortcut A/B/C/D to select
Timer: optional countdown per question (can toggle off)
Post-submit: accuracy %, time per question, explanation per question
Empty state: if 0 questions available for filter combination, show EmptyState.

━━━ SKILLS PAGE ━━━
Grid of skill tracks: C++ Mastery, Python Essentials (more TBD)
Each track: chapter list, progress indicator (completed/total notes)
Opens chapter note in Notes viewer (same iframe protocol)

━━━ LEADERBOARD ━━━
Two tabs: Weekly | All-Time
Table: Rank | Avatar | Name | Score | Streak
Score column: entry.total_points ?? entry.total_score ?? 0
Current user row highlighted with primary-container background
Skeleton: 10 table-row skeletons on load

━━━ PROFILE ━━━
Avatar (with upload trigger — POST to backend, not direct Supabase)
Editable: name, bio
Read-only: email, role, joined date
Stats section: total_score ?? 0, streak_days ?? 0, questions_attempted ?? 0
Danger zone: Delete Account (confirmation modal required)

━━━ SETTINGS ━━━
Theme toggle (dark/light) — reads/writes themeStore
Notification preferences (stored in profile via PUT /api/profile)
Account section: change password (Firebase re-auth)

═══════════════════════════════════════════════════════════════
  ⓭ SECURITY
═══════════════════════════════════════════════════════════════

usePlatformSecurity.ts:
  Debugger trap — run in App.tsx useEffect:
  setInterval(() => { debugger; }, 100);
  (This is the standard DevTools detection pattern — NOT dimension polling)

Route protection:
  <ProtectedRoute> wraps all authenticated pages
  Checks authStore.user — if null, redirect to /login with returnUrl param
  On login success, read returnUrl and navigate there

Firebase token refresh:
  In authStore, subscribe to onIdTokenChanged
  On token refresh, update idToken in store
  All API calls read getState().idToken — always current

═══════════════════════════════════════════════════════════════
  ⓮ FOLDER STRUCTURE
═══════════════════════════════════════════════════════════════

examforge/
├── index.html              ← Fonts + Material Symbols + KaTeX CSS + theme script
├── public/
│   ├── manifest.json
│   └── icons/
├── src/
│   ├── main.tsx
│   ├── App.tsx             ← Router + AnimatePresence + usePlatformSecurity()
│   ├── index.css           ← CSS vars (dark+light) + custom utility classes
│   ├── types/index.ts      ← ALL TypeScript interfaces (only place)
│   ├── lib/
│   │   ├── firebase.ts
│   │   ├── supabase.ts     ← Supabase client (read-only queries only from frontend)
│   │   ├── api.ts          ← Typed fetch wrappers for all backend endpoints
│   │   ├── utils.ts
│   │   └── store/
│   │       ├── authStore.ts
│   │       ├── notesStore.ts
│   │       ├── themeStore.ts
│   │       └── quizStore.ts
│   ├── hooks/
│   │   ├── usePlatformSecurity.ts
│   │   ├── useBookmarks.ts
│   │   ├── useProgress.ts
│   │   └── useTheme.ts
│   ├── components/
│   │   ├── layout/
│   │   │   ├── Sidebar.tsx
│   │   │   ├── TopBar.tsx
│   │   │   ├── BottomTabBar.tsx
│   │   │   └── AppShell.tsx
│   │   ├── ui/
│   │   │   ├── Button.tsx
│   │   │   ├── Input.tsx
│   │   │   ├── Badge.tsx
│   │   │   ├── Modal.tsx
│   │   │   ├── Toast.tsx
│   │   │   ├── Skeleton.tsx
│   │   │   ├── EmptyState.tsx
│   │   │   └── ProgressBar.tsx
│   │   ├── notes/
│   │   │   ├── NotesViewer.tsx    ← IMPLEMENTS SECTION ❺ EXACTLY
│   │   │   ├── FocusModeWrapper.tsx
│   │   │   ├── DoubtDrawer.tsx
│   │   │   └── BookmarkPanel.tsx
│   │   ├── practice/
│   │   │   ├── QuestionCard.tsx
│   │   │   ├── OptionButton.tsx
│   │   │   ├── FocusTimer.tsx
│   │   │   └── TagFilterBar.tsx
│   │   ├── dashboard/
│   │   │   ├── ProgressRing.tsx
│   │   │   ├── ActivityHeatmap.tsx
│   │   │   ├── SubjectMasteryChart.tsx
│   │   │   └── StudyVelocityChart.tsx
│   │   └── global/
│   │       ├── CommandPalette.tsx
│   │       ├── OfflineBanner.tsx
│   │       └── UpgradeModal.tsx
│   └── pages/
│       ├── Landing.tsx
│       ├── Login.tsx
│       ├── Signup.tsx
│       ├── Dashboard.tsx
│       ├── Notes.tsx
│       ├── Practice.tsx
│       ├── Skills.tsx
│       ├── Leaderboard.tsx
│       ├── Profile.tsx
│       └── Settings.tsx
├── tailwind.config.js
└── vite.config.ts

═══════════════════════════════════════════════════════════════
  ⓯ BUILD ORDER — STRICT SEQUENCE
═══════════════════════════════════════════════════════════════

PHASE 1 — Foundation (zero UI, pure infrastructure)
  1.  index.html           — Fonts, Material Symbols, KaTeX CSS, theme flash script
  2.  tsconfig.app.json    — noUnusedLocals: false (MUST be first edit)
  3.  src/index.css        — Full CSS vars (light + dark) + utility classes
  4.  tailwind.config.js   — Full token mapping + fontFamily + fontSize
  5.  src/types/index.ts   — All interfaces with Optional/nullable fields as specified
  6.  src/lib/firebase.ts
  7.  src/lib/supabase.ts
  8.  src/lib/store/*.ts   — All 4 stores
  9.  src/lib/api.ts       — All typed wrappers
  10. src/lib/utils.ts
  11. src/hooks/*.ts       — All hooks including usePlatformSecurity

PHASE 2 — UI Primitives
  12. ui/Button.tsx        — Primary (gradient CTA), Secondary, Ghost, Destructive
  13. ui/Input.tsx
  14. ui/Badge.tsx
  15. ui/Modal.tsx         — Framer Motion scale+fade, confirm variant
  16. ui/Toast.tsx         — Slide from right, max 3 visible
  17. ui/Skeleton.tsx      — All variants listed in Section ⓫
  18. ui/EmptyState.tsx
  19. ui/ProgressBar.tsx

PHASE 3 — Layout Shell
  20. layout/Sidebar.tsx
  21. layout/TopBar.tsx
  22. layout/BottomTabBar.tsx
  23. layout/AppShell.tsx
  24. App.tsx              — React Router v6, AnimatePresence, ProtectedRoute
  25. global/OfflineBanner.tsx
  26. global/CommandPalette.tsx

PHASE 4 — Pages (in this exact order)
  27. pages/Landing.tsx
  28. pages/Login.tsx + pages/Signup.tsx
  29. dashboard/* components → pages/Dashboard.tsx
  30. notes/NotesViewer.tsx (SECTION ❺ PROTOCOL) → pages/Notes.tsx
  31. practice/* components → pages/Practice.tsx
  32. pages/Skills.tsx      (reuses NotesViewer)
  33. pages/Leaderboard.tsx
  34. pages/Profile.tsx
  35. pages/Settings.tsx

PHASE 5 — Polish
  36. PWA config (vite-plugin-pwa + manifest.json)
  37. Framer Motion page transitions in App.tsx (AnimatePresence)
  38. Verify every page has Skeleton during load
  39. Verify every stat field is null-coalesced
  40. Run: tsc --noEmit → must pass with 0 errors

═══════════════════════════════════════════════════════════════
  ⓰ FINAL VERIFICATION CHECKLIST
═══════════════════════════════════════════════════════════════

Before declaring build complete, verify ALL of these:

□ tsc --noEmit passes with 0 errors
□ vite build completes with 0 errors
□ No `any` types in codebase (grep "as any" → 0 results)
□ No signed URL stored in Zustand or logged to console
□ Notes load in blob-URL iframe with correct height via postMessage
□ KaTeX renders correctly (CSS only, no manual init)
□ Theme toggle persists across page reload
□ New user with no data: Dashboard shows 0s, not NaN or crashes
□ Leaderboard with null scores: shows 0, not crash
□ Empty practice filter: shows EmptyState, not blank page
□ Vercel build: no CI failure from unused variable warnings

═══════════════════════════════════════════════════════════════

ExamForge Frontend Build Prompt v7.0
Stack: React 18 + Vite + TypeScript + Tailwind v3 + Firebase + Supabase
Design: The Academic Atelier (Tokyo Night dark / Sakura Pastel light)
Icons: Material Symbols Outlined | Fonts: Fraunces / Newsreader / Inter / Lora / Fira Code
No Redis | No Judge0 | No Piston | No DOMPurify | No Monaco — pure content delivery
All architectural bugs from v6 patched at prompt level.