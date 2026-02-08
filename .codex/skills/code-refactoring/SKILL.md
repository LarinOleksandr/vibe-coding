---
name: code-refactoring
description: Perform a structural change without altering external behavior.
---

# .codex/skills/code-refactoring/SKILL.md

## Name

`$code-refactoring`

## Purpose

Perform a structural change without altering external behavior.

## When to use

Invoke when any apply:

- code needs cleanup or reorganization
- behavior must remain unchanged
- refactor spans multiple files or folders

## Inputs

- Refactor goal (one sentence)
- Must-not-change constraints (APIs, outputs, behavior)
- Optional references (plan or architecture review)

## Procedure

0. Worktree gate (required)
   - ensure you are working inside a Git worktree under `.worktrees/...` (see `KB_GIT_WORKTREES`)
   - run: `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/git-worktree-ensure.ps1 -ThreadName "<current thread name>"`
   - after the worktree is ready, do all work only inside that worktree folder
1. Review protected contracts
   - read `DOC_PROJECT_PROTECTED_CONTRACTS`
   - treat it as the default must-not-change set for refactors
2. Confirm intent
   - verify behavior must remain unchanged
3. Propose scope and risks
   - list affected areas and potential regressions
   - confirm before edits
4. Check for existing artifacts
   - use `ROOT_AGENTS_ARTIFACTS/plans/<task-slug>.plan.md` if present
   - use `ROOT_AGENTS_ARTIFACTS/architectural-reviews/<task-slug>.arch-review.md` if present
5. Decide validation
   - propose tests or smoke paths
   - confirm before edits
6. Implement minimal changes
   - avoid unrelated refactors
7. Summarize and report
   - what changed
   - validation status
   - if the refactor introduced or clarified a stable contract people will rely on, propose adding it to `DOC_PROJECT_PROTECTED_CONTRACTS` (simple words; user approves/rejects)

## Acceptance checks

- Behavior unchanged (by intent and validation)
- Scope and risks confirmed before edits
- Tests/validation executed or explicitly deferred
- Summary provided

