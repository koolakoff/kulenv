# Overview
**kulenv** - is a set of Linux environment configurations intended for simplify development process.
kulenv includes config of bash console environment and vim editor oriented for Git-based development process

**NOTE** this set of environment is based on default Ubuntu 14.04 configurations.

More info available on project wiki: https://github.com/koolakoff/kulenv/wiki

<br><br>

# Install #
Run install script:

    ./install.sh [-p <PROJECT_NAME>]

where

- `-p` installs extra environment for specified `PROJECT_NAME`. Currently supported: `kernel_training`

The install script saves previous configuration. **NOTE** if run script 2 time at once, it will rewrite saved backup

**NOTE** To apply bash settings restart terminal or run

    . ~/.bashrc

<br><br>

# Content #

**Bash commands**

* `cdm`    - cahnge dir to `$MYDIR` (default `~`)
* `edinfo` - edit info file `$MYDIR/info`
* `fw`     - Find Word - wrapper for recursive grep. Usage: 'fw regexp'
* `fws`    - same as fw but search only in C source
* `glog`   - beautified git log
* `restartbash` - reload environment
* `setenv` - saves/clear env variable to local config file
* `tg`     - build C-tags in current dir

**VIM**

* Apply indenting for C language
* Print line numbers
* Highlight search
* Bautify status line
* Add nmaps for git merge by vimdiff ('gl' for get local, 'gr' for get remote, 'gb' for get base)

**Other changes**

* print branch name in console invitation when inside git project tree
