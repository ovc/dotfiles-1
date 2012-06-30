#!/bin/sh
# Restart the Plasma desktop.
exec &> /dev/null
kbuildsycoca4
kquitapp plasma-desktop
kstart plasma-desktop
