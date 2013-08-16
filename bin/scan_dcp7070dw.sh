#!/usr/bin/env bash
# Scan image from Brother DCP-7070DW scanner.
# Found the device name with $(scanimage -L).

dev_name="brother4:net1;dev0"
out_path="$HOME/media/images/scanned"
prefix="scanned_"

next_scan_number() {
	local prefix="$1"
	local next
	local files=$(ls ${prefix}[0-9]* 2>/dev/null)
	if [ "$?" -eq 0 ]; then
		last=$(echo "$files" | sed -e "s|${prefix}||" -e "s|\.pdf||" | sort -nr | head -1)
		next=$((last + 1))
	else
		next=0
	fi
	echo "$next"
}

convert2type() {
	local scan_name="$1"
	local from="$2"
	local to="$3"
	convert "${scan_name}.${from}" "${scan_name}.${to}"
	rm "${scan_name}.${from}"
}

copy_path_to_xclipboard() {
	local path="$1"
	echo  "$path" | xclip -i
}

cd "$out_path"
next=$(next_scan_number "$prefix")
scan_name="${prefix}${next}"
scanimage --device-name="${dev_name}" --progress --format=tff > "${scan_name}.tff"
if [ -e "${scan_name}.tff" ]; then
	convert2type "$scan_name" "tff" "pdf"
	copy_path_to_xclipboard "${out_path}/${scan_name}.pdf"
	echo "Scanned image at: ${out_path}/${scan_name}.pdf"
else
	echo "Scan failed -- no output." 1>&2
fi
