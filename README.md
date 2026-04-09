# ExamForge — Industrial Education Platform

A professional, high-performance monorepo for technical exam preparation, utilizing a hybrid SQLite/Supabase architecture.

## 📁 Repository Structure

- **`/frontend`**: React + Vite application using the "Premium Academic" design system. Linked to Vercel for continuous deployment.
- **`/backend`**: FastAPI service suite providing content retrieval (SQLite) and user state management (Supabase).
- **`/docs`**: Centralized documentation, architectural diagrams, and historical prompt logs.

## 🚀 Quick Start

### Backend
1. Navigate to `/backend`.
2. Configure your `.env` following `.env.example`.
3. Start the server: `uvicorn main:app --reload`.

### Frontend
1. Navigate to `/frontend`.
2. Install dependencies: `npm install`.
3. Start development: `npm run dev`.

## 🛠️ Technology Stack
- **Frontend**: React, Vite, Framer Motion, TailwindCSS, Zustand.
- **Backend**: FastAPI, Pydantic, SQLAlchemy/SQLite.
- **Infrastructure**: Supabase (Auth/DB), Firebase (Storage), Vercel.

## ⚖️ Database Architecture
- **Content Service**: SQLite (`content.db`) for high-speed, read-only access to thousands of questions.
- **User Service**: Supabase for real-time progress, profiles, and cross-device sync.
