# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

# ----------------------------------------------------------------------------
# Environment
# ----------------------------------------------------------------------------

export EDITOR='nvim'
export VISUAL='nvim'
export TERM='xterm-256color'
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# ----------------------------------------------------------------------------
# History
# ----------------------------------------------------------------------------

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=10000
shopt -s histappend
shopt -s checkwinsize

# ----------------------------------------------------------------------------
# Colors and aliases
# ----------------------------------------------------------------------------

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias s='sudo '

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ----------------------------------------------------------------------------
# Completion
# ----------------------------------------------------------------------------

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ----------------------------------------------------------------------------
# Tooling
# ----------------------------------------------------------------------------

if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_OPTS="--color=pointer:#00CC00"
    if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
        . /usr/share/doc/fzf/examples/key-bindings.bash
    fi
    if [ -f /usr/share/doc/fzf/examples/completion.bash ]; then
        . /usr/share/doc/fzf/examples/completion.bash
    fi
    if [ -f ~/.fzf.bash ]; then
        . ~/.fzf.bash
    fi
fi

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# opencode
export PATH=/home/vladko/.opencode/bin:$PATH
