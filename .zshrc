# Optionally enable ZSH profiling for debugging
# time ZSH_DEBUGRC=1 zsh -i -c exit
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Disable pattern errors in ZSH, and use patterns as-is
setopt NO_NOMATCH

# Set history options for better deduplication
setopt HIST_IGNORE_ALL_DUPS

# Load homebrew early, as some plugins are installed in brew paths
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Load NVM (Node Version Manager) using zsh-nvm plugin and enable lazy loading
export NVM_LAZY_LOAD=true

# Oh My Zsh configuration
export ZSH=~/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zoxide zsh-nvm zsh-autocomplete)

# Load Oh My Zsh
[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Load Powerlevel10k configuration
[[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Set up PATH with proper ordering (most specific first)
export PATH="$HOME/.local/bin:$HOME/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

DEFAULT_USER=$(whoami)

# Load custom aliases and functions (ZSH-compatible way)
# Skip if running in VS Code terminal to prevent issues
if [[ "$TERM_PROGRAM" != "vscode" ]] && [[ -n "$PS1" ]]; then
    for file in ~/.{aliases,functions,extra}; do
        [[ -r "$file" && -f "$file" ]] && source "$file"
    done
    unset file
fi

# Make Tab and ShiftTab go to the menu
bindkey              '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select

# Make Tab and ShiftTab change the selection in the menu
bindkey -M menuselect              '^I'         menu-complete
bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete

# Load fzf for history searching
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh

# Enable GitHub Copilot CLI aliases
if command -v gh >/dev/null 2>&1; then
    eval "$(gh copilot alias -- zsh)"
fi

# Disable the pager for GitHub CLI so responses are returned immediately
export GH_PAGER=

# Enable AWS SDK to load the config from the ~/.aws/config file
export AWS_SDK_LOAD_CONFIG=1

# Enable Atuin shell history management
if [[ -f "$HOME/.atuin/bin/env" ]]; then
    source "$HOME/.atuin/bin/env"
    eval "$(atuin init zsh)"
fi

# Load 1Password CLI plugins if available
[[ -f ~/.config/op/plugins.sh ]] && source ~/.config/op/plugins.sh

# Optionally enable ZSH profiling for debugging
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi
