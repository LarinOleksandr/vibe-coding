# Using Codex Threads in a Software Development Project

---

## 1. How to Use Threads

### What a Thread Is

A thread is a single, persistent workspace dedicated to one clearly defined unit of work.
All context inside a thread is cumulative: requirements, decisions, code, errors, fixes, and outputs.
A thread MUST map to exactly one unit of work.

---

### Core Principle

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

---

### When to Stay in the Same Thread

Stay in the same thread when you:

- Iterate on the same solution
- Respond to review feedback
- Fix test failures for the same change
- Make incremental improvements within the same scope

---

### How Threads Interact

Threads do not share context automatically.

To reuse decisions or constraints:

- Explicitly reference another thread
- Restate the critical decisions or constraints


---

### Thread Lifecycle

1. Open a thread with a clear goal and completion condition
2. Iterate until the goal is reached
3. Produce the final artifact
4. Validate against acceptance criteria or schema
5. Mark the thread as closed

Closed threads must not be revived.

---

### Practical Rule

If you would open a new pull request, you must open a new thread.

---

### Required thread start

Every thread must begin with the thread name on the first line.

---

## 2. Thread Types, Naming Rules, and Templates

---

### Naming rules (applies to all types)

Format: `<project> | <type> | <code>: <short-goal>`

- `<project>` = repo or product name (example: `vibe-coding`).
- `<type>` = one of: `feature`, `bug`, `refactor`, `architecture`, `planning`, `experiment`, `docs`, `code-review`, `design-review`, `other`.
- `<code>` = tracking id. Required for `feature`. Optional for others. Use these prefixes:
  - feature: `F-###`
  - bug: `B-###`
  - refactor: `RF-###`
  - architecture: `A-###`
  - planning: `P-###`
  - experiment: `E-###`
  - docs: `D-###`
  - code-review: `CR-###`
  - design-review: `DR-###`
- `<short-goal>` = 2-4 words describing the target, lowercase words preferred (example: `pdf export`).

If no code exists, omit the code segment entirely:
`<project> / <type>: <short-goal>`

Examples (one per type):
`vibe-coding | feature | F-042: pdf export`
`vibe-coding | bug | B-17: duplicate list`
`vibe-coding | refactor | RF-03: auth cleanup`
`vibe-coding | architecture | A-02: agent artifacts`
`vibe-coding | planning | P-03: onboarding flow`
`vibe-coding | experiment | E-02: rag vs fine-tuning`
`vibe-coding | docs | D-08: cookbook update`
`vibe-coding | code-review | CR-11: api pagination`
`vibe-coding | design-review | DR-05: export pipeline`
`vibe-coding | other: misc cleanup`

---

## A. Architecture Review Thread


Purpose:
Review system-wide decisions that affect multiple features or agents.

Thread template:

Goal  
Review architecture for <area>.

Review checklist

- Boundaries touched
- Conflicts or risks
- Compliant alternatives
- Go/no-go recommendation

Output

- Review note: agent-artifacts/architectural-reviews/<task-slug>.arch-review.md

Out of Scope

- Feature-level implementation
- UI details


## B. Feature Development Thread


Purpose:
Implement one feature end-to-end within approved architecture.

Thread template:

Goal  
Implement <feature-name>.



In Scope

- Functional requirements
- API changes
- UI changes required for this feature

Out of Scope

- Unrelated features
- Optional refactors

Constraints

- Approved tech stack
- Performance limits
- UX rules

References

- Architecture threads
- Related feature threads

Tasks

- Design
- Implementation
- Tests
- Review

Produced Outputs  
List generated files or sections.


---

## C. Bug Fix Thread


Purpose:
Fix one specific, well-defined bug.

Thread template:

Bug Description  
What is broken.



Expected Behavior  
What should happen.

Actual Behavior  
What happens now.

Reproduction Steps

1.
2.
3.

Constraints

- No public API changes
- No unrelated behavior changes

Fix  
Describe or implement the fix.

Verification  
How the fix is validated.


---

## D. Refactor Thread


Purpose:
Improve internal structure without changing external behavior.

Thread template:

Goal  
Refactor <area>.



Must Not Change

- External behavior
- APIs
- Output formats

Can Change

- Internal structure
- Naming
- File layout

Risks

- Regressions
- Performance impact

Plan  
Step-by-step refactor plan.


---

## E. Experiment / Spike Thread


Purpose:
Explore ideas without production guarantees.

Thread template:

Question  
What are we trying to learn?



Hypothesis  
Expected outcome.

Approach  
How the experiment is run.

Success Criteria  
What determines success or failure.

Results  
Observed outcomes.

Decision  
What (if anything) should move to production.

Non-Binding Rule  
Results do not affect production unless explicitly referenced
by a follow-up Architecture or Feature thread.


---

## F. Planning / Analysis Thread


Purpose:
Clarify requirements before implementation.

Hard Rule:
Planning threads are forbidden after the Discovery Document is approved.

Thread template:

Goal  
Clarify requirements for <topic>.



Open Questions

- ?
- ?

Assumptions

- ?

Non-Goals

- ?

Output  
Clear, implementable requirements.


---

## G. Docs Thread


Purpose:
Write or update documentation only.

Thread template:

Goal  
Document <topic>.

Scope  
What is covered.

Out of Scope  
What is excluded.

Sources (optional)  
Links or files to reference.

Output  
Updated docs.


---

## H. Code Review Thread


Purpose:
Review code changes for correctness, safety, and tests.

Thread template:

Goal  
Review code for <area>.

Scope  
PR, commit, or branch.

Focus  
Correctness, risks, tests.

Findings  
Issues and required changes.

Recommendation  
Approve or request changes.


---

## I. Design Review Thread


Purpose:
Review a proposed design before implementation.

Thread template:

Goal  
Review design for <area>.

Proposal summary  
Key approach.

Tradeoffs  
Pros and cons.

Risks  
Potential issues.

Recommendation  
Proceed or revise.


---

## J. Other Thread


Purpose:
Use for scoped tasks that do not fit any other thread type.

Thread template:

Goal  
Define the task and expected outcome.

Scope  
What is included.

Out of Scope  
What is excluded.

Constraints  
Anything that must not change.

Output  
What will be produced.


---

## Summary Rules

- One thread per unit of work
- Never mix unrelated tasks
- Experiments are non-binding by default
- Close threads after validated output
- Threads replace long conversations, not documentation
