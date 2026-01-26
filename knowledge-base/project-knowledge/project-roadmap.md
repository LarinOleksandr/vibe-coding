# Project Roadmap

This roadmap tracks the full scope of getting from "idea" to a shipped product: foundations, setup work, capabilities (DB/auth/etc.), feature delivery, and release readiness.

## How to use this document

- This is the single "what's next?" list for the product.
- It is intentionally extensible: add/remove sections as needed (AI services, external APIs, payments, etc.).
- Work proceeds item-by-item until you reach **Feature Development**, then continues feature-by-feature.
- Progress/status updates belong here.

## Roadmap

### Foundations (repo + workflow)

- [In Progress] Repository framework (workflows + commands)
  - [Completed] Standardize thread types and codes
  - [Completed] Add repository layout and wire it into maintenance
  - [Completed] Add design review workflow (`$design-review`, `DR-###`)
  - [Completed] Update application development guide
  - [Completed] Add UI/UX baseline routed docs (shadcn-first)
  - [Completed] Add app design setup workflow (preset + script + skill + command)
  - [Completed] Add explicit first-contact project setup intake rule
  - [Completed] Convert feature plan into product development roadmap (rename + reference updates)
  - [Completed] Add branch-per-thread workflow (branch naming, PRs, delete after merge)
  - [Completed] Move repo skills to `.codex/skills` (repo-local standard path)

### Product definition (required before building real features)

- [Not Started] Define product idea and initial roadmap (`$project-setup`)

### Frontend foundation (`frontend/web`)

- [Not Started] Confirm web app foundation (React + TypeScript + Vite) and basic run/test scripts
- [Not Started] Ensure the design system preset is applied and reproducible (`$app-design-setup`)
- [Not Started] Establish a minimal UI smoke path (load app, basic form validation, loading state)

### Platform capabilities (add only what is in scope)

- [Not Started] Database integration (Supabase) and local stack verification
- [Not Started] Authentication integration (Supabase Auth) and RLS alignment
- [Not Started] Payments integration (only if in scope)
- [Not Started] External API integrations (only if in scope)
- [Not Started] AI services integration (only if in scope)

### Feature Development

Use this section to track product features once foundations and required capabilities are in place.

- 1. [Not Started] Implement first product feature (TBD)

### Release & Operations

- [Not Started] Deployment and go-live readiness (CI/CD, env vars, smoke checks)

### Observability

- [Not Started] Observability baseline (error tracking, analytics, logs)




