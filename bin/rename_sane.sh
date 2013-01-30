#!/usr/bin/env sh
# Rename to sane file names.

if [ -n  "$1" ]; then
	path="$1"
else
	path="."
fi

IFS=$'\n'
for file in $(find $path  -type d | tac)
do
	cd "$file"
	rename.pl 's/(.*)/lc($1)/e' *
	cd - >/dev/null
done

IFS=$'\n'
for file in $(find $path  -type d | tac)
do
	cd "$file"
	rename.pl 's/ /_/g' *
	cd - >/dev/null
done
