#!/usr/bin/env bash
set -euo pipefail

# Determine repository root relative to this script so it works from any cwd.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Discover Python scripts by shebang (supports python, python3, python3.x).
# We intentionally use shebang detection because these scripts are extensionless.
mapfile -t python_files < <(
  grep -rEl --exclude-dir=.git '^#!/usr/bin/env python([0-9.]*)?$' "$REPO_ROOT" | sort
)

# Exit cleanly if no Python targets are present.
if [[ ${#python_files[@]} -eq 0 ]]; then
  echo "No Python lint targets found."
  exit 0
fi

# Ensure lint tooling is installed before running checks.
if ! command -v ruff >/dev/null 2>&1; then
  echo "ruff is required but was not found in PATH." >&2
  exit 1
fi

# Static analysis / style checks.
echo "Running ruff checks..."
ruff check "${python_files[@]}"

# Formatting check only (does not rewrite files).
echo "Running ruff format check..."
ruff format --check "${python_files[@]}"

# Success message for local and CI runs.
echo "Python lint checks passed."
