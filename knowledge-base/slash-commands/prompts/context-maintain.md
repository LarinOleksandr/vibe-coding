# /context-maintain

---

title: context-maintain

---

## Goal

Run a documentation + knowledge + methodology maintenance pass for the instruction framework (no product code changes).

## Actions (agent must execute)

1. Ask for (or infer) the trigger: what decision/change prompted the maintenance run.
2. Invoke `$context-maintenance` and follow its procedure.
   - Ensure `KB_REPOSITORY_LAYOUT` is updated when repo shape changed (folders, runtime boundaries, artifact categories).
3. Summarize what changed and why, and list any follow-ups.
