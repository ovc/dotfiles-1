#!/usr/bin/env bash
# TODO vim modline
# Initialize my X session. Different files are used depending on how X is started.
#	$HOME/.Xsession: called by displaymanagers like xdm.
#	$HOME/.xinitrc: called by xinit which is called by startx and also DMs like SLiM.
# I want to keep it consistent so I let .Xsession run this script instead. A symlink would do fine too but those tend to become invalid when moving between systems.

# In case everything goes wrong, we at least fall back to a plain xterm.
failsafe="xterm -ls -T Failsafe -geometry 80x24-0-0"
trap "exec $failsafe" EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

# Some bash (1 and 2) settings to avoid trouble on a failed program call.
set +e > /dev/null 2>&1
set +u > /dev/null 2>&1
set +o posix  > /dev/null 2>&1
if type shopt > /dev/null 2>&1 ; then
    shopt -s execfail
else
    no_exit_on_failed_exec=1
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

## Envoronment 

# Set the right keyboard map.
#setxkbmap -layout us -model pc105
#setxkbmap -layout us -model pc87
# TODO what keyboard model does my thinkpad have? `setxkbmap -query`
setxkbmap -layout us


# Modify key bindings.
if [ -f "$HOME/.Xmodmap" ]; then
	xmodmap $HOME/.Xmodmap
fi

# Add to font path so they can be used by X11.
xset +fp /usr/share/fonts/local
xset fp rehash

# Updated X resouced database.
if [ -f "$HOME/.Xresources" ]; then
	# Apparently merge will not always work for xterm settings.
	#xrdb -merge $HOME/.Xresources
	xrdb -load $HOME/.Xresources
fi

# Tell GTK and QT applications to use X input method so my .Xmodmaps becomes visible.
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

# Set wallpaper.
feh --bg-scale $HOME/.wallpaper


## Start applications.

# Start GNOME keyring. From https://wiki.archlinux.org/index.php/Gnome-keyring
# Start a D-Bus session
source /etc/X11/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# Network manager
nm-applet &

# System tray. Use package trayer-dwm for better dwm integration.
# NOTE not needed now since I use the systemtray patch for dwm.
#trayer --edge top --align  right --widthtype request --expand true --transparent true --alpha 255  --heighttype pixel --height 15

if ! pidof /usr/bin/python2 /usr/bin/udiskie >/dev/null; then
	# The notification system needs a daemon to run otherwise udiskie will die.
	#/usr/lib/notification-daemon-1.0/notification-daemon &
	dunst &
	udiskie &
fi

# Disable touchpad when typing.
syndaemon -K -d -i 0.5

# Start URxvt daemon.
urxvtd -q -o -f

# Start PulseAudio.
# TODO /etc/X11/xinit/xinitrc.d/pulseaudio fixes this?
#if ! pulseaudio --check; then
#	pulseaudio --start
#fi

# Start screensaver
xscreensaver -no-splash &

# Start xbinkeys.
xbindkeys

# DWM statusbar.
if ! (pidof dwnstatus >/dev/null) && [ -x $HOME/dev/dwmstatus/dwmstatus ]; then
	$HOME/dev/dwmstatus/dwmstatus &
fi

# Start skype.
skype &

# Start Dropbox.
dropboxd &

# Battery monitor.
batterymon & 

# TODO fix so paramter from SLiM can be used.
echo "$@" >> $HOME/.log/slim_dump.log

# Start the window manager with all paramters. This script ends at `exec` below.
unset WINDOW_MANAGER
#WINDOWMANAGER='/usr/bin/startkde'
#WINDOWMANAGER='dwm'
WINDOWMANAGER="$HOME/bin/startdwm.sh"

exec $WINDOWMANAGER ${1+"$@"}

# Call failsafe.
exit 0
