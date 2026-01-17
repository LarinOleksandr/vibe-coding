# Project Insights Log

## [1]
- Documented `skills/dev-debug-workflow/SKILL.md` to capture the canonical DevTools run-inspect-fix cycle (start the stack, connect via MCP, capture console/network errors, and repeat edits) so future debugging tasks follow a single workflow.

## [1.2]
- Added `$dev-debug-workflow` to the AGENTS skill list so the DevTools debug routine is explicitly invokable from instructions.

## [1.3]
- Added `/test-browser` under `knowledge-base/slash-commands/prompts/test-browser.md` to run the dev stack and check errors via MCP DevTools.

## [1.4]
- Added cross-platform fallback dev commands to `knowledge-base/agents-knowledge/tools.md` to keep the setup generic across package managers and OS scripts.

## [1.5]
- Updated `/test-browser` to select `pnpm`, `npm`, or `yarn` based on availability to avoid hangs when `pnpm` is missing.

## [1.6]
- Updated `/test-browser` to read the dev server output for the actual host/port instead of assuming `localhost:3000`.

## [1.7]
- Mirrored dev server URL detection in `skills/dev-debug-workflow/SKILL.md` to keep the skill in sync with `/test-browser`.

## [1.8]
- Added `knowledge-base/agents-knowledge/roots.md` to centralize canonical path aliases for instruction references.

## [1.9]
- Updated `roots.md` to use repo-root relative paths (prefixed with `./`).

## [1.10]
- Re-indexed `knowledge-base/agents-knowledge/roots.md` after the folder restructure to point at the new repo-root paths.

## [1.11]
- Added brief descriptions to each `roots.md` alias to clarify what each route contains.

## [1.12]
- Renamed `codex-behaviour-architecture.md` to `agent-behaviour-architecture.md` and updated references.

## [1.13]
- Added missing knowledge/documentation routes to `knowledge-base/agents-knowledge/roots.md` for repository rules, DDD guidance, and artifacts.

## [1.14]
- Added a self-reference alias (`KB_ROOTS`) to `knowledge-base/agents-knowledge/roots.md`.

## [1.15]
- Added scoped AGENTS aliases to `knowledge-base/agents-knowledge/roots.md` for ai, frontend, infra, and supabase folders.

## [1.16]
- Added `ROOT_DOCS` and `DOC_SLASH_COMMANDS_README` to `knowledge-base/agents-knowledge/roots.md`.

## [1.17]
- Replaced routed links in AGENTS files with `roots.md` aliases and added the `KB_ROOTS` pointer at the root.

## [1.18]
- Moved project documentation rules into `knowledge-base/agents-knowledge/project-doc-maintenance.md` and linked it from `KB_PROJECT_DOC_MAINTENANCE`.

## [1.19]
- Moved the skills list into `skills/skills.md`, referenced from `DOC_SKILLS_LIST` in `roots.md`, and linked from `AGENTS.md`.

## [1.20]
- Updated slash commands to reference `roots.md` aliases instead of hardcoded paths.

## [1.21]
- Updated skills to reference `roots.md` aliases instead of hardcoded paths.
