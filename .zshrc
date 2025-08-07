# ------------------------------------------------------------------------------
# ENVIRONMENT & PATH
# ------------------------------------------------------------------------------
# NOTE: PATH is constructed in order. The first match is used.
# Directories with more specific executables should come first.

# Oh My Zsh installation path.
export ZSH="$HOME/.oh-my-zsh"

# Homebrew (MUST be loaded early)
# NOTE: This sets up the PATH for all brew-installed packages like direnv, fnm, etc.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Add custom binaries and scripts to PATH
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH # This is a common default
export PATH="$HOME/.local/mygit/git/usr/bin:$HOME/.local/bin:$PATH" # Your custom path
export PATH="/opt/nvim-linux64/bin:$PATH" # nvim path
export PATH=$PATH:/usr/local/go/bin # Go path

# Set preferred editors
export EDITOR='nvim'
export VISUAL='nvim'

# Set terminal type
export TERM='xterm-256color'


# ------------------------------------------------------------------------------
# OH MY ZSH CONFIGURATION
# ------------------------------------------------------------------------------

# ZSH_THEME="robbyrussell"
# REASON FOR CHANGE: Commented out because you are using Starship.
# Starship completely controls the prompt, making this setting irrelevant.
ZSH_THEME=""

# Oh My Zsh plugins
# NOTE: Removed 'poetry-env' and 'autojump' to resolve conflicts.
# `direnv` will now handle environment activation.
plugins=(git poetry sudo direnv)

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory


# ------------------------------------------------------------------------------
# SOURCING CORE LIBS & FRAMEWORKS
# ------------------------------------------------------------------------------
# NOTE: Oh My Zsh must be sourced before we can use its plugin features,
# but after its configuration variables have been set.

source "$ZSH/oh-my-zsh.sh"


# ------------------------------------------------------------------------------
# TOOL INITIALIZATION
# ------------------------------------------------------------------------------
# NOTE: Tools should be initialized after the core shell is configured.
# The order here can matter.

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# fnm (Fast Node Manager)
# REASON FOR CHANGE: Combined the two redundant blocks into one clean check.
if command -v fnm > /dev/null; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# ghcup (Haskell)
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# direnv
# NOTE: This is the replacement for your custom `chpwd` function.
# It safely hooks into the shell to manage environments.
eval "$(direnv hook zsh)"

# fzf (Fuzzy Finder)
export FZF_DEFAULT_OPTS="--color pointer:#00CC00"
source <(fzf --zsh)

# Starship Prompt (MUST BE LAST)
# NOTE: This should be one of the last things to run, as it draws the prompt.
eval "$(starship init zsh)"


# ------------------------------------------------------------------------------
# CUSTOM FUNCTIONS, ALIASES & KEYBINDINGS
# ------------------------------------------------------------------------------

# Sourcing secrets and aliases
if [ -f ~/.zsh_secrets ]; then
  source ~/.zsh_secrets
fi
if [ -f ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

# Keybindings
bindkey -s ^f '~/scripts/tmux-sessionizer.sh\n'
bindkey -s ^a 'tmux a\n'

cd() {
  builtin cd "$@" || return
  ls -a
}
