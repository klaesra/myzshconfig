# Path to your oh-my-zsh installation.
ZSH=~/personal/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="klaes"

# Export ZSH or theme choser doesn't work
export ZSH

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias composer="php composer.phar"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
#DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(battery bower brew extract git git-extras gitfast git-prompt git-remote-branch npm osx rvm ruby rbenv python z)

# Git auto-completion
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$HOME/bin:$HOME/lib/bin:/usr/local/bin:$PATH

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Use node 0.12 as default, switch to 4.0 manually
nvm use 0.12

# Go lang
# Add gopath and gopath to path
# export GOPATH="/home/klaes/projects/getqueried/"
# export PATH=$PATH:$GOPATH/bin

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
#export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# ensure we use emacs bindings and not FUCKING VI
bindkey -e

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

# TRAMP for emacs
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '

function search() {
    yaourt -Ss $1
}

function resizeimg() {
    local i
    for i in "$@"
    do
        name=${i:r} ;
        convert $i -resize 256x256 -quality 90 $name.jpg
    done
}


function chpwd() {
    emulate -L zsh
    ls
}

export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh
