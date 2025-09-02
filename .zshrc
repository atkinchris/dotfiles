# =============================================================================
# ZSH PROFILING (Optional debugging - must be at top)
# =============================================================================
# Optionally enable ZSH profiling for debugging
# time ZSH_DEBUGRC=1 zsh -i -c exit
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

# =============================================================================
# INSTANT PROMPT (Must be near top, before anything that might print)
# =============================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# ZSH OPTIONS & SETTINGS
# =============================================================================
# Disable pattern errors in ZSH, and use patterns as-is
setopt NO_NOMATCH

# Set history options for better deduplication
setopt HIST_IGNORE_ALL_DUPS

# =============================================================================
# ENVIRONMENT SETUP (Before loading frameworks/plugins)
# =============================================================================
# Load homebrew early, as some plugins are installed in brew paths
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set up PATH with proper ordering (most specific first)
export PATH="$HOME/.local/bin:$HOME/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# Load NVM (Node Version Manager) using zsh-nvm plugin and enable lazy loading
export NVM_LAZY_LOAD=true

# Set default user for prompt
DEFAULT_USER=$(whoami)

# =============================================================================
# OH MY ZSH FRAMEWORK
# =============================================================================
# Oh My Zsh configuration
export ZSH=~/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zoxide zsh-nvm zsh-autocomplete)

# Load Oh My Zsh
[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Load Powerlevel10k configuration
[[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =============================================================================
# CUSTOM CONFIGURATION (Aliases, functions, etc.)
# =============================================================================
# Load custom aliases and functions (ZSH-compatible way)
# Skip if running in VS Code terminal to prevent issues
if [[ "$TERM_PROGRAM" != "vscode" ]] && [[ -n "$PS1" ]]; then
    for file in ~/.{aliases,functions,extra}; do
        [[ -r "$file" && -f "$file" ]] && source "$file"
    done
    unset file
fi

# =============================================================================
# KEY BINDINGS & COMPLETION
# =============================================================================
# Make Tab and ShiftTab go to the menu
bindkey              '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select

# Make Tab and ShiftTab change the selection in the menu
bindkey -M menuselect              '^I'         menu-complete
bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete

# =============================================================================
# EXTERNAL TOOL INTEGRATIONS
# =============================================================================
# Load fzf for history searching
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh

# Enable GitHub Copilot CLI aliases
if command -v gh >/dev/null 2>&1; then
    eval "$(gh copilot alias -- zsh)"
fi

# Enable Atuin shell history management
if [[ -f "$HOME/.atuin/bin/env" ]]; then
    source "$HOME/.atuin/bin/env"
    eval "$(atuin init zsh)"
fi

# Load 1Password CLI plugins if available
[[ -f ~/.config/op/plugins.sh ]] && source ~/.config/op/plugins.sh

# =============================================================================
# APPLICATION-SPECIFIC ENVIRONMENT VARIABLES
# =============================================================================
# Disable the pager for GitHub CLI so responses are returned immediately
export GH_PAGER=

# Enable AWS SDK to load the config from the ~/.aws/config file
export AWS_SDK_LOAD_CONFIG=1

# =============================================================================
# ZSH PROFILING (Optional debugging - must be at bottom)
# =============================================================================
# Optionally enable ZSH profiling for debugging
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi
