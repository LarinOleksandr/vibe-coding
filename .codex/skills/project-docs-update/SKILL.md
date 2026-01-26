---
name: project-docs-update
description: Use when project context, roadmap, or insights must be updated after a change.
---

# .codex/skills/project-docs-update/SKILL.md

## Name

`$project-docs-update`

## Purpose

Keep project docs accurate after changes.

## When to use

Invoke when any apply:

- a change affects project context, roadmap, or insights
- a feature or capability was completed
- the user explicitly requests doc updates

## Inputs

- Change summary (what changed and why)

## Procedure

1. Review:
   - `DOC_PROJECT_CONTEXT`
   - `DOC_PRODUCT_DEVELOPMENT_ROADMAP`
   - `DOC_PROJECT_INSIGHTS`
2. Apply only the minimum edits required to keep them accurate.
   - Progress updates go in the roadmap.
   - Insights are only for durable decisions or lessons.
3. Summarize what changed and why.
4. If the change affects rules, routes, skills, or repo shape, invoke `$context-maintenance`.

## Quick reference

| Do | Do not |
| --- | --- |
| Keep edits minimal and factual | Add routine progress to insights |
| Update roadmap status | Rewrite unrelated sections |

## Example

Change: "Added a new design review workflow."

You:
- Update roadmap if needed
- Append a short insight if it is a durable decision
- Summarize edits

## Rationalization table

| Excuse | Reality |
| --- | --- |
| "We can update docs later" | Docs are part of the change and must be current. |
| "Everything goes into insights" | Only durable decisions belong there. |

## Red flags

- "I'll skip the roadmap update"
- "I'll add routine progress to insights"

## Common mistakes

- Updating insights with routine status
- Missing roadmap status changes

## Acceptance checks

- Context, roadmap, and insights are accurate
- Summary of edits provided
- Context maintenance invoked when needed
