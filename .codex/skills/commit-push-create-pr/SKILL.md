---
name: commit-push-create-pr
description: Use when work is complete and you want to commit it, push it to GitHub, and create a PR.
---

# .codex/skills/commit-push-create-pr/SKILL.md

## Name

`$commit-push-create-pr`

## Purpose

Commit current work, push it to GitHub, create a PR, and guide the next feature selection.

## When to use

Invoke when any apply:

- feature work is complete and ready to commit
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
4. If a commit was created, push the branch and create a PR into `main` (prefer scripts in `scripts/`).
5. In all cases (commit succeeds, fails, or nothing to commit), show the feature list and statuses from `DOC_PROJECT_ROADMAP` (Feature Development section), including subfeatures.
   - If `DOC_PROJECT_ROADMAP` is missing, fall back to `DOC_PROJECT_FEATURE_PLAN` if present.
6. Ask what feature should be developed next and require a feature number.
7. If the selection is `In Progress` or `Completed`, inform the user and ask for another number.
8. After a valid selection, return a compliant thread name suggestion (`KB_THREADS`).

## Commands

- `git rev-parse --abbrev-ref HEAD`
- `git status --porcelain`
- `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-task-start.ps1 -ThreadName "<current thread name>"` (only if on main/master)
- `git add .`
- `git commit -m "<type>: <AUTO_SUMMARY_OF_COMPLETED_WORK>"`
- `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-pr-create.ps1` (only if a commit was created)

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
- Commit, push, and create a PR
- Ask for next feature number

## Acceptance checks

- Branch confirmed
- Docs updated
- Commit created or explicitly noted as nothing to commit
- Branch pushed (when a commit exists)
- PR created (when possible)
- Next feature selection requested
