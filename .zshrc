# Erik Westrup's zshrc.

# TODO fomrat .zshrc and .bashrc, groupings. 4 space width indentation.
# TODO migrade .bash_profile to .zshprofile?
# TODO go throught files from $(pacman -Qo grml-zsh-config), then remove package.
# TODO document configuration
# TODO PS! and PSX(path)
# TODO port/refactor .bashrc, .bash_aliases
# TODO convert .inputrc to zsh's zle
# TODO check unset optons $(unsetopt)
# TODO can't bachskapce/ctrl+h in command lined editing of command from history
# TODO look at antigen, prezto or oh-my-zsh
# TODO build custom prompt, port .bash_ps1. Suse prompt has ugly space between path and >
# TODO consider joining command togheter, minimize shell startup time
# TODO modeline not working in .zshrc
# TODO / in normal mode does not search history http://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode


# Modeline {
#	vi: foldmarker={,} foldmethod=marker foldlevel=4: tabstop=4 shiftwidth=4:
# }

# Common shell settings.
if [[ -f $HOME/.shell_commons && -r $HOME/.shell_commons ]]; then
	my_shell=zsh
	completion_func=compctl
	. $HOME/.shell_commons
fi

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
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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
	fi
# }

bindkey -v	# Use vi command editing mode.


setopt printexitvalue # Print abnormal exit status.


unsetopt correct correct_all 	# Don't encourage sloppy typing.


# Honor LS_COLORs in completion.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


# pkgfile "command not found" hook.
sourceifexists /usr/share/doc/pkgfile/command-not-found.zsh


# Enable help command for zsh functions.
autoload -U run-help
autoload run-help-git run-help-svn run-help-svk
#unalias run-help
alias help=run-help


setopt nohashdirs	# No need for rehash to find new binaries.

# Unset stupid vim function from /etc/zsh/zshrc.
unfunction vim


# Bindings {
	bindkey '^[[Z' reverse-menu-complete		# Reverse select on shift tab in completion menu.
# }

# Start X if we're at vt1.
# TODO start using systemd service when there is an official way of starting xorg in a user session.
type startx >/dev/null 2>&1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 && "$?" -eq 0 ]] && exec startx
