# frontend/AGENTS.md

## Scope

Applies to `frontend/**`.

---

## Local rules (extend root)

- React + TypeScript strict; no implicit `any` or unsafe casts.
- Use functional React components + hooks; avoid class components.
- Keep components small and focused; prefer composition over large multipurpose components.
- Keep business logic out of UI components; place it in hooks, services, and shared modules.
- Routing maps wizard steps to URLs (React Router).
- Server/async state via TanStack Query only.
- Validate user input and agent outputs with Zod before render.
- Prefer shadcn/ui + Tailwind; avoid parallel UI systems.
- Mobile-first responsive design by default; use Tailwind breakpoints to progressively enhance for larger screens.
- Rich text editing via TipTap; workflow/agent graphs via React Flow.
- Reuse shared contracts:
  - Core entity types from `shared/types/`
  - Schemas from `shared/validation/` when applicable

---

## Testing

- Update tests for behavior changes.
- For flow changes, include at least one UI-level smoke path when available.
