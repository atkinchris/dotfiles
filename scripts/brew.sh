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

# Setup iTerm2 to use a preferences file
mkdir -p ~/.iterm2
cp ./.iterm2/com.googlecode.iterm2.plist ~/.iterm2/
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Setup terminal tools, like oh-my-zsh, powerlevel10k and nvm
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# Install vim plugins
# Don't forget to run
# vim +PluginInstall +qall
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# rsync dotfiles
sh ./bootstrap.sh
