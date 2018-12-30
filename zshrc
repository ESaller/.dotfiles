##### Setting Up Directories #####
export CACHE_DIR="$HOME/.cache"
[[ ! -d "$CACHE_DIR" ]] && mkdir -p "$CACHE_DIR"
export _FASD_DATA="$CACHE_DIR/.fasd" # set fasd data file location
export ZPLUG_HOME="$HOME/.zplug"


##### PATH #####
case `uname` in
  Darwin)
    # commands for OS X go here
    export PATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:$PATH"
  ;;
  Linux)
    # commands for Linux go here
  ;;
esac


###### Language Settings #####
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


##### VIM #####
export EDITOR=vim
export VISUAL=vim


##### History Settings #####
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
export HISTFILE="$CACHE_DIR/.zsh_history"
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"


##### Basic Alias #####
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias lsa='ls -lah'
alias ll='ls -lh'

alias dsnope="find . -name '.DS_Store' -type f -delete"


##### MAN Pages #####
export MANPAGER='less -X'; # Don't clear the screen after quitting a manual page.
export LESS_TERMCAP_md="$yellow" # Highlight section titles in manual pages.


##### Color Basics #####
if [[ -n "$TMUX" ]]; then
    export TERM=screen-256color
else
    export TERM=xterm-256color
fi

##### ZSH Settinhs #####
# History
setopt append_history
setopt bang_hist                # !keyword
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify
setopt inc_append_history
setopt share_history


# Misc
setopt auto_cd                  # if command is a path, cd into it
setopt auto_remove_slash        # self explicit
setopt chase_links              # resolve symlinks
setopt correct                  # try to correct spelling of commands
setopt extended_glob            # activate complex pattern globbing
setopt glob_dots                # include dotfiles in globbing
setopt print_exit_value         # print return value if non-zero
setopt prompt_subst
unsetopt bg_nice                # no lower prio for background jobs
unsetopt hist_beep              # no bell on error in history
unsetopt rm_star_silent         # ask for confirmation for `rm *' or `rm path/*'
unsetopt menu_complete
unsetopt flowcontrol
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
setopt auto_menu
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.


# Commpletion Settings
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR


# shift-tab : go backward in menu (invert of tab)
bindkey '^[[Z' reverse-menu-complete
zstyle ':zplug:tag' depth 42


##### ZSH PLUGIN MANAGER #####
if [[ ! -d "$ZPLUG_HOME" ]]; then
    echo "Installing zplug"
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    source "$ZPLUG_HOME/init.zsh"
    zplug update
else
    source "$ZPLUG_HOME/init.zsh"
fi


##### Plugins #####


# Selfupdate
zplug "zplug/zplug", hook-build:"zplug --self-manage"


# Extensions
zplug "zsh-users/zsh-history-substring-search"      # Better History Search
zplug "zsh-users/zsh-syntax-highlighting", defer:2  # Syntax Highlights
zplug "zsh-users/zsh-autosuggestions"               # Completions
zplug "zsh-users/zsh-completions"                   # Completions
zplug "rawkode/zsh-docker-run"                      # Put commands into a container
zplug "peterhurford/up.zsh"                         # `up 3` == `cd ...` etc.
zplug "desyncr/auto-ls"                             # With empty command press Return for ls
zplug "junegunn/fzf", as:command, hook-build:"./install --bin", use:"bin/{fzf-tmux,fzf}"  # fzf fuzzy searching
zplug "modules/docker", from:prezto
zplug "changyuheng/zsh-interactive-cd"              # fish like cd comletion


# OS Specific


# OSX
zplug "modules/osx", from:prezto,  if:"[[ $OSTYPE == *darwin* ]]"


# Prompt
zplug "mafredri/zsh-async", on:sindresorhus/pure
zplug "sindresorhus/pure", use:pure.zsh, defer:3


# Update
if ! zplug check; then
    zplug install
fi

zplug load


##### Plugin Configuration #####


# fzf
source ~/.zplug/repos/junegunn/fzf/shell/key-bindings.zsh
source ~/.zplug/repos/junegunn/fzf/shell/completion.zsh

# tm - create new tmux session, or switch to existing one. Works from within tmux too.
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}


# fasd + fzf
# https://github.com/clvv/fasd
eval "$(fasd --init auto)"

# cd into recent directories
function zd() {
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

# j: jump to directories
alias j=zd

# View recent f files
function v() {
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && $EDITOR "${file}" || return 1
}

# cd into the directory containing a recently used file
function vd() {
    local dir
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && dir=$(dirname "$file") && cd "$dir"
}


# auto-ls
export AUTO_LS_CHPWD=false


##### PDF SEARCH #####
# https://github.com/bellecp/fast-p
p () {
    local open
    open=open   # on OSX, "open" opens a pdf in preview
    ag -U -g ".pdf$" \
    | fast-p \
    | fzf --read0 --reverse -e -d $'\t'  \
        --preview-window down:80% --preview '
            v=$(echo {q} | gtr " " "|");
            echo -e {1}"\n"{2} | ggrep -E "^|$v" -i --color=always;
        ' \
    | gcut -z -f 1 -d $'\t' | gtr -d '\n' | gxargs -r --null $open > /dev/null 2> /dev/null
}


##### Dockerized Commands (zsh-docker-run)  #####
function go() {
  run_with_docker "golang" "latest" "go" $@
}

function npm {
  run_with_docker "node" "alpine" "npm" $@
}

##### Commands #####
if [[ $(command -v rbenv) ]]; then
    eval "$(rbenv init - zsh --no-rehash)"
fi

##### Additional Files #####
#[[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"
