---
name: context-load
description: Use when a quick, baseline repo context snapshot and routing map are needed before deeper work.
---

# .codex/skills/context-load/SKILL.md

## Name

`$context-load`

## Purpose

Provide a fast, consistent snapshot of cross-cutting repo context and where to look next.

## When to use

Invoke when any apply:

- starting a new task and you need baseline repo rules
- you want a routing map before deeper, scoped docs
- the user asks for a quick context load or "where are the rules" overview

## Inputs

- None (use the baseline file list below)

## Procedure

1. Read the baseline files only, in order:
   - `AGENTS.md`
   - `knowledge-base/agents-knowledge/roots.md`
   - `knowledge-base/agents-knowledge/repository_rules.md`
   - `knowledge-base/agents-knowledge/repository-layout.md`
   - `knowledge-base/agents-knowledge/tech_stack.md`
   - `knowledge-base/agents-knowledge/runtime.md`
   - `knowledge-base/agents-knowledge/tools.md`
   - `knowledge-base/agents-knowledge/threads.md`
   - `.codex/skills/skills.md`
   - `knowledge-base/project-context.md`
   - `knowledge-base/product-development-roadmap.md`
   - `knowledge-base/project-insights.md`
2. Produce the Context Snapshot using the required headings.
3. Output the routing map list with when-to-consult notes.
4. Ask exactly one question: "What should we do next?"

## Output format (required)

### Context Snapshot

- Project overview: `<3-6 bullets>`
- Repo shape (what exists today): `<3-6 bullets>`
- Non-negotiable rules: `<5-10 bullets>`
- Tech stack + runtime topology: `<3-8 bullets>`
- Collaboration workflow: `<3-8 bullets>`

### Where To Look Next (routing map)

List the most relevant routes and when to consult them (do not read them now):

- `KB_REPOSITORY_LAYOUT`: when deciding where to find/place files and services
- `KB_FEATURE_TEMPLATE`: when defining/confirming a feature brief
- `KB_FEATURE_RESEARCH`: when surfacing risks/constraints before planning
- `KB_DEPLOYMENT_CICD`: when deciding CI/CD or deployment policy
- `KB_TESTING`: when validation plan is unclear or behavior changes
- `KB_SCHEMAS_OUTPUTS`: when adding/changing structured outputs or schemas
- `KB_API_CONVENTIONS`: when adding/changing HTTP APIs or Edge Functions
- `KB_ERROR_HANDLING`: when designing error codes, envelopes, or user-safe messages
- `KB_SUPABASE`: when touching DB schema, RLS, policies, or Edge Functions
- `KB_ARCHITECTURE_PRINCIPLES`: when changes span layers or risk boundary violations
- `KB_RUNTIME`: when changing services, ports, or dependencies
- `KB_UI_BASELINE`: when building consistent UI components and styling rules
- `KB_UX_BASELINE`: when defining UI behavior for loading/empty/error states and feedback
- `KB_TOOLS`: when choosing canonical commands and scripts
- `KB_THREADS`: when starting a new thread or naming one
- `KB_CONTEXT_MAINTENANCE`: when modifying rules/routes/skills/slash commands or detecting duplication/conflicts

## Quick reference

| Do | Do not |
| --- | --- |
| Read only the baseline file list | Read scoped AGENTS or extra routed docs |
| Keep bullets short and practical | Paste full file contents |
| Ask exactly one final question | Ask any other questions |

## Example

User: "Load context for this repo."

You:
- Read only the baseline list
- Output Context Snapshot and routing map
- End with: "What should we do next?"

## Rationalization table

| Excuse | Reality |
| --- | --- |
| "I should read one more file for clarity" | The baseline is fixed to keep the snapshot consistent. |
| "I'll ask two questions to be safe" | The command requires exactly one question. |

## Red flags

- "I'll just check one more routed doc"
- "I'll ask a quick follow-up too"

## Common mistakes

- Reading extra files beyond the baseline list
- Including scoped AGENTS for specific services
- Asking more than one question at the end
- Skipping the routing map

## Acceptance checks

- Only baseline files were read
- Output matches the required headings
- Routing map included with when-to-consult notes
- Final line asks: "What should we do next?"
