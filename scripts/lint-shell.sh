#!/usr/bin/env bash
set -euo pipefail

# Determine repository root relative to this script so it works from any cwd.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Collect all shell scripts in the repository (excluding .git internals).
mapfile -t shell_script_files < <(
  find "$REPO_ROOT" -type f -name '*.sh' -not -path '*/.git/*' | sort
)

# Bash dotfiles validated with shellcheck in bash mode.
bash_dotfiles=(
  ".aliases"
  ".bash_profile"
  ".bashrc"
  ".extra"
  ".functions"
)

# Zsh-specific dotfiles validated with zsh syntax checks.
zsh_dotfiles=(
  ".zshrc"
)

# Resolve absolute paths for existing bash dotfiles.
bash_shellcheck_files=()
for rel_path in "${bash_dotfiles[@]}"; do
  abs_path="$REPO_ROOT/$rel_path"
  if [[ -f "$abs_path" ]]; then
    bash_shellcheck_files+=("$abs_path")
  fi
done

# Resolve absolute paths for existing zsh dotfiles.
zsh_syntax_files=()
for rel_path in "${zsh_dotfiles[@]}"; do
  abs_path="$REPO_ROOT/$rel_path"
  if [[ -f "$abs_path" ]]; then
    zsh_syntax_files+=("$abs_path")
  fi
done

# Exit cleanly if there is nothing to lint.
if [[ ${#shell_script_files[@]} -eq 0 && ${#bash_shellcheck_files[@]} -eq 0 && ${#zsh_syntax_files[@]} -eq 0 ]]; then
  echo "No shell lint targets found."
  exit 0
fi

# Ensure required tooling is available.
if ! command -v shellcheck >/dev/null 2>&1; then
  echo "shellcheck is required but was not found in PATH." >&2
  exit 1
fi

if ! command -v shfmt >/dev/null 2>&1; then
  echo "shfmt is required but was not found in PATH." >&2
  exit 1
fi

if [[ ${#zsh_syntax_files[@]} -gt 0 ]] && ! command -v zsh >/dev/null 2>&1; then
  echo "zsh is required to lint zsh dotfiles but was not found in PATH." >&2
  exit 1
fi

# Lint standalone shell scripts.
if [[ ${#shell_script_files[@]} -gt 0 ]]; then
  echo "Running shellcheck for shell scripts..."
  shellcheck --external-sources "${shell_script_files[@]}"
fi

# Lint Bash dotfiles in bash mode.
if [[ ${#bash_shellcheck_files[@]} -gt 0 ]]; then
  echo "Running shellcheck for bash dotfiles..."
  shellcheck --external-sources --shell=bash -e SC1090 "${bash_shellcheck_files[@]}"
fi

# Format-check shell scripts only (no rewrites).
echo "Running shfmt check..."
if [[ ${#shell_script_files[@]} -gt 0 ]]; then
  shfmt -d -i 2 -ci "${shell_script_files[@]}"
fi

# Syntax-check zsh-specific config files.
if [[ ${#zsh_syntax_files[@]} -gt 0 ]]; then
  echo "Running zsh syntax checks..."
  for zsh_file in "${zsh_syntax_files[@]}"; do
    zsh -n "$zsh_file"
  done
fi

# Success message for local and CI runs.
echo "Shell lint checks passed."
