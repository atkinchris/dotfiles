#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mapfile -t python_files < <(
  grep -rEl --exclude-dir=.git '^#!/usr/bin/env python([0-9.]*)?$' "$REPO_ROOT" | sort
)

if [[ ${#python_files[@]} -eq 0 ]]; then
  echo "No Python lint targets found."
  exit 0
fi

if ! command -v ruff >/dev/null 2>&1; then
  echo "ruff is required but was not found in PATH." >&2
  exit 1
fi

echo "Running ruff checks..."
ruff check "${python_files[@]}"

echo "Running ruff format check..."
ruff format --check "${python_files[@]}"

echo "Python lint checks passed."
