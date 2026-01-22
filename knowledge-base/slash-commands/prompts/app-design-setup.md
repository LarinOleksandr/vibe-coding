# /app-design-setup

---

title: app-design-setup

---

## Goal

Initialize or update the `frontend/web` design system using the preset in `frontend/web/config/app-design-preset.json`, in a consistent and repeatable way.

## Use cases (must support)

### Use case A — Use the current preset (default)

- The agent applies the existing preset from `frontend/web/config/app-design-preset.json`.

### Use case B — Switch to a new preset

- The agent asks the user for a new preset input, updates `frontend/web/config/app-design-preset.json`, then applies it.

Users can switch presets at any time by rerunning this command.

## Actions (agent must execute)

1. Read:
   - `frontend/AGENTS.md`
   - `KB_UI_BASELINE`
   - `KB_UX_BASELINE`
   - `KB_REPOSITORY_RULES` (dependency approval rule)
2. Ensure `frontend/web/config/app-design-preset.json` exists.
3. Ask one choice question:
   - “Use the current design preset from `frontend/web/config/app-design-preset.json`?” (Yes/No)
4. If **No** (switch preset):
   - Provide the link: `https://ui.shadcn.com/create`
   - Ask the user to return the generated:
     - `https://ui.shadcn.com/init?...` URL
     - and the target template (`next` or `vite`) if needed
   - Update `frontend/web/config/app-design-preset.json` (single source of truth).
   - Update `knowledge-base/project-insights.md` with the decision (reference the config file path; avoid duplicating the whole URL in multiple places).
5. Ensure `frontend/web/scripts/app-design-init.ps1` exists.
6. If applying the preset will introduce new npm dependencies:
   - request explicit approval once for the “design system dependency bundle”
   - after approval, write `frontend/web/config/deps-approved.json`
7. Apply the preset via the script.
8. Run a minimal smoke verification suitable for the current state of `frontend/web` (no broad test runs unless needed).
