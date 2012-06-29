# Erik Westrup's bash aliases.

# Modeline {
#	 vi: foldmarker={,} foldmethod=marker foldlevel=0: tabstop=8 ft=sh:
# }

# Suppress alias expansion:: $ \aliasname || 'aliasname'
# Print alias definition: alias <aliasname>

# Desktop Environment Specific {
	# Defaults.
	alias open='xdg-open'				# Open files.
	alias afk='xscreensaver-command -activate'	# Start screensaver.
	#alias afk='xscreensaver-command -lock'

	DESKTYPE='kde'		# Current DE in use.
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
	if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
		eval "`dircolors -b`"
		# Colors when output is terminal.
		alias ls='ls --color=auto --time-style=long-iso'
		# Force colors to all stdouts.
		alias lsc='ls --color=always --time-style=long-iso'
		#alias dir='ls --color=auto --format=vertical'
		#alias vdir='ls --color=auto --format=long'

		# Highligt matches when output is on the terminal.
		alias grep='grep --color=auto'
		alias fgrep='fgrep --color=auto'
		alias egrep='egrep --color=auto'

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
	else
		alias ls='ls --time-style=long-iso'	# Use the one and only date and time format standard.
	fi
# }

# SSH-hosts {
	alias ssh_lth='ssh dt09ew6@login.student.lth.se'
	alias ssh_snejk='ssh snejk.dsek.lth.se'
	alias ssh_mushroom='ssh mushroom.dsek.lth.se'
	alias ssh_trevor='ssh trevor.dsek.lth.se'
	alias ssh_ohno='ssh ohno.dsek.lth.se'
	alias ssh_itsa='ssh itsa.dsek.lth.se'
	alias ssh_cpt='ssh -p 443 ljunghusen.2r.se'
	alias ssh_elitter='ssh elitter.net'
# }

# SSH agent {
	alias keyon="ssh-add -t 14400"
	alias keyoff='ssh-add -D'
	alias keylist='ssh-add -l'
# }

# Power management {
	alias halt='sudo halt'
	alias poweroff='sudo poweroff'
	alias shutdown='sudo shutdown'
	alias reboot='sudo reboot'
# }

# Navigation {
	alias -- +='pushd'
	alias -- ++='pushd .'
	alias -- -='popd'
# }

# Program enhancements {
	alias emacs='emacs -nw'					# Emacs belongs to the terminal.
	alias mvim='mvim -v'					# MacVim.
	alias gdb='gdb -q'					# Suppress legal info.
	alias cgdb='cgdb -q'					# Suppress legal info.
	#alias df='df -h'					# Always show in human readable.
	alias matlab='matlab -nodesktop -nosplash'		# Run in terminal with no splash screen.
	alias xmatlab='\matlab'					# Default X version.
	alias gimp='gimp --no-splash'				# Splash screens are just annoying.
# }

# Short hands {
	alias cls='clear'					# Old DOS habit...
	#alias vi='vim'						# Be IMproved.
	alias vidiff='vimdiff'
	#alias t='task'
	#alias c='gcalcli'
	alias gcal='gcalcli'
	alias vboxmanage='VBoxManage'					# Who likes caps? I don't.
	alias ll='ls -l'						# I don't use it but aliens on my systems presumes its existance.
	unalias l &>/dev/null						# I use bashmarks.
	alias lsc='ls --color=always --time-style=long-iso'		# Force color.
	alias agdbtui='arm-none-eabi-gdbtui'				# So tired of typing that...
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
# }
