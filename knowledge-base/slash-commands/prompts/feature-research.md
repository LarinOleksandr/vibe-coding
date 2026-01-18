# /feature-research

---

title: feature-research

---

## Goal

Produce a timeboxed feature research brief to surface risks, constraints, and default decisions before planning.

## Actions (agent must execute)

1. Restate the research target as a short statement.
2. Identify boundaries touched (choose only what applies):
   - Frontend UI
   - API / Edge Functions
   - Orchestrator workflows
   - Embeddings service
   - Supabase (schema/RLS/storage)
3. Apply `KB_FEATURE_RESEARCH` lenses (only what applies) and propose:
   - constraints + recommended defaults
   - key risks/abuse cases
   - failure modes + user-safe error expectations (see `KB_ERROR_HANDLING`)
   - decisions to confirm
   - open questions (blockers only)
4. If any required details are missing, ask only for the minimum clarifications needed to produce a correct brief.
5. Write the artifact:
   - `knowledge-base/agents-artifacts/research-briefs/<task-slug>.research.md`
   - do not overwrite an existing brief

## Output format

### Research Brief

- Feature: `<short name>`
- Timebox: `<e.g. 45 min>`
- Boundaries touched: `<list>`
- Assumptions: `<list or "None">`

### Risks and abuse cases

- `<bullets>`

### Constraints and recommended defaults

- `<bullets>`

### UX and failure modes

- `<bullets>`

### Operations and observability

- `<bullets>`

### Decisions to confirm

- `<bullets>`

### Open questions (blockers only)

- `<bullets>`

