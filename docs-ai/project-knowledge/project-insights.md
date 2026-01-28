# Project Insights Log

## [1]
- Why it matters: Framework rules must be path-stable and easy for non-experts.
- Root cause / constraint: Worktrees change the root path and confuse repo placement.
- Fix / decision: Remove worktree workflow from the framework; keep a single workspace.
- Prevention: Keep skills aligned to repo paths and verify references with `rg`.

## [2]
- Why it matters: Finishing work must be one simple action so users reliably verify, update docs, and save changes.
- Root cause / constraint: Overlapping “finish” skills caused duplicated steps and unclear user intent.
- Fix / decision: Fold verification + project docs updates into `$commit-push-create-pr` and remove overlapping skills.
- Prevention: Keep one “finish” workflow skill; keep other skills only for unique actions.
