#!/bin/bash
# Install environment config files

# local variables
show_help=
project=

##############
# VIM config #
##############
function vim_config()
{
    # backup original settings
    if [ -f ~/.vimrc ]
    then
        echo "  Save original .vimrc to ~/vimrc.old"
        cp ~/.vimrc ~/vimrc.old
    fi
    # apply new settings
    cp vimrc ~/.vimrc
}


#######################
# BASH console config #
#######################
function bash_config()
{
    if [ -f ~/.bashrc ]
    then
        # add auto init of ~/.bash.${USER} to ~/.bashrc
        if [[ -z $(grep  -e "\.bash\.\${USER}" ~/.bashrc) ]]
        then
            # backup original settings
            echo "  Save original .bashrc to ~/bashrc.old"
            cp ~/.bashrc ~/bashrc.old
    
	    # add automatic apply of user settings
            echo 'test -f ~/.bash.${USER} && . ~/.bash.${USER}' >> ~/.bashrc
        fi
    fi
    # backup original user settings
    if [ -f ~/.bash.${USER} ]
    then
        echo "  Save original .bash.${USER} to ~/bash.${USER}.old"
        cp ~/.bash.${USER} ~/bash.${USER}.old
    fi
    # apply new settings
    cp bashrc ~/.bash.${USER}
}


########################
# Local project config #
########################
function bash_project_specific_config()
{
    if [ -f project_specific/bash.project-$project ]
    then
        cp project_specific/bash.project-$project ~/.bash.project
    else
        echo "  Error! Cannot install project-specific config. Project $project unrecognized"
    fi
}

function install_all()
{
    # Process the command line options (if any)

    args=$(getopt --name $FUNCNAME --unquoted --options "hp:" --longoptions "help,project:" -- "$@") || return 1
    eval set -- "$args"
    until [[ $1 == "--" ]]
    do
        case $1 in
            '-h' | '--help'    ) show_help=1 ;;
            '-p' | '--project' ) project=${2-} ; shift ;;
            *                ) echo >&2 "Error - invalid parameter '$1'!" ; return 1 ;;
        esac
        shift
    done
    shift

    # Show help information
    if (( show_help == 1 ))
    then
        echo "Install environment on your host"
        echo "Command line format: $0 [-h|--help] [-p|--project Project_name]"
        echo ""
        echo "Where:"
        echo "    -h or --help                 - Display this help information"
        echo "    -p or --project PROJECT_NAME - name of project for install of project-specific setting"
        echo ""

        return 0
    fi


    echo "Installing VIM config..."
    vim_config
    
    echo "Installing BASH config..."
    bash_config
    
    if [ ! -z $project ]
    then
        echo "Installing BASH project-specific config for ${project}..."
        test -f project_specific/${project}.install.sh && . project_specific/${project}.install.sh
    fi

    echo "Done"
    echo
    echo "to apply changes restart terminal or run '. ~/.bashrc' or run 'resetbash' command"
}

install_all $@
