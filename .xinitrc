#!/usr/bin/env sh
# Initialization of xinit which is called by startx.

# Skip specific settings when starting with startx and run the same commands as when starting with a displaymanager.
[ -f "$HOME/.Xsession" ] && exec "$HOME.Xsession"
