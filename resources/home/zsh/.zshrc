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
    export TERM=screen-256color        # ranger image previews do not work in tmux
else
    if [[ $TERMINFO == *"kitty"* ]]; then
      export TERM=xterm-kitty            # mainly for ranger image previews
      alias ssh='TERM=xterm-256color ssh' # fix on ssh
    fi
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
zplug "desyncr/auto-ls"                             # With empty command press Return for ls
zplug "junegunn/fzf", as:command, hook-build:"./install --bin", use:"bin/{fzf-tmux,fzf}"  # fzf fuzzy searching
zplug "modules/docker", from:prezto
zplug "changyuheng/zsh-interactive-cd"              # fish like cd comletion
zplug "b4b4r07/enhancd", use:init.sh

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

# Based on romkatv/powerlevel10k/config/p10k-pure.zsh, checksum 30812.
# Wizard options: powerline, pure, original, rpromt, time, 2 lines, compact,
# instant_prompt=verbose.
# Type `p10k configure` to generate another config.
#
# Config file for Powerlevel10k with the style of Pure (https://github.com/sindresorhus/pure).
#
# Differences from Pure:
#
#   - Git:
#     - `@c4d3ec2c` instead of something like `v1.4.0~11` when in detached HEAD state.
#     - No automatic `git fetch` (the same as in Pure with `PURE_GIT_PULL=0`).
#
# Apart from the differences listed above, the replication of Pure prompt is exact. This includes
# even the questionable parts. For example, just like in Pure, there is no indication of Git status
# being stale; prompt symbol is the same in command, visual and overwrite vi modes; when prompt
# doesn't fit on one line, it wraps around with no attempt to shorten it.
#
# If you like the general style of Pure but not particularly attached to all its quirks, type
# `p10k configure` and pick "Lean" style. This will give you slick minimalist prompt while taking
# advantage of Powerlevel10k features that aren't present in Pure.

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh

  autoload -Uz is-at-least && is-at-least 5.1 || return

  # Unset all configuration options.
  unset -m 'POWERLEVEL9K_*'

  # Prompt colors.
  local grey='242'
  local red='1'
  local yellow='3'
  local blue='4'
  local magenta='5'
  local cyan='6'
  local white='7'

  # Left prompt segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    # context                 # user@host
    dir                       # current directory
    vcs                       # git status
    # command_execution_time  # previous command duration
    # =========================[ Line #2 ]=========================
    newline                   # \n
    # virtualenv              # python virtual environment
    prompt_char               # prompt symbol
  )

  # Right prompt segments.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    command_execution_time    # previous command duration
    virtualenv                # python virtual environment
    context                   # user@host
    time                      # current time
    # =========================[ Line #2 ]=========================
    newline                   # \n
  )

  # Basic style options that define the overall prompt look.
  typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=           # no segment icons

  # Add an empty line before each prompt except the first. This doesn't emulate the bug
  # in Pure that makes prompt drift down whenever you use the Alt-C binding from fzf or similar.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  # Magenta prompt symbol if the last command succeeded.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=$magenta
  # Red prompt symbol if the last command failed.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=$red
  # Default prompt symbol.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='λ'
  # Prompt symbol in command vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='Λ'
  # Prompt symbol in visual vi mode is the same as in command mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='Λ'
  # Prompt symbol in overwrite vi mode is the same as in command mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=false

  # Grey Python Virtual Environment.
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=$grey
  # Don't show Python version.
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
  typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

  # Blue current directory.
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=$blue

  # Context format when root: user@host. The first part white, the rest grey.
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE="%F{$white}%n%f%F{$grey}@%m%f"
  # Context format when not root: user@host. The whole thing grey.
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE="%F{$grey}%n@%m%f"
  # Don't show context unless root or in SSH.
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_CONTENT_EXPANSION=

  # Show previous command duration only if it's >= 5s.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=5
  # Don't show fractional seconds. Thus, 7s rather than 7.3s.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  # Duration format: 1d 2h 3m 4s.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  # Yellow previous command duration.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$yellow

  # Grey Git prompt. This makes stale prompts indistinguishable from up-to-date ones.
  typeset -g POWERLEVEL9K_VCS_FOREGROUND=$grey

  # Disable async loading indicator to make directories that aren't Git repositories
  # indistinguishable from large Git repositories without known state.
  typeset -g POWERLEVEL9K_VCS_LOADING_TEXT=

  # Don't wait for Git status even for a millisecond, so that prompt always updates
  # asynchronously when Git state changes.
  typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0

  # Cyan ahead/behind arrows.
  typeset -g POWERLEVEL9K_VCS_{INCOMING,OUTGOING}_CHANGESFORMAT_FOREGROUND=$cyan
  # Don't show remote branch, current tag or stashes.
  typeset -g POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind)
  # Don't show the branch icon.
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=
  # When in detached HEAD state, show @commit where branch normally goes.
  typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='@'
  # Don't show staged, unstaged, untracked indicators.
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED}_ICON=
  # Show '*' when there are staged, unstaged or untracked files.
  typeset -g POWERLEVEL9K_VCS_DIRTY_ICON='*'
  # Show '⇣' if local branch is behind remote.
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=':⇣'
  # Show '⇡' if local branch is ahead of remote.
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=':⇡'
  # Don't show the number of commits next to the ahead/behind arrows.
  typeset -g POWERLEVEL9K_VCS_{COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=1
  # Remove space between '⇣' and '⇡' and all trailing spaces.
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${${${P9K_CONTENT/⇣* :⇡/⇣⇡}// }//:/ }'

  # Grey current time.
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=$grey
  # Format for the current time: 09:51:02. See `man 3 strftime`.
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  # If set to true, time will update when you hit enter. This way prompts for the past
  # commands will contain the start times of their commands rather than the end times of
  # their preceding commands.
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false

  # Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
  # when accepting a command line. Supported values:
  #
  #   - off:      Don't change prompt when accepting a command line.
  #   - always:   Trim down prompt when accepting a command line.
  #   - same-dir: Trim down prompt when accepting a command line unless this is the first command
  #               typed after changing current working directory.
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

  # Instant prompt mode.
  #
  #   - off:     Disable instant prompt. Choose this if you've tried instant prompt and found
  #              it incompatible with your zsh configuration files.
  #   - quiet:   Enable instant prompt and don't print warnings when detecting console output
  #              during zsh initialization. Choose this if you've read and understood
  #              https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
  #   - verbose: Enable instant prompt and print a warning when detecting console output during
  #              zsh initialization. Choose this if you've never tried instant prompt, haven't
  #              seen the warning, or if you are unsure what this all means.
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

  # Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
  # For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
  # can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
  # really need it.
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  # If p10k is already loaded, reload configuration.
  # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
  (( ! $+functions[p10k] )) || p10k reload
}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'




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

# Select a docker container to start and attach to
function da() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

# Select a docker container to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
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
