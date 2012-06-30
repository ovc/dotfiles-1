#!/bin/bash
# Covnert some defined images to pngs in the given path and deletes them.
TARGETS=(jpg jpeg gif tif)
IPATH="."
[[ -n "$1" ]] && IPATH=$1
for TARGET in ${TARGETS[*]}; do
	# TODO seriously, counting files with wc -w...?
	NBR=`ls $IPATH/* | grep "${TARGET}" | wc -w`
	if [[ "$NBR" -gt "0" ]]; then
	mogrify -format png ${IPATH}/*.$TARGET
	rm -f ${IPATH}/*.$TARGET
	fi
done
exit 0
