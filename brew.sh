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
  nvm \
  ranger \
  rtv \
  the_silver_searcher \
  tree \
  vim \
  wget \
  yarn --without-node \
  zsh zsh-completions

brew tap homebrew/cask-fonts
brew cask install \
  font-hack-nerd-font \
  font-hasklig \
  font-menlo-for-powerline \
  font-meslo-for-powerline

brew cleanup

git lfs install

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

mkdir -p ~/.nvm

mkdir -p ~/.iterm2
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

sh ./bootstrap.sh
