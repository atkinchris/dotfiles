#!/bin/bash
set -eu

if ! [ -x "$(command -v brew 2>/dev/null)" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade
brew install coreutils
brew install git git-lfs
brew install wget
brew install zsh zsh-completions
brew install nvm yarn
brew install vim rtv ranger highlight the_silver_searcher fzf

brew tap homebrew/cask-fonts
brew cask install font-hasklig font-meslo-for-powerline font-menlo-for-powerline

brew cleanup

git lfs install

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

mkdir -p ~/.nvm

mkdir -p ~/.iterm2
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

sh ./bootstrap.sh
