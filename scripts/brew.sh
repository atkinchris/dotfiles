#!/bin/bash
set -eu

# Setup brew
if ! [ -x "$(command -v brew 2>/dev/null)" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update and upgrade brew, just in case
brew update
brew upgrade

# Install brew packages from Brewfile
brew bundle install --file=Brewfile

# Housekeeping for brew
brew cleanup

# Setup git lfs
git lfs install

# Setup terminal tools, like oh-my-zsh, powerlevel10k and nvm
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
git clone https://github.com/lukechilds/zsh-nvm $ZSH_CUSTOM/plugins/zsh-nvm

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# Install vim plugins
# Don't forget to run
# vim +PluginInstall +qall
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# rsync dotfiles
sh ./bootstrap.sh
