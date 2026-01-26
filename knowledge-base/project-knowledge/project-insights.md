# Project Insights Log

## [1.1]

- Standardized thread types and codes (`KB_THREADS`) and aligned docs/commands to the canonical format.

## [1.2]

- Added `KB_REPOSITORY_LAYOUT` and wired it into baseline context loads and documentation maintenance so placement guidance stays current as the repo grows.

## [1.3]

- Added a first-class design review workflow: `$design-review` (thread type `DR-###`) and a persisted design review artifact location under `knowledge-base/agents-artifacts/design-reviews/`.

## [1.4]

- Renamed the primary human guide to `docs/application-development-guide.md` and updated references.

## [1.5]

- Added framework-level UI and UX baseline docs (`KB_UI_BASELINE`, `KB_UX_BASELINE`) so frontend work starts consistent (shadcn-first) without baking in product-specific tokens or flows.

## [1.6]

- Added an agent-driven "app design setup" workflow for `frontend/web`: single preset source of truth in `frontend/web/config/app-design-preset.json`, an apply script, plus `$app-design-setup` and `$app-design-setup` to keep design initialization automated and repeatable.

## [1.7]

- Made "first contact / uninitialized project" handling explicit: when project foundation docs are empty/generic, the agent must ask for minimal product inputs and propose `$project-setup` before proceeding.

## [1.8]

- Replaced the feature-only plan with a full-scope project roadmap (`knowledge-base/project-knowledge/project-roadmap.md`) and updated framework references so early work proceeds item-by-item until Feature Development.

## [1.9]

- Switched the shadcn preset to the Vite template; single source of truth remains `frontend/web/config/app-design-preset.json`.

## [1.10]

- Made observability explicit in the project roadmap (`knowledge-base/project-knowledge/project-roadmap.md`) so it is planned and tracked, not treated as an afterthought.

## [1.11]

- Made Supabase operational expectations explicit: when touching Supabase, the agent must use Supabase CLI + migration files (and repo scripts when present) and should not delegate DB changes to the user via manual Supabase/Studio steps.

## [1.12]

- Standardized branch-per-thread workflow: the agent creates a branch derived from the thread name, pushes it, and opens a PR into `main` when possible (with a script-first workflow via `scripts/git-task-start.ps1` and `scripts/git-pr-create.ps1`).

## [1.13]

- Aligned repo skills with Codex’s supported repo-local path by moving skills into `.codex/skills` and updating all routes and docs to reference that location.


## [1.14]

- Moved workflow execution to skills only and removed slash command prompts.
- Updated docs and agent rules to reference skills as the single source of procedure.




