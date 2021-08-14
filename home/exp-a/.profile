# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export PATH="$PATH:/opt/intelFPGA/20.1/quartus/bin:/opt/intelFPGA/20.1/nios2eds/bin:/opt/intelFPGA/20.1/modelsim_ase/bin"
export QSYS_ROOTDIR="/opt/intelFPGA_lite/20.1/quartus/sopc_builder/bin"
export QUARTUS_ROOTDIR_OVERRIDE="/opt/intelFPGA/20.1/quartus"
export QUARTUS_64BIT=1

export QSYS_ROOTDIR="/opt/intelFPGA/20.1/quartus/sopc_builder/bin"
