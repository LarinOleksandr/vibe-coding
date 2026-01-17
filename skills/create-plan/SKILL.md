---
name: create-plan
description: Create a concrete, executable plan file for large or risky changes.
---

# skills/create-plan/SKILL.md

## Name

$create-plan

## Purpose

Create a concrete, executable plan file for large or risky changes. If the plan includes coding, include an implementation plan with step-by-step instructions and verification per step.

## When to use

Invoke when any apply:

- change spans multiple components or layers
- schema, contract, or data model changes
- new agent, workflow, or service
- refactor touching shared or core logic

## Inputs

- Goal (one sentence)
- Scope (in / out; if missing, the agent proposes and confirms)
- Affected areas (folders/components; if missing, the agent proposes and confirms)
- Risks (if any; if missing, the agent proposes and confirms)
- Validation intent (optional; if missing, the agent proposes it)

## Output location

- File path: `ROOT_AGENTS_ARTIFACTS/plans/<task-slug>.plan.md`
- One plan file per task
- Do not overwrite plans from other tasks
- Use a short kebab-case task slug derived from the goal

## Procedure

1. Identify change boundaries
   - list touched components/layers
   - list contracts/schemas/data affected
   - if scope/areas/risks are unclear, propose and confirm before finalizing the plan
2. Define implementation steps (ordered)
   - smallest viable sequence
   - include dependency ordering
3. If coding is involved, include an implementation plan
   - small, specific steps with no code
   - each step includes a verification method (test/check/inspection)
   - focus on the base application, not full feature expansion
4. Define validation plan
   - tests to add/update
   - smoke path(s)
   - schema validation points
   - if not provided, propose validation with brief rationale
5. Define rollback notes (only if data/schema involved)
6. Write or update the plan file
   - minimal and executable
   - reflects current intended approach

## Plan file structure (required)

- Goal
- Scope / Non-scope
- Affected areas
- Steps (ordered)
- Implementation plan (coding only; each step includes verification)
- Risks
- Validation (tests + smoke path)
- References (optional; existing plans or architecture reviews)
- Rollback notes (only if applicable)

## Acceptance checks

- Planning triggers applied correctly
- Plan file exists in `ROOT_AGENTS_ARTIFACTS/plans/`
- Steps are ordered and implementable
- Implementation plan included for coding tasks with verification per step
- Validation is concrete and testable
- Schema/contract impacts are explicit
- Rollback included when data/schema is affected
