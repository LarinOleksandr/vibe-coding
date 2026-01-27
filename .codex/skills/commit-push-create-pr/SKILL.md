---
name: commit-push-create-pr
description: Use when work is complete and you want to commit it and publish it to GitHub (push, optional PR).
---

# .codex/skills/commit-push-create-pr/SKILL.md

## Name

`$commit-push-create-pr`

## Purpose

Commit current work, push it to GitHub, optionally create a PR, and guide the next roadmap item selection.

## When to use

Invoke when any apply:

- work is complete and ready to commit (feature, bug fix, refactor, or docs change)
- user requests a commit

## Inputs

- Current thread name (for branch naming)

## Procedure

1. Ensure work is on a branch (not `main`/`master`).
   - If on `main` or `master`, create/switch to a branch derived from the current thread name (`KB_THREADS`).
2. Check for changes (tracked or untracked).
3. If changes exist:
   - Update project docs using `$project-docs-update`.
   - Stage everything.
   - Generate a commit message based on branch type:
     - `feature/*` -> `feat: ...`
     - `bugfix/*` -> `fix: ...`
     - `refactor/*` -> `refactor: ...`
     - `docs/*` -> `docs: ...`
     - otherwise -> `chore: ...`
   - Create the commit.
4. If a commit was created, publish it to GitHub (push).
   - Ask: "Create a PR too? (Yes/No)"
   - If Yes: push and attempt PR creation.
   - If No: push only.
5. In all cases (commit succeeds, fails, or nothing to commit), show the overall roadmap from `DOC_PROJECT_ROADMAP` with statuses.
6. Ask: "Pick the next roadmap item now? (Yes/No)"
7. If Yes:
   - Ask what roadmap item should be developed next.
   - Require the user to pick one item (paste the exact item line).
   - If the selection is `In Progress` or `Completed`, inform the user and ask for another item.
   - After a valid selection, return a compliant thread name suggestion (`KB_THREADS`) for the selected item.
8. If No: stop after showing the roadmap.

## Commands

- `git rev-parse --abbrev-ref HEAD`
- `git status --porcelain`
- `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-task-start.ps1 -ThreadName "<current thread name>"` (only if on main/master)
- `git add .`
- `git commit -m "<type>: <AUTO_SUMMARY_OF_COMPLETED_WORK>"`
- Push + PR (if user says Yes): `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-pr-create.ps1` (only if a commit was created)
- Push only (if user says No): `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-pr-create.ps1 -SkipGh` (only if a commit was created)

## Rules

- Do not ask the user anything before the commit step.
- Do not create tags.
- If `git commit` fails because there is nothing to commit, output `nothing to commit` and continue to step 5.

## Quick reference

| Do | Do not |
| --- | --- |
| Update docs before commit | Skip doc updates |
| Use branch-based commit prefixes | Use arbitrary prefixes |

## Example

User: "Commit the feature."

You:
- Ensure branch
- Update docs
- Commit
- Ask whether to create a PR
- Show roadmap and ask for the next roadmap item

## Acceptance checks

- Branch confirmed
- Docs updated
- Commit created or explicitly noted as nothing to commit
- Branch pushed (when a commit exists)
- PR created only if the user chose Yes and it was possible
- Roadmap shown with statuses
- Next roadmap item selection requested (or explicitly deferred by the user)
