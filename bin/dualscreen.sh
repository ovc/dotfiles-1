#!/usr/bin/env bash
# Control dual screens. Alternatively use arandr GUI tool.
# Get information with $(xrandr -q).
# TODO detect prefered resolution from $(xrandr -q) and try that (if that is not the default behaviour already). 

if [ "$#" -eq 2 ]; then
	monitor="$1"
	action="$2"
	if !([ "$action" == "enable" ] || [ "$action" == "disable" ]); then
		echo "Unknown action \"${2}\"." 1>&2
		exit 3
	fi
else
	echo "Expected argument: monitor (enable|disable)" 1>&2
	exit 1
fi

args_lvds1="--output LVDS1 --mode 1600x900"
case "$monitor" in
	"dell24") # Dell 24" monitor.
		if [ "$action" == "enable" ]; then
			ext_monargs="--output HDMI2 --primary --mode 1920x1200 --right-of LVDS1"
		else
			args_lvds1="${args_lvds1} --primary"
			ext_monargs="--output HDMI2 --off"
		fi
		;;
	"lgtv") # Lund LG TV.
		if [ "$action" == "enable" ]; then
			ext_monargs="--output HDMI1 --mode 1360x768 --left-of LVDS1"
		else
			args_lvds1="${args_lvds1} --primary"
			ext_monargs="--output HDMI1 --off"
		fi
		;;
	"ljunghusen-sharp") # Parents' large TV.
		if [ "$action" == "enable" ]; then
			ext_monargs="--output HDMI1 --mode 1920x1080i --left-of LVDS1"
		else
			args_lvds1="${args_lvds1} --primary"
			ext_monargs="--output HDMI1 --off"
		fi
		;;
	*)
		echo "Unknow monitor \"${monitor}\"." 1>&2
		exit 2
		;;
esac
xrandr $args_lvds1
xrandr $ext_monargs

# Set wallpaper again to re-fit.
feh --bg-fill --no-xinerama $HOME/.wallpaper
