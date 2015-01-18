#!/bin/sh
# Quickly fix a screwed keyboard.
setxkbmap -layout us -variant altgr-intl
xmodmap ~/.Xmodmap
