# Editing protocol (permission + worktree)

## Goal

Prevent accidental changes and keep work predictable.

## Rule 1: permission first (must)

Do not change any files unless the user clearly asked you to change files.

If it is not clear, ask one short question:

- "Do you want me to change files now?"

## Rule 2: where edits are allowed without a worktree (must)

If you will modify **only** these folders:

- `docs/`
- `docs-ai/`

Then a Git worktree under `.worktrees/...` is **not required**.

Still follow the permission rule.

## Rule 3: worktree required for everything else (must)

If you will modify anything **outside** `docs/` and `docs-ai/`:

1. Create/ensure a worktree with `scripts/git-worktree-ensure.ps1`
2. Do all work only inside that `.worktrees/...` folder
3. Do not scan or modify files outside the current worktree folder

## Rule 4: writing down an idea (must)

If the user asks to "write down an idea" (or says "save as idea"):

- Use `$review-ideas` and follow its **save** action
- Only create one new Idea file under `docs/ideas/`
- Do not edit any other files

