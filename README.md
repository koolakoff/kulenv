# Overview
**kulenv** - is a set of Linux environment configurations intended for simplify development process.
kulenv includes config of bash console environment and vim editor oriented for Git-based development process

**NOTE** this set of environment is based on default Ubuntu 14.04 configurations.

More info available on project wiki: https://github.com/koolakoff/kulenv/wiki

<br><br>

# Install #
Run install script:

    ./install.sh

The install script saves previous configuration. **NOTE** if run script 2 time at once, it will rewrite saved backup

**NOTE** To apply bash settings restart terminal or run

    . ~/.bash.${USER}

<br><br>

# Content #

**Bash commands**

* fw   - Find Word - wrapper for recursive grep. Usage: 'fw regexp'
* fws  - same as fw but search only in C source
* glog - beautified git log

**VIM**

* Apply indenting for C language
* Print line numbers
* Highlight search
* Bautify status line

**Other changes**

* print branch name in console invitation when inside git project tree
