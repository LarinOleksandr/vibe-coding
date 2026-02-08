# docs-ai/agents-core-knowledge/threads.md

## Agent summary

- Scope threads to avoid context bleed and unintended coupling

---

## Thread rules

- One thread = one coherent task or change set.
- Start a new thread when switching feature/bug, changing layer focus, or moving to review/analysis.
- Each thread must have a clear goal and completion condition.
- Each thread must begin with the thread name on the first line.
- If the agent starts a new thread, it must use a compliant thread name.
- If the first user line is non-compliant, propose a corrected thread name and ask the user to start a new thread with it.
- If scope expands materially, stop and plan.
- If planning for coding work, include an implementation plan with step-by-step verification.
- Planning belongs to the thread that executes it.
- Threads do not share context automatically; restate critical decisions when referencing others.
- If you would open a new PR, start a new thread.

---

## New thread handoff (copy/paste format)

When you want the user to continue in a new thread (or the user asks “what’s next?”), provide:

1. One short, user-friendly sentence that explains what to do.
2. Then a copy/paste block in the exact format below.

The copy/paste block must be clean (no headers like “Next task:”, no bullets inside the block).

Preface sentence examples (pick the one that matches the situation):

- Feature: “Please start a new feature by creating a new thread and pasting the text below as the first message.”
- Bug fix: “Please start a new bug-fix thread and paste the text below as the first message.”
- Planning: “Please start a new planning thread and paste the text below as the first message.”

Copy/paste block format (required):

<thread name>

<first message to paste>

---

## Default delivery approach

- For feature work, default to the simplest solution that meets the confirmed acceptance criteria.
- If cleanup is desired after shipping, open a separate code refactor thread (`RF-###`) with explicit "must not change" constraints.

---

## Thread naming

Format:

`<project> | <code>: <short-goal>`

If no code exists, omit it:

`<project> | <short-goal>`

Types:

- project-planning
- feature-development
- bug-fix
- code-refactor
- experiment
- architecture-review-decision
- docs-update
- code-review
- design-review
- deploy-publish
- other

Code prefixes:

- project-planning: `P-###`
- feature-development: `F-###`
- bug-fix: `B-###`
- code-refactor: `RF-###`
- experiment: `E-###`
- architecture-review-decision: `A-###`
- docs-update: `D-###`
- code-review: `CR-###`
- design-review: `DR-###`
- deploy-publish: `DP-###`
- other: no code

Examples:

- `vibe-coding | P-03: onboarding flow`
- `vibe-coding | F-042: pdf export`
- `vibe-coding | B-17: duplicate list`
- `vibe-coding | RF-03: auth cleanup`
- `vibe-coding | E-02: rag vs fine-tuning`
- `vibe-coding | A-02: agent artifacts`
- `vibe-coding | D-08: cookbook update`
- `vibe-coding | CR-11: api pagination`
- `vibe-coding | DR-05: export pipeline`
- `vibe-coding | DP-01: initial go-live`
- `vibe-coding | misc cleanup`

---

## Branch workflow (one branch per thread)

When a thread implies code changes (feature/bug/refactor/docs/deploy), the agent should also:

1. Create a work branch from `main` (or `master`) named from the thread name.
2. Do work and commits on that branch.
3. Open a PR back to `main`.
4. Merge, then delete the branch.

## Parallel threads (Git worktrees)

If you want multiple threads to run in parallel without overwriting each other’s files, use Git worktrees.

This repo’s worktree rules are defined in `KB_GIT_WORKTREES`.

Branch prefix mapping (from thread code):

- `F-###` -> `feature/<code>-<goal>`
- `B-###` -> `bugfix/<code>-<goal>`
- `RF-###` -> `refactor/<code>-<goal>`
- `D-###` -> `docs/<code>-<goal>`
- `DP-###` -> `deploy/<code>-<goal>`
- Otherwise -> `chore/<goal>`

Use the git helper scripts in `scripts/` for branch/PR automation (see `KB_TOOLS`). If scripts cannot be used, fall back to raw git commands.

---

## Artifact references

If a thread is based on an existing plan or architecture review, include the artifact path in the request:

- `docs-ai/agents-artifacts/plans/<task-slug>.plan.md`
- `docs-ai/agents-artifacts/architectural-reviews/<task-slug>.arch-review.md`
- `docs-ai/agents-artifacts/design-reviews/<task-slug>.design-review.md`
- `docs-ai/agents-artifacts/conversations/YYYY-MM-DD__<thread-code>__<slug>.summary.md` (created via `$conversation-save`)

---

## Close trigger

The agent should treat any clear "we are done" intent as a close request.
Examples of intent: "Close the thread", "We are done", "Wrap up", "That is all".
If the intent is ambiguous, ask once for confirmation.

When closing, invoke `$commit-push-create-pr`.

---

## Closure checklist

- Artifact produced and validated for the goal.
- Goal met.
- Definition of done validated.
- No unfinished decisions left implicit.
