#!/bin/bash
set -eu

# Setup brew
if ! [ -x "$(command -v brew 2>/dev/null)" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update and upgrade brew, just in case
brew update
brew upgrade

# Install basic tools
brew install \
  autojump \
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

# Install work tools
brew install \
  awscli \
  jq \
  kubernetes-cli \
  k9s \
  kubectx \
  aws-iam-authenticator \
  terraform

# Tap and install fonts
brew tap homebrew/cask-fonts
brew install --cask \
  font-hack-nerd-font \
  font-hasklig \
  font-menlo-for-powerline \
  font-meslo-for-powerline

# Housekeeping for brew
brew cleanup

# Setup git lfs
git lfs install

# Setup editor font
cd `mktemp -d`
git clone https://github.com/kencrocken/FiraCodeiScript.git .
cp *.ttf /Library/Fonts
cd -

# Setup iTerm2 to use a preferences file
mkdir -p ~/.iterm2
cp ./.iterm2/com.googlecode.iterm2.plist ~/.iterm2/
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Setup terminal tools, like oh-my-zsh, powerlevel10k and nvm
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# Install vim plugins
# Don't forget to run
# vim +PluginInstall +qall
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# rsync dotfiles
sh ./bootstrap.sh
