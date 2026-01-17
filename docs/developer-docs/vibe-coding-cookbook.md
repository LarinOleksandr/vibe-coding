# Codex User Guide

## What a Thread Is

A thread is a single, persistent workspace dedicated to one clearly defined unit of work.
All context inside a thread is cumulative: requirements, decisions, code, errors, fixes, and outputs.

A thread MUST map to exactly one unit of work.
One thread = one goal.  
If the goal changes, start a new thread.

---

### How Threads Fit the Development Workflow

- Jira ticket → thread
- Git branch → thread
- Pull request → thread  
  Threads are task-level workspaces, not project-level containers.

---

### When to Create a New Thread

Create a new thread when you:

- Start a new feature
- Fix a specific bug
- Refactor a clearly defined subsystem
- Run an experiment or spike
- Make an architectural or cross-cutting decision
- Write or revise documentation
- Perform a code or design review
- Handle a scoped task that does not fit other types

### Thread naming (required)

Start every thread with its name on the first line.

If the first line is non-compliant, the agent will propose a corrected name and recommend starting a new thread with it.

Format:

`<project> | <code>: <short-goal>`

If no code exists, omit it:

`<project> | <short-goal>`

Type codes and examples:

- feature: `F-###`, `vibe-coding | F-042: pdf export`
- bug: `B-###`, `vibe-coding | B-17: duplicate list`
- refactor: `RF-###`, `vibe-coding | RF-03: auth cleanup`
- experiment: `E-###`, `vibe-coding | E-02: rag vs fine-tuning`
- architecture: `A-###`, `vibe-coding | A-02: agent artifacts`
- docs: `D-###`, `vibe-coding | docs | D-08: cookbook update`
- code-review: `CR-###`, `vibe-coding | CR-11: api pagination`
- design-review: `DR-###`, `vibe-coding | DR-05: export pipeline`
- other: no code, `vibe-coding | misc cleanup`

---

### When to Stay in the Same Thread

Stay in the same thread when you:

- Iterate on the same solution
- Respond to review feedback
- Fix test failures for the same change
- Make incremental improvements within the same scope

---

### Thread Lifecycle

1. Open a thread with a clear goal and completion condition
2. Iterate until the goal is reached
3. Produce the final artifact
4. Validate against acceptance criteria or schema
5. Mark the thread as closed

Closed threads must not be revived.

---

## 1) Feature Development Thread

### When

- Implement one feature end-to-end within approved architecture.

### How

Say what you want and why.
If you know constraints or the area, add them. If not, the agent will infer context and ask for missing details.

### Example

Please add a PDF export for project summaries so users can share them. Keep the API backward compatible.

### Result

- Small features can be done quickly; large ones take more steps.
- Agent classifies size (small/medium/large) and drafts a feature brief from repo context.
- Agent asks only for missing required fields and confirms them before changes.
- Default approach is "ship then cleanup": keep optional refactors out of the feature thread; do cleanup in a separate `RF-###` refactor thread (see `knowledge-base/agents-knowledge/threads.md`).
- You get code and/or docs as requested.

---

## 2) Bug Fix

### When

- Use when behavior is wrong or broken.
- If you cannot reproduce, say so.

### How

Say what is broken and what you expected. That is enough to start.
If you know steps, logs, or impact, add them. If not, the agent will ask.

### Example

The project list shows duplicates after refresh. It should show each project only once. Steps if helpful: open Projects page, refresh, scroll.

### Result

- Small fixes are quick; complex ones may need follow-ups.
- Agent asks if the repro is unclear.
- You get fix details and test status.
- You get code changes plus a short summary.
- Agent pulls needed context and asks for specific details only if required.

---

## 3) Refactor (no behavior change)

### When

- Use for structural cleanup without behavior changes.
- If a plan or architecture review already exists, mention it.
- Agent may trigger a plan for bigger refactors.
- Often used as a follow-up after shipping a major feature.

### How

Say what to refactor and what must not change.
If a plan or architecture review exists, mention it.

### Example

Please refactor project list data fetching to a single hook. Do not change UI behavior or API calls. If possible, use this review: knowledge-base/agents-artifacts/architectural-reviews/project-list.arch-review.md.

### Result

- Small refactors can finish in one response; larger ones may need a plan.
- Agent confirms constraints before edits.
- You get a minimal-change approach aligned with any referenced plan/review.
- You get code changes plus a short summary.
- If scope/areas/risks/tests are missing, the agent proposes them and confirms before changes.

---

## 5) Architecture Review (when needed)

### When

- Use when a change might break architecture or cross boundaries.
- Agent will also trigger a review automatically for large/complex changes.

### How

Ask in plain language. No special command required.

### Example

Before we change this, please do an architecture review. This touches the orchestrator, shared types, and storage.

### Result

- Usually one response.
- Agent may ask for missing details.
- You get conflicts (if any), compliant alternatives, and a go/no-go recommendation.
- Output is a review note saved in `./knowledge-base/agents-artifacts/architectural-reviews/<task-slug>.arch-review.md` (no code changes).

---

## Planning Checkpoint (only when triggered)

### When

- Ask for a plan if you want the agent to pause and map the steps before touching code.
- Agent will also trigger a plan automatically for bigger changes (touching several areas, changing data/contracts, or adding a new service).

### How

Ask for a plan in plain language. The agent will decide what validation and checkpoints belong in the plan.

### Example

Can you pause and make a plan before coding? The change touches shared types, validation, and the orchestrator, and we need to keep old outputs working.

### Result

- Usually one response to draft the plan.
- Agent identifies needed tests/smoke paths and includes them with brief reasoning.
- For coding work, the plan includes step-by-step implementation instructions with a verification step for each, focused on the base application.
- You get a plan file location and next steps.
- Output is a plan in `./knowledge-base/agents-artifacts/plans/<task-slug>.plan.md`.

---

## Close the Thread

### When

- Use when you want to finish and close the task.

### How

Any phrase about finishing work or closing a thread

### Example

Close the thread.

### Result

- Agent runs a close checklist (goal completion, tests/validation, docs).
- Agent asks once if something required is missing.
- You get a final summary and any follow-ups.
- Agent confirms closure and stops work in this thread.
