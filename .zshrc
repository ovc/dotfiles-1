# Erik Westrup's zshrc.

# Modeline {
#	vi: foldmarker={,} filetype=zsh foldmethod=marker foldlevel=0: tabstop=4 shiftwidth=4:
# }

# Common shell settings.
if [[ -f $HOME/.shell_commons && -r $HOME/.shell_commons ]]; then
	export my_shell=zsh
	export completion_func=compctl
	source $HOME/.shell_commons
fi

# Environment {
	typeset -U path		# Don't add entry to path if it's already present.
	#path=(~/tmp $path)

	# Function paths.
	fpath=(~/.zsh_funcs $fpath)
# }

# Completion {
	zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
	zstyle ':completion:*' max-errors 3 numeric
	# Visualize and selecting with arrow keys in completion.
	zstyle ':completion:*' menu select
	# Remove slash from completed directory.
	zstyle ':completion:*' squeeze-slashes true
	# Cache completions.
	zstyle ':completion:*' use-cache onzstyle ':completion:*' use-cache on
	# Honor LS_COLORs in completion.
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
	# Ignore case in tab complete. http://www.rlazo.org/2010/11/18/zsh-case-insensitive-completion/
	zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
    	    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    	# Completing process IDs with menu selection:
	zstyle ':completion:*:*:kill:*' menu yes select
	zstyle ':completion:*:kill:*'   force-list always
	# Style if no matching completion is found.
	zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

	# Complete options for aliases too.
	setopt completealiases
	# List files when cd-completing.
	#compdef _path_files cd

	autoload -Uz compinit
	compinit -C
# }

# History {
	export HISTFILE=~/.zsh_histfile		# Where to save history.
	export HISTSIZE=100000
	export SAVEHIST=10000
	export HISTIGNORE="poweroff:reboot:[bf]g:nano"

	setopt appendhistory		# Append to history write on exit, don't overwrite.
	setopt histignoredups		# Don't save immediate duplicates lines in history.
	setopt histignorespace		# Ignore commands starting with space.
	setopt extendedhistory		# Save command time start and exec time in seconds.
	setopt histreduceblanks		# Strip redundant spaces.
# }

# UI {
	autoload -U colors && colors

	#autoload -Uz promptinit
	#promptinit
	#prompt suse	# Prompt theme.

	# Fish like syntax highlighting on command line.
	if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
		source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	fi
# }

# Options {
	# Manual & categories: http://zsh.sourceforge.net/Doc/Release/Options.html

	# Changing Directories {
		setopt autopushd		# Add prev PWD to directory stack.
		setopt pushdignoredups	# No duplicates in dirs stack.
		setopt pushdignoredups		# Don't record immediate duplicates.
		setopt pushdtohome		# pushd with no args pushes $HOME.
		#setopt chaselinks		# Go to full destination of symlinks.
	# }

	# Input/Output {
		unsetopt correct correctall 	# Don't encourage sloppy typing.
		#setopt nohashdirs		# No need for rehash to find new binaries.
		#setopt printexitvalue 		# Print abnormal exit status.
	# }

	# Job Control  {
		setopt longlistjobs		# Display PID when suspending processes.
	# }

	# Shell Emulation # {
		#setopt ksharrays		# Array are 0-indexed. NOTE breaks zsh functions plugins etc..
		setopt shnullcmd		# Truncate like in bash e.g. $(>file).
	# }

	# ZLE {
		setopt nobeep			# No beeps thanks!
	#}
# }

# Bindings {
	bindkey -v								# vi command editing mode.
	export KEYTIMEOUT=1						# Set ESC to normal mode timout to 10 ms.
	bindkey '^[[Z' reverse-menu-complete	# Reverse select on shift tab in completion menu.
	bindkey "\ep"  insert-last-word			# Insert !$ with Alt-p.
	bindkey ' ' magic-space					# Expand !-commands on space.
	bindkey "^R" history-beginning-search-backward # Complete from history with prefix
	bindkey "^S" history-beginning-search-forward # Complete from history with prefix

	# Enable char deleteion on command from history.
	bindkey "^?" backward-delete-char
	bindkey "^H" backward-delete-char
	bindkey "^W" backward-kill-word
	bindkey "^U" backward-kill-line
# }

# ZLE {
	# Let  / search in vi mode. Defined in ~/.zsh_funcs/vi-search-fix
	# Reference: http://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode
	autoload vi-search-fix
	zle -N vi-search-fix
	bindkey -M viins '\e/' vi-search-fix

	# Visual mode in vi-mode, like in bash.
	autoload -U edit-command-line
	zle -N edit-command-line
	bindkey -M vicmd v edit-command-line
# }

# zsh extras {
	# Enable help command for zsh functions.
	autoload -U run-help
	autoload run-help-git run-help-svn run-help-svk
	#unalias run-help
	alias help=run-help
# }

# Programs {
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

# Powerline {
	if [ -d $POWERLINE_ROOT ]; then
		source $POWERLINE_ROOT/bindings/zsh/powerline.zsh
	fi
# }

sourceifexists $HOME/.shell_startx
