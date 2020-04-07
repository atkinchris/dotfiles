#!/bin/bash
set -eu

apt-get update
apt-get install -y \
  curl \
  git \
  tree \
  vim \
  wget \
  zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sh ./bootstrap.sh
