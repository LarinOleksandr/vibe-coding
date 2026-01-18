---
name: db-migration
description: Evolve Supabase schema and data without breaking contracts or RLS.
---

# skills/db-migration/SKILL.md

## Name

$db-migration

## Purpose

Evolve Supabase schema and data without breaking contracts or RLS.

## When to use

Invoke when any apply:

- create/alter/drop tables, columns, indexes, constraints
- modify RLS policies
- add/modify Edge Function DB behavior
- data backfill or transformation required

## Inputs

- Change goal (one sentence)
- Affected tables/entities
- Compatibility requirement (backward-compatible? breaking?)
- Data backfill required? (yes/no)

## Procedure

1. Classify change
   - additive/backward-compatible preferred
   - breaking or destructive -> require `$plan-creation`
2. Update contracts first (if core entities)
   - `shared/types/` (source of truth)
   - `shared/validation/` schemas for structured payloads
3. Write migration
   - explicit and reviewable
   - prefer additive steps (new columns/tables, nullable fields)
4. RLS update (if applicable)
   - follow `KB_SUPABASE`
5. Edge Functions update (if applicable)
   - validate inputs
   - return typed responses
6. Local apply and verification
   - apply migrations locally
   - verify schema state
   - verify RLS allow/deny paths
7. Backfill (if required)
   - explicit, testable step
   - verify counts and invariants
8. Tests
   - RLS allow/deny
   - function behavior
   - schema validation failure paths

## Acceptance checks

- Migration applies cleanly in local environment
- RLS enforced and tested for allowed + denied access
- Contracts and validators updated and consistent
- Backfill completed and verified (if applicable)
- Breaking changes have an explicit plan and rollout notes
