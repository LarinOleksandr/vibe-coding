# OPEN QUESTIONS (BLOCKERS)

- None.

# TASK CHECKLIST

- [ ] Phase 1: Create plan + baseline checks
- [ ] Phase 1: Rename the agent docs folder to `docs-ai\` via `git mv`
- [ ] Phase 1: Confirm the folder move is staged (`git status`)
- [ ] Phase 2: Update routed aliases in `docs-ai\agents-core-knowledge\roots.md`
- [ ] Phase 2: Update all repo references to use `docs-ai/` and `docs-ai\`
- [ ] Phase 2: Fix any headings that embed the old path (e.g. `# docs-ai/...`)
- [ ] Phase 3: Run repo-level checks/tests (only what exists in this repo)
- [ ] Phase 3: Final audit: ensure zero outdated folder references remain

# PHASE 1 - Prepare + Rename

## Affected files/folders

- `docs-ai\` (target folder)
- `docs-ai\agents-artifacts\plans\` (this plan file)

## Per-item change summary

- Rename the agent docs folder to `docs-ai` while preserving git history.

## Implementation steps

1. Baseline scan (counts and locations):
   - `rg -n "<old-folder-name>" -S .`
2. Rename using git:
   - `git mv <old-folder-name> docs-ai`
3. Confirm the rename is staged:
   - `git status --porcelain`

## Unit tests (this phase)

- None (rename-only).

# PHASE 2 - Update Links, Routes, and References

## Affected files (expected; not exhaustive)

- `AGENTS.md`
- `docs\application-development-guide.md`
- `docs\user-story-agent-collaboration.md`
- `frontend\web\config\app-design-preset.json`
- `docs-ai\agents-core-knowledge\**/*.md`
- `docs-ai\project-knowledge\**/*.md`
- `docs-ai\agents-artifacts\**/*.md`

## Per-file change summary (high level)

- Replace old folder name in all Markdown references and headings.
- Update the alias map in `roots.md` so all `KB_*` and `ROOT_*` paths point to `./docs-ai/...`.

## Implementation steps

1. Update alias paths:
   - Edit `docs-ai\agents-core-knowledge\roots.md`
2. Replace references across the repo:
   - Replace `<old-folder-name>/` -> `docs-ai/`
   - Replace `<old-folder-name>\` -> `docs-ai\`
3. Re-scan and fix remaining edge cases:
   - `rg -n "<old-folder-name>" -S .`
4. Ensure routed docs and tables use the new folder:
   - `repository-layout.md`, `project-context.md`, `threads.md`, and any artifact templates.

## Unit tests (this phase)

- None (doc + path update), but verification commands must pass:
  - `rg -n "<old-folder-name>" -S .` returns no matches.

# PHASE 3 - Verification + Final Audit

## Affected files

- None (verification only), unless fixes are required.

## Implementation steps

1. Run whatever checks exist (do not add new dependencies):
   - If `pnpm-lock.yaml` exists: `pnpm -r test` and `pnpm -r run lint`
   - Else if root `package.json` exists: `npm test` and `npm run lint` (if defined)
2. Git sanity:
   - `git diff --stat`
   - `git status --porcelain`
3. Final audit (must be clean):
   - `rg -n "<old-folder-name>" -S .`

## Unit tests (this phase)

- Repo tests/lint only if they already exist and are runnable in this repo.

