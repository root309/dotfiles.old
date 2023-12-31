show_git_user() {
    local git_user_name="$(git config --global user.name)"
    local git_user_email="$(git config --global user.email)"
    if [ -n "$git_user_name" ] && [ -n "$git_user_email" ]; then
        echo "Current Git User: $git_user_name ($git_user_email)"
    fi
}

show_git_user

# Automatically start tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# autocd
setopt autocd

# History control
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt
if [[ "$TERM" == "xterm-color" ]] || [[ "$TERM" == *-256color ]]; then
    PS1='%F{green}%n@%m%f:%F{blue}%~%f$ '
else
    PS1='%n@%m:%~$ '
fi

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    [[ -r ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions from ~/.bash_aliases
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# Python aliases
alias python="python3.11"
alias pip="python3.11 -m pip"

# Git aliases
alias g="git"
alias gi="git init"
alias gadd="git add"
alias gc="git commit -m"
alias gpl="git pull"
alias gps="git push"
alias gf="git fetch"

# Docker aliases
alias d="docker"
alias ssdstart="sudo service docker start"
alias dcmrun="docker compose run --rm"

# Neovim alias
alias vim="nvim"

# Additional environment settings
source "$HOME/.cargo/env"
export PATH=~/clang+llvm-12.0.0-x86_64-linux-gnu-ubuntu-20.04/bin:$PATH
source ~/powerlevel10k/powerlevel10k.zsh-theme

alias gswitch="/home/az/git-switch-user.sh"

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
