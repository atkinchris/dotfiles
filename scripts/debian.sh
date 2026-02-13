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

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM_DIR/themes/powerlevel10k"
git clone https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH_CUSTOM_DIR/plugins/zsh-autocomplete"
git clone https://github.com/lukechilds/zsh-nvm "$ZSH_CUSTOM_DIR/plugins/zsh-nvm"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sh ./bootstrap.sh
