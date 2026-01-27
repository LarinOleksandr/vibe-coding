---
name: verification-of-work
description: Use when you are about to state that work is complete, fixed, or passing tests and need fresh proof.
---

# .codex/skills/verification-of-work/SKILL.md

## Name

`$verification-of-work`

## Purpose

Make sure any success statement is backed by fresh verification.

## When to use

Invoke when any apply:

- you are about to say "done", "fixed", "ready", or "tests pass"
- you are about to answer that work is complete or working
- you are about to claim a bug is resolved

## Inputs

- The exact statement you plan to make
- The command that proves it

## Procedure

1. Identify the proof command
   - tests, build, lint, or a specific smoke path
2. Run the command now
3. Read the full output and exit code
4. Decide based on evidence
   - if it fails or is incomplete, say so and stop
   - if it passes, state the claim with the evidence

## Rules

- No success statements without fresh evidence
- Do not use words like "should" or "probably" for verification
- If you did not run the command in this message, you cannot claim success

## Acceptance checks

- Proof command executed
- Evidence recorded
- Claims match the output
