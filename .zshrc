# Erik Westrup's zshrc.

# TODO Go throught zsh configuration manuals
# TODO build custom prompt, port .bash_ps1. Suse prompt has ugly space between path and >
# TODO check unset optons $(unsetopt)
# TODO exit status, git branch in PS1
# TODO consider joining command togheter, minimize shell startup time
# TODO document configuration
# TODO fomrat .zshrc and .bashrc, groupings. 4 space width indentation.
# TODO modeline not working in .zshrc
# TODO look at antigen, prezto or oh-my-zsh


# Modeline {
#	vi: foldmarker={,} filetype=zsh foldmethod=marker foldlevel=4: tabstop=4 shiftwidth=4:
# }

# Common shell settings.
if [[ -f $HOME/.shell_commons && -r $HOME/.shell_commons ]]; then
	my_shell=zsh
	completion_func=compctl
	source $HOME/.shell_commons
fi

# Environment {
	typeset -U path		# Don't att entry to path if it's already present.
	#path=(~/tmp $path)

	# Function paths.
	fpath=(~/.zsh_funcs $fpath)
# }

# Completion {
	zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
	zstyle ':completion:*' max-errors 3 numeric
	zstyle :compinstall filename '/home/erikw/.zshrc'
	# Visuaize and selectin with arrow keys in completion.
	zstyle ':completion:*' menu select
	# Complete options for aliases too.
	setopt completealiases
	# List files when cd-completing.
	#compdef _path_files cd

	# Honor LS_COLORs in completion.
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

	autoload -Uz compinit
	compinit -C

	# Ingore case in tab complete. http://www.rlazo.org/2010/11/18/zsh-case-insensitive-completion/
	zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
    	    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# }

# History {
	HISTFILE=~/.histfile		# Where to save history.
	HISTSIZE=100000
	SAVEHIST=10000

	setopt appendhistory		# Append to history write on exit, don't overwrite.
	setopt HIST_IGNORE_DUPS		# Dont save duplicate lines in history.
	setopt histignorealldups

	# TODO
	#nobanghist
	#extendedhistory
	#histfcntllock
	#histignorealldups
	#histignorespace
	#histnostore
	#histreduceblanks
	#histsavenodups
	#histverify
	#incappendhistory
# }

# UI {
	autoload -U colors && colors

	autoload -Uz promptinit
	promptinit
	prompt suse	# Prompt theme.

	# Fish like syntax highlightning on command line.
	if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
		source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	fi
# }

# ZLE {
	# Let  / search in vi mode.
	# Reference: http://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode
	autoload vi-search-fix
	zle -N vi-search-fix
	bindkey -M viins '\e/' vi-search-fix
# }

# Options {
	# TODO split out to different categories?
	setopt printexitvalue 		# Print abnormal exit status.
	setopt nohashdirs		# No need for rehash to find new binaries.
	unsetopt correct correct_all 	# Don't encourage sloppy typing.

	setopt longlistjobs		# Display PID when suspending processes.
	setopt auto_pushd		# Put old path in dirs stack.
	setopt pushd_ignore_dups	# No duplicates in dirs stack.
	setopt nobeep			# No beeps thanks@
	#setopt ksharrays		# Array are 0-indexed. NOTE breaks zsh functions plugins etc..
# }


# Bindings {
	bindkey -v				# vi command editing mode.
	bindkey '^[[Z' reverse-menu-complete	# Reverse select on shift tab in completion menu.
	bindkey "\ep"  insert-last-word		# Insert !$ with Alt-p.
	bindkey ' ' magic-space			# Expand !-commands on space.

	# Enable char deleteion on command from history.
	bindkey "^?" backward-delete-char
	bindkey "^H" backward-delete-char
	bindkey "^W" backward-kill-word
	bindkey "^U" backward-kill-line
# }

# Programs {
	# pkgfile "command not found" hook.
	sourceifexists /usr/share/doc/pkgfile/command-not-found.zsh

	# Shell bookmarks with jump. https://github.com/flavio/jump
	type jump-bin >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		source $(jump-bin --zsh-integration)
    	    	# Bashmark style aliases
    	    	alias g="jump"
    	    	alias s="jump --add"
    	    	alias d="jump --del"
    	    	alias l="jump --list"
		compctl -K _jump -S '' g	# Add completion to 'g' alias.
	fi

	# Gitignore boiler plate.
	if [ -d $HOME/src/gibo ]; then
		PATH="$PATH:$HOME/src/gibo"
		source $HOME/src/gibo/gibo-completion.zsh
	fi
# }



# Enable help command for zsh functions.
autoload -U run-help
autoload run-help-git run-help-svn run-help-svk
#unalias run-help
alias help=run-help



# Start X if we're at vt1.
# TODO start using systemd service when there is an official way of starting xorg in a user session.
type startx >/dev/null 2>&1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 && "$?" -eq 0 ]] && exec startx
