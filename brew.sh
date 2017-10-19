#!/bin/bash
set -eu

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install coreutils
brew install git git-lfs
brew install wget
brew install zsh zsh-completions
brew install nvm yarn
brew install vim rtv ranger highlight the_silver_searcher fzf
brew cleanup

git lfs install

mkdir ~/.nvm
nvm install node

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
