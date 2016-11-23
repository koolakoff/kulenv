# Overview
**kulenv** - is a set of Linux environment configurations intended for simplify development process.
kulenv includes config of bash console environment and vim editor oriented for Git-based development process

**NOTE** this set of environment is based on default Ubuntu 14.04 configurations.

<br><br>

# Install #
**VIM config**

Copy `vimrc` to home directory with `.vimrc` name:

    $ cp vimrc ~/.vimrc

**Bash config**

Copy `bashrc` to home directory with `.bash.$USER` name:

    $ cp bashrc ~/.bash.$USER

and insert the following lines to your `~/.bashrc` config file:

    [[ -f ~/.bash.${USER} ]]   && . ~/.bash.${USER}

Note, to enable colored console invitation you should uncomment `#force_color_prompt=yes` line in your `~/.bashrc`
