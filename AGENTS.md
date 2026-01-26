# AGENTS.md

## Routing rules

Canonical path aliases: see `knowledge-base/agents-core-knowledge/roots.md`.

## Automatic agentic invocation

Agent may automatically invoke additional steps when risk or complexity is detected:

- `$project-setup` when the user provides an idea/PRD and the project foundation docs are missing, empty, clearly outdated, or still generic placeholders.
  - If the agent detects the project has not been initialized yet (no real product info in `DOC_PROJECT_CONTEXT`, `DOC_PROJECT_ROADMAP`, `DOC_PROJECT_INSIGHTS`), it must first ask for the PRD or minimal product inputs (Product, Users, Problem, Success, Constraints, Out of scope) and then propose `$project-setup`.
- `$feature-development` when the user requests a new feature or behavior change and requirements are unclear.
- `$feature-research` when the feature touches risky areas (uploads, permissions, external integrations, PII, authZ).
- `$plan-creation` for large or complex changes (multiple components, schema/contract changes, new agent/service/workflow, or shared/core refactors). Plans are written to `ROOT_AGENTS_ARTIFACTS/plans/<task-slug>.plan.md`.
- `$architecture-review` for cross-boundary changes, new services/workflows, or likely architecture conflicts.
- `$api-endpoint-development` when adding or changing API/Edge Function endpoints or their contracts.
- `$db-migration` when schema, RLS, or migrations are involved.
- `$new-agent-development` when orchestrator workflows/nodes or output schemas change.
- `$documents-export` when adding or changing export formats or templates.
- `$test-plan <feature>` when validation needs are unclear or when changes touch UI behavior or API endpoints; propose it and ask the user to confirm before generating the plan.
- `$testing-in-browser` when UI behavior changes require manual verification; propose it and ask the user to confirm before running it.
- `$feature-commit` when feature scope is complete and validation is acceptable; propose it and ask the user to confirm before committing.
- `$context-maintenance` when changes touch documentation, routed knowledge, skills, or any AGENTS rules/routes; resolve routing and duplication and update project docs when needed.

When auto-invoked, the agent pauses implementation, explains why, and asks for any missing inputs or required approvals before running the skill.

---

