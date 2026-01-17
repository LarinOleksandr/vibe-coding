# Generic Repository Structure

## Agent summary

- Reference structure for a monorepo with frontend, backend, AI services, and shared code.
- Use this as a guide, not a literal checklist.

---

## Root files

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `.gitignore` | file | Yes | Ignore rules to exclude build artifacts, logs, local env files, and other non-source content. |
| `.editorconfig` | file | No | Shared editor formatting rules (indentation, line endings, charset). |
| `package.json` | file | Yes | Root Node/TypeScript manifest defining workspaces, scripts (dev, build, test), and shared deps. |
| `pnpm-workspace.yaml` | file | Yes | Workspace definition listing frontend, backend, ai, and shared packages. |
| `tsconfig.base.json` | file | Yes | Base TypeScript config shared by all TS projects for consistent compiler options. |
| `README.md` | file | Yes | Top-level project documentation describing purpose, architecture overview, and setup steps. |

---

## Config

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `config/` | folder | No | Project-level configuration for lint, CI, env templates, and global runtime defaults. |
| `config/lint/` | folder | No | ESLint, Prettier, and style-related configuration files. |
| `config/ci/` | folder | No | Shared CI/CD workflow templates and reusable configuration fragments. |
| `config/env/` | folder | No | Environment variable templates (for example `.env.example`) and required keys. |
| `config/runtime/` | folder | No | Global runtime defaults (JSON/YAML) and cross-service feature flags. |

---

## Docs

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `docs/` | folder | No | Human-oriented documentation for the system, product, and operations. |
| `docs/architecture/` | folder | No | Architecture documents such as diagrams, data models, and component relationships. |
| `docs/product/` | folder | No | Product and UX docs describing user journeys, wizard steps, and use cases. |
| `docs/operations/` | folder | No | Monitoring instructions, incident runbooks, and deployment playbooks. |

---

## Knowledge base

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `knowledge-base/` | folder | No | LLM-oriented assets that provide structured context for agent workflows. |
| `knowledge-base/tech-stack/` | folder | No | Markdown files describing the full and minimal tech stack. |
| `knowledge-base/prompts/` | folder | No | Prompt templates and system messages for agent roles and shared behaviors. |
| `knowledge-base/schemas/` | folder | No | Machine-readable schemas representing agent inputs and outputs (JSON Schema or equivalent). |

---

## Frontend

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `frontend/` | folder | Yes | All user-facing web UI projects. |
| `frontend/web/` | folder | Yes | Primary React + Vite + TypeScript application implementing the wizard UI. |
| `frontend/web/package.json` | file | Yes | Frontend manifest with UI deps and scripts for running/building the app. |
| `frontend/web/tsconfig.json` | file | Yes | TypeScript config for the web app, typically extending the root config. |
| `frontend/web/vite.config.ts` | file | Yes | Vite configuration for entry points, plugins, and build options. |
| `frontend/web/tailwind.config.cjs` | file | No | Tailwind configuration controlling theme, content paths, and plugins. |
| `frontend/web/postcss.config.cjs` | file | No | PostCSS config for Tailwind and related plugins. |
| `frontend/web/index.html` | file | Yes | HTML shell for mounting the React application at runtime. |
| `frontend/web/src/` | folder | Yes | Source code: components, routes, hooks, and utilities. |
| `frontend/web/public/` | folder | No | Static assets served directly without processing. |
| `frontend/web/config/` | folder | No | Frontend runtime config layered by environment. |

---

## Backend

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `backend/` | folder | Yes | Non-AI backend code for domain logic, API behavior, and exports. |
| `backend/api/` | folder | Yes | Node/TypeScript HTTP or serverless API service for core endpoints. |
| `backend/domain/` | folder | Yes | Core business logic independent from HTTP or database layers. |
| `backend/validation/` | folder | No | Validation helpers (Zod schemas, JSON Schema utilities). |
| `backend/exports/` | folder | No | Export routines for DOCX, PDF, Markdown, and ZIP files. |
| `backend/config/` | folder | No | Backend runtime configuration layered by environment. |

---

## AI

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `ai/` | folder | Yes | AI-specific services including orchestration and embeddings. |
| `ai/orchestrator/` | folder | Yes | Node/TypeScript service running the multi-agent workflow graph. |
| `ai/orchestrator/package.json` | file | Yes | Orchestrator manifest with dependencies and scripts. |
| `ai/orchestrator/src/` | folder | Yes | Graph definition, agent nodes, LLM clients, and retrieval logic. |
| `ai/orchestrator/config/` | folder | No | Orchestrator runtime config layered by environment. |
| `ai/embeddings/` | folder | Yes | Python-based embedding service with a FastAPI endpoint. |
| `ai/embeddings/app/` | folder | Yes | FastAPI application code and request/response schemas. |
| `ai/embeddings/requirements.txt` | file | Yes | Python deps for the embedding service. |
| `ai/llm-runtime/` | folder | No | LLM engine configuration and documentation (for example Ollama). |
| `ai/llm-runtime/config/` | folder | No | Model and runtime configuration files for the LLM engine. |

---

## Shared

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `shared/` | folder | Yes | Shared libraries and utilities used across services. |
| `shared/types/` | folder | Yes | TypeScript type definitions for core entities (single source of truth). |
| `shared/validation/` | folder | Yes | Shared validation schemas for JSON structures across services. |
| `shared/config/` | folder | No | Shared configuration utilities such as typed loaders and env parsing. |

---

## Infrastructure

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `infra/` | folder | Yes | Infrastructure and deployment configuration. |
| `infra/docker/` | folder | Yes | Dockerfiles and `docker-compose.yml` with profiles. |
| `infra/k8s/` | folder | No | Kubernetes manifests for cluster deployments. |
| `infra/netlify/` | folder | No | Netlify build and deploy configuration. |
| `infra/ci/` | folder | No | CI pipeline definitions (for example GitHub Actions). |

---

## Tests

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `tests/` | folder | No | High-level test suites spanning multiple modules. |
| `tests/e2e/` | folder | No | End-to-end tests (for example Playwright). |
| `tests/integration/` | folder | No | Integration tests across services. |
| `tests/contract/` | folder | No | Contract tests for API and AI service stability. |

---

## Scripts

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `scripts/` | folder | Yes | Helper scripts for dev workflows, migrations, and seeding. |
| `scripts/dev-all.sh` | file | Yes | Starts the complete local environment for development and testing. |
| `scripts/migrate.sh` | file | No | Runs database migrations via Supabase or other tooling. |
| `scripts/seed.sh` | file | No | Seeds development or demo data. |

---

## Supabase

| Path | Type | Required | Description |
| --- | --- | --- | --- |
| `supabase/` | folder | Yes | Supabase CLI project directory. |
| `supabase/config.toml` | file | Yes | Supabase project config for local dev and migrations. |
| `supabase/migrations/` | folder | Yes | SQL migrations for schema changes and pgvector setup. |
| `supabase/functions/` | folder | Yes | Supabase Edge Functions for database-adjacent logic. |
| `supabase/seed/` | folder | No | Seed SQL or scripts for development and testing. |

---

## Original JSON

```json
[
    {
        "path":  ".gitignore",
        "type":  "file",
        "mandatory":  true,
        "description":  "Git ignore rules to exclude build artifacts, logs, local environment files and other non-source content from version control, keeping the repository clean and focused on trackable code."
    },
    {
        "path":  ".editorconfig",
        "type":  "file",
        "mandatory":  false,
        "description":  "Shared editor formatting rules (indentation, line endings, charset) so different IDEs produce consistent code style across the whole project."
    },
    {
        "path":  "package.md",
        "type":  "file",
        "mandatory":  true,
        "description":  "Root Node/TypeScript manifest defining workspaces, high-level scripts (dev, build, test) and shared dependencies; required to install and run the monorepo."
    },
    {
        "path":  "pnpm-workspace.yaml",
        "type":  "file",
        "mandatory":  true,
        "description":  "Workspace definition listing frontend, backend, ai and shared packages so pnpm can manage them as a single monorepo with proper linking."
    },
    {
        "path":  "tsconfig.base.md",
        "type":  "file",
        "mandatory":  true,
        "description":  "Base TypeScript configuration shared by all TS projects (frontend, backend, ai, shared) to enforce the same compiler options and strictness everywhere."
    },
    {
        "path":  "README.md",
        "type":  "file",
        "mandatory":  true,
        "description":  "Top-level project documentation describing purpose, architecture overview and setup steps so any developer can understand and run the stack."
    },
    {
        "path":  "config/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Central project-level configuration area for lint, CI, environment templates and global runtime defaults that are not tied to a single app or service."
    },
    {
        "path":  "config/lint/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "ESLint, Prettier and style-related configuration files used to keep code style rules consistent across all packages."
    },
    {
        "path":  "config/ci/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Shared CI/CD workflow templates and reusable configuration fragments for pipelines, making build and deploy definitions easier to maintain."
    },
    {
        "path":  "config/env/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Environment variable templates (e.g. .env.example) and documentation of required configuration keys for different environments."
    },
    {
        "path":  "config/runtime/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Global runtime defaults (JSON/YAML) and cross-service feature flags. Service-specific runtime configuration lives next to each service (e.g. backend/config, ai/orchestrator/config, frontend/web/config)."
    },
    {
        "path":  "docs/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Human-oriented documentation for the system, including product vision, technical design and operational guidance for running and supporting the platform."
    },
    {
        "path":  "docs/architecture/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Architecture documents such as system diagrams, data models and component relationships that describe how the system is structured."
    },
    {
        "path":  "docs/product/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Product and UX documentation describing user journeys, wizard steps, use cases and value propositions for the AI Product Wizard."
    },
    {
        "path":  "docs/operations/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Operational documentation including monitoring instructions, incident runbooks and deployment playbooks used by operators and DevOps."
    },
    {
        "path":  "knowledge-base/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "LLM-oriented assets that provide structured context (tech stack, prompts, schemas) for agents to use during reasoning and code generation. Not required for basic app runtime, but essential for AI-assisted workflows."
    },
    {
        "path":  "knowledge-base/tech-stack/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "JSON files describing the full and minimal tech stack, used by AI agents to understand available technologies and responsibilities."
    },
    {
        "path":  "knowledge-base/prompts/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Prompt templates and system messages for different agent roles and shared behaviors, used to standardize agent instructions."
    },
    {
        "path":  "knowledge-base/schemas/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Machine-readable JSON schemas and related structures representing inputs and outputs of agents, used for validation and guidance."
    },
    {
        "path":  "frontend/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "All user-facing web UI projects; currently contains the main React-based wizard and may later contain additional frontends (e.g. admin dashboards)."
    },
    {
        "path":  "frontend/web/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Primary React + Vite + TypeScript application implementing the AI Product Wizard interface for end users."
    },
    {
        "path":  "frontend/web/package.md",
        "type":  "file",
        "mandatory":  true,
        "description":  "Frontend-specific manifest declaring React, Vite, Tailwind, shadcn/ui and other UI dependencies plus scripts for running and building the web app."
    },
    {
        "path":  "frontend/web/tsconfig.md",
        "type":  "file",
        "mandatory":  true,
        "description":  "TypeScript configuration for the web app, typically extending the root tsconfig, controlling JSX, module resolution and TS strictness in the frontend."
    },
    {
        "path":  "frontend/web/vite.config.ts",
        "type":  "file",
        "mandatory":  true,
        "description":  "Vite configuration defining entry points, plugins (React, TS, env), and build options for the frontend bundling pipeline."
    },
    {
        "path":  "frontend/web/tailwind.config.cjs",
        "type":  "file",
        "mandatory":  false,
        "description":  "Tailwind CSS configuration controlling theme, content paths and plugins, enabling utility-first styling across the frontend."
    },
    {
        "path":  "frontend/web/postcss.config.cjs",
        "type":  "file",
        "mandatory":  false,
        "description":  "PostCSS configuration used in the frontend build to process CSS with Tailwind and other PostCSS plugins."
    },
    {
        "path":  "frontend/web/index.html",
        "type":  "file",
        "mandatory":  true,
        "description":  "HTML shell used by Vite as the main document into which the React application is mounted at runtime."
    },
    {
        "path":  "frontend/web/src/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Source code of the web application, including React components, routes, hooks and configuration utilities."
    },
    {
        "path":  "frontend/web/public/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Static assets for the web app (icons, images, manifest) that are served directly without processing."
    },
    {
        "path":  "frontend/web/config/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Frontend runtime configuration (for example API base URLs and feature flags) layered by environment and loaded by the web app at startup."
    },
    {
        "path":  "backend/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Non-AI backend code that encapsulates domain logic, API behavior and export routines, independent of any particular hosting provider."
    },
    {
        "path":  "backend/api/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Node/TypeScript HTTP or serverless API service providing core endpoints (project CRUD, document management, agent trigger endpoints and export functions), independent from database and Supabase internals."
    },
    {
        "path":  "backend/domain/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Core business logic such as project lifecycle rules, document versioning, approval flows and validations, independent from HTTP or database layers."
    },
    {
        "path":  "backend/validation/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Backend validation helpers (Zod schemas, JSON Schema utilities) that enforce constraints on incoming and outgoing data structures."
    },
    {
        "path":  "backend/exports/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Code for converting internal document representations into DOCX, PDF, Markdown and ZIP files and coordinating their storage."
    },
    {
        "path":  "backend/config/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Backend runtime configuration (for example environment-specific settings and feature flags) kept close to the backend code and layered per environment."
    },
    {
        "path":  "ai/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "AI-specific services, including multi-agent orchestration, embedding computation and LLM runtime integration used by the product wizard."
    },
    {
        "path":  "ai/orchestrator/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Node/TypeScript service that uses LangGraph and LangChain to define and execute the multi-agent workflow graph for PM, BA, UXD, and other roles."
    },
    {
        "path":  "ai/orchestrator/package.md",
        "type":  "file",
        "mandatory":  true,
        "description":  "Service manifest for the orchestrator declaring dependencies (LangGraph, LangChain, HTTP server) and scripts to run and build the orchestration service."
    },
    {
        "path":  "ai/orchestrator/src/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Source for the orchestrator: graph definition, individual agent nodes, LLM client integrations and retrieval logic for contextualizing agent calls."
    },
    {
        "path":  "ai/orchestrator/config/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Orchestrator runtime configuration (for example model routing, timeouts and feature flags) layered by environment and read by the orchestration service at startup."
    },
    {
        "path":  "ai/embeddings/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Python-based embedding service that exposes a FastAPI endpoint for converting text into embeddings used with pgvector for semantic search."
    },
    {
        "path":  "ai/embeddings/app/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "FastAPI application code for the embedding service, including the main server entrypoint, model loading and request/response schemas."
    },
    {
        "path":  "ai/embeddings/requirements.txt",
        "type":  "file",
        "mandatory":  true,
        "description":  "Python dependencies for the embedding service, typically including FastAPI, uvicorn and sentence-transformers, required to install and run the service."
    },
    {
        "path":  "ai/llm-runtime/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Configuration and documentation related to the LLM engine(s) in use (for example Ollama or cloud providers), describing available models and how the orchestrator connects to them."
    },
    {
        "path":  "ai/llm-runtime/config/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Model and runtime configuration files (for example model names, endpoints and parameters) used to control how the LLM engine operates."
    },
    {
        "path":  "shared/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Shared libraries and utilities consumed by frontend, backend and AI services, reducing duplication and keeping contracts consistent."
    },
    {
        "path":  "shared/types/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "TypeScript type definitions and interfaces for core entities like Project, Document, AgentRun, used as a single source of truth across the codebase."
    },
    {
        "path":  "shared/validation/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Common validation schemas (usually Zod) for JSON structures that are shared between UI, backend and AI orchestrator to keep data contracts aligned."
    },
    {
        "path":  "shared/config/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Shared configuration utilities such as typed config loaders, environment parsing and feature flags used by multiple parts of the system."
    },
    {
        "path":  "infra/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Infrastructure and deployment configuration, describing how services are run locally and in production (containers, cloud, CI integration)."
    },
    {
        "path":  "infra/docker/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Dockerfiles for individual services and a docker-compose.yml with profiles (for example dev and ci) that orchestrates backend, AI services and supporting components."
    },
    {
        "path":  "infra/k8s/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Kubernetes manifests (Deployments, Services, Ingress) for running the system in a Kubernetes cluster when or if you adopt k8s."
    },
    {
        "path":  "infra/netlify/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Netlify-related configuration files controlling how the frontend is built and deployed to Netlify hosting."
    },
    {
        "path":  "infra/ci/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Concrete CI pipeline definitions (e.g. GitHub Actions YAML) that implement build, test and deploy workflows for the monorepo."
    },
    {
        "path":  "tests/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "High-level test suites that span multiple modules (frontend + backend + ai) such as end-to-end, integration and contract tests."
    },
    {
        "path":  "tests/e2e/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "End-to-end tests (e.g. Playwright) that simulate real user journeys from project creation through agent runs and exports."
    },
    {
        "path":  "tests/integration/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Integration tests that verify interactions between components and services, such as backend API calls into AI orchestrator and database."
    },
    {
        "path":  "tests/contract/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Contract tests that assert the shape and behavior of APIs and AI service endpoints remain stable across versions."
    },
    {
        "path":  "scripts/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Developer and CI helper scripts that automate common workflows like starting the stack, running migrations or seeding data. Core to the rule that everything should be runnable via scripts."
    },
    {
        "path":  "scripts/dev-all.sh",
        "type":  "file",
        "mandatory":  true,
        "description":  "Convenience script that starts the complete local environment (frontend, backend, AI services, database) to support development and manual testing with a single command."
    },
    {
        "path":  "scripts/migrate.sh",
        "type":  "file",
        "mandatory":  false,
        "description":  "Wrapper script that runs database migrations via Supabase or another migration tool, keeping the schema in sync with code."
    },
    {
        "path":  "scripts/seed.sh",
        "type":  "file",
        "mandatory":  false,
        "description":  "Script to populate the database with development or demo data, such as sample projects and documents, for easier testing."
    },
    {
        "path":  "supabase/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Supabase CLI project directory required by Supabase tooling; contains database migrations, function definitions and local project configuration."
    },
    {
        "path":  "supabase/config.toml",
        "type":  "file",
        "mandatory":  true,
        "description":  "Supabase configuration file that defines the project ID and local settings used by the Supabase CLI for migrations and local dev."
    },
    {
        "path":  "supabase/migrations/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "SQL migration files that describe database schema changes over time, including tables for projects, documents, versions, agent runs and pgvector setup."
    },
    {
        "path":  "supabase/functions/",
        "type":  "folder",
        "mandatory":  true,
        "description":  "Supabase Edge Function source code implementing serverless endpoints that sit close to the database and are invoked by the frontend or backend when low-latency, database-adjacent logic is needed."
    },
    {
        "path":  "supabase/seed/",
        "type":  "folder",
        "mandatory":  false,
        "description":  "Seed SQL or scripts for initializing Supabase with baseline data useful in development or testing environments."
    }
]
```
