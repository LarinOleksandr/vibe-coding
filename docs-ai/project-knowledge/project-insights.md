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

## [9]
- Why it matters: Working on `main` causes accidental changes in the wrong place.
- Root cause / constraint: The agent can start work without a branch check.
- Fix / decision: Add a pre-work branch check to the worktree rules; if on `main`, create a worktree + branch first.
- Prevention: Treat the branch check as required before any task work.

## [10]
- Why it matters: PRDs and foundation work get lost if they are not saved to a real repo early.
- Root cause / constraint: After `$brainstorming`, the agent could propose planning/implementation before confirming the folder is a git repo with a pushable `origin`.
- Fix / decision: Add a strict repository gate after `$brainstorming` and enforce a single next step: persist to repo, then `$project-setup`, then `$plan-creation`.
- Prevention: Add `$repo-bootstrap` for missing repo/`origin`, and require copy/paste next-thread prompts in the skills handoff.

## [11]
- Why it matters: Absolute OS paths in docs break portability and cause inconsistent agent behavior across machines.
- Root cause / constraint: The agent could output machine-specific paths (like drive-letter paths) instead of using `KB_ROOTS` aliases or repo-relative paths.
- Fix / decision: Enforce the no-absolute-path rule across skills/docs and add a verification gate (`scripts/verify.ps1`) that fails if absolute OS paths are present.
- Prevention: Keep all repo references as `ROOT_*` / `KB_*` / `DOC_*` routes or repo-relative paths; run verification during `$commit-push-create-pr`.

## [12]
- Why it matters: New projects often start in an empty folder; Git may not be installed yet and later steps can fail in confusing ways.
- Root cause / constraint: Git-dependent workflows (commit/push/PR/worktrees) can be proposed before verifying `git` exists.
- Fix / decision: Add a git prerequisite gate as a must-rule in `KB_REPOSITORY_RULES` and route it from `AGENTS.md`.
- Prevention: When `git` is missing, stop early and route the user to `$repo-bootstrap` after installing Git.

## [13]
- Why it matters: Bug fixes are safer when they come with proof and a permanent regression guard.
- Root cause / constraint: It is easy to “fix first” and only add tests later (or never), which lets bugs return.
- Fix / decision: Make “reproducing test first → fix → prove by passing test” the default inside `$bug-fix`, with small, explicit exceptions.
- Prevention: If test-first is not a fit, the agent must say why and use another proof (for UI: Playwright + screenshots).

## [14]
- Why it matters: Accidental edits on `main` or outside the active worktree are dangerous and confusing.
- Root cause / constraint: Git worktrees are separate folders, but they do not enforce filesystem isolation; the agent can still write in the wrong folder unless we gate it.
- Fix / decision: Add a worktree gate rule: before edits, ensure a per-thread worktree under `.worktrees/...` and then work only inside that folder.
- Prevention: Use `scripts/git-worktree-ensure.ps1` as the default entry point and treat “no edits outside worktree” + “do not scan other worktrees” as must rules.

## [15]
- Why it matters: Starting a new thread should be easy to copy/paste without manual cleanup.
- Root cause / constraint: Mixed “next task” headers and bullets made the handoff hard to paste as-is.
- Fix / decision: Standardize a user-friendly preface sentence + a clean 2-line copy/paste handoff block in `KB_THREADS`, and require handoff skills to follow it.
- Prevention: Keep the handoff format defined only in `KB_THREADS` and reference it from skills (no per-skill formatting rules).

## [16]
- Why it matters: Worktree helpers must be reliable because the framework depends on the worktree gate.
- Root cause / constraint: `scripts/git-worktree-ensure.ps1` calls `scripts/git-worktree-start.ps1 -Json` and expects clean JSON output.
- Fix / decision: Make `scripts/git-worktree-start.ps1 -Json` output JSON and exit before any git commands that can print extra output.
- Prevention: Treat “JSON mode prints only JSON” as a script contract; keep human logs out of JSON paths.

## [17]
- Why it matters: Fast “capture now, build later” reduces lost ideas and context switching.
- Root cause / constraint: Adopting upstream do-work as-is would conflict with “one thread = one task”, skill routing, and the worktree scope rule.
- Fix / decision: Add `$do-work` as a framework-integrated task queue under `ROOT_DO_WORK_QUEUE`, with a dispatcher-style work action that routes REQs into the existing thread/skill workflow.
- Prevention: Capture/maintenance should happen in a dedicated docs thread/branch so feature PRs don’t accidentally include unrelated queue edits.

## [18]
- Why it matters: Ideas must have one capture mechanism and one source of truth.
- Root cause / constraint: “User requests” and UR/REQ queue structure added confusion and duplicated what `docs/ideas/` already provides.
- Fix / decision: Make `docs/ideas/` the only place to save Ideas; add `$review-ideas` to turn Ideas into classified Requests under `ROOT_WORK_REQUESTS`.
- Prevention: Keep Requests outcome-focused and classified so the next step is always an existing skill (example: `$feature-development`, `$bug-fix`, `$code-refactoring`).
- Notes: This supersedes **[17]**; ignore older `ROOT_DO_WORK_QUEUE` / `$do-work` references.
