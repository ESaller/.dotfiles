# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

echo      Welcome back Commander!

#DEFAULT_USER = "ESaller"
export LANG=de_DE.UTF-8
export LC_COLLATE="de_DE.UTF-8"
export LC_CTYPE="de_DE.UTF-8"
export LC_MESSAGES="de_DE.UTF-8"
export LC_MONETARY="de_DE.UTF-8"
export LC_NUMERIC="de_DE.UTF-8"
export LC_TIME="de_DE.UTF-8"
export LC_ALL="de_DE.UTF-8"
export CC=gcc-4.9
export CXX=g++-4.9
export FFLAGS=-ff2c
export PYTHONPATH="/Users/esaller/anaconda/bin/python"
export EDITOR=vim
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

export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-lin


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="agnoster"

ZSH_TMUX_AUTOSTART=true
#source /Users/esaller/perl5/perlbrew/etc/bashrc


#Alias
alias di="rolldice"
alias zshconfig="vim ~/.zshrc"
alias g="gvim --remote-silent"
alias gg="gvim --remote-silent ./"
alias GMP="find . -maxdepth 1 -type d -exec sh -c '(cd {} && git pull)' ';'"
alias GMV="find . -maxdepth 1 -type d -exec sh -c '(cd {} && git remote -v)' ';'"
alias gsf="git submodule foreach --recursive git fetch"
alias gsmom="git submodule foreach git merge origin master"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

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

#PATH
export PATH=~/anaconda/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/texbin:.:/Users/esaller/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/opt/go/bin:/opt/go/lib/go/bin:~/usr/lib/go/bin:.:/Users/esaller/usr/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/opt/go/bin:/opt/go/lib/go/bin:~/usr/lib/go/bin:.:/Users/esaller/usr/bin:/opt/local/bin:/opt/local/sbin:/Users/esaller/perl5/perlbrew/bin:$OPENCCG_HOME/bin:~/Applications/TreeTagger/cmd:~/Applications/TreeTagger/bin:$PATH:~/external_libs/Wapiti/

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(history-substring-search git vim-interaction tmux vi-mode)

source $ZSH/oh-my-zsh.sh
