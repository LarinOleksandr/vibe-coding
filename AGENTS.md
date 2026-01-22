# AGENTS.md

## Title

Rules, Constraints and Routing for Coding Agent.

---

Canonical path aliases: see `KB_ROOTS`.

## Hard rules (non-negotiable)

## Security & Data Safety

- Never commit secrets; only `.env.example` and variable names.
- Validate all external/client input before use.

## Repository Rules (Config & Architecture)

- `KB_REPOSITORY_RULES` is canonical for repo structure, runtime boundaries, and configuration layering.

## Scope & Assumptions

- Assume inputs are incomplete unless stated otherwise; make minimal assumptions and state them explicitly.
- If scope, affected areas, risks, or tests are unclear, propose and confirm before implementation.

## Agent State & Outputs

- Structured outputs must follow `KB_SCHEMAS_OUTPUTS`.
- Agents are stateless by default; persistence must be explicit.

---

## Routing rules

Consult routed docs before changes when applicable:

- Architecture boundaries and placement -> `KB_ARCHITECTURE_PRINCIPLES`
- Repo layout and placement ("where to find/put things") -> `KB_REPOSITORY_LAYOUT`
- Runtime topology, ports, dependencies -> `KB_RUNTIME`
- Schemas, validation, outputs -> `KB_SCHEMAS_OUTPUTS`
- Supabase usage, migrations, policies -> `KB_SUPABASE`
- Testing strategy and smoke paths -> `KB_TESTING`
- Tools and canonical commands -> `KB_TOOLS`
- Threading rules -> `KB_THREADS`
  - Error handling patterns -> `KB_ERROR_HANDLING`
  - API conventions (REST, pagination, errors) -> `KB_API_CONVENTIONS`
  - External specs and doc resolution -> `KB_EXTERNAL_SPECS`
  - Feature development template (required for feature work) -> `KB_FEATURE_TEMPLATE`
  - Feature research brief (pre-planning) -> `KB_FEATURE_RESEARCH`
  - Context maintenance -> `KB_CONTEXT_MAINTENANCE`
  - Deployment and CI/CD -> `KB_DEPLOYMENT_CICD`

---

## Automatic agentic invocation

Agent may automatically invoke additional steps when risk or complexity is detected:

- `/project-setup` when the user provides an idea/PRD and the project foundation docs are missing, empty, clearly outdated, or still generic placeholders.
  - If the agent detects the project has not been initialized yet (no real product info in `DOC_PROJECT_CONTEXT`, `DOC_PRODUCT_DEVELOPMENT_ROADMAP`, `DOC_PROJECT_INSIGHTS`), it must first ask for the PRD or minimal product inputs (Product, Users, Problem, Success, Constraints, Out of scope) and then propose running `/project-setup`.
- `$plan-creation` for large or complex changes (multiple components, schema/contract changes, new agent/service/workflow, or shared/core refactors). Plans are written to `ROOT_AGENTS_ARTIFACTS/plans/<task-slug>.plan.md`.
- `$architecture-review` for cross-boundary changes, new services/workflows, or likely architecture conflicts.
- `/test-plan <feature>` when validation needs are unclear or when changes touch UI behavior or API endpoints; propose it and ask the user to confirm before generating the plan.
- `/test-in-browser` when UI behavior changes require manual verification; propose it and ask the user to confirm before running it.
- `/feature-commit` when feature scope is complete and validation is acceptable; propose it and ask the user to confirm before committing.
- `$context-maintenance` when changes touch documentation, routed knowledge, skills, slash commands, or any AGENTS rules/routes; resolve routing and duplication and update project docs when needed.

When auto-invoked, the agent pauses implementation, explains why, and asks for any missing inputs.

---

## Definition of done

- Tests and validations pass; no TypeScript errors.
- If tests are not added or run, state why.
- Schemas/validators updated where behavior changed.
- DB changes include migrations + contract/schema updates.
- Planning artifact updated when required.
- Generated artifacts handled via product flow, not committed.
- Instruction docs or skills updated if workflow or constraints changed.

---

## Agents Instruction scope

- Nearest `AGENTS.md` applies to modified files.
- Expected scoped locations:
  - `AGENTS_FRONTEND`
  - `AGENTS_AI_ORCHESTRATOR`
  - `AGENTS_AI_EMBEDDINGS`
  - `AGENTS_SUPABASE`
  - `AGENTS_INFRA` (if applicable)

---

## Skills (procedural)

Skill list and descriptions live in `DOC_SKILLS_LIST`.

---

## Project Documentation

Project documentation rules are defined in `KB_PROJECT_DOC_MAINTENANCE`.
