# /project-setup

---

title: project-setup

---

## Goal

Turn a user idea/notes/PRD into a confirmed project foundation: context, initial product development roadmap, and initial insights.

## Actions (agent must execute)

1. Read the baseline project context (same baseline as `/context-load`):
   - `AGENTS.md`
   - `knowledge-base/agents-knowledge/roots.md`
   - `knowledge-base/agents-knowledge/repository_rules.md`
   - `knowledge-base/agents-knowledge/repository-layout.md`
   - `knowledge-base/agents-knowledge/tech_stack.md`
   - `knowledge-base/agents-knowledge/runtime.md`
   - `knowledge-base/agents-knowledge/tools.md`
   - `knowledge-base/agents-knowledge/threads.md`
   - `skills/skills.md`
   - `knowledge-base/slash-commands/README.md`
   - `knowledge-base/project-context.md`
   - `knowledge-base/product-development-roadmap.md`
   - `knowledge-base/project-insights.md`
2. If the user has not provided enough product input to proceed, ask for the minimum inputs (single pass) and stop:
   - Product (one sentence)
   - Users (who it's for)
   - Problem (what pain it solves)
   - Success (3-7 measurable outcomes)
   - Constraints (deadline, budget, privacy, must-use tech)
   - Out of scope (what we will not build now)
3. Restate the product input in 3-7 bullets (what it is, who it's for, why it matters).
4. Draft or update the foundation docs (do not implement features yet):
   - `knowledge-base/project-context.md`
   - `knowledge-base/product-development-roadmap.md`
   - `knowledge-base/project-insights.md`
5. Ask only for the minimum confirmations needed to proceed (single pass):
   - scope (in / out)
   - success criteria (3-7 bullets)
   - first 3-10 roadmap items (ordered, with a clear "next item")
6. After the user confirms the foundations:
   - Propose proceeding with the next roadmap item.
   - If the next item is a feature, suggest a compliant feature thread name and tell the user to run `/feature-start`.
   - If the next item is not a feature, suggest a compliant project planning thread name and proceed work-item-by-item until Feature Development is reached.
   - Stop.

## Rules

- Do not plan or implement any feature code during this command.
- Keep the foundation docs simple and editable; avoid deep technical detail.
- Do not add new dependencies.
- Never add secrets; `.env.example` may contain variable names only.

## Output format

### Summary

- Product: `<one sentence>`
- Users: `<who it's for>`
- Success (draft): `<3-7 bullets>`
- Proposed next roadmap item: `<item name>`

### Confirmations Needed (single pass)

- Scope in: `<bullets>`
- Scope out: `<bullets>`
- Success criteria: `<bullets>`
- Roadmap order: `<bullets>`

### Next Step (after confirmation)

- Next roadmap item: `<item name>`
- Suggested thread name: `<project> | P-###: <short-goal>` or `<project> | F-###: <short-goal>` (if the item is a feature)
- Do next:
  - Start a new thread with the suggested name
  - If the item is a feature: run `/feature-start`
