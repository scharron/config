# Things done in non-login shells (and login shells…)

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# History config
HISTCONTROL=ignoredups
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# Misc config
# After each command, chez window size and update LINES and 
#  COLUMNS variables.
shopt -s checkwinsize
# Enable completion
. /etc/bash_completion


# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Exports
export EDITOR=vim
export PAGER="less -FirSwX"
export MANPAGER="less -FiRswX"


# Path
export PATH=$PATH:$HOME/local/bin/
# RoR config
export PATH=$PATH:/var/lib/gems/1.8/bin/
# Python 3
export PATH=$HOME/local/python/bin/:$PATH
export PATH=$HOME/local/darktable/bin/:$PATH

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
function prompt()
{
  __res=$?
  if test $(__gitdir)
  then
    # Git prompt
    local name=$(basename $(readlink -f $(__gitdir)/..))
    local path=$(readlink -f $(pwd) | sed -re s,$(readlink -f $(__gitdir)/..),,)
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
