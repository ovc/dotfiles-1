#!/usr/bin/env sh
# Start dualscreen for HDMI output for our livingroom TV.
# Get information with $(xrandr -q).

xrandr --output LVDS1 --mode 1600x900 --output HDMI1 --mode 1920x1080 --right-of LVDS1
