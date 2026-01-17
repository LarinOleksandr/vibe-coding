Establish and maintain authoritative project documentation in a `/docs` directory. Documentation must always reflect the current project context, plans, decisions, and insights using structured Markdown files.

---

## Core Rules

1. A `/docs` folder **must always exist** with exactly four Markdown files:

   - `context.md`
   - `plan.md`
   - `insights.md`
   - `codex-vibe-coding.md`

2. **Before any substantial work**, memory compaction, refactor, or feature development:

   - Review `codex-vibe-coding.md`, `context.md`, `insights.md` and `plan.md` to ensure alignment with how we work and the latest project state.

3. **The first entry written to `insights.md` must be the content starting from “Document Usage and Update” below.**
   - This content defines collaboration and operating rules.
   - Treat it as persistent instructions to be read at the start of every feature.

---

## Document Usage and Update

Update documentation immediately when any of the following occur:

1. A feature is developed or completed
2. An essential code or architectural change is made
3. A significant decision is made or approved
4. The user explicitly requests an update

For each event, determine which files require updates and modify them to reflect:

- Updated context
- Plan changes
- New insights or lessons learned

Files to consider:

- `context.md`
- `plan.md`
- `insights.md`

---

## File Specifications

### context.md

**Purpose:** Canonical project overview.

**Must include:**

- Project name
- Current project description
- High-level technical and architectural information (stack, core features)
- Current, confirmed project goals

---

### plan.md

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

### insights.md

**Purpose:** Chronological decision and change log.

**Rules:**

- Append-only; ordered from oldest to newest
- Each entry must include:
  - A concise summary of the change or insight
  - Supporting details when relevant (architecture, tooling, design, content, integrations)
- Reference the related feature or subfeature number

---

## Required Markdown Structure

### context.md

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

### plan.md

<pre>
# Project Plan

## Features
- 1. [In Progress] Feature Name
  - 1.1 [Not Started] Subfeature Name
  - 1.2 [Completed] Subfeature Name
</pre>

### insights.md

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



