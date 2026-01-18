# knowledge-base/agents-knowledge/project-doc-maintenance.md

## Agent summary

- Rules for required project documentation files
- When and how to update project context, plan, and insights

---

## Core Project Documentation Rules

1. A `/knowledge-base` folder **must always have** three Markdown files:

   - `DOC_PROJECT_CONTEXT`
   - `DOC_PROJECT_FEATURE_PLAN`
   - `DOC_PROJECT_INSIGHTS`

If the project is starting from an idea/PRD and these docs are missing, empty, or clearly outdated, run `/project-setup` to draft them before feature work.

2. **Before any substantial work**, memory compaction, refactor, or feature development:

   - Review `DOC_PROJECT_CONTEXT`, `DOC_PROJECT_INSIGHTS` and `DOC_PROJECT_FEATURE_PLAN` to ensure alignment with how we work and the latest project state.

---

## Project Documents Usage and Update

Update documentation immediately when any of the following occur:

1. A feature is developed or completed
2. An essential code or architectural change is made
3. A significant decision is made or approved
4. The user explicitly requests an update

If the change also affects the repository shape (new/renamed top-level folders, new runtime boundary, new artifact category), update `KB_REPOSITORY_LAYOUT` via `/context-maintain`.

In normal feature work, doc updates are part of finishing the change: update the docs automatically before proposing a feature commit.

For each event, determine which files require updates and modify them to reflect:

- Updated context
- Plan changes
- New insights or lessons learned

Files to consider:

- `DOC_PROJECT_CONTEXT`
- `DOC_PROJECT_FEATURE_PLAN`
- `DOC_PROJECT_INSIGHTS`

---

## File Specifications

### project-context.md

**Purpose:** Canonical project overview.

**Must include:**

- Project name
- Current project description
- High-level technical and architectural information (stack, core features)
- Current, confirmed project goals

---

### project-feature-plan.md

**Purpose:** Work breakdown and progress tracking.

**Rules:**

- Features are listed as numbered top-level headings
- Subfeatures use hierarchical numbering (e.g., 1.1, 1.2)
- Every feature and subfeature must include a status:
  - `Not Started`
  - `In Progress`
  - `Completed`
- Decompose features further as clarity increases
- Ordering format: number, status, then item name

---

### project-insights.md

**Purpose:** Chronological decision and change log.

**Rules:**

- Append-only; ordered from oldest to newest
- Each entry must include:
  - A concise summary of the change or insight
  - Supporting details when relevant (architecture, tooling, design, content, integrations)
- Reference the related feature or subfeature number

---

## Required Markdown Structure

### project-context.md

<pre>
# Project Context

## Overview
Brief description of the application and its purpose.

## Goals
- List current project goals.

## Essential Information
- Technical stack
- Core features
- Other critical high-level details
</pre>

### project-feature-plan.md

<pre>
# Project Plan

## Features
- 1. [In Progress] Feature Name
  - 1.1 [Not Started] Subfeature Name
  - 1.2 [Completed] Subfeature Name
</pre>

### project-insights.md

<pre>
# Project Insights Log

## [1.1]
- Added authentication module and updated project structure.

## [2]
- Selected PostgreSQL as the primary database.
- Documented deployment strategy.
</pre>

---

## Writing Standards

- Be concise and factual
- Avoid redundancy
- Prefer clarity over completeness
- Follow the specified Markdown structure exactly
