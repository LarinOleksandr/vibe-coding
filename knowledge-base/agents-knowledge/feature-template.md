# knowledge-base/agents-knowledge/feature-template.md

## Agent summary

- Single template for feature requests
- Agent chooses required sections based on complexity
- Do not plan or implement until required fields are confirmed

---

## Trigger and flow

- User can request a feature without mentioning this template.
- The agent classifies feature complexity and selects required sections.
- The agent drafts a feature brief from repo context, then asks the user to confirm or fill gaps.
- Ask only for missing required fields, in one pass, before planning or implementation.
- If a required field is unknown, write "Unknown" and confirm with the user.
- If scope/areas/risks/tests are unclear, propose them and confirm before implementation.
- Default delivery approach: ship the simplest solution that meets acceptance criteria.
- Proactively highlight likely issues, risks, and edge cases (including failure modes) before implementation.
- If the validation plan is unclear, invoke `/test <short feature description>` (or just `/test` if the thread context is sufficient) to draft a minimal, repo-consistent test plan before implementation.

---

## Complexity levels

**Small**

- Single component or service
- No schema/contract changes
- No new workflows or services

Required sections: Goal, Scope, Out of scope, Acceptance criteria, Affected areas, Constraints (if any), Validation plan.

**Medium**

- Multiple components or API surface changes
- Behavior changes across boundaries

Required sections: Small + Existing behavior, Data models, Edge cases, User impact, Dependencies/owners.

**Large**

- Schema/contract changes
- New agents/services/workflows
- Broad refactors

Required sections: Full template + Risks + References + Rollout/rollback.
Also invoke `$architecture-review` before implementation.

---

## Template

## Goal

Clear, single-sentence description of what is being built.

## Problem

What problem this feature solves. No background or history.

## Scope

What is included in this feature. List concrete capabilities only.

## Out of scope

What is explicitly excluded. Prevents accidental expansion.

## Acceptance criteria

Observable conditions that must be met for the feature to be considered complete.

## Affected areas

Folders, services, or modules expected to change.

## Constraints

Hard limits that must be respected (performance, security, API compatibility, architectural rules).

## Assumptions

Only assumptions required to proceed.

## Existing behavior

What the system does today that is relevant to this feature.

## Related code

Links or excerpts of code to be touched (only relevant parts).

## Data models

Relevant entities, DTOs, or schemas involved. Prefer `shared/types/`.

## Edge cases

Known special cases or failure modes specific to this feature.

## Validation plan

Tests to add/update and any required smoke paths.

## Dependencies/owners

External services, teams, or systems involved.

## User impact

Expected UX/behavior changes.

## Risks

Potential regressions or migration hazards.

## Rollout/rollback

Notes on rollout steps or how to safely revert.

## References

Links to prior decisions, threads, or schemas (only if relevant).

## Deliverables

Exact outputs expected from this feature (code, schemas, migrations, docs).
