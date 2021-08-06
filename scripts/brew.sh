#!/bin/bash
set -eu

if ! [ -x "$(command -v brew 2>/dev/null)" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

brew install \
  coreutils \
  fzf \
  git \
  git-lfs \
  highlight \
  ranger \
  the_silver_searcher \
  tree \
  vim \
  wget \
  zsh zsh-completions

brew tap homebrew/cask-fonts
brew install --cask \
  font-hack-nerd-font \
  font-hasklig \
  font-menlo-for-powerline \
  font-meslo-for-powerline

brew cleanup

mkdir -p ~/.iterm2
cp ./.iterm2/com.googlecode.iterm2.plist ~/.iterm2/
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sh ./bootstrap.sh
