# Erik Westrup's zshrc.
# TODO bring all options from bashrc. Maybe refactor out the common parts like setting of $PATH.

# Modeline {
#	 vi: foldmarker={,} foldmethod=marker foldlevel=0: tabstop=8:
# }

# Completion {
	zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
	zstyle ':completion:*' max-errors 3 numeric
	zstyle :compinstall filename '/home/erikw/.zshrc'

	autoload -Uz compinit
	compinit
# }

# History {
	HISTFILE=~/.zsh_histfile # TODO use $HOME?
	HISTSIZE=10000
	SAVEHIST=100000
	setopt appendhistory
# }
autoload -U colors && colors

autoload -Uz promptinit
promptinit

prompt suse

TERM=xterm

bindkey -v	# Use vi mode.
