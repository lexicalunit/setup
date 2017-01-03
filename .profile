#! .profile

INTERACTIVE=false
if [[ $- == *i* ]]; then
    INTERACTIVE=true
fi

################################################################################
# setup paths
################################################################################
export PATH=""

# Allow OS X tool to discover typical PATH items first, if possible.
if [[ -e /usr/libexec/path_helper ]]; then
    eval "$(/usr/libexec/path_helper -s)"
else
    test -d /usr/bin && PATH="$PATH:$_"
    test -d /bin && PATH="$PATH:$_"
    test -d /usr/sbin && PATH="$PATH:$_"
    test -d /sbin && PATH="$PATH:$_"
    test -d /usr/local/bin && PATH="$PATH:$_"
    test -d /opt/X11/bin && PATH="$PATH:$_"
fi

# Then add specific paths that I use.
test -d /usr/local/opt/ruby/bin && PATH="$PATH:$_"
test -d /opt/local/bin && PATH="$PATH:$_"
test -d /opt/local/sbin && PATH="$PATH:$_"

# Export currently built PATH so the rest of this script has access to them.
if test -e /usr/libexec/path_helper; then
    eval "$($_ -s)"
else
    export PATH
    export MANPATH
fi

# Make sure Homebrew utilities override system utilities.
if type brew >/dev/null 2>&1; then
    BREW_PREFIX="$(brew --prefix)"
    test -d "$BREW_PREFIX/bin" && PATH="$_:$PATH"
    test -d "$BREW_PREFIX/sbin" && PATH="$_:$PATH"
    # Don't use brew installed python. Prefer an Anaconda distro instead.
    # test -d "$BREW_PREFIX/lib/python2.7/site-packages" && PYTHONPATH="$PYTHONPATH:$_"
    BREW_COREUTILS_PREFIX="$(brew --prefix coreutils 2>/dev/null)"
    if [[ $? == 0 ]]; then
        test -d "$BREW_COREUTILS_PREFIX/libexec/gnubin" && PATH="$_:$PATH"
        test -d "$BREW_COREUTILS_PREFIX/libexec/gnuman" && MANPATH="$_:$MANPATH"
    fi
    export PATH
    export MANPATH
    export PYTHONPATH
fi

# Add specific application paths, such as Python, rvm, etc...
test -d "$HOME/.rvm/bin" && PATH="$PATH:$_"
test -d "$HOME/.log-ninja" && PATH="$PATH:$_"
test -d /usr/local/lib/svn-python && PYTHONPATH="$_:$PYTHONPATH"
test -d /opt/local/lib/pkgconfig && PKG_CONFIG_PATH="$_:$PKG_CONFIG_PATH"
test -d /usr/local/lib/pkgconfig && PKG_CONFIG_PATH="$_:$PKG_CONFIG_PATH"

# Go's env
GOPATH="/usr/local/lib/gopath"
if [[ ! -d "$GOPATH" ]]; then
    mkdir -p "$GOPATH"
fi
test -d "$GOPATH/bin" && PATH="$PATH:$_"
test -d /usr/local/opt/go/libexec/bin && PATH="$PATH:$_"
export GOPATH

# Make sure user utilities take precedence
test -d "$HOME/bin" && PATH="$_:$PATH"

export PATH
export PYTHONPATH
export PKG_CONFIG_PATH

################################################################################
# inspect system
################################################################################
USER="$(whoami)"
HOST="$(uname -n)"
PLATFORM="$(uname)"
export USER
export HOST
export PLATFORM

if $INTERACTIVE; then

################################################################################
# interactive settings
################################################################################
# print timestamp and given message
_interactive_log() {
    echo "$(date +%H:%M:%S.%N) - $*"
}

_interactive_log "interactive settings"

set -o emacs

# Make backspace work correctly.
stty erase '^?' eol ^@ start ^q stop ^s intr ^c

if echo "$SHELL" | grep -q bash; then
    # Bash won't get SIGWINCH if another process is in the foreground.
    # Enable checkwinsize so that bash will check the terminal size when
    # it regains control.  #65623
    # http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
    shopt -s checkwinsize
fi

################################################################################
# setup base16-shell -- https://github.com/chriskempson/base16-shell
################################################################################
_interactive_log "setting up base16-shell"
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
type -f _base16 >/dev/null 2>&1 && _base16 "$BASE16_SHELL/scripts/base16-solarized-light.sh" solarized-light

################################################################################
# python environment control
################################################################################
test -f "$HOME/.pythonrc.py" && PYTHONSTARTUP="$_"

export PYTHONSTARTUP
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYTHON_ENV=""

entervirtualenv() {
    exitconda

    if type virtualenvwrapper.sh >/dev/null 2>&1; then
        # shellcheck source=virtualenvwrapper.sh
        source "$(which virtualenvwrapper.sh)"
    fi
    export PYTHON_ENV="virtualenv"
}

exitvirtualenv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        if type deactivate >/dev/null 2>&1; then
            deactivate
        fi
    fi
    unset PYTHON_ENV
}

# shellcheck disable=SC2120
enterconda() {
    # should be safe to exitvirtualenv just in case we're in a virtualenv
    exitvirtualenv

    # assume anaconda is installed in your home directory unless specified
    local ANACONDA_DIR_NAME="anaconda3"
    if [[ -z "$1" ]]; then
        export ANACONDA_ROOT="$HOME/$ANACONDA_DIR_NAME"
    else
        export ANACONDA_ROOT="$1"
    fi

    if [[ ! -e "$ANACONDA_ROOT" ]]; then
        echo "error: can not enter anaconda env at '$ANACONDA_ROOT', directory does not exist."
        return 1
    fi

    test -d "$ANACONDA_ROOT/bin" && PATH="$_:$PATH"
    test -d "$ANACONDA_ROOT/share/man" && MANPATH="$_:$MANPATH"
    export PATH
    export MANPATH
    export PYTHON_ENV="conda"

    # provide bash completion for conda
    if echo "$SHELL" | grep -q bash; then
        eval "$(register-python-argcomplete conda)"
    fi
}

exitconda() {
    if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        if which deactivate >/dev/null 2>&1; then
            source deactivate
        fi
    fi

    if [[ -n "$ANACONDA_ROOT" ]]; then
        PATH="$(echo "$PATH" | sed "s@$ANACONDA_ROOT/bin@@g;s@::@:@g;s@^:@@;s@:\$@@;")"
        MANPATH="$(echo "$PATH" | sed "s@$ANACONDA_ROOT/share/man@@g;s@::@:@g;s@^:@@;s@:\$@@;")"
        export PATH
        export MANPATH
    fi
    unset PYTHON_ENV
}

################################################################################
# terminal history setup
################################################################################
_interactive_log "history setup"

if echo "$SHELL" | grep -q bash; then
    shopt -s histappend
    shopt -s histreedit
    shopt -s histverify

    # syncs bash history from all shells
    _bash_history_sync() {
        builtin history -a
        HISTFILESIZE=$HISTSIZE
        builtin history -c
        builtin history -r
    }

    # syncs history then forwards to builtin
    history() {
        _bash_history_sync
        builtin history "$@"
    }

    # for PROMPT_COMMAND, see below
    _bash_history_append() {
        builtin history -a
    }
elif echo "$SHELL" | grep -q zsh; then
    setopt APPEND_HISTORY
    setopt SHARE_HISTORY
    bindkey "^[[A" history-beginning-search-backward
    bindkey "^[[B" history-beginning-search-forward
fi

HISTFILE="$HOME/.$(basename "$SHELL")_history.$(uname -s)"
export HISTFILE
export HISTCONTROL=ignoredups:erasedups
export TERMINAL_HISTORY_SIZE="100000"
export HISTSIZE="$TERMINAL_HISTORY_SIZE"
export HISTFILESIZE="$TERMINAL_HISTORY_SIZE"
export SAVEHIST="$TERMINAL_HISTORY_SIZE"

################################################################################
# setup terminal colors and editors
################################################################################
_interactive_log "setup terminal colors and editors"
if type dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b "$HOME/.dircolors" 2>/dev/null)" # sets LS_COLORS
    alias ls='ls -hF --color=auto'
fi
export CLICOLOR=1
alias l='ls '
alias ll='ls -l '

# setup grep
export GREP_OPTIONS='--color=auto' GREP_COLOR='7;35'

# setup editor
export EDITOR=vim
export CVSEDITOR=vim
export XEDITOR=vim
export IGNOREEOF=0
if type atom >/dev/null 2>&1; then
    # export EDITOR='atom -w'
    # export CVSEDITOR='atom -w'
    export OSXEDITOR='atom -w'
    alias edit='atom '
    ew() { atom "$(which "$1")"; }
    eman() { man "$@" | col -bx | tmpin atom -w & }
elif type subl >/dev/null 2>&1; then
    # export EDITOR='subl -w'
    # export CVSEDITOR='subl -w'
    export OSXEDITOR='subl -w'
    alias edit='subl '
    ew() { subl "$(which "$1")"; }
    eman() { man "$@" | col -bx | subl -w & }
elif type vim >/dev/null 2>&1; then
    alias edit='vim '
    ew() { vim "$(which "$1")"; }
    eman() { man "$@" | col -bx | vim -; }
fi

# setup atom beta if it's installed
if type atom-beta >/dev/null 2>&1; then
    alias edit='atom-beta '
    alias atom='atom-beta '
    alias apm='apm-beta '
    ew() { atom-beta "$(which "$1")"; }
fi

vman() { man "$@" | col -bx | vim -; }

# setup man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

################################################################################
# setup bash completions
################################################################################
if echo "$SHELL" | grep -q bash; then
    _interactive_log "setup bash completions"
    _source_completions() {
        if [[ -d "$1" ]]; then
            for I in "$1"/*; do
                # shellcheck source=.profile
                source "$I" 2>/dev/null
            done
        elif [[ -f "$1" ]]; then
            # shellcheck source=.profile
            source "$1" 2>/dev/null
        fi
    }
    _source_completions /usr/local/etc/bash_completion.d 2>/dev/null
    _source_completions ~/.bash_completion.d 2>/dev/null
    _source_completions /etc/bash_completion 2>/dev/null
    _source_completions ~/.bash-completion/bash_completion 2>/dev/null # git.debian.org/git/bash-completion
    _source_completions ~/.complete 2>/dev/null # setup env
    if type brew >/dev/null 2>&1; then
        # shellcheck source=/usr/local/Library/Contributions/brew_bash_completion.sh
        source "$(brew --repository)/Library/Contributions/brew_bash_completion.sh"
    fi
    complete -cf sudo
elif echo "$SHELL" | grep -q zsh; then
    if test -d /usr/local/share/zsh-completions; then
        fpath=($_ $fpath)
    fi

    # env
    autoload -Uz bashcompinit && bashcompinit
    _source_completions() {
      if [[ -d "$1" ]]; then
          for I in "$1"/*; do
              # shellcheck source=.profile
              source "$I" 2>/dev/null
          done
      elif [[ -f "$1" ]]; then
          # shellcheck source=.profile
          source "$1" 2>/dev/null
      fi
    }
    _source_completions ~/.complete 2>/dev/null # setup env
fi

################################################################################
# setup command prompt
################################################################################
_interactive_log "setup command prompt"

if echo "$SHELL" | grep -q bash; then
    # prints OS type
    ostype() {
        if [ -n "$OS" ]; then
            echo "$OS"
            return 0
        fi

        local OS
        local CHIP
        OS="$(uname -s)"

        case "$OS" in
            SunOS|IRIX64|Darwin)    CHIP="$(uname -p)"; OS="$(uname -s)";;
            Linux|machten)          CHIP="$(uname -m)"; OS="$(uname -s)";;
            "Mac OS")               CHIP="$(uname -p)"; OS="MacOS";;
            *)                      CHIP="unknown";;
        esac

        echo "$OS-$CHIP"
        return 0
    }

    # prints python environment information
    _prompt_python_env() {
        local PROMPT_PYTHON_ENV=""
        if [[ -n "$PYTHON_ENV" ]]; then
            PROMPT_PYTHON_ENV=" # [$PYTHON_ENV"

            if [[ -n "$VIRTUAL_ENV" ]]; then
                PROMPT_PYTHON_ENV="$PROMPT_PYTHON_ENV:$(basename "$VIRTUAL_ENV")"
            elif [[ -n "$CONDA_DEFAULT_ENV" ]]; then
                PROMPT_PYTHON_ENV="$PROMPT_PYTHON_ENV:$CONDA_DEFAULT_ENV"
            fi

            PROMPT_PYTHON_ENV="$PROMPT_PYTHON_ENV]"
        fi
        echo -n "$PROMPT_PYTHON_ENV"
    }

    # allow user to provide override for terminal title
    title() {
        export TERMINAL_TITLE_USER="$*"
    }

    # allow user to provide override for terminal prompt note
    note() {
        export PROMPT_USER_NOTE="$*"
    }

    # prints terminal note if one is set
    _prompt_usernote() {
        if [[ -n "$PROMPT_USER_NOTE" ]]; then
            echo -n " #" "$PROMPT_USER_NOTE"
        fi
    }

    # prints repository information, bash only
    _prompt_repo() {
        branch=$(type __git_ps1 &>/dev/null && __git_ps1 "%s")
        if [[ -n "$branch" ]]; then
            vcs=git
        else
            branch=$(type -P hg &>/dev/null && hg branch 2>/dev/null)
            if [[ -n "$branch" ]]; then
                vcs=hg
            elif [[ -e .bzr ]]; then
                vcs=bzr
            elif [[ -e .svn ]]; then
                vcs=svn
            else
                vcs=
            fi
        fi
        if [[ -n "$vcs" ]]; then
            if [[ -n "$branch" ]]; then
                repo="$vcs: $branch"
            else
                repo="$vcs"
            fi
            echo -n " # $repo"
        fi
    }

    _prompt_command() {
        local   BLUE="\[\e[0;34m\]"
        local    RED="\[\e[0;31m\]"
        local   BRED="\[\e[1;38;5;160m\]"
        local BGREEN="\[\e[1;32m\]"
        local  BLACK="\[\e[0m\]"
        local   GREY="\[\e[0;38;5;241m\]"

        # "\w" or "${PWD/#$HOME/~}" not sure which to go with...
        local TERMINAL_TITLE
        local PROMPT_LINE_1
        local PROMPT_LINE_2
        TERMINAL_TITLE="$TERMINAL_TITLE_USER$(if [[ -n $TERMINAL_TITLE_USER ]]; then printf ' '; fi)$USER@$HOST:\w"
        PROMPT_LINE_1="$RED\w${BLUE}$(_prompt_python_env)$GREY$(_prompt_repo)$BLUE$(_prompt_usernote)"
        PROMPT_LINE_2="$RED$(date +%H%M) $(ostype | sed 's/Linux-//g') \u@\h\`if [ \$? = 0 ]; then echo \"$BGREEN\$\"; else echo \"$BRED>\"; fi\`$BLACK"

        PS1="\[\e]2;\]${TERMINAL_TITLE}\a\
${PROMPT_LINE_1}\n\
${PROMPT_LINE_2} "
        PS2="> "
        PS3="#? "
        PS4="$0:$LINENO: "
    }

    export PROMPT_COMMAND='_bash_history_append; _prompt_command ' # single quotes to avoid variable expansion
fi

################################################################################
# setup zsh run-help
################################################################################
if echo "$SHELL" | grep -q zsh; then
    _interactive_log "setup zsh run-help"
    unalias run-help
    autoload run-help
    export HELPDIR="/usr/local/share/zsh/help"
    alias help='run-help '
fi

################################################################################
# setup aliases and functions
################################################################################
_interactive_log "setup aliases and functions"
alias wchmod="stat -c '%A %a %n' "
alias st='stree '
alias bc='bc -l '
alias profile='valgrind --tool=callgrind --dump-instr=yes --simulate-cache=yes --collect-jumps=yes '
alias memcheck='valgrind --tool=memcheck --leak-check=yes -show-reachable=yes -fno-inline --logfile=memcheck.log '
alias taskc='fa "#[^ T\!#\n]" '
alias tasks='fa "#T" '
alias unmerged='git ls-files -u | cut -f2 | sort -u '
alias pygmentize='pygmentize -O bg=dark'
alias gits='git s '
alias gitsu='git s -u '
alias yapf='yapf --style="{based_on_style: pep8, column_limit: 120}" '
# This ipython alias prevents `ipython notebook` from working correctly.
# alias ipython='ipython --no-banner --no-confirm-exit '

if type ncftp >/dev/null 2>&1; then alias ftp='ncftp '; fi
if type share >/dev/null 2>&1; then alias shares='share '; fi
if type htop >/dev/null 2>&1; then alias top='htop '; fi

export RSYNC_RSH=rsh # use ssh over rsync
alias ssh='ssh -Y -C ' # use compression over ssh connections

cb() {
    # cb: clipboard
    # TODO: Maybe use xclip or xsel on linux?
    # http://superuser.com/questions/288320/whats-like-osxs-pbcopy-for-linux
    [[ -t 0 ]] && pbpaste || pbcopy
}

fpdf() {
    pdf2ps "$1" - | ps2pdf - "f$1"
}

running_in_docker() {
    awk -F/ '$2 == "docker"' /proc/self/cgroup | read
}

lw() {
    local LOC
    local FINFO
    local REAL
    LOC="$(which "$1")"
    echo "$LOC"
    FINFO="$(file -h "$LOC")"
    if echo "$FINFO" | grep -q 'symbolic link to'; then
        SYLOC="$(echo "$FINFO" | sed 's@.*symbolic link to\s*\(.*\)@\1@')"
        if [[ "$SYLOC" != /* ]]; then
            LOC="$(dirname "$LOC")/$SYLOC"
        else
            LOC="$SYLOC"
        fi
        echo "$LOC"
        if type realpath >/dev/null 2>&1; then
            REAL="$(realpath "$LOC")"
            if [[ "$REAL" != "$LOC" ]]; then
                echo "$REAL"
            fi
        fi
    fi
}

fawk() {
    awk "{print \$$1}"
}

hist() {
    [[ $1 == "--workaround-sc2120" ]] && return
    if echo "$SHELL" | grep -q zsh; then
        if [[ -n "$*" ]]; then
            history "$@"
        else
            history 1
        fi
    elif echo "$SHELL" | grep -q bash; then
        history "$@"
    fi
}
hist --workaround-sc2120 # see: https://github.com/koalaman/shellcheck/wiki/SC2120

h() {
    if [[ -z "$*" ]]; then
        hist
    else
        hist | egrep "$@"
    fi
}

dps() {
    docker ps | while read line; do
        if echo $line | grep -q 'CONTAINER ID'; then
            echo -e "IP ADDRESS\t$line"
        else
            CID=$(echo $line | awk '{print $1}')
            IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" $CID)
            printf "%s\t%s\n" "${IP}" "${line}"
        fi
    done
}

weather() {
    local LOC
    if [[ -n "$1" ]]; then
        LOC="$1"
    else
        LOC="austin"
    fi
    run "curl -s http://wttr.in/$LOC"
}

# use gnu-sed if available
if type gsed >/dev/null 2>&1; then
    alias sed='gsed '
fi

################################################################################
# source any local configuration files
################################################################################
IFS=$'\n'
for I in $(/bin/ls -1 ~/.profile_* 2>/dev/null) ; do
    _interactive_log "sourcing $I"
    # shellcheck source=.profile
    source "$I"
done
IFS=' '

################################################################################
# setup shell_control
################################################################################
# shellcheck source=.shell_control
source "$HOME/.shell_control" || echo "$(tput bold)error: ~/.shell_control not installed!$(tput sgr0)" >&2

################################################################################
# setup fasd
################################################################################
if type fasd >/dev/null 2>&1; then
    eval "$(fasd --init auto)"
fi

################################################################################
# always assume we want our default anaconda environment
################################################################################
_interactive_log "setting up conda environment"
enterconda || true

################################################################################
# setup zsh-autocompletions -- https://github.com/zsh-users/zsh-autosuggestions
################################################################################
if echo "$SHELL" | grep -q zsh; then
    _interactive_log "setting up zsh-autocompletions"
    # shellcheck source=.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    if [[ -s "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
        source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

        # Shift-{Left,Right}Arrow because Ctrl triggers Mission Control shortcuts
        bindkey '^[[1;2C' forward-word
        bindkey '^[[1;2D' backward-word

        # ESC should clear autosuggestions
        bindkey '\e' autosuggest-clear

        # Completions, history navigation, and kill line should clear autosuggestions
        export ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(
            accept-line
            complete-word
            down-line-or-history
            expand-or-complete
            expand-or-complete-prefix
            history-beginning-search-backward
            history-beginning-search-forward
            history-search-backward
            history-search-forward
            history-substring-search-down
            history-substring-search-up
            kill-line
            menu-complete
            menu-expand-or-complete
            up-line-or-history
        )

        # Better color for autosuggestions
        export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4"
    fi
fi

################################################################################
# setup rvm -- must go last otherwise rvm complains about PATH
################################################################################
_interactive_log "setting up rvm"
# shellcheck source=.rvm/scripts/rvm
test -s "$HOME/.rvm/scripts/rvm" && source "$_"
if type rvm >/dev/null 2>&1; then
    rvm use "$(rvm list default string)" >/dev/null
fi

_interactive_log "environment setup complete"

fi # if $INTERACTIVE
