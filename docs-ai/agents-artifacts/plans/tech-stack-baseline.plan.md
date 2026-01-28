# tech-stack-baseline.plan.md

## Goal

Make `KB_TECH_STACK` a baseline/default stack and place the actual project stack in project docs. Update all references so the framework consistently treats `KB_TECH_STACK` as baseline and `DOC_PROJECT_CONTEXT` as the current project stack.

## Scope

- Update `docs-ai/agents-core-knowledge/tech-stack-baseline.md` to clearly state baseline/default stack.
- Add a project-specific stack section to `docs-ai/project-knowledge/project-context.md`.
- Update any docs that reference `KB_TECH_STACK` to clarify baseline vs project-specific overrides.
- Update routing/index references where necessary.
- Add user-facing notes in docs about where the real project stack lives and how to update it.

## Out of scope

- No changes to product code.
- No dependency or tooling changes.

## Files to touch (expected)

- `C:\Dev\3-Projects\vibe-coding\docs-ai\agents-core-knowledge\tech-stack-baseline.md`
- `C:\Dev\3-Projects\vibe-coding\docs-ai\project-knowledge\project-context.md`
- `C:\Dev\3-Projects\vibe-coding\docs-ai\agents-core-knowledge\tools.md`
- `C:\Dev\3-Projects\vibe-coding\docs-ai\agents-core-knowledge\testing.md`
- `C:\Dev\3-Projects\vibe-coding\docs-ai\agents-core-knowledge\deployment-and-cicd.md`
- `C:\Dev\3-Projects\vibe-coding\docs-ai\agents-core-knowledge\ui-baseline.md`
- `C:\Dev\3-Projects\vibe-coding\docs-ai\agents-core-knowledge\roots.md`

## Plan

1. Baseline definition
   - Edit `tech-stack-baseline.md` to label it as baseline/default guidance.
   - Add a short ?Project override? note that the actual stack lives in `DOC_PROJECT_CONTEXT`.
   - Add a note that changes to the baseline require user approval.

2. Project-specific stack
   - Add a ?Project tech stack? section to `project-context.md` with the actual stack for this repo.
   - Include a short note that it can override the baseline.
   - Add a note that changes to the project stack require user approval and must also update the baseline if the default changes.

3. Reference updates
   - Update every reference to `KB_TECH_STACK` to clarify ?baseline stack? and point to `DOC_PROJECT_CONTEXT` for actual stack when relevant.
   - Keep these edits short and consistent across docs.

4. Routing/index alignment
   - Ensure `roots.md` description for `KB_TECH_STACK` matches ?baseline/default stack.?
   - Add or update any project-doc link if needed.

5. Documentation for users and scenarios
   - Update any human-oriented docs that mention the stack to say:
     - baseline lives in `KB_TECH_STACK`
     - current project stack lives in `DOC_PROJECT_CONTEXT`
     - user approval is required for stack changes

## Validation

- `rg -n "KB_TECH_STACK|tech_stack\.md" -S .` shows updated references.
- `project-context.md` has a clear ?Project tech stack? section.
- No docs imply the baseline is the only active stack.
- User approval requirement is stated in both baseline and project stack sections.

## Risks

- Minor confusion if references are not updated consistently.
- Project stack section may be empty; must ensure it is populated.



