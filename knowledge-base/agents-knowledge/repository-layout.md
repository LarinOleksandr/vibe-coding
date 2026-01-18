# knowledge-base/agents-knowledge/repository-layout.md

## Agent summary

- Fast placement index: where to find things and where to put new things.
- This doc answers "where?"; constraints and governance live in `KB_REPOSITORY_RULES`.

---

## Current root layout (what limits search)

| Path | What it contains | Use when you need... |
| --- | --- | --- |
| `AGENTS.md` | Root rules + routing | non-negotiables and which KB doc to consult |
| `knowledge-base/` | Agent knowledge, prompts, artifacts, and project docs | any agent workflow, prompt, artifact, or project state |
| `skills/` | Procedural skills | a repeatable multi-step procedure (`$<skill>`) |
| `docs/` | Human-facing docs | application development guidance and collaboration docs |
| `frontend/` | Frontend runtime boundary (placeholder) | the user-facing web/mobile client code (when it exists) |
| `ai/` | AI runtime boundaries (placeholders) | orchestrator/embeddings services (when they exist) |
| `supabase/` | Supabase boundary (placeholder) | DB migrations, Edge Functions, RLS policies (when adopted) |
| `infra/` | Infrastructure boundary (placeholder) | deploy templates, local stack definitions (when adopted) |

---

## Find index (look here first)

| If you need... | Look in... | Notes |
| --- | --- | --- |
| Repo structure rules / boundaries / config rules | `knowledge-base/agents-knowledge/repository_rules.md` | canonical constraints |
| Where does X belong? (routing) | `knowledge-base/agents-knowledge/repository-layout.md` | this document |
| Application workflow guide | `docs/application-development-guide.md` | end-to-end workflow from idea -> deploy |
| Thread naming + codes | `knowledge-base/agents-knowledge/threads.md` | canonical thread rules |
| Feature brief template | `knowledge-base/agents-knowledge/feature-template.md` | used by `/feature-start` |
| Feature research expectations | `knowledge-base/agents-knowledge/feature-research.md` | timeboxed research brief |
| Testing strategy and gates | `knowledge-base/agents-knowledge/testing.md` | no new deps without approval |
| Deployment/CI "DNA" rules | `knowledge-base/agents-knowledge/deployment-and-cicd.md` | Netlify/Vercel rules, branch policy |
| Slash command prompts | `knowledge-base/slash-commands/prompts/` | `/project-setup`, `/feature-start`, etc. |
| Skills list | `skills/skills.md` | canonical list + when to use |
| A specific skill procedure | `skills/<skill-name>/SKILL.md` | step-by-step procedure |
| Generated plans | `knowledge-base/agents-artifacts/plans/` | created by `$plan-creation` |
| Architecture review artifacts | `knowledge-base/agents-artifacts/architectural-reviews/` | created by `$architecture-review` |
| Design review artifacts | `knowledge-base/agents-artifacts/design-reviews/` | created by `$design-review` |
| Research brief artifacts | `knowledge-base/agents-artifacts/research-briefs/` | created by `$feature-research` |
| Project context/plan/insights | `knowledge-base/project-*.md` | maintained by `/project-setup` and `/project-docs-update` |
| Archived legacy docs | `knowledge-base/old/` | non-canonical reference only |

---

## Placement index (where to put new things)

| If you are adding... | Put it in... | Example name(s) |
| --- | --- | --- |
| A new routed KB doc | `knowledge-base/agents-knowledge/` | `repository-layout.md`, `deployment-and-cicd.md` |
| A new slash command prompt | `knowledge-base/slash-commands/prompts/` | `design-review.md` |
| A new skill | `skills/<skill-name>/SKILL.md` | `skills/design-review/SKILL.md` |
| A new agent artifact type | `knowledge-base/agents-artifacts/<category>/` | `design-reviews/`, `research-briefs/` |
| A new project "memory" doc | `knowledge-base/` | `project-context.md`, `project-feature-plan.md` |
| Human-facing guidance | `docs/` | application development guide, user instructions |
| A new deploy template | `infra/deploy/<provider>/` | `infra/deploy/netlify/` |

---

## Adding a new runtime/service (folder placement + naming cues)

This repo grows by adding services. Use these naming cues to keep the tree predictable (constraints are in `KB_REPOSITORY_RULES`):

1. Pick the runtime root by what it is:
   - user-facing app -> `frontend/<app>`
   - AI runtime -> `ai/<service>`
   - DB-adjacent (migrations/functions/policies) -> `supabase/`
   - infra/deploy/local stack -> `infra/`
   - non-AI API/service -> `backend/<service>` (create `backend/` only when it becomes real)
2. Name by role, not technology:
   - prefer: `web`, `api`, `worker`, `orchestrator`, `embeddings`
   - avoid: `react`, `node`, `python`, `express`
3. If a new service is expected to become a permanent runtime boundary, create it under the correct root and keep it self-contained.

---

## Expected next folders as real code appears (not present yet)

These are common additions as the proto-repo becomes a real application:

- `shared/` (contracts and schemas shared across services)
- `scripts/` (canonical dev/test/build/migrate entrypoints)
- `backend/` (non-AI API/services)
- `config/` (global defaults/templates, if needed beyond service-local config)
- `tests/` (cross-service test suites, if needed)
