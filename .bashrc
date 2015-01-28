# Erik Westrup's bashrc.
# NOTE Login shells read ~/.profile, normal and interactive shells read ~/.bashrc.

# Modeline {
#	 vi: foldmarker={,} foldmethod=marker foldlevel=0: tabstop=8:
# }

# Source file if it exists.
sourceifexists() {
	local prog="$1"
	if [ -f "$prog" ]; then
		source "$prog"
	fi
}

# If not running interactively, don't do anything.
#[ -z "$PS1" ] && return

# Source global profile.
sourceifexists "/etc/profile"

# Paths {
	# Include system binaries.
	PATH="$PATH:/sbin:/usr/sbin"
	# Include binaries in home directory.
	PATH="$HOME/bin/:$PATH"

	# Set common bin paths.
	#PATH=${PATH}:$(find ~/bin -maxdepth 2 -type d | tr '\n' ':' | sed 's/:$//')
	common_bin_dirs=(mutt mkdirs)
	for common_dir in "${common_bin_dirs[@]}"; do
		if [ -d "$HOME/bin/$common_dir" ]; then
			PATH="$PATH:$HOME/bin/$common_dir"
		fi
	done
	export PATH
# }

# Environment {
	# Set Vi command line editing mode. Not needed because it's set in ~/.inputrc.
	#set -o vi

	# Use THE text editor.
	export EDITOR='vim'
	export VISUAL='vim'
	export CSHEDIT='vim'

	# and the only pager.
	export PAGER='less'

	# Source aliases.
	if [ -f "$HOME/.bash_aliases" ]; then
		. $HOME/.bash_aliases
	fi

	# Let others know what underlying terminal emulator is used. This is needed since $TERM does not always represent the real terminal e.g. in tmux when you want colors.
	export TERMEMU="urxvt"

	# Complete @hostnames in a file with /ets/hosts format.
	HOSTFILE='/etc/hosts'

	# Convenient cdpaths.
	#CDPATH=$HOME

	# Enable forward history search with ^s
	#stty stop ""

	# Enable bash tab completion. Not needed with package 'bash-completion' installed.
	#complete -cf sudo
	#complete -cf man

	# Web browser to use. urlscan (and others?) uses this variable.
	export BROWSER=firefox

    	# Current DE in use.
	export DESKTYPE='dwm'

	if [ "$DESKTYPE" == "dwm" ]; then
	    # Java does not know about dwm so GUI apps will not be displayed correctly (if at all).
	    # Reference: https://wiki.archlinux.org/index.php/Dwm#Fixing_misbehaving_Java_applications
	    export _JAVA_AWT_WM_NONREPARENTING=1
	fi

	type clang >/dev/null 2>&1
	if [ "$?" -eq 0 ]; then
    	    export CC=clang
    	    export CXX=clang++
    	fi

# }

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

	# Solarized ls colors.
	if [ -f "$HOME/.dircolorsrc" ]; then
		eval `dircolors $HOME/.dircolorsrc`
	fi

	# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
	shopt -s checkwinsize

	# If this is an xterm set the title to user@host:dir
	case "$TERM" in
		xterm*|rxvt*)
			export TERM=xterm-256color
			PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
			;;
		screen)
			export TERM=screen-256color
			PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
			;;
		*)
			;;
	esac

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

	# Source bash functions.
	if [ -f "$HOME/.bash_functions" ]; then
		. $HOME/.bash_functions
	fi

	# Tell gPodder to reside in multimedia directory. KDE4 uses ~/.kde4/env/
	export GPODDER_HOME="$HOME/media/music/gPodder"

	# Source MPD environment variables.
	sourceifexists "$HOME/.mpd_env"

	# Sorce bashmarks.
	sourceifexists "$HOME/.local/bin/bashmarks.sh"

	# SSH agent. Source bash file if not connected from a remote SSH.
	#if [ -z "$SSH_CLIENT" ] && [ -f "$HOME/.ssh-agent" ]; then
		#. $HOME/.ssh-agent
	#fi

	# Set up ros environment.
	sourceifexists "$HOME/bin/ros/setup.bash"

	# Tmuxifier path and initialization.
	export TMUXIFIER="$HOME/src/tmuxifier"
	sourceifexists "$TMUXIFIER/init.sh"
	# Custom path for layouts.
	export TMUXIFIER_LAYOUT_PATH="$HOME/.tmuxifier-layouts"

	# Tmuxifier initialization.
	sourceifexists "$HOME/.tmuxinator/scripts/tmuxinator"
	if [ -d "$HOME/src/tmuxinator/bin/" ]; then
		export PATH="$PATH:$HOME/src/tmuxinator/bin/"
		source "$HOME/src/tmuxinator/bin/tmuxinator_completion"
	fi

	# Gitignore fetcher Gibo bin and completion.
	if [ -d "$HOME/src/gitignore-boilerplates/" ]; then
		PATH="$PATH:$HOME/src/gitignore-boilerplates/"
		source "$HOME/src/gitignore-boilerplates/gibo-completion.bash"
	fi

	# Dot files manager.
	if [ -d "$HOME/.dotfiles/bin" ]; then
		PATH="$PATH:$HOME/.dotfiles/bin"
	fi

	# lastfm-mpd-cli
	if [ -d "$HOME/src/lastfm-mpd-cli/" ]; then
		PATH="$PATH:$HOME/src/lastfm-mpd-cli/"
	fi

	# svtget
	if [ -d "$HOME/src/svtget/" ]; then
		PATH="$PATH:$HOME/src/svtget/"
	fi

	# youtube2mp3.sh
	if [ -d "/opt/youtube2mp3/" ]; then
		PATH="$PATH:/opt/youtube2mp3/"
	fi

	# Add ANSI color output to ant.
	type ant >/dev/null 2>&1
	if [ "$?" -eq 0 ]; then
		export ANT_ARGS='-logger org.apache.tools.ant.listener.AnsiColorLogger'
	fi

	# Use perl GCC color wrapper if it exists.
	if [ -d "/usr/lib/colorgcc/" ]; then
	    export PATH="$PATH:/usr/lib/colorgcc/bin"
	fi

	# Add tab completion to daemonize.
	type ant >/dev/null 2>&1
	if [ "$?" -eq 0 ]; then
	    complete -cf daemonize
	fi

	# Ruby version manager.
	if [ -f "$HOME/.rvm/scripts/rvm" ]; then
	    source $HOME/.rvm/scripts/rvm
	    PATH="$PATH:$HOME/.rvm/bin"
	fi

	# Tab complete for viw.
	type viw >/dev/null 2>&1
	if [ "$?" -eq 0 ]; then
	    complete -cf viw
	fi

	# Go
    	export GOPATH="$HOME/src/godeps/:$HOME/dev/go"
    	export GOROOT="$HOME/src/go"
    	export PATH="$PATH:$HOME/src/godeps/bin/:$HOME/dev/go/bin:$GOROOT/bin:$GOROOT/pkg/tool/linux_amd64"

    	# cdw
    	sourceifexists "$HOME/bin/cdw"

	# less {
		# Syntax highlighting for less with src-highlight.
		type src-hilite-lesspipe.sh  &> /dev/null
		if [ "$?" -eq 0 ]; then
			export LESSOPEN="| src-hilite-lesspipe.sh %s"
		fi
		#LESS="$LESS --no-lessopen"		# Disable usage of LESSOPEN.
		LESS="$LESS --RAW-CONTROL-CHARS"	# Display colors.
		LESS="$LESS --ignore-case"		# Case insensitive search. However using capital letter(s) will enable case sensitive search.
		LESS="$LESS --status-column"		# Status column with number of lines etc.
		#LESS="$LESS --LINE-NUMBERS"		# Show line numbers.
		#LESS="$LESS --mouse-support"		# TODO Some lessess seems to have this option. What does it do?
		export LESS
	# }

	# Sage {
		if [ -d "$HOME/bin/sage3.0" ]; then
			export SAGE_DIRECTORY="$HOME/bin/sage3.0"
			export PATH="$PATH:${SAGE_DIRECTORY}/bin"
			if [ -z ${LD_LIBRARY_PATH} ]; then
				export LD_LIBRARY_PATH="${SAGE_DIRECTORY}/lib"
			else
				export LD_LIBRARY_PATH="${SAGE_DIRECTORY}/lib:${LD_LIBRARY_PATH}"
			fi
		fi
	# }

	# Android SDK
	if [ -d "$HOME/src/android-sdk-linux/" ]; then
    	    export PATH="$HOME/src/android-sdk-linux/tools/:$HOME/src/android-sdk-linux/platform-tools/:$PATH"
	fi
# }

# Start X if we're at vt1.
# TODO start using systemd service when there is an official way of starting xorg in a user session.
type startx >/dev/null 2>&1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 && "$?" -eq 0 ]] && exec startx
