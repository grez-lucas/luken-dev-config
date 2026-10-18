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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


# Added by Antigravity CLI installer
export PATH="/home/luken/.local/bin:$PATH"

# Go and brew CLI tools, for the graphical session.
#
# The desktop session sources this file but never ~/.zshenv, so a GUI-launched
# nvim would otherwise have no `go` and gopls/Mason/golangci-lint would fail to
# start. This is the PATH half of ~/.config/environment.d/10-go.conf, which
# cannot set PATH: systemd 255 filters that one variable out.
#
# brew's `go` formula is the single Go install and is not keg-only, so brew's
# bin dir covers go, buf and the rest. Keep in step with ~/.zshenv.
export PATH="/home/linuxbrew/.linuxbrew/bin:$HOME/go/bin:$PATH"
. "$HOME/.cargo/env"
