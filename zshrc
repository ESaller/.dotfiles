echo      Welcome back Commander!

export PYTHONPATH="~/anaconda/bin/python"

# colored man pages
man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
                                        man "$@"
  }


# perbrew
# source /Users/esaller/perl5/perlbrew/etc/bashrc

# Set language environment
export LC_CTYPE=de_DE.UTF-8
export LC_ALL=de_DE.UTF-8
export LANG=de_DE.UTF-8


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="bureau"

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false
# disabled for debug
# ZSH_TMUX_ITERM2=true

# Perlbrew
# source /Users/esaller/perl5/perlbrew/etc/bashrc

# nvim command line edit and editor pref.
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
export VISUAL="nvim"
export EDITOR="nvim"

#Alias
alias di="rolldice"
alias zshconfig="vim ~/.zshrc"
alias GMP="find . -maxdepth 1 -type d -exec sh -c '(cd {} && git pull)' ';'"
alias GMV="find . -maxdepth 1 -type d -exec sh -c '(cd {} && git remote -v)' ';'"
alias gsf="git submodule foreach --recursive git fetch"
alias gsmom="git submodule foreach git merge origin master"
alias pullallsubd="ls | parallel git -C {} pull"
alias wsg="web_search google"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

#PATH - every Path in a new line TODO: prune and sort

# Python interpreter
# force anaconda before default path
export PATH="$HOME/anaconda/bin:$PATH"
#path+=~/anaconda/bin

# Defaul Path for MAC OSX based on /private/etc/paths
# no needed because of how path is built
#path+=usr/local/bin
#path+=usr/bin
#path+=bin
#path+=usr/sbin
#path+=sbin

# HOMEBREW MAC OSX install location for slinks
path+=usr/local/sbin
path+=usr/local/bin

# X11
path+=opt/X11/bin
path+=usr/X11/bin

# Stuff TODO: Check and toss
path+=opt/local/bin
path+=opt/local/sbin
path+=OPENCCG_HOME/bin

#other
path+=/usr/local/lib
path+=/usr/local/include

# Ruby Stuff
# Add RVM to PATH for scripting
path+=~/.rvm/bin
# Load RVM into a shell session *as a function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


# export everything
export path


#Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(history-substring-search git tmux vi-mode web-search)

SAVEHIST=1000
HISTFILE=~/.zsh_history

# Path to your oh-my-zsh configuration.
ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

