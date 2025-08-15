#!/bin/bash
set -eu

sudo apt-get update
sudo apt-get install -y \
  curl \
  git \
  tree \
  vim \
  wget \
  zoxide \
  zsh

curl -sS https://starship.rs/install.sh | sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-nvm

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sh ./bootstrap.sh
