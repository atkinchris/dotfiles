#!/usr/bin/env bash
set -euo pipefail

# sync-back.sh
#
# Copies managed dotfiles from $HOME back into this repository.
#
# Behavior:
# - Uses files.txt as the source of truth for most paths.
# - Treats ./.local/bin specially: only scripts that already exist in the
#   repository are copied back, so host-only scripts are not imported.
# - Skips paths that do not exist in $HOME (macOS rsync compatibility).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
FILES_LIST="$REPO_ROOT/files.txt"

if [[ ! -f "$FILES_LIST" ]]; then
  echo "Missing files list: $FILES_LIST" >&2
  exit 1
fi

tmp_files="$(mktemp)"
cleanup() {
  rm -f "$tmp_files"
}
trap cleanup EXIT

source_exists_in_home() {
  local rel_path=$1
  local source_path="$HOME/$rel_path"

  [[ -e "$source_path" || -L "$source_path" ]]
}

# Start with files.txt entries except .local/bin, which is handled separately
# to avoid copying host-only scripts back into the repo.
while IFS= read -r rel_path; do
  [[ -z "$rel_path" ]] && continue

  case "$rel_path" in
    ./.local/bin | ./.local/bin/ | ./.local/bin/*)
      continue
      ;;
  esac

  if source_exists_in_home "$rel_path"; then
    printf '%s\n' "$rel_path" >>"$tmp_files"
  fi
done <"$FILES_LIST"

# Add only files that already exist in the repo under .local/bin.
if [[ -d "$REPO_ROOT/.local/bin" ]]; then
  while IFS= read -r tracked_bin_file; do
    if source_exists_in_home "$tracked_bin_file"; then
      printf '%s\n' "$tracked_bin_file" >>"$tmp_files"
    fi
  done < <(
    cd "$REPO_ROOT"
    find ./.local/bin \( -type f -o -type l \) | sort
  )
fi

rsync -avr --no-perms --files-from="$tmp_files" "$HOME/" "$REPO_ROOT/"
