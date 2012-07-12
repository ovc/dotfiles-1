# Openbox autostart.

# Start session manager
lxsession &

# Enable power management
xfce4-power-manager &

# Start Thunar Daemon
thunar --daemon &

# Set desktop wallpaper
nitrogen --restore &

# Launch panel
tint2 &

# Enable Eyecandy - off by default, uncomment one of the commands below.
# Note: cairo-compmgr prefers a sleep delay, else it tends to produce
# odd shadows/quirks around tint2 & Conky.
#(sleep 10s && cb-compmgr --cairo-compmgr) &
cb-compmgr --xcompmgr &

# Launch network manager applet
#(sleep 4s && nm-applet) & # Not needed in new openbox it seems.

# Detect and configure touchpad. See 'man synclient' for more info.
if egrep -iq 'touchpad' /proc/bus/input/devices; then
    synclient VertEdgeScroll=1 &
    synclient TapButton1=1 &
fi

# Start xscreensaver
(sleep 4s && xscreensaver -no-splash) &

# Start gnome-screensaver
#(sleep 4s && gnome-screensaver) &

# Start Conky after a slight delay
(sleep 3s && conky -q) &

# Start volumeicon after a slight delay
#(sleep 3s && volumeicon) & # Not needed in new openbox it seems.

# Start Clipboard manager
(sleep 3s && parcellite) &

# Bad Nautilus, minimises the impact of running Nautilus under
# an Openbox session by applying some gconf settings. Safe to delete.
#cb-bad-nautilus &

# Autostart the Dropbox deamon
(sleep 30s && ~/.dropbox-dist/dropboxd) &

# Start blueproximity
#(sleep 8 && blueproximity) & # not needed

# Disable touchpad when typing.
syndaemon -d -i 1

# Run offlineimap forever.
offlineimap &

# Keyboard shortcuts
xbindkeys
