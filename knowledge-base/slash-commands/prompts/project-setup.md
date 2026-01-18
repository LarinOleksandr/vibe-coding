# /project-setup

---

title: project-setup

---

## Goal

Turn a user idea/notes/PRD into a confirmed project foundation: context, initial feature plan, and initial insights.

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
   - `knowledge-base/project-feature-plan.md`
   - `knowledge-base/project-insights.md`
2. Restate the product input in 3-7 bullets (what it is, who it's for, why it matters).
3. Draft or update the foundation docs (do not implement features yet):
   - `knowledge-base/project-context.md`
   - `knowledge-base/project-feature-plan.md`
   - `knowledge-base/project-insights.md`
4. Ask only for the minimum confirmations needed to proceed (single pass):
   - scope (in / out)
   - success criteria (3-7 bullets)
   - first 3-10 features (ordered, with a clear "next feature")
5. After the user confirms the foundations:
   - Propose proceeding with the first feature (the "next feature" from the plan).
   - Suggest a compliant feature thread name using `KB_THREADS` naming rules.
   - Provide concrete next steps: start the new thread with that name and run `/feature-start`.
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
- Proposed next feature: `<feature name>`

### Confirmations Needed (single pass)

- Scope in: `<bullets>`
- Scope out: `<bullets>`
- Success criteria: `<bullets>`
- Feature list order: `<bullets>`

### Next Step (after confirmation)

- Next feature: `<feature name>`
- Suggested thread name: `<project> | F-###: <short-goal>`
- Do next:
  - Start a new thread with the suggested name
  - Run `/feature-start`
