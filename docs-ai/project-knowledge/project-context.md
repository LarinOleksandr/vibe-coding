# Project Context

## Overview

This repository is a proto-repository ("DNA") for building an application with a coding agent.
It defines collaboration workflows (threads), routed knowledge, and procedural skills that should scale as product complexity grows.

## Goals

- Provide a consistent agent-driven development workflow from idea -> deployed product.
- Keep rules, routing, and procedures explicit and maintainable as the repo grows into a real app.

## Essential Information

- Human docs live in `docs/`; the primary guide is `docs/application-development-guide.md`.
- Agent knowledge/prompts/artifacts live in `docs-ai/` (routed via `KB_ROOTS`).
- Service boundaries are represented by top-level runtime folders (`frontend/`, `ai/`, `supabase/`, `infra/`) per `KB_REPOSITORY_RULES`.

## Project tech stack

Current project stack: not set yet. Until defined, use the baseline in `KB_TECH_STACK`.

If the project stack changes, update this section and get user approval. If the baseline changes, update `KB_TECH_STACK` as well (also requires user approval).
