#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mapfile -t shell_script_files < <(
  find "$REPO_ROOT" -type f -name '*.sh' -not -path '*/.git/*' | sort
)

dotfiles=(
  ".aliases"
  ".bash_profile"
  ".bashrc"
  ".extra"
  ".functions"
  ".zshrc"
)

shellcheck_dotfiles=()
for rel_path in "${dotfiles[@]}"; do
  abs_path="$REPO_ROOT/$rel_path"
  if [[ -f "$abs_path" ]]; then
    shellcheck_dotfiles+=("$abs_path")
  fi
done

if [[ ${#shell_script_files[@]} -eq 0 && ${#shellcheck_dotfiles[@]} -eq 0 ]]; then
  echo "No shell lint targets found."
  exit 0
fi

if ! command -v shellcheck >/dev/null 2>&1; then
  echo "shellcheck is required but was not found in PATH." >&2
  exit 1
fi

if ! command -v shfmt >/dev/null 2>&1; then
  echo "shfmt is required but was not found in PATH." >&2
  exit 1
fi

if [[ ${#shell_script_files[@]} -gt 0 ]]; then
  echo "Running shellcheck for shell scripts..."
  shellcheck --external-sources "${shell_script_files[@]}"
fi

if [[ ${#shellcheck_dotfiles[@]} -gt 0 ]]; then
  echo "Running shellcheck for sourced dotfiles..."
  shellcheck --external-sources --shell=bash -e SC1090 "${shellcheck_dotfiles[@]}"
fi

echo "Running shfmt check..."
shfmt -d -i 2 -ci "${shell_script_files[@]}" "${shellcheck_dotfiles[@]}"

echo "Shell lint checks passed."
