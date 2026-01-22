# Project Insights Log

## [1.1]

- Standardized thread types and codes (`KB_THREADS`) and aligned docs/commands to the canonical format.

## [1.2]

- Added `KB_REPOSITORY_LAYOUT` and wired it into baseline context loads and documentation maintenance so placement guidance stays current as the repo grows.

## [1.3]

- Added a first-class design review workflow: `/design-review` (thread type `DR-###`) and a persisted design review artifact location under `knowledge-base/agents-artifacts/design-reviews/`.

## [1.4]

- Renamed the primary human guide to `docs/application-development-guide.md` and updated references.

## [1.5]

- Added framework-level UI and UX baseline docs (`KB_UI_BASELINE`, `KB_UX_BASELINE`) so frontend work starts consistent (shadcn-first) without baking in product-specific tokens or flows.

## [1.6]

- Added an agent-driven “app design setup” workflow for `frontend/web`: single preset source of truth in `frontend/web/config/app-design-preset.json`, an apply script, plus `$app-design-setup` and `/app-design-setup` to keep design initialization automated and repeatable.

## [1.7]

- Made “first contact / uninitialized project” handling explicit: when project foundation docs are empty/generic, the agent must ask for minimal product inputs and propose `/project-setup` before proceeding.

## [1.8]

- Replaced the feature-only plan with a full-scope product development roadmap (`knowledge-base/product-development-roadmap.md`) and updated framework references so early work proceeds item-by-item until Feature Development.

## [1.9]

- Switched the shadcn preset to the Vite template; single source of truth remains `frontend/web/config/app-design-preset.json`.
