#!/usr/bin/env bash
# Install the macOS apps I use, using brew, cask and pip.

make_1line() {
	echo "$1" | tr '\n' ' '
}

read -r -d '' brew_apps_default <<'EOAPPS'
	ack
	aspell
	cloc
	cmatrix
	cowsay
	cscope
	ctags
	ctags
	curl
	curl
	dfc
	dos2unix
	elinks
	emacs
	git
	git
	graphviz
	htop-osx
	htop-osx
	httpie
	imagemagick
	ipython
	irssi
	links
	macvim
	macvim
	ncdu
	pdfgrep
	pyenv
	pyenv-virtualenvwrapper
	python
	python3
	readline
	reattach-to-user-namespace
	source-highlight
	task
	tasksh
	tig
	tig
	tmux
	tmux
	tree
	tree
	urlview
	vim
	vim
	watch
	watch
	wego
	wget
	zsh
EOAPPS
brew_apps_default=$(make_1line "$brew_apps_default")

read -r -d '' brew_apps_additional <<'EOAPPS'
EOAPPS
brew_apps_additional=$(make_1line "$brew_apps_additional")


read -r -d '' cask_apps_default <<'EOAPPS'
	appcleaner
	caffeine
	clamxav
	clipmenu
	colloquy
	cyberduck
	dropbox
	electric-sheep
	firefox
	flip4mac
	flux
	gimp
	google-chrome
	gpgtools
	handbrake
	iterm2
	jing
	karabiner-elements
	libreoffice
	mactex
	macvim
	name-mangler
	postman
	qr-journal
	skype
	spotify
	spotify-notifications
	the-unarchiver
	transmission
	vlc
	wireshark
EOAPPS
cask_apps_default=$(make_1line "$cask_apps_default")

read -r -d '' cask_apps_additional <<'EOAPPS'
	1password
	adium
	caffeine
	chicken
	eclipse-ide
	google-drive
	keepassx
	perian
	pycharm
	skim
	slack
	thunderbird
	virtualbox
	xee
	yasu
	zeplin
EOAPPS
cask_apps_additional=$(make_1line "$cask_apps_additional")

# virtualenvwrapper needs to be installed for brew's pyenv-virtualenvwrapper, python2, it seems :O
read -r -d '' pip2_pkgs <<'EOAPPS'
	virtualenvwrapper
EOAPPS
pip2_pkgs=$(make_1line "$pip2_pkgs")

read -r -d '' pip3_pkgs <<'EOAPPS'
	ipdb
	ipython
	powerline-status
	pudb
	ropevim
EOAPPS
pip3_pkgs=$(make_1line "$pip3_pkgs")


# Manual install programs.
#easytag


# Install homebrew.
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install $brew_apps_default
brew install $brew_apps_additional

brew tap homebrew/science
brew install octave


# Install cask.
brew tap caskroom/cask
brew cask install $cask_apps_default
brew cask install $cask_apps_additional


# Install python packages.
pip2 install --user $pip2_pkgs
pip3 install --user $pip3_pkgs
