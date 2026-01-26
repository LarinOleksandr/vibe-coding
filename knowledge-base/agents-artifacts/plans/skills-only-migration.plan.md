# Skills-Only Migration Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace slash commands with skills while preserving all current workflow behavior.

**Architecture:** Skills become the single source of procedure. Docs and rules reference skills and plain-language requests only. Legacy slash command files and install scripts are removed after parity is confirmed.

**Tech Stack:** Markdown docs, `.codex/skills/*`, knowledge-base routing docs, Windows Codex prompts folder.

## Scope / Non-scope

- Scope: migrate slash command behavior into skills; remove slash command prompts and references; keep workflow functionality.
- Non-scope: product feature code changes; new dependencies; UI changes.

## Affected areas

- `c:\Dev\3-Projects\vibe-coding\knowledge-base\slash-commands\`
- `c:\Dev\3-Projects\vibe-coding\.codex\skills\`
- `c:\Dev\3-Projects\vibe-coding\AGENTS.md`
- `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\`
- `c:\Dev\3-Projects\vibe-coding\docs\`
- `C:\Users\oleks\.codex\prompts\`

## Steps

### Step 1: Inventory current commands and map to skills

**Deliverable:** A mapping table of slash commands → target skills, with gaps noted.

**Integration:** Add the mapping to `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-artifacts\plans\skills-only-migration.plan.md` (this file).

**Command â†’ skill mapping (current state)**

Repo slash commands (`c:\Dev\3-Projects\vibe-coding\knowledge-base\slash-commands\prompts\`):

| Slash command | Target skill | Status |
| --- | --- | --- |
| `/app-design-setup` | `$app-design-setup` | exists |
| `/code-review` | `$code-review` | exists |
| `/context-load` | `$context-load` | exists |
| `/context-maintain` | `$context-maintenance` | exists |
| `/design-review` | `$design-review` | exists |
| `/feature-commit` | `$feature-commit` | exists |
| `/feature-research` | `$feature-research` | exists |
| `/feature-start` | `$feature-start` | exists |
| `/project-docs-update` | `$project-docs-update` | exists |
| `/project-setup` | `$project-setup` | exists |
| `/test-in-browser` | `$testing-in-browser` | exists |
| `/test-plan` | `$test-plan` | exists |
| `/coding-standards-check` | `$coding-standards-check` | exists |
| `/optimize-performance` | `$optimize-performance` | exists |
| `/security-check` | `$security-check` | exists |
| `/ui-consistency-check` | `$ui-consistency-check` | exists |

Local Codex prompts (`C:\Users\oleks\.codex\prompts\`):

| Prompt file | Slash command | Target skill | Status |
| --- | --- | --- | --- |
| `commit-feature.md` | `/commit-feature` | `$feature-commit` | exists |
| `load-context.md` | `/load-context` | `$context-load` | exists |
| `start-feature.md` | `/start-feature` | `$feature-start` | exists |
| `test-browser.md` | `/test-browser` | `$testing-in-browser` | exists |
| `update-knowledge.md` | `/update-knowledge` | `$project-docs-update` | exists |
| `optimize-performance (test).md` | `/optimize-performance` | `$optimize-performance` | exists |

**Verify:**
- Every command in `c:\Dev\3-Projects\vibe-coding\knowledge-base\slash-commands\prompts\` has a matching skill name.
- Every prompt in `C:\Users\oleks\.codex\prompts\` is accounted for.

### Step 2: Create missing skills for command parity

**Deliverable:** New skill folders with `SKILL.md` for any command without a skill.

**Integration:** Add to `c:\Dev\3-Projects\vibe-coding\.codex\skills\`.

**Planned new skills:**
- `context-load`
- `project-setup`
- `project-docs-update`
- `feature-start`
- `test-plan`
- `feature-commit`
- `optimize-performance` (if you want to keep this workflow)

**Verify:**
- Each new skill has `name` and `description` frontmatter and matches the current command behavior.
- `c:\Dev\3-Projects\vibe-coding\.codex\skills\skills.md` lists every new skill.

### Step 3: Update skills list and references

**Deliverable:** Skills list and internal references point only to skills.

**Integration:**
- Update `c:\Dev\3-Projects\vibe-coding\.codex\skills\skills.md`
- Replace any `$old-command` mentions with `$skill-name` in:
  - `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\api-conventions.md` (already uses skills)
  - `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\repository-layout.md`

**Verify:**
- `rg -n "/[a-z-]+" c:\Dev\3-Projects\vibe-coding\knowledge-base` only finds places we still want to keep as examples (if any).

### Step 4: Update agent rules to prefer skills

**Deliverable:** Root rules stop instructing slash command usage.

**Integration:**
- Update `c:\Dev\3-Projects\vibe-coding\AGENTS.md` to reference skills instead of `/commands`.
- Update `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\threads.md` if it references slash commands for closure or workflow.

**Verify:**
- All workflow triggers in `c:\Dev\3-Projects\vibe-coding\AGENTS.md` reference `$skill-name` or plain-language requests.

### Step 5: Update human docs to skills-first language

**Deliverable:** Human docs no longer instruct using slash commands.

**Integration:**
- Update `c:\Dev\3-Projects\vibe-coding\docs\application-development-guide.md`
- Update `c:\Dev\3-Projects\vibe-coding\docs\user-story-agent-collaboration.md`

**Verify:**
- `rg -n "/[a-z-]+" c:\Dev\3-Projects\vibe-coding\docs` returns no workflow commands, or only explicitly marked historical examples (if you keep any).

### Step 6: Remove slash command assets from the repo

**Deliverable:** Slash command prompts and installer scripts removed.

**Integration:**
- Remove `c:\Dev\3-Projects\vibe-coding\knowledge-base\slash-commands\prompts\`
- Remove `c:\Dev\3-Projects\vibe-coding\knowledge-base\slash-commands\README.md`
- Update `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\roots.md` to remove `ROOT_SLASH_COMMANDS`
- Update `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\repository-layout.md` to remove slash command entries

**Verify:**
- `rg -n "slash command|slash-commands" c:\Dev\3-Projects\vibe-coding --glob "!knowledge-base/agents-artifacts/plans/skills-only-migration.plan.md"` returns no hits.

### Step 7: Clean Codex prompts folder

**Deliverable:** `C:\Users\oleks\.codex\prompts\` has no obsolete slash commands.

**Integration:**
- Remove:
  - `C:\Users\oleks\.codex\prompts\commit-feature.md`
  - `C:\Users\oleks\.codex\prompts\load-context.md`
  - `C:\Users\oleks\.codex\prompts\start-feature.md`
  - `C:\Users\oleks\.codex\prompts\test-browser.md`
  - `C:\Users\oleks\.codex\prompts\update-knowledge.md`
  - `C:\Users\oleks\.codex\prompts\optimize-performance (test).md`

**Verify:**
- `Get-ChildItem C:\Users\oleks\.codex\prompts` returns empty or only non-workflow prompts.

### Step 8: Context maintenance and documentation checks

**Deliverable:** Framework docs are consistent with skills-only workflow.

**Integration:**
- Run a context maintenance pass (use `$context-maintenance`) and update:
  - `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\roots.md`
  - `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\repository-layout.md`
  - `c:\Dev\3-Projects\vibe-coding\knowledge-base\project-knowledge\project-insights.md` (record decision)

**Verify:**
- All routes in `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\roots.md` resolve.

## Implementation plan (do X, then verify Y)

1. Build the command → skill mapping table, then verify every prompt has a skill target.
2. Draft missing skills, then verify `c:\Dev\3-Projects\vibe-coding\.codex\skills\skills.md` is complete.
3. Replace rule and doc references, then verify no `/command` hits remain.
4. Remove slash command assets, then verify `knowledge-base\slash-commands\` is gone.
5. Remove `C:\Users\oleks\.codex\prompts\` files, then verify folder is clean.
6. Run context maintenance updates, then verify routes and docs are consistent.

## Risks

- Behavior drift if a command’s exact steps are not carried into its skill.
- Docs becoming inconsistent if slash command references remain.

## Validation

- `rg -n "/[a-z-]+" c:\Dev\3-Projects\vibe-coding`
- `rg -n "slash command|slash-commands" c:\Dev\3-Projects\vibe-coding --glob "!knowledge-base/agents-artifacts/plans/skills-only-migration.plan.md"`
- `Get-ChildItem C:\Users\oleks\.codex\prompts`

## References

- `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\roots.md`
- `c:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\repository-layout.md`
- `c:\Dev\3-Projects\vibe-coding\.codex\skills\skills.md`





