# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Disable pattern errors in ZSH, and use patterns as-is
setopt NO_NOMATCH

export ZSH=~/.oh-my-zsh

# Load homebrew before oh-my-zsh, as some plugins are installed in brew paths
[ -f /opt/homebrew/bin/brew ] && eval $(/opt/homebrew/bin/brew shellenv)

DEFAULT_USER=$(whoami)
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zoxide)
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

# Load custom aliases and functions
# This must be run after oh-my-zsh is loaded to ensure it overrides existing aliases
[ -n "$PS1" ] && source ~/.bash_profile

# Load fzf for history searching and set it to unique commands only
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
setopt HIST_IGNORE_ALL_DUPS

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -x "$(command -v gh)" ] && eval "$(gh copilot alias -- zsh)" # Enable GitHub Copilot CLI aliases

# Disable the pager for GitHub CLI so responses are returned immediately
export GH_PAGER=

# Enable AWS SDK to load the config from the ~/.aws/config file
export AWS_SDK_LOAD_CONFIG="true"

# Enable Atuin shell history management
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Load 1Password CLI plugins if available
[ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh
