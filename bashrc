#!/bin/bash
# Local bash environment configuration

# search for word in all files and folders in current dir
alias fw='grep -R ./ --exclude-dir='.git' -H --color -n -e'

# search for word in all C source and headers files and folders in current dir
alias fws='grep -R ./ --exclude-dir='.git' --include="*.[ch]" -H --color -n -e'

# generate C tags
alias tg='ctags -R --languages=C,C++ --c++-kinds=+p --fields=+iaS --extra=+q'



# GIT commands

alias glog='git log --graph --oneline --decorate --all --color'
