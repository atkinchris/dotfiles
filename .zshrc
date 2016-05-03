export ZSH=~/.oh-my-zsh
[ -n "$PS1" ] && source ~/.bash_profile;

DEFAULT_USER=$(whoami)
ZSH_THEME="agnoster"
plugins=(git)
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
source $ZSH/oh-my-zsh.sh
