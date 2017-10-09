# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{aliases,functions,exports,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Conditionally load NVM
NVMSCRIPT=$(brew --prefix nvm 2>/dev/null)/nvm.sh
if [ $(command -v brew 2>/dev/null) ] && [ -f $NVMSCRIPT ]; then
		export NVM_DIR=~/.nvm
		source $NVMSCRIPT
fi
unset NVMSCRIPT
