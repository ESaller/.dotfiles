################################################################################
# Setting Up Directories
# If some directories are needed they are specified here
# Note: Some plugins may create their own folders
################################################################################

export CACHE_DIR="$HOME/.cache"
[[ ! -d "$CACHE_DIR" ]] && mkdir -p "$CACHE_DIR"
export _FASD_DATA="$CACHE_DIR/.fasd" # set fasd data file location
export ZPLUG_HOME="$HOME/.zplug"


################################################################################
# PATH
# Manual PATH adjustments are done here
# Note: Some plugins also update PATH, e.g. zplug
################################################################################
case `uname` in
  Darwin)
    # commands for OS X go here
    export PATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:$PATH"
  ;;
  Linux)
    # commands for Linux go here
  ;;
esac


################################################################################
# ENVIRONMENT
################################################################################

export KITTY_CONFIG_DIRECTORY=~/.kitty
export TERM=xterm-kitty


################################################################################
# LANG
################################################################################

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


################################################################################
# EDITOR
################################################################################

export EDITOR=vim
export VISUAL=vim


################################################################################
# HISTORY
# Setting up the shell history
################################################################################

export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTFILE="$CACHE_DIR/.zsh_history"

# From https://github.com/mattjj/my-oh-my-zsh/blob/master/history.zsh

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
unsetopt HIST_BEEP               # Beep when accessing nonexistent history.


################################################################################
# ALIAS
################################################################################
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias lsa='ls -lah'
alias ll='ls -lh'

alias code="code-insiders"
alias ls="exa"

alias dsnope="find . -name '.DS_Store' -type f -delete"
alias lup="ag --nobreak --nonumbers --noheading . | fzf"
alias trackfileupdates="ls -ltur | tail -10"


################################################################################
# MAN
################################################################################

export MANPAGER='less -X';             # Don't clear the screen after quitting a manual page.
export LESS_TERMCAP_md="$yellow"       # Highlight section titles in manual pages.


################################################################################
# COLOR
################################################################################

# TERM
if [[ -n "$TMUX" ]]; then
    export TERM=screen-256color
else
    export TERM=xterm-256color
fi

################################################################################
# ZSH
################################################################################

setopt auto_cd                         # if command is a path, cd into it
setopt auto_remove_slash               # self explicit
setopt correct                         # try to correct spelling of commands
setopt extended_glob                   # activate complex pattern globbing
setopt print_exit_value                # print return value if non-zero
setopt prompt_subst                    # parameter expansion, command substitution and arithmetic expansion in prompts
unsetopt bg_nice                       # no lower prio for background jobs
unsetopt rm_star_silent                # ask for confirmation for `rm *' or `rm path/*'
unsetopt menu_complete
unsetopt flowcontrol                   # output flow control via start/stop characters (usually assigned to ^S/^Q)
                                       # is disabled in the shell's editor.
setopt always_to_end                   # when completing from the middle of a word, move the cursor to the end of it
setopt complete_in_word                # allow completion from within a word/phrase
setopt auto_menu                       # use menu completion after the second consecutive request for completion
setopt list_ambiguous                  # complete as much of a completion until it gets ambiguous.


# Commpletion Settings
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories


# use cache
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR


# shift-tab : go backward in menu (invert of tab)
bindkey '^[[Z' reverse-menu-complete
zstyle ':zplug:tag' depth 42


################################################################################
# ZPLUG
################################################################################

if [[ ! -d "$ZPLUG_HOME" ]]; then
    echo "Installing zplug"
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    source "$ZPLUG_HOME/init.zsh"
    zplug update
else
    source "$ZPLUG_HOME/init.zsh"
fi


################################################################################
# PLUGINS
################################################################################

########################################
# Selfupdate
########################################
zplug "zplug/zplug", hook-build:"zplug --self-manage"


########################################
# Extensions
########################################
zplug "zsh-users/zsh-history-substring-search"      # Better History Search
zplug "zsh-users/zsh-syntax-highlighting", defer:2  # Syntax Highlights
zplug "zsh-users/zsh-autosuggestions"               # Completions
zplug "zsh-users/zsh-completions"                   # Completions
zplug "peterhurford/up.zsh"                         # `up 3` == `cd ...` etc.
zplug "desyncr/auto-ls"                             # With empty command press Return for ls
zplug "junegunn/fzf", as:command, hook-build:"./install --bin", use:"bin/{fzf-tmux,fzf}"  # fzf fuzzy searching
zplug "modules/docker", from:prezto
zplug "changyuheng/zsh-interactive-cd"              # fish like cd comletion


########################################
# OS Specific
########################################

####################
# OSX
####################
zplug "modules/osx", from:prezto,  if:"[[ $OSTYPE == *darwin* ]]"


########################################
# Prompt
########################################
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme


###################
# Prompt Configuration
###################



# Original location: https://github.com/romkatv/dotfiles-public/blob/master/.purepower.
# If you copy this file, keep the link to the original and this sentence intact; you are encouraged
# to change everything else.
#
# This file defines configuration options for Powerlevel10k ZSH theme that will make your prompt
# lightweight and sleek, unlike the default bulky look. You can also use it with Powerlevel9k -- a
# great choice if you need an excuse to have a cup of coffee after every command you type.
#
# This is how it'll look:
# https://raw.githubusercontent.com/romkatv/dotfiles-public/master/dotfiles/purepower.png.
#
# Pure Power needs to be installed in addition to Powerlevel10k, not instead of it. Pure Power
# defines a set of configuration parameters that affect the styling of Powerlevel10k; there is no
# code in it.
#
#                         PHILOSOPHY
#
# This configuration is made for those who care about style and value clear UI without redundancy
# and tacky ornaments that serve no function.
#
#   * No overwhelming background that steals attention from real content on your screen.
#   * No redundant icons. A clock icon next to the current time takes space without conveying any
#     information. This is your personal prompt -- you don't need an icon to remind you that the
#     segment on the right shows current time.
#   * No separators between prompt segments. Different foreground colors are enough to keep them
#     visually distinct.
#   * Bright colors for important things, low-contrast colors for everything else.
#   * No needless color switching. The number of stashes you have in a git repository is always
#     green. Since its meaning is the same in a clean and in a dirty repository, it doesn't change
#     color.
#   * Works with any font.
#
#                       ATTRIBUTION
#
# Visual design of this configuration borrows heavily from https://github.com/sindresorhus/pure.
# Recreation of Pure look and feel in Powerlevel10k was inspired by
# https://github.com/iboyperson/p9k-theme-pastel. The origin myth is chiseled onto
# https://www.reddit.com/r/zsh/comments/b45w6v/.

if test -z "${ZSH_VERSION}"; then
  echo "purepower: unsupported shell; try zsh instead" >&2
  return 1
  exit 1
fi

() {
  emulate -L zsh && setopt no_unset pipe_fail

  # `$(_pp_c x y`) evaluates to `y` if the terminal supports >= 256 colors and to `x` otherwise.
  zmodload zsh/terminfo
  if (( terminfo[colors] >= 256 )); then
    function _pp_c() { print -nr -- $2 }
  else
    function _pp_c() { print -nr -- $1 }
    typeset -g POWERLEVEL9K_IGNORE_TERM_COLORS=true
  fi

  # `$(_pp_s x y`) evaluates to `x` in portable mode and to `y` in fancy mode.
  if [[ ${PURE_POWER_MODE:-fancy} == fancy ]]; then
    function _pp_s() { print -nr -- $2 }
  else
    if [[ $PURE_POWER_MODE != portable ]]; then
      echo -En "purepower: invalid mode: ${(qq)PURE_POWER_MODE}; " >&2
      echo -E  "valid options are 'fancy' and 'portable'; falling back to 'portable'" >&2
    fi
    function _pp_s() { print -nr -- $1 }
  fi

  typeset -ga POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
      dir_writable dir vcs)

  typeset -ga POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
      status command_execution_time background_jobs custom_rprompt context)

  local ins=$(_pp_s '>' 'λ')
  local cmd=$(_pp_s '<' 'Λ')
  if (( ${PURE_POWER_USE_P10K_EXTENSIONS:-1} )); then
    local p="\${\${\${KEYMAP:-0}:#vicmd}:+${${ins//\\/\\\\}//\}/\\\}}}"
    p+="\${\${\$((!\${#\${KEYMAP:-0}:#vicmd})):#0}:+${${cmd//\\/\\\\}//\}/\\\}}}"
  else
    p=$ins
  fi
  local ok="%F{$(_pp_c 002 076)}${p}%f"
  local err="%F{$(_pp_c 001 196)}${p}%f"

  if (( ${PURE_POWER_USE_P10K_EXTENSIONS:-1} )); then
    typeset -g ZLE_RPROMPT_INDENT=0
    typeset -g POWERLEVEL9K_SHOW_RULER=true
    typeset -g POWERLEVEL9K_RULER_CHAR=$(_pp_s '-' '─')
    typeset -g POWERLEVEL9K_RULER_BACKGROUND=none
    typeset -g POWERLEVEL9K_RULER_FOREGROUND=$(_pp_c 005 237)
  else
    typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  fi

  typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  typeset -g POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%(?.$ok.$err) "

  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_WHITESPACE_BETWEEN_{LEFT,RIGHT}_SEGMENTS=

  typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=none
  typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_VISUAL_IDENTIFIER_COLOR=003
  typeset -g POWERLEVEL9K_LOCK_ICON='#'

  typeset -g POWERLEVEL9K_DIR_{ETC,HOME,HOME_SUBFOLDER,DEFAULT}_BACKGROUND=none
  typeset -g POWERLEVEL9K_DIR_{ETC,DEFAULT}_FOREGROUND=$(_pp_c 003 209)
  typeset -g POWERLEVEL9K_DIR_{HOME,HOME_SUBFOLDER}_FOREGROUND=$(_pp_c 004 039)
  typeset -g POWERLEVEL9K_{ETC,FOLDER,HOME,HOME_SUB}_ICON=

  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED,LOADING}_BACKGROUND=none
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$(_pp_c 002 076)
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$(_pp_c 006 014)
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$(_pp_c 003 011)
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=$(_pp_c 005 244)
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_UNTRACKEDFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_UNSTAGEDFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_MODIFIED_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_STAGEDFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_MODIFIED_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_INCOMING_CHANGESFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_CLEAN_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_OUTGOING_CHANGESFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_CLEAN_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_STASHFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_CLEAN_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_ACTIONFORMAT_FOREGROUND=001
  typeset -g POWERLEVEL9K_VCS_LOADING_ACTIONFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_LOADING_FOREGROUND
  typeset -g POWERLEVEL9K_VCS_{GIT,GIT_GITHUB,GIT_BITBUCKET,GIT_GITLAB,BRANCH}_ICON=
  typeset -g POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON=$'%{\b|%}'
  typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='@'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
  typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='!'
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON='+'
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$(_pp_s '<' '⇣')
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$(_pp_s '>' '⇡')
  typeset -g POWERLEVEL9K_VCS_STASH_ICON='*'
  typeset -g POWERLEVEL9K_VCS_TAG_ICON=$'%{\b#%}'
  typeset -g POWERLEVEL9K_VCS_MAX_NUM_STAGED=-1
  typeset -g POWERLEVEL9K_VCS_MAX_NUM_UNSTAGED=-1
  typeset -g POWERLEVEL9K_VCS_MAX_NUM_UNTRACKED=1

  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=none
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$(_pp_c 001 009)
  typeset -g POWERLEVEL9K_CARRIAGE_RETURN_ICON=

  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=none
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$(_pp_c 005 101)
  typeset -g POWERLEVEL9K_EXECUTION_TIME_ICON=

  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=none
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_COLOR=002
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_ICON=$(_pp_s '%%' '⇶')

  typeset -g POWERLEVEL9K_CUSTOM_RPROMPT=custom_rprompt
  typeset -g POWERLEVEL9K_CUSTOM_RPROMPT_BACKGROUND=none
  typeset -g POWERLEVEL9K_CUSTOM_RPROMPT_FOREGROUND=$(_pp_c 004 012)

  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,ROOT,REMOTE_SUDO,REMOTE,SUDO}_BACKGROUND=none
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,REMOTE_SUDO,REMOTE,SUDO}_FOREGROUND=$(_pp_c 007 244)
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=$(_pp_c 003 011)

  function custom_rprompt() {}  # redefine this to show stuff in custom_rprompt segment

  unfunction _pp_c _pp_s
} "$@"

# Update
if ! zplug check; then
    zplug install
fi

zplug load


################################################################################
# Plugin Configuration
################################################################################

########################################
# fasd
# https://github.com/clvv/fasd
########################################

eval "$(fasd --init auto)"


########################################
## fzf
########################################

# Setting keybindings based on the zplug pull
source ~/.zplug/repos/junegunn/fzf/shell/key-bindings.zsh
source ~/.zplug/repos/junegunn/fzf/shell/completion.zsh


########################################
## https://github.com/zsh-users/zsh-history-substring-search
########################################

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


########################################
## auto-ls
########################################

export AUTO_LS_CHPWD=false


################################################################################
# CUSTOM COMMANDS
# Combinations of different installed plugins, e.g. fzf+fasd
################################################################################

# tmux fzf integration
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

# fasd fzf integration
# cd into recent directories
function zd() {
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

# fasd fzf integration
# j: jump to directories
alias j=zd

# fasd fzf integration
# View recent f files
function v() {
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && $EDITOR "${file}" || return 1
}

# fasd fzf integration
# cd into the directory containing a recently used file
function vd() {
    local dir
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && dir=$(dirname "$file") && cd "$dir"
}


################################################################################
# PDF SEARCH
# https://github.com/bellecp/fast-p
# Searches the first page of all pdf files in current dir and subdir
################################################################################

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


################################################################################
# Dockerized Commands
################################################################################

# This is taken from rawkode/zsh-docker-run
# It allows for certain commands to be executed inside docker
# For example you can use this for specifc python versions


########################################
# Dockerized Commands - SETUP
########################################

function can_be_run_through_docker_compose_service() {
  # Look for a service using the image $1 inside docker-compose.yml
  image_name=''
  if [ -f "docker-compose.yml" ];
  then
    image_name=$(grep -B1 -A0 "image: $1" docker-compose.yml | head -n1 | awk -F ":" '{print $1}' | tr -d '[:space:]')
  fi
}

function docker_run() {
  docker run --rm -it -v $PWD:/sandbox -w /sandbox --entrypoint=$3 $1:$2 ${@:4}
}

function docker_compose_run() {
  docker-compose run --rm --entrypoint=$1 ${@:2}
}

function run_with_docker() {
  can_be_run_through_docker_compose_service $1

  if [[ ! -z "${image_name// }" ]];
  then
    docker_compose_run $3 $image_name ${@:4}
  else
    docker_run $1 $2 $3 ${@:4}
  fi
}


########################################
# Dockerized Commands - COMMANDS
########################################

function go() {
  run_with_docker "golang" "latest" "go" $@
}


################################################################################
# CONDITIONALS
################################################################################

if [[ $(command -v rbenv) ]]; then
    eval "$(rbenv init - zsh --no-rehash)"
fi


################################################################################
# SOURCE
################################################################################
#[[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"
