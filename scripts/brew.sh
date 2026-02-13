#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

clone_if_missing() {
  local repo_url=$1
  local destination=$2

  if [[ -d "$destination/.git" ]]; then
    echo "Already installed: $destination"
    return 0
  fi

  if [[ -d "$destination" ]]; then
    echo "Skipping clone for existing non-git directory: $destination"
    return 0
  fi

  git clone "$repo_url" "$destination"
}

# Setup brew
if ! [ -x "$(command -v brew 2>/dev/null)" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update and upgrade brew, just in case
brew update
brew upgrade

# Install brew packages from Brewfile
brew bundle install --file="$REPO_ROOT/Brewfile"

# Housekeeping for brew
brew cleanup

# Setup git lfs
git lfs install

# Setup terminal tools, like oh-my-zsh, powerlevel10k and nvm
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh already installed."
fi

ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM_DIR/themes" "$ZSH_CUSTOM_DIR/plugins" "$HOME/.vim/bundle"

clone_if_missing "https://github.com/romkatv/powerlevel10k.git" "$ZSH_CUSTOM_DIR/themes/powerlevel10k"
clone_if_missing "https://github.com/marlonrichert/zsh-autocomplete.git" "$ZSH_CUSTOM_DIR/plugins/zsh-autocomplete"
clone_if_missing "https://github.com/lukechilds/zsh-nvm" "$ZSH_CUSTOM_DIR/plugins/zsh-nvm"

if [[ ! -s "$HOME/.nvm/nvm.sh" ]]; then
  NVM_VERSION="${NVM_VERSION:-v0.40.1}"
  curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
else
  echo "nvm already installed."
fi

# Install vim plugins
# Don't forget to run
# vim +PluginInstall +qall
clone_if_missing "https://github.com/VundleVim/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim"

# rsync dotfiles
bash "$REPO_ROOT/bootstrap.sh"
