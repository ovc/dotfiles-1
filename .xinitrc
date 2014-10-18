#!/usr/bin/env bash
# Modeline {
#	 vi: foldmarker={,} foldmethod=marker foldlevel=0: tabstop=8:
# }

# Initialize my X session. Different files are used depending on how X is started.
#	$HOME/.Xsession: called by displaymanagers like xdm.
#	$HOME/.xinitrc: called by xinit which is called by startx and also DMs like SLiM.
# I want to keep it consistent so I let .Xsession run this script instead. A symlink would do fine too but those tend to become invalid when moving between systems.

# Setup {
	# In case everything goes wrong, we at least fall back to a plain xterm.
	failsafe="xterm -ls -T Failsafe -geometry 80x24-0-0"
	# Damn son, where'd you find this?
	trap "exec $failsafe" EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

	# Some bash (1 and 2) settings to avoid trouble on a failed program call.
	set +e > /dev/null 2>&1
	set +u > /dev/null 2>&1
	set +o posix  > /dev/null 2>&1
	if type shopt > /dev/null 2>&1 ; then
    	    shopt -s execfail
	fi

	# Run user xinit scripts.
	for script in /etc/X11/xinit/xinitrc.d/*; do
    	    test -d $script && continue
    	    test -x $script || continue
    	    case "$script" in
		.*)		continue ;;
		*.rpm*)		continue ;;
		*.swap)		continue ;;
		*.bak)		continue ;;
		*.orig)		continue ;;
		\#*)		continue ;;
		*~)		continue ;;
    	    esac
    	    $script
	done
	unset script

	# Be compatible with other DM and use xprofile.
	if [ -f $HOME/.xprofile ]; then
		source $HOME/.xprofile
	fi
# }

# Environment {

	# Set up display with default modes. NOTE set wallpaper after this.
        #xrandr --auto --output LVDS1 --mode 1600x900 --output HDMI2 --mode 1920x1200 --right-of LVDS1
	$HOME/bin/dualscreen.sh dell24 enable

	# Set the right keyboard map.
	#setxkbmap -layout us -model pc105
	#setxkbmap -layout us -model pc87
	setxkbmap -layout us


	# Modify key bindings.
	if [ -f "$HOME/.Xmodmap" ]; then
		xmodmap $HOME/.Xmodmap
	fi

	# Add to font path so they can be used by X11.
	xset +fp /usr/share/fonts/local
	xset fp rehash

	# Updated X resouce database.
	if [ -f "$HOME/.Xresources" ]; then
		# Apparently merge will not always work for xterm settings.
		#xrdb -merge $HOME/.Xresources
		xrdb -load $HOME/.Xresources
	fi

	# Tell GTK and QT applications to use X input method so my .Xmodmaps becomes visible.
	export GTK_IM_MODULE=xim
	export QT_IM_MODULE=xim

	# Set wallpaper.
	wallpaper_set.sh
	# Set terminal cursor speed. First argument (in ms) is the delay before auto repeat starts.
	# The second paramter is the repeat rate in number repeats per second.
	# Get current values with $(xset q | grep rate)
	xset r rate 450 40
# }

# Start applications {
	# Try to not start programs in daemon mode, so that when parent (the desktop manager) quits all programs started there are killed as well.

	# Start XDG autostart programs
	# dex -a

	# Start GNOME keyring. From https://wiki.archlinux.org/index.php/Gnome-keyring
	# Start a D-Bus session
	#source /etc/X11/xinit/xinitrc.d/30-dbus
	# Start GNOME Keyring
	eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
	# You probably need to do this too:
	export SSH_AUTH_SOCK
	export GPG_AGENT_INFO
	export GNOME_KEYRING_CONTROL
	export GNOME_KEYRING_PID

	# Network manager
	# NOTE switched to netctl.
	#nm-applet &

	# System tray. Use package trayer-dwm for better dwm integration.
	# NOTE not needed now since I use the systemtray patch for dwm.
	#trayer --edge top --align  right --widthtype request --expand true --transparent true --alpha 255  --heighttype pixel --height 15

	# Start notification system.
	#/usr/lib/notification-daemon-1.0/notification-daemon &
	dunst &

	# Start auto mounter. Needs a running notification systen daemon.
	if ! pidof /usr/bin/python2 /usr/bin/udiskie >/dev/null; then
		udiskie &
	fi

	# Start notify-listener to the irssi plugin notify can emit messages.
	# NOTE stoped working, missing typelibe, so the legacy notify-send is used directly in the irssi plugin instead.
	#$HOME/bin/notify-listener.py

	# Disable touchpad when typing.
	#syndaemon -K -d -i 0.5 &
	syndaemon -K -i 0.5 &

	# Start URxvt daemon.
	#urxvtd --quiet --opendisplay --fork
	urxvtd --quiet --opendisplay &

	# Start PulseAudio.
	# Previously autostarted by /etc/X11/xinit/xinitrc.d/pulseaudio, seems to be replaced by XDG autostart.
	if ! pulseaudio --check; then
		pulseaudio --start
	fi

	# Start Music Player Daemon.
	#mpd &
	mopidy &

	# Volume notification daemon.
	#volnoti --timeout 1.2
	volnoti --no-daemon --timeout 1.2 &

	# Start screensaver
	#xscreensaver -no-splash &
	#xautolock -time 20 -detectsleep -locker slimlock -corners +000 -cornerdelay 2 -cornerredelay 30 -notify 10 -notifier "notify-send -u normal -a xautolock 'Locking screen in 10 seconds.'" &
	xautolock -time 20 -detectsleep -locker slock -notify 10 -notifier "notify-send -u normal -a xautolock 'Locking screen in 10 seconds.'" &

	# Screen blanking, turn off screen after inactivity (in seconds). For mysterious reasons the sleep is needed.
	xset +dpms
	sleep 1; xset s 1500

	# Start X keyboard shortcut daemon.
	xbindkeys

	# DWM statusbar.
	if ! (pidof dwnstatus >/dev/null) && [ -x $HOME/dev/dwmstatus/dwmstatus ]; then
		$HOME/dev/dwmstatus/dwmstatus &
	fi

	# Fetch my mails with IMAP IDLE.
	#offlineimap &

	# Start my Maildir notifier.
	$HOME/bin/maildir_watch.sh &

	# Start irexec used for executing arbitary commands from ~/.lircrc.
	#/usr/bin/env irexec --daemon

	# Start mailleds that will blink LEDs when there are unread emails.
	#$HOME/bin/mailleds_start.sh &

	# Lock screen when my phone is too far away.
	# TODO is it proximity who causes kernel oops?
	#start_proximity.sh &

	# Start my general tmux session.
	irctor start &

	# MPD notifier.
	mpd-notification &

	# Scrobble songs in MPD.
	#mpdscribble &
	mpdscribble --no-daemon &

	# Start skype.
	#skype &

	# System tray volume control.
	pnmixer &

	# Network monitor for netctl.
	netmon &

	# Start skyped hopefully after Skype is loaded.
	# TODO is this sleep still needed?
	#(sleep 10s && skyped) &

	# Battery monitor.
	batterymon &

	# Clipboard manager.
	parcellite &

	# Bluetooth applet. TODO broken in AUR, find replacement.
	#blueman-applet &

	# Start Dropbox.
	dropboxd &

	# SpiderOak Hive sync.
	#SpiderOak &
# }

# Window manager {
	# Start the window manager with all paramters. This script ends at `exec` below.
	unset WINDOW_MANAGER
	if [ "$#" -gt 0 ]; then
		WINDOWMANAGER="$@"
	else
		#WINDOWMANAGER='startkde'
		WINDOWMANAGER='dwm'
		#WINDOWMANAGER="$HOME/bin/startdwm.sh"
	fi

	exec $WINDOWMANAGER

	# Call failsafe.
	exit 0
# }
