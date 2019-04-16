export ZSH=~/.oh-my-zsh
[ -n "$PS1" ] && source ~/.bash_profile

DEFAULT_USER=$(whoami)
ZSH_THEME="agnoster"
plugins=(git)
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
source $ZSH/oh-my-zsh.sh

# Load fzf for history searching and set it to unique commands only
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
setopt HIST_IGNORE_ALL_DUPS

# Automatically load nvm versions when changing directories
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm install
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
