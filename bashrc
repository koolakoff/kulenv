#!/bin/bash
# Local bash environment configuration

###############################
# Local Environment variables #
###############################

test -f ~/.bash.env && . ~/.bash.env

###############################
# General Alias and Functions #
###############################

test -z $EDITOR && EDITOR=vim

test -z $MYDIR && MYDIR=~

# search for word in all files and folders in current dir
alias fw='grep -R ./ --exclude-dir='.git' -H --color -n -e'

# search for word in all C source and headers files and folders in current dir
alias fws='grep -R ./ --exclude-dir='.git' --include="*.[ch]" -H --color -n -e'

# reset bashrc
alias resetbash='. ~/.bashrc'

# My dir and my temp files
alias cdm='cd $MYDIR'
alias setm='echo old MYDIR was $MYDIR ; setenv MYDIR $(pwd)'
alias edinfo='$EDITOR $MYDIR/info'

# Save/clear variable to local ~/.bash.env file
#   setenv VAR [VAL]
# where
#   - VAR - name of variable
#   - VAL - value (if empty, delete the variable)
function setenv()
{
    local sedcmd=''

    test $# == 0 && echo "wrong params"

    if [ $# == 1 ]
    then
        echo "Remove $1 param from ~/.bash.env"
        # just exit if there is no env file
        test -f ~/.bash.env || return 0
        # delete line
        sedcmd="/^export\ $1/d"
        sed -i -e "$sedcmd" ~/.bash.env
    elif [ $# == 2 ]
    then
        echo -e "Set $1 param from ~/.bash.env to '$2' value"
        # create env file if there was no one
        test -f ~/.bash.env || echo '#!/bin/bash' >  ~/.bash.env
        # check if var not exists
        if [ -z "$(grep -e $1 ~/.bash.env)" ]
        then
            # add var if it was not present in env file
            echo "export $1=$2" >> ~/.bash.env
        else
            # update var if it was already devined
            sedcmd="s/^export\ $1.*/export\ $1=${2//\//\\\/}/"
            sed -i -e "$sedcmd" ~/.bash.env
        fi
    else
        echo "wrong params"
    fi

    source ~/.bash.env

    return
}

# generate C tags
#  reuses tags file for current dir
function tgl()
{
        ctags -a -R --languages=C,C++ --c++-kinds=+p --fields=+iaS --extra=+q . $@
}

#  reuses tags file including project dir, if not exists, generates it (uses $PROJECT_DIR/taglist)
function tg()
{
    # generate tags for project tree if 'taglist' file with dir list exists
    # otherwares generate tags only for current dir
    if [ -f $PROJECT_DIR/taglist ]
    then
        test -f $PROJECT_DIR/tags || ctags -a -R --languages=C,C++ --c++-kinds=+p --fields=+iaS --extra=+q -L $PROJECT_DIR/taglist -o $PROJECT_DIR/tags
        test -f tags || cp $PROJECT_DIR/tags ./
        ctags -a -R --languages=C,C++ --c++-kinds=+p --fields=+iaS --extra=+q -L $PROJECT_DIR/taglist . $@
    else
        tgl $@
    fi
}


###########################
# Git Alias and Functions #
###########################

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
test -f ~/.bash.$MY_PROJECT && . ~/.bash.$MY_PROJECT
