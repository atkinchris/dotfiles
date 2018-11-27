#!/bin/bash
set -eu

if ![ $(command -v brew 2>/dev/null) ]; then
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
brew cask install font-hasklig font-meslo-for-powerline

brew cleanup

git lfs install

mkdir -p ~/.nvm
nvm install node

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
