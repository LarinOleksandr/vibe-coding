# /context-load

---

title: context-load

---

## Goal

Load only the general, cross-cutting project/repo context and provide a routing map for where to find deeper, need-based context later.

## Actions (agent must execute)

1. Read these files in order (baseline only):
   - `AGENTS.md`
   - `knowledge-base/agents-knowledge/roots.md`
   - `knowledge-base/agents-knowledge/repository_rules.md`
   - `knowledge-base/agents-knowledge/repository-layout.md`
   - `knowledge-base/agents-knowledge/tech_stack.md`
   - `knowledge-base/agents-knowledge/runtime.md`
   - `knowledge-base/agents-knowledge/tools.md`
   - `knowledge-base/agents-knowledge/threads.md`
   - `skills/skills.md`
   - `knowledge-base/slash-commands/README.md`
   - `knowledge-base/project-context.md`
   - `knowledge-base/product-development-roadmap.md`
   - `knowledge-base/project-insights.md`
2. Produce a concise **Context Snapshot** using the format below.
3. Ask exactly one question and stop: `What should we do next?`

## Rules

- Do not read any additional files beyond the baseline list above during this command execution.
- Do not read scoped `AGENTS.md` files (e.g., `frontend/AGENTS.md`, `ai/orchestrator/AGENTS.md`, `supabase/AGENTS.md`) as part of this command.
- Do not read specialized routed docs as part of this command.
- Do not read `knowledge-base/old/**` by default.
- Do not ask any other questions besides `What should we do next?`
- Keep summaries short and practical (bullets preferred); do not paste full file contents.

## Output format (required)

### Context Snapshot

- Project overview: `<3-6 bullets>`
- Repo shape (what exists today): `<3-6 bullets>`
- Non-negotiable rules: `<5-10 bullets>`
- Tech stack + runtime topology: `<3-8 bullets>`
- Collaboration workflow: `<3-8 bullets>`

### Where To Look Next (routing map)

List the most relevant routes and when to consult them (do not read them now):

- `KB_REPOSITORY_LAYOUT`: when deciding where to find/place files and services
- `KB_FEATURE_TEMPLATE`: when defining/confirming a feature brief
- `KB_FEATURE_RESEARCH`: when surfacing risks/constraints before planning
- `KB_DEPLOYMENT_CICD`: when deciding CI/CD or deployment policy
- `KB_TESTING`: when validation plan is unclear or behavior changes
- `KB_SCHEMAS_OUTPUTS`: when adding/changing structured outputs or schemas
- `KB_API_CONVENTIONS`: when adding/changing HTTP APIs or Edge Functions
- `KB_ERROR_HANDLING`: when designing error codes, envelopes, or user-safe messages
- `KB_SUPABASE`: when touching DB schema, RLS, policies, or Edge Functions
- `KB_ARCHITECTURE_PRINCIPLES`: when changes span layers or risk boundary violations
- `KB_RUNTIME`: when changing services, ports, or dependencies
- `KB_UI_BASELINE`: when building consistent UI components and styling rules
- `KB_UX_BASELINE`: when defining UI behavior for loading/empty/error states and feedback
- `KB_TOOLS`: when choosing canonical commands and scripts
- `KB_THREADS`: when starting a new thread or naming one
- `KB_CONTEXT_MAINTENANCE`: when modifying rules/routes/skills/slash commands or detecting duplication/conflicts
