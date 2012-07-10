# Things done in non-login shells (and login shells…)

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# History config
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend


# When displaying prompt, write previous command to history file so that,
# any new shell immediately gets the history lines from all previous shells.
PROMPT_COMMAND='history -a'

# Misc config
# After each command, check window size and update LINES and 
#  COLUMNS variables.
shopt -s checkwinsize
# Enable completion
test -f /etc/bash_completion && . /etc/bash_completion


# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Exports
export EDITOR=vim
export PAGER="less -FirSwX"
export MANPAGER="less -FiRswX"


# Prompt
lred="\[\e[1;31m\]"
lgreen="\[\e[1;32m\]"
lyellow="\[\e[1;33m\]"
lblue="\[\e[1;34m\]"
lpurple="\[\e[1;35m\]"
lcyan="\[\e[1;36m\]"
lwhite="\[\e[1;37m\]"

dred="\[\e[0;31m\]"
dgreen="\[\e[0;32m\]"
dorange="\[\e[0;33m\]"
dblue="\[\e[0;34m\]"
dpurple="\[\e[0;35m\]"
dcyan="\[\e[0;36m\]"
dgrey="\[\e[0;37m\]"

reset="\[\e[0m\]"

PROMPT_COMMAND='prompt'

function gitdir()
{
        if [ -z "${1-}" ]; then
                if [ -n "${__git_dir-}" ]; then
                        echo "$__git_dir"
                elif [ -d .git ]; then
                        echo .git
                else
                        git rev-parse --git-dir 2>/dev/null
                fi
        elif [ -d "$1/.git" ]; then
                echo "$1/.git"
        else
                echo "$1"
        fi
}


function prompt()
{
  __res=$?
  if test $(gitdir)
  then
    # Git prompt
    local name=$(basename $(readlink -f "$(gitdir)"/..))
    local path=$(readlink -f "$(pwd)" | sed -re s,$(readlink -f "$(gitdir)"/..),,)
    local branch=$(git symbolic-ref HEAD 2>/dev/null)
    branch=${branch##refs/heads/}
    local dirty=""
    git diff --no-ext-diff --quiet --exit-code || dirty="C"
    test -n "$(git ls-files --others --exclude-standard)" && dirty="${dirty}U"
    test -n "$dirty" && dirty=" $dirty"
    PS1="$dblue($branch) $dgreen$name$lyellow$path$lpurple$dirty$reset "
  else
    # Normal prompt
    local name=$(pwd | sed -re s,$(readlink -f ~),,)
    local home=$(pwd | grep -E "^$(readlink -f ~)" > /dev/null 2> /dev/null && echo '~')
    PS1="$lyellow$home$dgreen$name$reset "
  fi
  PS1="$PS1\`test \$__res -eq 0 && echo -n '$lgreen'[✔] || echo -n '$lred'[✘]; echo $reset\`"
  PS1="$PS1$lwhite→$reset "
  export PS1=$PS1
}


# Path
export PATH=$PATH:$HOME/local/bin/
# Python 3
export PATH=$HOME/local/python/bin/:$PATH
# Darktable
export PATH=$HOME/local/darktable/bin/:$PATH
# nodejs
export PATH=$HOME/local/nodejs/bin/:$PATH
# jsctags (vim js plugin)
export NODE_PATH=/home/scharron/local/nodejs/lib/jsctags/:$NODE_PATH
