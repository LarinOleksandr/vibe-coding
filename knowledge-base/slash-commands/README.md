# Coding Agent Commands

This folder contains a folder `prompts` with commands that you can run inside a coding agent (Codex) in VS Code and their installation scripts.
A command is a predefined instruction that tells the agent what to do when you type its name (for example: `/feature-commit`).

---

## Files

### `feature-commit.md`

Describe what the agent must do when you run the command.

### `code-review.md`

Run a focused Codex code review in a dedicated code-review thread.

### `project-setup.md`

Turn an idea/notes/PRD into a confirmed project foundation (context + feature plan + insights).

### `context-load.md`

Load only the general, cross-cutting project/repo context and provide a routing map for deeper, need-based context later.

### `project-docs-update.md`

Update the canonical project docs (context/plan/insights) after a change.

### `test-in-browser.md`

Run the dev stack and verify the app in a browser via MCP DevTools, then report and fix errors.

### `test-plan.md`

Generate a comprehensive, repo-consistent test plan for the requested feature/change (unit + integration + error cases + edge cases + mobile checks).

### `feature-research.md`

Produce a timeboxed feature research brief to surface risks, constraints, and default decisions before planning.

### `design-review.md`

Run a focused design review in a dedicated `DR-###` thread and produce a short design review artifact.

### `context-maintain.md`

Run a documentation + knowledge + methodology maintenance pass for the instruction framework (no product code changes).

### `vscode-install.ps1`

Installs commands into the Codex prompts folder at `$env:USERPROFILE\\.codex\\prompts` on **Windows**.

### `vscode-install.sh`

Installs commands into the Codex prompts folder at `~/.codex/prompts` on **macOS/Linux**.
