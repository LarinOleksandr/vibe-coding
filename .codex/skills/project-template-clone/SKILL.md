---
name: project-template-clone
description: Clone the current repository into a new project folder (template-based scaffolding) using PowerShell. Use when the user asks to create a new project with the same folders/config/layout as this repo. Excludes secrets and build output, does not copy .git (starts a fresh repo), and applies project-name text replacements driven by a repo-local config file.
---

# Project Template Clone

## Goal

Create a new project folder that starts from this repo’s structure and setup, while removing unsafe or machine-specific files.

## Default inputs (repo-local)

- Config file: `ROOT_SKILLS/project-template-clone/assets/template-clone.config.json`
- Scaffold skeleton (copied into the new project): `ROOT_SKILLS/project-template-clone/assets/skeleton/`
- Script: `ROOT_SKILLS/project-template-clone/scripts/new-project-from-template.ps1`

## Interface (script parameters)

Required:

- `-NewProjectName <name>`: the new project name (also used for replacements).

Optional:

- `-DestinationPath <path>`: folder to create for the new project. Default: a sibling folder next to this repo (`../<NewProjectName>`).
- `-TemplatePath <path>`: source template folder. Default: current folder.
- `-ConfigPath <path>`: default: `ROOT_SKILLS/project-template-clone/assets/template-clone.config.json`.
- `-InitGit`: run `git init` in the new folder if Git is available (default: on).
- `-AllowExistingDestination`: allow using an existing destination folder (danger: may overwrite files).
- `-DryRun`: show what would happen without copying/changing files.

## Workflow (what to do)

1. Choose a destination folder path for the new project.
2. Run the script with `-DryRun` first.
3. Run again without `-DryRun` to perform the clone.
4. If the repo-local config defines replacements, verify the new project name is updated in common files (README, package config, etc.).

## Notes (safety)

- Do not copy secrets: `.env` is excluded by default (config can add more).
- Do not copy generated output: common build/cache folders are excluded by default.
- Reset legacy agent state: the script replaces `docs-ai/agents-artifacts/` and `docs-ai/project-knowledge/` with clean scaffold content from the skill skeleton.
- Prefer repo-relative paths or `KB_ROOTS` aliases in any instructions.
