#!/bin/bash
# Install environment config files


##############
# VIM config #
##############

echo "Installing VIM config..."
# backup original settings
if [ -f ~/.vimrc ]
then
    echo "  Save original .vimrc to ~/vimrc.old"
    cp ~/.vimrc ~/vimrc.old
fi
# apply new settings
cp vimrc ~/.vimrc


#######################
# BASH console config #
#######################
echo "Installing BASH config..."
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

echo "Done"
echo
echo "to apply changes restart terminal or run '. ~/.bashrc'"
