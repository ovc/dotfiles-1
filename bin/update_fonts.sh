#!/usr/bin/env bash
cd $HOME/.fonts
mkfontdir
mkfontscale
fc-cache -fv
xset fp rehash
