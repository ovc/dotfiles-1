#!/usr/bin/env bash

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
	wget
	zsh
EOAPPS
brew_apps_default=$(make_1line "$brew_apps_default")

read -r -d '' brew_apps_additional <<'EOAPPS'
EOAPPS
brew_apps_additional=$(make_1line "$brew_apps_additional")


read -r -d '' cask_apps_default <<'EOAPPS'
	appcleaner
	clamxav
	colloquy
	cyberduck
	dropbox
	firefox
	flip4mac
	flux
	gimp
	google-chrome
	gpgtools
	handbrake
	iterm2
	jing
	libreoffice
	mactex
	macvim
	name-mangler
	postman
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
	electric-sheep
	google-drive
	karabiner
	keepassx
	perian
	pycharm
	seil
	skim
	slack
	thunderbird
	virtualbox
	xee
	yasu
EOAPPS
cask_apps_additional=$(make_1line "$cask_apps_additional")

# Manual programs
#easytag

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install $brew_apps_default
brew install $brew_apps_additional

brew tap homebrew/science
brew install octave


# Install cask
brew tap caskroom/cask
cask_apps=$(make_1line "$cask_apps")
brew cask install $cask_apps_default
brew cask install $cask_apps_additional
