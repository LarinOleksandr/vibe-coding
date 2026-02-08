# Review Action (Ideas → Requests)

## Goal

Review Ideas one by one and convert them into classified Requests.

This is not brainstorming.

The focus is:

- expected result (business perspective)
- how it supports the project goals
- which existing skill should be used next

## Where Ideas live

- `docs/ideas/`

Ignore these subfolders:

- `docs/ideas/deleted/`
- `docs/ideas/snoozed/`
- `docs/ideas/processed/`

## Where Requests live

- `ROOT_WORK_REQUESTS` -> `docs-ai/agents-artifacts/work-requests/`

## Workflow

### Step 1: Pick the next Idea

- Find `*.md` files in `docs/ideas/` (root only).
- Order by last modified time (oldest first).
- Pick the first file.

If none exist, say: “No pending Ideas in `docs/ideas/`.”

### Step 2: Load project context

Read:

- `DOC_PROJECT_CONTEXT`
- `DOC_PROJECT_ROADMAP`
- `DOC_PROJECT_INSIGHTS`
- `DOC_PROJECT_PROTECTED_CONTRACTS`

### Step 3: Discuss (minimal questions)

1. Restate the Idea in simple words.
2. Connect it to project purpose/goals.
3. Identify the work type and the recommended existing skill.
4. Ask only what is required to make the expected result clear.

### Step 4: Draft Request(s)

Create one or more Requests using:

- `ROOT_SKILLS/review-ideas/actions/request-schema.md`

Rules:

- Split into multiple Requests only when outcomes are independent.
- Keep together when outcomes depend on each other.

### Step 5: User decision for the Idea

Ask the user to choose one:

- Delete → move the Idea file to `docs/ideas/deleted/`
- Snooze → move the Idea file to `docs/ideas/snoozed/`
- Process → propose project knowledge updates; if approved, apply them; then move Idea file to `docs/ideas/processed/`
- Stop → end the review session

### Step 6: Project knowledge updates (approval gate)

When the user chooses Process, propose updates to:

- `DOC_PROJECT_CONTEXT` (only if the project definition/goals change)
- `DOC_PROJECT_ROADMAP` (add the Request(s) in the right place)
- `DOC_PROJECT_INSIGHTS` (only durable decisions/lessons)
- `DOC_PROJECT_PROTECTED_CONTRACTS` (only with explicit approval)

Do not edit these files until the user explicitly approves.

