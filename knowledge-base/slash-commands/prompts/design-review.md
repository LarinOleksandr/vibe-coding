# /design-review

---

title: design-review

---

## Goal

Run a dedicated design review in a separate `DR-###` thread and produce a short, actionable design review artifact.

## Actions (agent must execute)

1. If the current thread is not a design-review thread (`[project] | DR-###: ...`):
   - Suggest a compliant thread name (use the current branch name if available).
   - Ask the user to start a new thread with that name and re-run `/design-review`, then stop.
2. Invoke `$design-review` and follow its procedure.

