---
name: commit-push-create-pr
description: Use when work is complete and you want to commit it, push it to GitHub, and optionally create a PR.
---

# .codex/skills/commit-push-create-pr/SKILL.md

## Name

`$commit-push-create-pr`

## Purpose

Commit current work, publish it to GitHub, update documentation, then show a simple next-action menu.

## When to use

Invoke when any apply:

- work is complete and ready to commit (feature, bug fix, refactor, or docs change)
- user requests a commit
- user says they want to finish, wrap up, or save the work

## Inputs

- Current thread name (for branch naming)

## Procedure

1. Ensure work is on a branch (not `main`/`master`).
   - If on `main` or `master`, create/switch to a branch derived from the current thread name (`KB_THREADS`).
2. Check for changes (tracked or untracked).
3. If changes exist, run a quick verification gate.
   - Pick the first proof command that exists and run it now:
     - If `scripts/verify.ps1` exists: run it.
     - If `frontend/web/package.json` exists: run the frontend checks (for example `npm test` or `npm run build`).
     - If `ai/orchestrator` has a test runner configured: run its tests.
     - Otherwise: verification is `Skipped` (no proof command found).
   - If the proof command fails, stop. Do not commit or push.
4. If changes exist:
   - Update project docs (minimal edits, only when needed):
     - `knowledge-base/project-knowledge/project-context.md`
     - `knowledge-base/project-knowledge/project-roadmap.md`
     - `knowledge-base/project-knowledge/project-insights.md`
   - Rules for doc updates:
     - Roadmap: update status lines for what you just finished.
     - Insights: add only durable decisions/lessons (not routine progress).
     - Context: update only if product goals, constraints, or tech stack changed.
   - Stage everything.
   - Generate a commit message based on branch type:
     - `feature/*` -> `feat: ...`
     - `bugfix/*` -> `fix: ...`
     - `refactor/*` -> `refactor: ...`
     - `docs/*` -> `docs: ...`
     - otherwise -> `chore: ...`
   - Create the commit.
5. If a commit was created, publish it to GitHub (push).
6. Show the overall roadmap from `DOC_PROJECT_ROADMAP` with statuses.
7. Show the next-action menu and ask the user to pick one option:
   - 1. Merge into `main`
   - 2. Create PR (optional)
   - 3. Start next roadmap item
8. Handle the chosen option:
   - If 1: merge the current branch into `main` and report the outcome.
   - If 2: attempt to create a PR (if not possible automatically, explain what the user should do next in simple words).
   - If 3: ask the user to pick the next roadmap item (paste the exact item line), then return a compliant thread name suggestion (`KB_THREADS`).

## Commands

- `git rev-parse --abbrev-ref HEAD`
- `git status --porcelain`
- (optional) `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/verify.ps1` (only if it exists)
- `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-task-start.ps1 -ThreadName "<current thread name>"` (only if on main/master)
- `git add .`
- `git commit -m "<type>: <AUTO_SUMMARY_OF_COMPLETED_WORK>"`
- Push: `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-pr-create.ps1 -SkipGh` (only if a commit was created)
- Create PR (optional): `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-pr-create.ps1` (only if a commit was created)
- Merge into main: `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-merge-main.ps1`

## User-facing output (keep it non-technical)

When reporting results to the user, prefer outcomes over commands.

Say:

- whether verification was run and the result (Pass/Fail/Skipped)
- overall status (Success/Stopped)
- branch name
- whether a commit was created (Yes/No)
- whether the branch was pushed (Yes/No)
- whether a PR was created (Yes/No, only if the user chose option 2)
- if the user chose option 1: whether merge into main succeeded (Yes/No)
- if the user chose option 3: suggested next thread name

Avoid:

- printing the full commit message
- printing script names or command lines

## Rules

- Do not ask the user anything before the commit step.
- Do not create tags.
- If `git commit` fails because there is nothing to commit, output `nothing to commit` and continue to step 6.

## Quick reference

| Do                               | Do not                 |
| -------------------------------- | ---------------------- |
| Update docs before commit        | Skip doc updates       |
| Use branch-based commit prefixes | Use arbitrary prefixes |

## Example

User: "Commit the feature."

You:

- Ensure branch
- Update docs
- Commit and push
- Show roadmap
- Show menu: merge / create PR / start next roadmap item

## Acceptance checks

- Branch confirmed
- Verification status reported (Pass/Fail/Skipped)
- Docs updated
- Commit created or explicitly noted as nothing to commit
- Branch pushed (when a commit exists)
- Roadmap shown with statuses
- Menu shown and user picked an option
