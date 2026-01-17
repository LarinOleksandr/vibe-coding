# Coding Agent Commands

This folder contains a folder `prompts` with commands that you can run inside a coding agent (Codex) in VS Code and their installation scripts.
A command is a predefined instruction that tells the agent what to do when you type its name (for example: `/commit-feature`).

---

## Files

### `commit-feature.md`

Describe what the agent must do when you run the command.

### `update-project-docs.md`

Update the canonical project docs (context/plan/insights) after a change.

### `test-browser.md`

Run the dev stack and verify the app in a browser via MCP DevTools, then report and fix errors.

### `test.md`

Generate a comprehensive, repo-consistent test plan for the requested feature/change (unit + integration + error cases + edge cases + mobile checks).

### `maintain-context.md`

Run a documentation + knowledge + methodology maintenance pass for the instruction framework (no product code changes).

### `vscode-install.ps1`

Installs commands into the Codex prompts folder at `$env:USERPROFILE\\.codex\\prompts` on **Windows**.

### `vscode-install.sh`

Installs commands into the Codex prompts folder at `~/.codex/prompts` on **macOS/Linux**.
