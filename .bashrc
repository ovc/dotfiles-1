# Erik Westrup's bashrc.
# NOTE Login shells read ~/.profile, normal and interactive shells read ~/.bashrc.

# Modeline {
#	vi: foldmarker={,} foldmethod=marker foldlevel=4: tabstop=4 shiftwidth=4:
# }

if [ -f $HOME/.shell_commons ] && [ -r $HOME/.shell_commons ]; then
	my_shell=bash
    completion_func=complete
    . $HOME/.shell_commons
fi

# Source global profile.
sourceifexists "/etc/profile"

# Set Vi command line editing mode. Not needed because it's set in ~/.inputrc.
#set -o vi

# Completion {
    # Complete @hostnames in a file with /ets/hosts format.
    HOSTFILE=/etc/hosts

    # Enable bash tab completion. Not needed with package 'bash-completion' installed.
    #complete -cf sudo
    #complete -cf man
# }

# pkgfile "command not found" hook.
sourceifexists /usr/share/doc/pkgfile/command-not-found.bash

# History {
	# Number lines to store in active bash session.
	export HISTSIZE=100000
	# Number lines to store in history file after session end.
	export HISTFILESIZE=100000
	# Don't put duplicate commands in the history.
	export HISTCONTROL="erasedups:ignoreboth"
	# Commands to ignore in history.
	# TODO poweroff logged somehow, why?
	export HISTIGNORE="&:[ ]*:exit:halt:poweroff:shutdown:reboot:xlogout:pm-hibernate:pm-suspend"
	# Append instead of overwrite history on exit.
	shopt -s histappend
	# Allow multiline commands as one command.
	shopt -s cmdhist
# }

# UI {
	# Source PS1 configuration.
	sourceifexists "$HOME/.bash_ps1"
	#source /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh

	# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
	shopt -s checkwinsize

	# Colored man pages.
	# Reference: https://wiki.archlinux.org/index.php/Man_Page#Colored_man_pages
	man() {
		env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
	}
# }

# Programs {
	# Sorce bashmarks.
	#sourceifexists $HOME/.local/bin/bashmarks.sh

	# Load rvm and gems to PATH.
    if [ -s "$HOME/.rvm/scripts/rvm" ]; then
    	. "$HOME/.rvm/scripts/rvm"
    fi

	type jump-bin >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		source $(jump-bin --bash-integration)/shell_driver
    	# Bashmark style aliases
    	alias g="jump"
    	alias s="jump --add"
    	alias d="jump --del"
    	alias l="jump --list"
	fi
# }


# Start X if we're at vt1.
# TODO start using systemd service when there is an official way of starting xorg in a user session.
type startx >/dev/null 2>&1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 && "$?" -eq 0 ]] && exec startx
