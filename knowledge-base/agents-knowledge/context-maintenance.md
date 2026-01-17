# knowledge-base/agents-knowledge/context-maintenance.md

## Agent summary

- How to maintain project context, knowledge, and methodology safely and consistently
- Uses the blueprint as the single source of truth

---

## Blueprint location

- `knowledge-base/agents-knowledge/agent-behaviour-architecture.md`

---

## When to use

Invoke maintenance when any apply:

- A new rule, routed doc, or skill is added
- Conflicts or duplication are detected
- Routing or scope boundaries change
- The user requests a context audit or update

---

## Procedure

1. Invoke `$context-maintenance`
2. Check single source of truth
   - no duplicated rules across layers
   - routed docs do not restate root rules
3. Verify routing and scope
   - root routes point to existing docs
   - scoped AGENTS remain smaller than root
4. Prune and normalize
   - remove redundant rules
   - prefer references over repeats
5. Record changes
   - list edits applied
   - list follow-ups if needed

---

## Outputs

- Issues found (with file paths)
- Proposed edits and moves
- Routing updates required
