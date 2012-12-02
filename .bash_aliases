# Erik Westrup's bash aliases.

# Modeline {
#	 vi: foldmarker={,} foldmethod=marker foldlevel=0: tabstop=8 ft=sh:
# }

# Suppress alias expansion:: $ \aliasname || 'aliasname'
# Print alias definition: alias <aliasname>

# Desktop Environment Specific {
	# Defaults.
	alias open='xdg-open'				# Open files.
	alias afk='xscreensaver-command -lock'		# Start screensaver.

	DESKTYPE='dwm'					# Current DE in use.
	case $DESKTYPE in
	kde)
		alias open='kde-open'			# Open files like in Dolphin.
		# Log out
		alias xlogout='qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout 0 0 2'
		#alias xlogout='kdeinit4_shutdown'
		# Start screensaver.
		alias afk='qdbus org.kde.screensaver /ScreenSaver org.freedesktop.ScreenSaver.SetActive true > /dev/null'
		# Empty KDE trash folders.
		alias emptytrash='rm -rf ~/.local/share/Trash/info/* ~/.local/share/Trash/files/*'
		;;
	gnome)
		alias open='gnome-open'					# Open files like in Nautilus.
		alias xlogout='gnome-session-save --force-logout'	# Log out.
		;;
	openbox)
		alias open='thunar'			# Open files.
		alias xlogout='openbox-logout'		# Log out.
		;;
	dwm)
		alias xlogout='pkill -f startdwm.sh'
		;;
	osx)
		# Enable or disable the Dashboard.
		alias mac_dashboard_enable='defaults write com.apple.dashboard mcx-disabled -boolean NO'
		alias mac_dashboard_disable='defaults write com.apple.dashboard mcx-disabled -boolean YES'
		# Show or hide dotfiles in Finder.app.
		alias mac_showhidden='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
		alias mac_hidehidden='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'
		# Hibernate the Mac.
		alias mac_hibernate='sudo pmset -a hibernatemode'
		# TODO ?
		alias mac_listhibernate='sudo pmset -g | grep hibernatemode'
		;;
	esac
# }

# Color support {
	ls_options="--time-style=long-iso -F"
	if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
		eval "`dircolors -b`"
		# Colors when output is terminal.
		alias ls="ls ${ls_options} --color=auto"
		# Force colors to all stdouts.
		alias ls="ls ${ls_options} --color=always"
		#alias dir='ls --color=auto --format=vertical'
		#alias vdir='ls --color=auto --format=long'

		# Highligt matches when output is on the terminal.
		#export GREP_OPTIONS='--color=always'

		# Force color e.g. to use when piping to less.
		alias grepc='grep --color=always'
		alias fgrepc='fgrep --color=always'
		alias egrepc='egrep --color=always'

		# Use colored diff if it can be found.
		hash colordiff 2>/dev/null
		if [ "$?" -eq 0 ]; then
			alias cdiff='colordiff'
			alias diffc='colordiff'
			alias diff='colordiff'
		fi

		# Use colored du if exists.
		hash cdu 2>/dev/null
		if [ "$?" -eq 0 ]; then
			alias du='cdu -idh'
		fi

		# Colorize SVN.
		type colorsvn >/dev/null 2>&1
		if [ "$?" -eq 0 ]; then
	    	alias svn='colorsvn'
		fi

		# Make colors.
		type colormake >/dev/null 2>&1
		if [ "$?" -eq 0 ]; then
	    	alias make='colormake'
		fi
	else
		alias ls="ls ${ls_options}"
	fi
# }

# SSH agent {
	alias keyon="ssh-add -t 14400"
	alias keyoff='ssh-add -D'
	alias keylist='ssh-add -l'
# }

# Sudo {
	alias loadkeys='sudo loadkeys'
	alias poweroff='sudo poweroff'
	alias halt='sudo halt'
	alias shutdown='sudo shutdown'
	alias reboot='sudo reboot'
	alias pm-suspend='sudo pm-suspend'
	alias pm-hibernate='sudo pm-hibernate'
	alias sudo='sudo '			# Bring my aliases with me.
# }

# Navigation {
	alias -- +='pushd'
	alias -- ++='pushd .'
	alias -- -='popd'
# }

# Program enhancements {
	alias emacs='emacs --no-window-system'			# Emacs belongs to the terminal.
	alias mvim='mvim -v'					# MacVim.
	alias gdb='gdb -q'					# Suppress legal info.
	alias cgdb='cgdb -q'					# Suppress legal info.
	#alias df='df -h'					# Always show in human readable.
	alias matlab='matlab -nodesktop -nosplash'		# Run in terminal with no splash screen.
	alias xmatlab='\matlab'					# Default X version.
	alias gimp='gimp --no-splash'				# Splash screens are just annoying.
	alias dmenu="dmenu -i"					# Ignore case.
	alias pacman='pacman-color'				# Use colorfoull pacman.
	alias cower='cower --color=auto'			# Use colors.
# }

# Short hands {
	alias cls='clear'					# Old DOS habit...
	alias vi='vim'						# Be IMproved.
	alias view='vim -R'					# Not all distributions of vim provide the readonly version.
	alias vidiff='vimdiff'
	#alias t='task'
	#alias c='gcalcli'
	alias gcal='gcalcli'
	alias vboxmanage='VBoxManage'							# Who likes caps?- I don't.
	alias ll='ls -l'										# I don't use it but aliens on my systems presumes its existance.
	unalias l &>/dev/null									# I use bashmarks.
	alias lsc='ls --color=always --time-style=long-iso'		# Force color.
	alias agdbtui='arm-none-eabi-gdbtui'					# So tired of typing that...
	alias shredzr='shred --zero --remove'					# Zero out and delete file.
	alias sysc='systemctl'									# The length of a name should correspond to its importance, see vi.
	alias journal='journalctl'
	# Take a screenshot of selected window.
	alias scrot-win="scrot --quality 80 --count --delay --border --delay 3 --select $HOME/media/images/screenshots/screenshot_%Y-%m-%d-%H%M%S.png"
	# Run JUnit on a test class.
	alias junitx="java -cp /usr/share/java/junit.jar:bin org.junit.runner.JUnitCore"
	alias pkillf="pkill -f -9"								# Force kill full name matched process.
# }

# Misc {
	alias psg='ps aux | grep -i '			# List matching processes.
	alias dusch='du -sch'				# The best file size calculator.
	alias rehash='hash -r'				# Reload PATH caches or something similar. It works!
	alias beep='echo -en "\007"'			# Whoop whoop'
	alias bygg='make -f Byggfil'			# New standard?
	alias webshare='python -m SimpleHTTPServer'	# Start webshare on port 8000 in CWD.
	alias image_dim="identify -format '%w %h\n'"	# Get dimmensions of an image.
	# Simple network speed test.
	alias speed_check='wget -O/dev/null ftp://ftp.port80.se/100M'
	# Unmount my key.
	alias uk='umount /media/key/ 2>/dev/null && echo "Key umounted." || echo "Umount failed." 1>&2'
	# ZO RELAXEN
	alias blinkenlichten='while true; do xset led 3; sleep 0.2s; xset -led 3; sleep 0.3s; done'
	alias cursh="ps -p \$\$ | tail -1 | awk '{print \$NF}'"		# Current shell.
# }
