#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mapfile -t shell_script_files < <(
  find "$REPO_ROOT" -type f -name '*.sh' -not -path '*/.git/*' | sort
)

bash_dotfiles=(
  ".aliases"
  ".bash_profile"
  ".bashrc"
  ".extra"
  ".functions"
)

zsh_dotfiles=(
  ".zshrc"
)

bash_shellcheck_files=()
for rel_path in "${bash_dotfiles[@]}"; do
  abs_path="$REPO_ROOT/$rel_path"
  if [[ -f "$abs_path" ]]; then
    bash_shellcheck_files+=("$abs_path")
  fi
done

zsh_syntax_files=()
for rel_path in "${zsh_dotfiles[@]}"; do
  abs_path="$REPO_ROOT/$rel_path"
  if [[ -f "$abs_path" ]]; then
    zsh_syntax_files+=("$abs_path")
  fi
done

if [[ ${#shell_script_files[@]} -eq 0 && ${#bash_shellcheck_files[@]} -eq 0 && ${#zsh_syntax_files[@]} -eq 0 ]]; then
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

if [[ ${#zsh_syntax_files[@]} -gt 0 ]] && ! command -v zsh >/dev/null 2>&1; then
  echo "zsh is required to lint zsh dotfiles but was not found in PATH." >&2
  exit 1
fi

if [[ ${#shell_script_files[@]} -gt 0 ]]; then
  echo "Running shellcheck for shell scripts..."
  shellcheck --external-sources "${shell_script_files[@]}"
fi

if [[ ${#bash_shellcheck_files[@]} -gt 0 ]]; then
  echo "Running shellcheck for bash dotfiles..."
  shellcheck --external-sources --shell=bash -e SC1090 "${bash_shellcheck_files[@]}"
fi

echo "Running shfmt check..."
if [[ ${#shell_script_files[@]} -gt 0 ]]; then
  shfmt -d -i 2 -ci "${shell_script_files[@]}"
fi

if [[ ${#zsh_syntax_files[@]} -gt 0 ]]; then
  echo "Running zsh syntax checks..."
  for zsh_file in "${zsh_syntax_files[@]}"; do
    zsh -n "$zsh_file"
  done
fi

echo "Shell lint checks passed."
