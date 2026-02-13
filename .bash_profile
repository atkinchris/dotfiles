# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Quit early if running in VS Code terminal
# This prevents VS Code from running scripts intended for interactive shells
[[ "$TERM_PROGRAM" == "vscode" ]] && return

# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
