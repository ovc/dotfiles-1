#!/usr/bin/env sh
# Initialization of xinit which is called by startx (and KDM apparently).

# Skip specific settings when starting with startx and run the same commands as when starting with a display manager.
[ -x "$HOME/.Xsession" ] && exec "$HOME/.Xsession"
