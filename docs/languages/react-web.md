# Modern Frontend & React Conventions

Applies whenever the project (or current task) involves React, Next.js, or Modern Web UI.

---

## 1. Core Principles

- **TypeScript Everywhere**: Always use strict TypeScript with explicit prop interfaces. Never use `any`.
- **Component Anatomy**:
  - Keep components small (< 250 lines). Split large UI blocks into focused sub-components.
  - Separate stateful containers/hooks from pure presentational components.
- **Server vs Client (Next.js App Router)**:
  - Default to React Server Components (RSC).
  - Only mark components with `'use client'` when they require interactivity (`useState`, `useEffect`, browser event listeners).
- **Accessibility (a11y)**:
  - All interactive elements must have semantic tags (`<button>`, `<a>`, `<input>`) or explicit ARIA attributes.
  - Interactive elements must be keyboard navigatable (`Tab`, `Enter`, `Space`) with visible focus outlines.

---

## 2. Directory Structure (Feature-Driven)

```
src/
├── app/ (or routes/)         # Pages and layout definitions
├── components/
│   ├── ui/                   # Reusable atomic design primitives (Button, Modal, Input)
│   └── common/               # Shared compound components (Navbar, Footer, Sidebar)
├── features/                 # Domain-driven features
│   ├── auth/
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── api/              # Queries and mutations
│   │   └── types.ts
│   └── billing/
├── hooks/                    # Cross-cutting custom hooks
├── lib/                      # Third-party wrappers (queryClient, supabase, etc.)
└── styles/                   # Global tokens, theme definitions
```

---

## 3. State Management & Data Fetching

- **Server State vs Client State**:
  - Do not copy server response data into local `useState` or Redux/Zustand unless actively editing.
  - Use modern cache-first data fetching (React Query / TanStack Query, SWR, or Next.js server actions).
- **Effect Discipline**:
  - Do not use `useEffect` for data transformations that can be derived directly from props/state.
  - Clean up event listeners, timers, and abort controllers in return callbacks.

---

## 4. Performance & Styling

- Optimize images using native framework components (`next/image`) with explicit width/height and responsive `sizes`.
- Avoid layout shifts (CLS) by reserving space for dynamic content and loaders.
- Avoid inline function allocations in high-frequency list renders.
