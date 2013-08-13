#!/usr/bin/env bash
# Scan image from Brother DCP-7070DW scanner.
# Found the device name with $(scanimage -L).

out_path="$HOME/media/images/scanned"
prefix="scanned_"

cd "$out_path"
files=$(ls ${prefix}[0-9]* 2>/dev/null)
if [ "$?" -eq 0 ]; then
	last=$(echo "$files" | sed -e "s|${prefix}||" -e "s|\.pdf||" | sort -nr | head -1)
	next=$((last + 1))
else
	next=0
fi

scan_name="${prefix}${next}"
scanimage --device-name="brother4:net1;dev0" --progress --format=tff > "${scan_name}.tff"
if [ -e "${scan_name}.tff" ]; then
	convert "${scan_name}.tff"  "${scan_name}.pdf"
	rm "${scan_name}.tff"
	echo "${out_path}/${scan_name}.pdf" | xclip -i
	echo "Scanned image at: ${out_path}/${scan_name}.pdf"
else
	echo "Scan failed -- no output." 1>&2
fi
