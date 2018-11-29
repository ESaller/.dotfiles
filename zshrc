echo      Welcome back Commander!

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


# Set language environment
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="chains"
ZSH_TMUX_ITERM2=false
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_AUTOQUIT=false


# vim command line edit and editor pref
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
export VISUAL="vim"
export EDITOR="vim"


# Alias
# alias tmux="TERM=screen-256color-bce tmux"
alias useconda="export PATH='$HOME/anaconda/bin:$HOME/miniconda3/bin:$HOME/conda/bin:$PATH'"
alias di="rolldice"
alias zshconfig="vim ~/.zshrc"
alias GMP="find . -maxdepth 1 -type d -exec sh -c '(cd {} && git pull)' ';'"
alias GMV="find . -maxdepth 1 -type d -exec sh -c '(cd {} && git remote -v)' ';'"
alias gsf="git submodule foreach --recursive git fetch"
alias gsmom="git submodule foreach git merge origin master"
alias pullallsubd="ls | parallel git -C {} pull"
alias dsnope="find . -name '.DS_Store' -type f -delete"
alias ftcount='find . -type f | grep -E ".*\.[a-zA-Z0-9]*$" | sed -e "s/.*\(\.[a-zA-Z0-9]*\)$/\1/" | sort | uniq -c | sort -n'
eval $(thefuck --alias)


# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# FUNCTIONS

# Direct login login to physical machine
function uni-takeover (){
    echo "User $1 is taking over computer $2"
    eval "ssh -o 'ProxyCommand ssh -W %h:%p $1@remote.cip.ifi.lmu.de' $1@$2"
}


# PATH - every Path in a new line


# Python
# force anaconda before default path
# moved to useconda alias
# export PATH="$HOME/anaconda/bin:$PATH"
# export PATH="$HOME/miniconda3/bin:$PATH"


# Ruby
# force rbenv before default path
# configure it so, that it considers system ruby as global for building with brew
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


# HOMEBREW MAC OSX install location for slinks
path+=usr/local/sbin
path+=usr/local/bin


# X11
path+=opt/X11/bin
path+=usr/X11/bin


# OS specifc paths
if [[ `uname` == 'Darwin' ]]
then
    export OSX=1
    path+=~/Library/Android/sdk/platform-tools
    export PATH="/usr/local/opt/openssl/bin:$PATH"
else
    export OSX=0
fi


# other
path+=/usr/local/lib
path+=/usr/local/include


# export everything
export path


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
# git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-history-substring-search.git $ZSH_CUSTOM/plugins/zsh-history-substring-search
plugins=(sudo git history tmux zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search)
autoload -U compinit && compinit


SAVEHIST=1000
HISTFILE=~/.zsh_history


# Shell Helper for base16 themes
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Add company internal config
source ~/.zshrccompany

# Path to your oh-my-zsh configuration.
ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# FZF keybindings & config (See https://github.com/junegunn/fzf)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
