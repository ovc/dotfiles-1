# Erik Westrup's bashrc.
# NOTE Login shells read ~/.profile, normal and interactive shells read ~/.bashrc.

# Modeline {
#	 vi: foldmarker={,} foldmethod=marker foldlevel=0: tabstop=8:
# }

# If not running interactively, don't do anything.
#[ -z "$PS1" ] && return

# Paths {
	# Fins system binaries.
	PATH="$PATH:/sbin:/usr/sbin"
	# Include binaries in home directory.
	PATH="$HOME/bin/:$PATH"

	# Set common bin paths.
	#PATH=${PATH}:$(find ~/bin -maxdepth 2 -type d | tr '\n' ':' | sed 's/:$//')
	common_bin_dirs=(android-sdk-linux/tools android-sdk-linux/platform-tools arm-2010q1/bin mutt mkdirs)
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
# }

# History {
	# Don't put duplicate commands in the history.
	export HISTCONTROL="erasedups:ignoreboth"
	# History limits.
	export HISTFILESIZE=600000
	export HISTSIZE=100000
	# Commands to ignore.
	export HISTIGNORE="&:[ ]*:exit:halt:poweroff:shutdown:reboot:xlogout"
	# Append instead of overwrite history on exit.
	shopt -s histappend
	# Allow multiline commands as one command.
	shopt -s cmdhist
# }

# Source file if it exists.
sourceif() {
	local prog="$1"
	if [ -f "$prog" ]; then
		source "$prog"
	fi
}

# UI {
	# Source PS1 configuration.
	sourceif "$HOME/.bash_ps1"

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
	# Tell gPodder to reside in multimedia directory. KDE4 uses ~/.kde4/env/
	export GPODDER_HOME="$HOME/media/music/gPodder"

	# Source MPD environment variables.
	sourceif "$HOME/.mpd_env"

	# Sorce bashmarks.
	sourceif "$HOME/.local/bin/bashmarks.sh"

	# SSH agent. Source bash file if not connected from a remote SSH.
	if [ -z "$SSH_CLIENT" ] && [ -f "$HOME/.ssh-agent" ]; then
		. $HOME/.ssh-agent
	fi

	# Set up ros environment.
	sourceif "$HOME/bin/ros/setup.bash"

	# Tmuxifier path and initialization.
	export TMUXIFIER="$HOME/src/tmuxifier"
	sourceif "$TMUXIFIER/init.sh"
	# Custom path for layouts.
	export TMUXIFIER_LAYOUT_PATH="$HOME/.tmuxifier-layouts"

	# Tmuxifier initialization.
	sourceif "$HOME/.tmuxinator/scripts/tmuxinator"
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

	# Add ANSI color output to ant.
	type ant >/dev/null 2>&1
	if [ "$?" -eq 0 ]; then
		export ANT_ARGS='-logger org.apache.tools.ant.listener.AnsiColorLogger'
	fi


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
			export PATH=${SAGE_DIRECTORY}/bin:${PATH}
			if [ -z ${LD_LIBRARY_PATH} ]; then
				export LD_LIBRARY_PATH=${SAGE_DIRECTORY}/lib
			else
				export LD_LIBRARY_PATH=${SAGE_DIRECTORY}/lib:${LD_LIBRARY_PATH}
			fi
		fi
	# }
# }
