# Project Insights Log

## [1]
- Why it matters: Framework rules must be path-stable and easy for non-experts.
- Root cause / constraint: Worktrees change the root path and confuse repo placement.
- Fix / decision: Remove worktree workflow from the framework; keep a single workspace.
- Prevention: Keep skills aligned to repo paths and verify references with `rg`.

## [2]
- Why it matters: Finishing work must be one simple action so users reliably verify, update docs, and save changes.
- Root cause / constraint: Overlapping "finish" skills caused duplicated steps and unclear user intent.
- Fix / decision: Fold verification + project docs updates into `$commit-push-create-pr` and remove overlapping skills.
- Prevention: Keep one "finish" workflow skill; keep other skills only for unique actions.

## [3]
- Why it matters: The agent must behave predictably and choose the correct skill instead of giving generic advice.
- Root cause / constraint: Without explicit routing rules, the agent may answer from general habits instead of the repo skills framework.
- Fix / decision: Add a root "Skill routing (must)" rule and add clear per-skill trigger words in `.codex/skills/skills.md`.
- Prevention: Keep `AGENTS.md` as a router; keep skill triggers in `.codex/skills/skills.md` as the single source of truth.

## [4]
- Why it matters: PRDs must be consistent and complete without relying on users to invent structure or analysis.
- Root cause / constraint: Free-form PRDs cause duplication (product vs feature) and miss key inputs (users, JTBD, baselines).
- Fix / decision: Standardize Product PRD and Feature PRD templates; Product PRD is the single source of truth, Feature PRDs reference it.
- Prevention: Use proactive PRD interviews (agent drafts + recommends + asks for approvals) and keep absolute OS paths out of instructions (use `KB_ROOTS` aliases).

## [5]
- Why it matters: People should not need to guess what is “safe to change”; the agent must prevent accidental breaking changes.
- Root cause / constraint: “Do not change” constraints can be missed in bug/refactor threads unless they are routed and always checked.
- Fix / decision: Add `DOC_PROJECT_PROTECTED_CONTRACTS` as the single source of truth, and require the agent to proactively propose updates (user approves/rejects).
- Prevention: Route the doc via `KB_ROOTS` and include it in `$context-load` and `$feature-start` baseline reads.

## [6]
- Why it matters: We need searchable “long-term memory” for valuable discussions without bloating Git or leaking sensitive text.
- Root cause / constraint: Full chat transcripts can be large and may include secrets; we still want traceable decisions.
- Fix / decision: Add opt-in conversation summaries under `ROOT_AGENTS_ARTIFACTS/conversations/` via `$conversation-save`.
- Prevention: Ignore `*.transcript.md` by default and only create summaries when the user explicitly asks (or confirms after `$commit-push-create-pr`).

## [7]
- Why it matters: Parallel agent threads must not overwrite each other’s files.
- Root cause / constraint: A “no worktrees” rule forced parallel work into one folder or full clones, which caused confusion and lost work.
- Fix / decision: Reintroduce Git worktrees with a path-stable convention: all worktrees live under `.worktrees/` in the repo root (ignored by git).
- Prevention: Use `scripts/git-worktree-start.ps1` for parallel threads and keep “one thread = one branch = one worktree”.
- Notes: This supersedes insight **[1]** for the current workflow.

## [8]
- Why it matters: Users should not have to remember Git steps (branch, PR, cleanup) to avoid losing work.
- Root cause / constraint: Manual “create PR / merge / cleanup” decisions add confusion and lead to unfinished branches/worktrees.
- Fix / decision: Make the default finish flow agent-led: on “wrap up / close thread”, run `$commit-push-create-pr`, create PR automatically (best effort), ask only “merge now? Yes/No”, and auto-clean after merge.
- Prevention: Keep user-facing docs aligned and keep one finish workflow (`$commit-push-create-pr`) as the single source of truth.
