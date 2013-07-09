#!/usr/bin/env sh
# Start dualscreen for HDMI output for our livingroom TV. Alternatively use arandr GUI tool.
# Get information with $(xrandr -q).
# TODO detect prefered resolution from $(xrandr -q) and try that (if that is not the default behaviour already). 

# Lund LG TV
xrandr --output LVDS1 --mode 1600x900 --output HDMI1 --mode 1360x768 --left-of LVDS1
