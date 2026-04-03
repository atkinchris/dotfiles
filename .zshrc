# =============================================================================
# ZSH PROFILING (Optional debugging - must be at top)
# =============================================================================
# Optionally enable ZSH profiling for debugging
# time ZSH_DEBUGRC=1 zsh -i -c exit
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
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
export PATH="$HOME/.local/bin:$HOME/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# If Homebrew binutils is installed, add its bin directory to PATH
# This makes commands like readelf available without needing to specify the full path,
# and ensures they take precedence over system versions
if command -v brew >/dev/null 2>&1; then
    binutils_prefix="$(brew --prefix binutils 2>/dev/null)"
    if [[ -n "$binutils_prefix" ]] && [[ ":$PATH:" != *":$binutils_prefix/bin:"* ]]; then
        export PATH="$binutils_prefix/bin:$PATH"
    fi
    unset binutils_prefix
fi

# Add custom completion definitions for local CLI scripts
fpath=("$HOME/.local/share/zsh/site-functions" $fpath)

# Load NVM (Node Version Manager) using zsh-nvm plugin and enable lazy loading
export NVM_LAZY_LOAD=true

# Keep IDE terminals on a simpler, safer zsh path. The integrated terminal
# has been prone to zle/zpty hangs with some async plugins, so disable only the
# riskiest interactive features there by default.
typeset -gi IS_IDE_TERMINAL=0
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    IS_IDE_TERMINAL=1
fi

# Set default user for prompt
DEFAULT_USER="$USER"

# Enable Cargo environment if available
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

# Homebrew settings
# Prevent Homebrew from installing Node, to avoid bringing in unmanaged versions or package managers
export HOMEBREW_FORBIDDEN_FORMULAE="node"

# =============================================================================
# APPLICATION-SPECIFIC ENVIRONMENT VARIABLES
# =============================================================================
# Disable the pager for GitHub CLI so responses are returned immediately
export GH_PAGER=

# Enable AWS SDK to load the config from the ~/.aws/config file
export AWS_SDK_LOAD_CONFIG=1

# Stop here for non-interactive shells; the rest is interactive-only configuration.
[[ -o interactive ]] || return

# =============================================================================
# OH MY ZSH FRAMEWORK
# =============================================================================
# Oh My Zsh configuration
export ZSH=~/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zoxide zsh-nvm)
if (( ! IS_IDE_TERMINAL )); then
    plugins+=(zsh-autocomplete)
fi

# Load Oh My Zsh
[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Load Powerlevel10k configuration
[[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =============================================================================
# CUSTOM CONFIGURATION (Aliases, functions, etc.)
# =============================================================================
# Load custom aliases and functions (ZSH-compatible way)
# Skip if running in IDE terminal to prevent issues
if (( ! IS_IDE_TERMINAL )) && [[ -n "$PS1" ]]; then
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
# Load extra interactive shell integrations only outside IDE terminals by default.
if (( ! IS_IDE_TERMINAL )); then
    # Load fzf for history searching
    [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
    [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh

    # Enable Atuin shell history management
    if [[ -f "$HOME/.atuin/bin/env" ]]; then
        source "$HOME/.atuin/bin/env"
        eval "$(atuin init zsh)"
    fi
fi

# =============================================================================
# ZSH PROFILING (Optional debugging - must be at bottom)
# =============================================================================
# Optionally enable ZSH profiling for debugging
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi
