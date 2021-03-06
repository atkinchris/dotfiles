#!/bin/bash
set -eu

if ! [ -x "$(command -v brew 2>/dev/null)" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

brew install \
  awscli \
  jq \
  kubernetes-cli \
  terraform

brew tap homebrew/cask
brew tap caskroom/versions

brew cask install \
  android-platform-tools \
  android-sdk \
  java8 \
  postman

if ! [ -x "$(command -v rustup 2>/dev/null)" ]; then
  curl https://sh.rustup.rs -sSf | sh
fi
