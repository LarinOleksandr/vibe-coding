# /code-review

---

title: code-review

---

## Goal

Run a dedicated Codex code review in a separate `CR-###` thread, focused only on the PR diff (not the full feature-development context).

## Actions (agent must execute)

1. If the current thread is not a code-review thread (`[project] | CR-###: ...`):
   - Suggest a compliant thread name (use the current branch name if available).
   - Ask the user to start a new thread with that name and re-run `/code-review`, then stop.
2. Invoke `$code-review` and follow its procedure.
