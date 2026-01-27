# Skills Transfer Plan

## Goal
Integrate beneficial practices from the superpowers skills repository into the VibeCoding framework while keeping skill links, docs, and routes consistent and beginner-friendly.

## Scope / Non-scope

**Scope (in):**
- Review all skills in `C:\Users\oleks\.codex\superpowers\skills` and classify: adopt, adapt, defer, or reject.
- Transfer beneficial practices into existing skills or create new skills under `C:\Dev\3-Projects\vibe-coding\.codex\skills\`.
- Align cross-links and dependencies between skills.
- Update framework documentation and indices to reflect new/updated skills and artifact locations.
- Validate that all references resolve and no stale links remain.

**Non-scope (out):**
- Product/application code changes.
- Changes to external repos or tooling outside this repo.
- Adding new runtime dependencies.

## Affected areas
- `C:\Dev\3-Projects\vibe-coding\.codex\skills\` (skills to update or add)
- `C:\Dev\3-Projects\vibe-coding\.codex\skills\skills.md` (skills index)
- `C:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\repository-layout.md` (artifact category references)
- `C:\Dev\3-Projects\vibe-coding\knowledge-base\agents-artifacts\readme.md` (artifact naming and lists)
- `C:\Dev\3-Projects\vibe-coding\docs\application-development-guide.md` (user-facing workflow references)
- `C:\Dev\3-Projects\vibe-coding\AGENTS.md` (only if routing or trigger rules change)

## Steps

### Step 1: Inventory and classify superpowers skills
**Deliverable:** A short table listing each superpowers skill with a decision: adopt, adapt, defer, or reject.
**Integration:** Store the table in this plan file under a new “Decision Log” section.
**Verify:** Confirm every folder under `C:\Users\oleks\.codex\superpowers\skills` is listed.

### Step 2: Map candidates to the VibeCoding skill set
**Deliverable:** For each “adopt/adapt” skill, map to an existing skill or define a new skill name and location.
**Integration:** Update the Decision Log with “target skill” and “change type” (update vs new).
**Verify:** Ensure each mapped target exists or is explicitly marked “create new”.

### Step 3: Apply required integration checks (must include)
**Deliverable:** A focused checklist that covers the four requested areas.
**Integration:** Add this checklist to the Decision Log section and follow it for each affected skill/doc.
**Verify:** Each item below is explicitly addressed in the plan.

**Required items:**
- **Systematic debugging integration:** Add root-cause-first workflow into `C:\Dev\3-Projects\vibe-coding\.codex\skills\bug-fix\SKILL.md` (either by direct steps or a dedicated skill cross-link).
- **Verification overlap check:** Compare with `C:\Dev\3-Projects\vibe-coding\.codex\skills\thread-closing\SKILL.md` and `C:\Dev\3-Projects\vibe-coding\.codex\skills\commit\SKILL.md` to avoid duplicate rules; decide whether to embed or create a minimal standalone gate and cross-link.
- **Worktree removal audit:** Ensure no worktree workflow references remain in user docs or skills.
- **Writing-plans extraction:** Identify transferable practices from `C:\Users\oleks\.codex\superpowers\skills\writing-plans\SKILL.md` and fold the useful ones into `C:\Dev\3-Projects\vibe-coding\.codex\skills\plan-creation\SKILL.md` (or a new skill if needed).

### Step 4: Align terminology, paths, and triggers
**Deliverable:** A rules checklist for translation (naming, paths, artifact locations, cross-links, style).
**Integration:** Use this checklist when editing each target skill.
**Verify:** Checklist includes: no “superpowers:” prefixes, no CLAUDE.md references, correct artifact paths, and correct plan locations.

### Step 5: Update existing skills
**Deliverable:** Updated skill files in `C:\Dev\3-Projects\vibe-coding\.codex\skills\` reflecting adopted practices.
**Integration:** Keep each skill consistent with framework style (short, clear, beginner-friendly).
**Verify:** All updated skills still reference only existing skills and current paths.

### Step 6: Create new skills (if needed)
**Deliverable:** New skill folders with `SKILL.md` under `C:\Dev\3-Projects\vibe-coding\.codex\skills\`.
**Integration:** Add each new skill to the index at `C:\Dev\3-Projects\vibe-coding\.codex\skills\skills.md`.
**Verify:** Each new skill has valid frontmatter and a clear “Use when…” description.

### Step 7: Update framework documentation
**Deliverable:** Updated docs reflecting skill changes.
**Integration:**
- `C:\Dev\3-Projects\vibe-coding\.codex\skills\skills.md`
- `C:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\repository-layout.md`
- `C:\Dev\3-Projects\vibe-coding\knowledge-base\agents-artifacts\readme.md`
- `C:\Dev\3-Projects\vibe-coding\docs\application-development-guide.md`
- `C:\Dev\3-Projects\vibe-coding\AGENTS.md` (only if triggers/routing need changes)
**Verify:** Each doc reflects the new skill names and any new artifact categories.

### Step 8: Cross-link and dependency audit
**Deliverable:** A simple audit pass for broken links and stale references.
**Integration:** Use `rg` to find “superpowers:”, “CLAUDE.md”, and legacy paths like `docs/plans/`.
**Verify:** No unexpected matches. Any remaining hits must be only in plan artifacts or audit text.

### Step 9: Consistency pass
**Deliverable:** A short consistency checklist applied across skills.
**Integration:** Ensure skill descriptions are “Use when…” only and avoid process in descriptions.
**Verify:** Sample 5 skills and confirm style, terminology, and link consistency.

## Decision Log

| Superpowers skill | Decision | Target skill (VibeCoding) | Change type | Notes |
| --- | --- | --- | --- | --- |
| brainstorming | adapt | `C:\Dev\3-Projects\vibe-coding\.codex\skills\brainstorming\SKILL.md` | update | Already adapted to PRD flow. |
| dispatching-parallel-agents | defer | n/a | n/a | Needs multi-agent support. |
| executing-plans | defer | n/a | n/a | Depends on subagent/parallel execution. |
| finishing-a-development-branch | reject | n/a | n/a | Overlaps with `$commit-push-create-pr`; keep single workflow. |
| receiving-code-review | reject | n/a | n/a | Tone and workflow conflict with beginner-friendly style. |
| requesting-code-review | defer | n/a | n/a | Depends on subagents and review dispatch. |
| subagent-driven-development | defer | n/a | n/a | Requires subagent infrastructure. |
| systematic-debugging | adapt | `C:\Dev\3-Projects\vibe-coding\.codex\skills\bug-fix\SKILL.md` | update | Add root-cause-first workflow. |
| test-driven-development | defer | n/a | n/a | Too strict for current framework; revisit later. |
| using-git-worktrees | reject | n/a | n/a | Removed from framework to avoid repo-structure confusion. |
| using-superpowers | reject | n/a | n/a | Conflicts with current framework flow. |
| verification-of-work | adapt | `C:\Dev\3-Projects\vibe-coding\.codex\skills\verification-of-work\SKILL.md` | new | Add minimal gate, cross-link only. |
| writing-plans | adapt | `C:\Dev\3-Projects\vibe-coding\.codex\skills\plan-creation\SKILL.md` | update | Fold useful ideas into plan-creation. |
| writing-skills | defer | n/a | n/a | Heavy process; not needed now. |

## Translation Checklist (apply to every updated skill)

- Remove all `superpowers:` prefixes.
- Remove any CLAUDE.md references.
- Use current artifact paths (no `docs/plans/`).
- Use existing skill names from `C:\Dev\3-Projects\vibe-coding\.codex\skills\skills.md`.
- Keep descriptions as “Use when…” only (no workflow summary).
- Keep wording beginner-friendly and short.

## Implementation plan (docs/skills only)
- Do Step 1 and add the Decision Log section to this plan file, then verify every superpowers skill is listed.
- Do Step 2 by mapping each “adopt/adapt” item to a target skill, then verify target names exist or are marked “create new”.
- Do Step 3 by adding the required integration checklist, then verify all four requested items are covered.
- Do Step 4 by writing the translation checklist in this plan file, then verify it covers names, paths, and cross-links.
- Do Step 5 by editing existing skills one by one, then verify each only references valid skills and paths.
- Do Step 6 by creating new skill folders if needed, then verify they appear in `C:\Dev\3-Projects\vibe-coding\.codex\skills\skills.md`.
- Do Step 7 by updating docs and indices, then verify references match the new skill set.
- Do Step 8 by running targeted `rg` searches, then verify zero stale references remain.
- Do Step 9 by applying the consistency checklist, then verify sampled skills meet style and link rules.

## Risks
- Conflicting guidance between transferred skills and existing framework rules.
- Broken cross-links after renaming or mapping skills.
- Overly strict rules that conflict with beginner-friendly tone.
- Artifacts stored in inconsistent locations.

## Validation
- `rg -n "superpowers:|CLAUDE.md|docs/plans/" C:\Dev\3-Projects\vibe-coding`
- Confirm `C:\Dev\3-Projects\vibe-coding\.codex\skills\skills.md` lists all new/updated skills.
- Confirm `C:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\repository-layout.md` reflects any new artifact category.
- Confirm `C:\Dev\3-Projects\vibe-coding\knowledge-base\agents-artifacts\readme.md` lists any new artifact type and naming.

## References
- `C:\Users\oleks\.codex\superpowers\skills`
- `C:\Dev\3-Projects\vibe-coding\.codex\skills\skills.md`
- `C:\Dev\3-Projects\vibe-coding\.codex\skills\plan-creation\SKILL.md`
- `C:\Dev\3-Projects\vibe-coding\knowledge-base\agents-core-knowledge\repository-layout.md`
- `C:\Dev\3-Projects\vibe-coding\knowledge-base\agents-artifacts\readme.md`
- `C:\Dev\3-Projects\vibe-coding\docs\application-development-guide.md`

## Rollback notes
Not applicable (documentation and skill procedure changes only).
