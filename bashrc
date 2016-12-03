#!/bin/bash
# Local bash environment configuration

#######################
# Alias and Functions #
#######################

# search for word in all files and folders in current dir
alias fw='grep -R ./ --exclude-dir='.git' -H --color -n -e'

# search for word in all C source and headers files and folders in current dir
alias fws='grep -R ./ --exclude-dir='.git' --include="*.[ch]" -H --color -n -e'

# generate C tags
alias tg='ctags -R --languages=C,C++ --c++-kinds=+p --fields=+iaS --extra=+q'

# GIT commands
alias glog='git log --graph --oneline --decorate --color'

parse_git_branch() 
{
    test "xtrue" == "x$(git rev-parse --is-inside-work-tree 2>/dev/null)" && git branch | grep -e "^\*"| sed "s/^..\(.*\)/\1 /"
}

################
#   Settings   #
################

# color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]$(parse_git_branch)\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]\$ '

# config history size
HISTSIZE=5000
HISTFILESIZE=20000

####################
# Project specific #
####################
test -f ~/.bash.project && . ~/.bash.project
