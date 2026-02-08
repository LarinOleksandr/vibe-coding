# Request Schema (work-requests)

## Goal

Create Requests that are ready to use with existing framework skills.

## Location

Requests live under:

- `ROOT_WORK_REQUESTS` -> `docs-ai/agents-artifacts/work-requests/`

## File naming

- `REQ-NNN-<slug>.md`

## Required frontmatter

- `status: pending`
- `created_at: YYYY-MM-DD`
- `source_idea: docs/ideas/<file>.md`
- `work_type: <one of the classification values below>`
- `recommended_skill: <skill-name>`

## Classification values (work_type → recommended_skill)

Use the existing framework work types:

- `feature` → `feature-development`
- `bug-fix` → `bug-fix`
- `refactor` → `code-refactoring`
- `docs` → `context-maintenance`
- `experiment` → (no dedicated skill; treat as experiment thread and timebox it)
- `architecture` → `architecture-review`
- `security` → `security-check`
- `performance` → `optimize-performance`
- `api` → `api-endpoint-development`
- `db` → `db-migration`
- `agent` → `new-agent-development`
- `export` → `documents-export`
- `testing` → `test-plan`

If unsure:

- `work_type: other`
- `recommended_skill: feature-development`

## Required sections

# <Title>

## What (expected result)

What should be true when this is done.

## Why (project relevance)

How this supports the project purpose/goals.

## Scope

What is included.

## Out of scope

What is not included.

## Acceptance criteria

Observable “done” conditions.

## Constraints

Constraints the user stated (or “Unknown”).

## Suggested next step

One line:

- “Start the right thread type and run `$<recommended_skill>` using this Request file as input.”

