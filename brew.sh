#!/usr/bin/env bash

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install coreutils
brew install git git-lfs
brew install wget
brew install zsh zsh-completions
brew cleanup

git lfs install

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
