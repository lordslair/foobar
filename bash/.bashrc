# ~/.bashrc: executed by bash(1) for non-login shells.

export PS1="\[\033[38;5;1m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;7m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:[\[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]\\$ \[$(tput sgr0)\]"

export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=5000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="%d/%m/%Y - %T : "

shopt -s checkwinsize
