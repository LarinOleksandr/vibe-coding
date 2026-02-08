---
name: review-ideas
description: Turn Ideas in `docs/ideas/` into classified Requests in `ROOT_WORK_REQUESTS`, with approval-gated project-knowledge updates.
---

# .codex/skills/review-ideas/SKILL.md

## Name

`$review-ideas`

## Purpose

Convert Ideas into Requests in a consistent, framework-native way.

This skill does not create or use “user requests”.

## Entities

- **Idea**: a Markdown file in `ROOT_IDEAS` (`docs/ideas/`)
- **Request**: a Markdown file in `ROOT_WORK_REQUESTS` (`docs-ai/agents-artifacts/work-requests/`)

## What this skill does

1. Lets you save chat content as an Idea (only into `docs/ideas/`)
2. Reviews Ideas one by one (earliest first) and turns them into one or more Requests
3. Proposes updates to project knowledge and applies them only after you approve
4. Moves the Idea into `deleted/`, `snoozed/`, or `processed/` based on your decision

## When to use

Invoke when any apply:

- you want to look at the current Ideas
- you want to turn Ideas into Requests
- you want to save something you said as an Idea

## Inputs (user-facing)

Supported intents:

- save as idea: “save as idea: …”
- review ideas: “review ideas” / “what ideas do we have?”

## Procedure

0. Worktree gate (required)
   - ensure you are working inside a Git worktree under `.worktrees/...` (see `KB_GIT_WORKTREES`)
   - run: `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-worktree-ensure.ps1 -ThreadName "<current thread name>"`
   - after the worktree is ready, do all work only inside that worktree folder

1. Route to the right action
   - use `ROOT_SKILLS/review-ideas/actions/router.md`

2. Follow the action procedure
   - save -> `ROOT_SKILLS/review-ideas/actions/save-idea.md`
   - review -> `ROOT_SKILLS/review-ideas/actions/review.md`
   - request schema -> `ROOT_SKILLS/review-ideas/actions/request-schema.md`

## Acceptance checks

- Ideas are written only under `docs/ideas/`
- Requests are written only under `ROOT_WORK_REQUESTS`
- Project knowledge files are edited only after explicit approval
- The user decides: delete / snooze / process

