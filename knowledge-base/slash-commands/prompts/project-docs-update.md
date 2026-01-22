# /project-docs-update

---

title: project-docs-update

---

## Goal

Update the canonical project docs after a change.

## Actions (agent must execute)

1. Review `DOC_PROJECT_CONTEXT`, `DOC_PRODUCT_DEVELOPMENT_ROADMAP`, and `DOC_PROJECT_INSIGHTS`.
2. Apply only the minimum edits required to keep them accurate.
   - Progress/status updates belong in `DOC_PRODUCT_DEVELOPMENT_ROADMAP`.
   - Add to `DOC_PROJECT_INSIGHTS` only when there is a durable decision, lesson learned, or guardrail (see `KB_PROJECT_DOC_MAINTENANCE`).
3. Summarize what changed and why in the response.
4. If the change implies broader updates to agent rules, routed docs, skills, slash commands, routing aliases, or the repo shape/placement guidance (`KB_REPOSITORY_LAYOUT`), invoke `/context-maintain`.
