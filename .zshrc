# Erik Westrup's zshrc.
# TODO go throught files from $(pacman -Qo grml-zsh-config), then remove package.
# TODO document configuration
# TODO !! does not expand
# TODO PS! and PSX(path)
# TODO port/refactor .bashrc, .bash_aliases
# TODO convert .inputrc to zsh's zle
# TODO bashmarks
# TODO check unset optons $(unsetopt)
# TODO can't bachskapce/ctrl+h in command lined editing of command from history
# TODO migrade .bash_profile to .zshprofile?
# TODO look at antigen, prezto or oh-my-zsh
# TODO consider joining command togheter, minimize shell startup time
# TODO build custom prompt, port .bash_ps1

# Modeline {
#	 vi: foldmarker={,} foldmethod=marker foldlevel=8: tabstop=8:
# }

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

# Completion {
	zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
	zstyle ':completion:*' max-errors 3 numeric
	zstyle :compinstall filename '/home/erikw/.zshrc'
	# Visuaize and selectin with arrow keys in completion.
	zstyle ':completion:*' menu select
	# Complete options for aliases too.
	setopt completealiases

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

TERM=xterm

bindkey -v	# Use vi command editing mode.


setopt printexitvalue # Print abnormal exit status.



# pkgfile "command not found" hook
source /usr/share/doc/pkgfile/command-not-found.zsh


# Enable help command for zsh functions.
autoload -U run-help
autoload run-help-git run-help-svn run-help-svk
#unalias run-help
alias help=run-help


setopt nohashdirs	# No need for rehash to find new binaries.
