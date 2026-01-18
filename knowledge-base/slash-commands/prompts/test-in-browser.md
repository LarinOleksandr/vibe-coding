# /test-in-browser

---

title: test-in-browser

---

## Goal

Start the local dev stack, open the app in a browser via MCP DevTools, capture console/network errors, and iterate until the route is clean.

## Actions (agent must execute)

1. Determine the package manager and command:
   - If `pnpm` is available, use `pnpm dev` (or `pnpm --filter web dev` for the web app).
   - If `pnpm` is not available but `npm` is, use `npm run dev`.
   - If `pnpm` is not available but `yarn` is, use `yarn dev`.
   - If none are available, report the missing tools and stop.
2. Start the dev stack using the chosen command or `./scripts/dev-up.sh` when the full stack is required.
3. Read the dev server output to determine the actual host/port (avoid assuming `localhost:3000`).
4. Open the detected URL with MCP DevTools (`mcp__chrome-devtools__new_page` or `mcp__chrome-devtools__navigate_page`).
5. Capture runtime issues:
   - `mcp__chrome-devtools__list_console_messages`
   - `mcp__chrome-devtools__list_network_requests`
   - Take a snapshot if DOM inspection is needed.
6. Map errors to source files, apply fixes, and reload the page.
7. Repeat steps 4-6 until the console and network panels show no blocking errors for the target route.
8. Report the resolved errors, remaining issues (if any), and the files touched.
9. If new commands or patterns were discovered, append a brief note to `DOC_PROJECT_INSIGHTS`.

## Commands

pnpm dev
pnpm --filter web dev
npm run dev
yarn dev
./scripts/dev-up.sh

## Rules

- Use the smallest command set required for the app to run.
- Do not claim the browser is clean without checking console and network output via MCP.
- If a fix requires a larger change, pause and ask before proceeding.
