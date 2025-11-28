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
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
curl -fsSL https://get.pnpm.io/install.sh | sh -

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sh ./bootstrap.sh
