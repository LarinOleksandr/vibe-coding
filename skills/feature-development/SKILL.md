---
name: feature-development
description: Manage feature development readiness. Use when a user requests a new feature or behavior change, including short or vague requests that need structured clarification.
---

# skills/feature-development/SKILL.md

## Name

$feature-development

## Purpose

Transform a feature request into a confirmed, actionable feature brief.

## When to use

Invoke when any apply:

- user requests a new feature or behavior change
- requirements are partial or unclear
- feature spans multiple components or services

## Inputs

- Feature request (even a short description)
- Constraints (if known)
- References (if any)

## Procedure

1. Classify complexity
   - small, medium, or large using `KB_FEATURE_TEMPLATE`
2. Draft the feature brief
   - fill required sections from repo context first
3. Ask only for missing required fields
   - single pass, clear questions
4. Confirm before changes
   - confirm scope, out of scope, and acceptance criteria
5. Trigger follow-ups
   - invoke `$architecture-review` for large or cross-boundary changes
   - invoke `$create-plan` when change complexity requires it

## Acceptance checks

- Required sections are complete or explicitly "Unknown"
- Missing required fields are confirmed with the user
- Scope and out-of-scope are explicit
- Follow-up triggers applied when needed
