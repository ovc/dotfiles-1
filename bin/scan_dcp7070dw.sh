#!/usr/bin/env bash
# Scan image from Brother DCP-7070DW scanner.
# Found the device name with $(scanimage -L).

out_path="$HOME/media/images/scanned"
prefix="scanned_"

cd "$out_path"
files=$(ls ${prefix}[0-9]* 2>/dev/null)
if [ "$?" -eq 0 ]; then
	last=$(echo "$files" | sed -e "s|${prefix}||" -e "s|\.png||" | sort -nr | head -1)
	next=$((last + 1))
else
	next=0
fi

scan_name="${prefix}${next}"
scanimage --device-name="brother4:net1;dev0" --progress --format=tff > "${scan_name}.tff"
convert "${scan_name}.tff"  "${scan_name}.png"
rm "${scan_name}.tff"
