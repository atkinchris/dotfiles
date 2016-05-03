#!/usr/bin/env bash

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew update
brew upgrade --all

brew tap homebrew/versions

brew install coreutils
brew install git
brew install git-lfs
brew install homebrew/versions/node4-lts
brew install zsh zsh-completions
brew install wget --with-iri
brew install p7zip
brew install speedtest_cli

brew install vim --override-system-vi

brew cask install alfred
brew cask install dropbox
brew cask install google-chrome
brew cask install vlc
brew cask install iterm2
brew cask install github-desktop
brew cask install atom
brew cask install flux
brew cask install spotify
brew cask install onyx
brew cask install tunnelbear
brew cask install steam
brew cask install wunderlist
brew cask install the-unarchiver

brew cleanup

apm stars --user atkinchris --install

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
