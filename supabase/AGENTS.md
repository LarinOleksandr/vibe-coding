# supabase/AGENTS.md

## Scope

Applies to `supabase/**`.

---

## Local rules (extend root)

- This folder contains schema, policies, Edge Functions, and local Supabase config only.
- All schema changes are migration-driven; no direct edits.
- Edge Functions are adapters only; no domain logic.
- Review `KB_SUPABASE` before changes.
- Data model changes or destructive migrations require `$create-plan`.
