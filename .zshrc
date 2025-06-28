# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="$HOME/.local/mygit/git/usr/bin:$HOME/.local/bin:$PATH"
# chsh 
# export SHELL=$(which zsh)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
export EDITOR='nvim'
export TERM='xterm-256color'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# For a full list of active aliases, run `alias`.
alias zshrc="nvim ~/.zshrc"

eval "$(starship init zsh)"
bindkey -s ^f '~/scripts/tmux-sessionizer.sh\n'
export PATH="/opt/nvim-linux64/bin:$PATH"

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env --use-on-cd --shell zsh`"
fi

if command -v fnm > /dev/null; then
  eval "`fnm env --use-on-cd --shell zsh`"
fi

# golang
export PATH=$PATH:/usr/local/go/bin

# sci-markdown
# https://github.com/Hackder/sci-markdown
alias sci-mark="~/sci-markdown/.venv/bin/python ~/sci-markdown/src/sci_markdown/__main__.py"

# docker aliases
alias cls="clear"

# alias for running the program
alias haskell="ghci"
alias prolog="swipl"

# aliases for config files
alias ghosttyconf="nvim ~/.config/ghostty/config"

# alias for git fzf
alias fsb='~/dotfiles/scripts/fsb.sh'
alias fshow='~/dotfiles/scripts/fshow.sh'

# aliases for workflows
alias dulogika="$HOME/dotfiles/workflows/dulogika.sh"
alias pulogika="$HOME/dotfiles/workflows/pulogika.sh"

# loglang alias
# https://github.com/Hackder/log_lang
alias loglang="~/log_lang/.venv/bin/python3 ~/log_lang/main.py"

# vim -> nvim alias
alias vim="nvim"

# ctrl-a to attach to tmux
bindkey -s ^a 'tmux a\n'

export FZF_DEFAULT_OPTS="
  --color pointer:#00CC00\
"

source <(fzf --zsh)

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env


# functions
cd() {
  builtin cd "$@" || return
  ls -a
}

# if there is .venv file in the directory, activate it
chpwd() {
  if [ -n "$VIRTUAL_ENV" ]; then
    return
  fi
  if [ -d ".venv" ]; then
    source .venv/bin/activate
  fi
}

chpwd

eval "$(gh copilot alias -- zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
