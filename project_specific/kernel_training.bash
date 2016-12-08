#!/bin/bash

# alias for change dir to
alias cdp='cd $PROJECT_DIR'
alias cdb='cd $BUILD_DIR'

alias cdk='cd $SRC_KERNEL'
alias cdr='cd $SRC_ROOT'

alias cdbk='cd $BUILD_KERNEL'
alias cdbr='cd $BUILD_ROOT'

alias cdl='cd $LOCAL_DIR'

# download kernel sources from Git
function pull_kernel()
{
    if [ -d $SRC_KERNEL/.git ]
    then
        echo "$SRC_KERNEL already exists"
	return 0
    fi

    pushd $(pwd) > /dev/null

    mkdir -p $PROJECT_DIR
    mkdir -p $BUILD_KERNEL

    cd $PROJECT_DIR
    git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable
    cd linux-stable
    git checkout v4.8.6 -b work

    echo
    echo "Linux kernel sources is stored at"
    echo "   $SRC_KERNEL"
    echo "Buld directory for Linux kernel is"
    echo "   $BUILD_KERNEL"
    echo

    popd > /dev/null
}

# download rootfs sources from Git
function pull_rootfs()
{
    if [ -d $SRC_ROOT/.git ]
    then
        echo "$SRC_ROOT already exists"
	return 0
    fi

    pushd $(pwd) > /dev/null

    mkdir -p $PROJECT_DIR
    mkdir -p $BUILD_ROOT

    cd $PROJECT_DIR
    git clone git://git.buildroot.net/buildroot

    echo
    echo "rootfs sources is stored at"
    echo "   $SRC_ROOT"
    echo "Buld directory for rootfs is"
    echo "   $BUILD_ROOT"
    echo

    popd > /dev/null
}

function restore_rootfs()
{
    echo restore ${BUILD_ROOT}/images/rootfs.ext3
    cp -f ${BUILD_ROOT}/images/rootfs.ext3.backup ${BUILD_ROOT}/images/rootfs.ext3
}

function backup_rootfs()
{
    echo save ${BUILD_ROOT}/images/rootfs.ext3
    echo "  to  ${BUILD_ROOT}/images/rootfs.ext3.backup"
    cp -f ${BUILD_ROOT}/images/rootfs.ext3 ${BUILD_ROOT}/images/rootfs.ext3.backup
}

function emulate()
{
    qemu-system-i386 \
        -kernel ${BUILD_KERNEL}/arch/x86/boot/bzImage \
        -append "root=/dev/sda" \
        -hda ${BUILD_ROOT}/images/rootfs.ext3 \
        -redir tcp:8022::22 &
}

function connect()
{
    ssh -p 8022 user@localhost
}

function check_project_env()
{
    test ! -d $SRC_KERNEL && echo "Linux kernel source not found in $SRC_KERNEL Use 'pull_kernel' to download it."
    test ! -d $SRC_ROOT &&   echo "Linux rootfs source not found in $SRC_ROOT Use 'pull_rootfs' to download it."
}

check_project_env
