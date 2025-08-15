# Disable pattern errors in ZSH, and use patterns as-is
setopt NO_NOMATCH

# Load homebrew early, as some plugins are installed in brew paths
[ -f /opt/homebrew/bin/brew ] && eval $(/opt/homebrew/bin/brew shellenv)

DEFAULT_USER=$(whoami)
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Load custom aliases and functions
[ -n "$PS1" ] && source ~/.bash_profile

# Load fzf for history searching and set it to unique commands only
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
setopt HIST_IGNORE_ALL_DUPS

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -x "$(command -v gh)" ] && eval "$(gh copilot alias -- zsh)" # Enable GitHub Copilot CLI aliases

# Disable the pager for GitHub CLI so responses are returned immediately
export GH_PAGER=

# Enable AWS SDK to load the config from the ~/.aws/config file
export AWS_SDK_LOAD_CONFIG="true"

# Enable zoxide for quick directory navigation
[ -x "$(command -v zoxide)" ] && eval "$(zoxide init zsh)"

# Init Starship
[ -x "$(command -v starship)" ] && eval "$(starship init zsh)"

# Enable Atuin shell history management
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Load 1Password CLI plugins if available
[ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh
