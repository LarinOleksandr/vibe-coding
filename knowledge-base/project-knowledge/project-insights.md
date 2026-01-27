# Project Insights Log

## [1]
- Why it matters: Framework rules must be path-stable and easy for non-experts.
- Root cause / constraint: Worktrees change the root path and confuse repo placement.
- Fix / decision: Remove worktree workflow from the framework; keep a single workspace.
- Prevention: Keep skills aligned to repo paths and verify references with `rg`.