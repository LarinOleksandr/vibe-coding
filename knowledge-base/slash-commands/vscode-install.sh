#!/usr/bin/env bash
set -euo pipefail

CODEX_DIR="$HOME/.codex/prompts"
mkdir -p "$CODEX_DIR"

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=("$THIS_DIR/prompts"/*)

if [ ${#FILES[@]} -eq 0 ]; then
  echo "No files found in prompts folder."
  exit 0
fi

for file in "${FILES[@]}"; do
  cp -f "$file" "$CODEX_DIR/"
  echo "Installed to Codex: $CODEX_DIR/$(basename "$file")"
done

echo "Done. Restart Codex / VS Code to load commands."
