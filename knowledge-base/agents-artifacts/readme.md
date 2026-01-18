# knowledge-base/agents-artifacts/readme.md

This folder stores agent-generated artifacts.

## Structure

- `plans/` contains planning files created by `$plan-creation`
- `architectural-reviews/` contains architecture review artifacts from `$architecture-review`
- `design-reviews/` contains design review artifacts from `$design-review` or `/design-review`
- `research-briefs/` contains research briefs created by `$feature-research` or `/feature-research`

## Rules

- One artifact per task.
- Use standardized names:
  - plans: `<task-slug>.plan.md`
  - architectural reviews: `<task-slug>.arch-review.md`
  - design reviews: `<task-slug>.design-review.md`
  - research briefs: `<task-slug>.research.md`
- Do not delete or overwrite old artifacts.
