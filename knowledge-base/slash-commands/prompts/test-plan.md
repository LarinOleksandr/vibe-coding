# /test-plan

---

title: test-plan

---

## Goal

Generate a comprehensive, repo-consistent test plan for the requested feature or change, inferred from thread context.

## Actions (agent must execute)

1. Restate the test target as a short statement.
2. Identify boundaries touched (choose only what applies):
   - Frontend UI
   - API / Edge Functions
   - Orchestrator workflows
   - Embeddings service
   - Supabase (schema/RLS)
3. Propose a minimal test suite using `KB_TESTING` expectations:
   - Use stack-defined frameworks and existing repo tooling (see `KB_TECH_STACK`); do not add new test dependencies without explicit approval (see `KB_REPOSITORY_RULES`)
   - Unit tests for core functions/validators used by the change
   - Integration tests for any new/changed API endpoints
   - Error-handling cases aligned with `KB_ERROR_HANDLING` and HTTP mapping from `KB_API_CONVENTIONS`
   - Edge cases and failure modes (per boundary touched); include at least one happy-path and one failure-path test per boundary, and include schema-validation failure cases when schemas are involved
4. Include mobile compatibility verification when UI/layout is involved:
   - manual mobile responsiveness check (small viewport, no clipped controls, no horizontal scrolling)
5. For each proposed test, include:
   - what it covers (happy/failure path)
   - inputs and expected outputs/behavior
   - where it should live (service/folder)
6. If any required details are missing (API shape, auth model, routes, schema), ask only for the minimum clarifications needed to write a correct test plan.
7. If the repo has runnable tests for the relevant area, run the smallest applicable test set and report results. If tests are not run, explicitly state why.

## Output format

### 1) Scope

- Target: `<one sentence>`
- Boundaries touched: `<list>`
- Assumptions: `<list or "None">`
- Risks / edge cases to prioritize: `<list>`

### 2) Unit tests

List proposed unit tests as:

- **Test**: `<name>`
- **Location**: `<path>`
- **Covers**: `<behavior>`
- **Cases**: `<bullet list>`

### 3) Integration tests (API / Edge)

List proposed integration tests as:

- **Endpoint**: `<method> <path>`
- **Location**: `<path>`
- **Happy path**: `<what to assert>`
- **Error handling**: `<status + error.code + message safety>`
- **Edge cases**: `<list>`

### 4) Mobile compatibility checks (UI)

- **Manual check**: small viewport pass criteria
- **Routes/views**: `<list>`

### 5) Next questions (only if blocked)

- `<question 1>`
- `<question 2>`

### 6) Execution report

- Ran tests: `<yes/no>`
- Commands: `<commands or "N/A">`
- Results: `<pass/fail summary, key failures if any>`
