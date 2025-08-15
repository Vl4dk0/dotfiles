# ------------------------------------------------------------------------------
# ENVIRONMENT & PATH
# ------------------------------------------------------------------------------

# Oh My Zsh installation path.
export ZSH="$HOME/.oh-my-zsh"

# on linux
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# on mac
export PATH="/opt/homebrew/bin:$PATH"

# Add custom binaries and scripts to PATH
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# export PATH="$HOME/.local/mygit/git/usr/bin:$HOME/.local/bin:$PATH"

# just for linux
# export PATH="/opt/nvim-linux64/bin:$PATH"
# export PATH=$PATH:/usr/local/go/bin

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
plugins=(git poetry sudo)

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory


# ------------------------------------------------------------------------------
# SOURCING CORE LIBS & FRAMEWORKS
# ------------------------------------------------------------------------------

source "$ZSH/oh-my-zsh.sh"


# ------------------------------------------------------------------------------
# TOOL INITIALIZATION
# ------------------------------------------------------------------------------

# fnm (Fast Node Manager)
# REASON FOR CHANGE: Combined the two redundant blocks into one clean check.
if command -v fnm > /dev/null; then
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

# direnv
eval "$(direnv hook zsh)"

# fzf (Fuzzy Finder)
export FZF_DEFAULT_OPTS="--color pointer:#00CC00"
source <(fzf --zsh)

# Starship Prompt (MUST BE LAST)
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
