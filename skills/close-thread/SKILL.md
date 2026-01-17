---
name: close-thread
description: Close a thread reliably with validation status, documentation updates, and a final summary.
---

# skills/close-thread/SKILL.md

## Name

$close-thread

## Purpose

Close a thread reliably with validation status, documentation updates, and a final summary.

## When to use

Invoke when any apply:

- user expresses clear intent to close the thread
- user says "Close the thread", "We are done", "Wrap up", or similar

If intent is ambiguous, ask once to confirm.

## Inputs

- Tests/validation status (if available)

## Procedure

1. Confirm goal and completion status
   - If unclear, ask once.
   - Verify any promised artifacts exist.
2. Check tests/validation
   - If status unknown, ask once.
   - If failures or gaps exist, ask whether to fix now or defer.
3. Update documentation
   - Update internal knowledge-base docs if rules/skills changed.
   - Update user-facing docs if behavior or usage changed.
   - If none needed, state that explicitly.
4. Summarize
   - Short summary of work completed.
   - Follow-ups or unresolved items (if any).
5. Confirm closure
   - State: "Thread closed. No further changes in this thread."
   - Stop work unless explicitly reopened.

## Acceptance checks

- Goal and completion status confirmed
- Test/validation status recorded
- Documentation updates performed or explicitly not needed
- Final summary provided
- Closure confirmed
