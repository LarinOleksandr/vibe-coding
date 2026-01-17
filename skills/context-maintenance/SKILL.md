---
name: context-maintenance
description: Maintain project documentation, agent knowledge, and methodology; keep routes consistent and remove duplication across the instruction framework.
---

# skills/context-maintenance/SKILL.md

## Name

$context-maintenance

## Purpose

Keep the instruction framework and project knowledge base accurate and consistent as decisions and workflows evolve.

This skill updates documentation, knowledge, and methodology only (AGENTS, routed knowledge docs, skills, slash commands, and project docs). It does not audit or modify product code.

## When to use

Invoke when any apply:

- a significant decision is made or approved that affects how we work or what we build
- rules/routing/aliases are added, moved, or renamed
- a new routed doc, skill, or slash command is added (or one is modified)
- duplication/conflicts are suspected across AGENTS, routed docs, skills, or slash commands
- the user requests a documentation/knowledge/methodology maintenance pass

## Inputs

- Change summary (what triggered the maintenance run)
- Optional: affected areas (project docs, routed docs, skills, slash commands, AGENTS scopes)

## Procedure

1. Establish the maintenance scope
   - project state updates (context/plan/insights), framework updates, or both
2. Load the canonical sources
   - `KB_ROOTS`
   - `KB_BEHAVIOUR_ARCHITECTURE`
   - `KB_PROJECT_DOC_MAINTENANCE`
   - `KB_CONTEXT_MAINTENANCE`
3. Validate routing and references
   - every alias in `KB_ROOTS` points to an existing file
   - every referenced `KB_*` / `DOC_*` route used in instructions resolves via `KB_ROOTS`
4. Update the framework with correct layering
   - keep rules in AGENTS and scoped AGENTS only
   - keep knowledge in `knowledge-base/agents-knowledge/` and referenced by route
   - keep procedures in `skills/` and slash commands, referencing routed docs instead of duplicating them
5. Remove duplication and resolve conflicts
   - if the same rule appears in multiple layers, keep it in the correct layer and replace others with a reference
   - if guidance conflicts, pick a single source of truth and update references accordingly
6. Update project documents when the decision/change affects project state
   - apply `KB_PROJECT_DOC_MAINTENANCE` to update `DOC_PROJECT_CONTEXT`, `DOC_PROJECT_FEATURE_PLAN`, and append to `DOC_PROJECT_INSIGHTS`
7. Ensure indices remain accurate
   - `DOC_SKILLS_LIST` reflects the current skills
   - `knowledge-base/slash-commands/README.md` lists existing commands and brief purpose lines
8. Report results
   - what changed, why, and any remaining follow-ups

## Acceptance checks

- Routes resolve: `KB_ROOTS` aliases and referenced routes point to existing files
- No duplicated rules across layers (AGENTS vs routed docs vs skills vs slash commands)
- Project docs updated when decisions/features changed project state
- Skill and slash command indices are accurate
