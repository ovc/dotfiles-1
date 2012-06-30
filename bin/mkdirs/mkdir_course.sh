#!/bin/bash
# Create standard directories for a course.

dirs=(exams exercises labs lectures projects)

if [ -n "$1" ] && [ -n "$2" ]; then
	year=$1
	course_code=$2
else
	echo "You need to supply a course year and a course code." >&2
	exit 1;
fi

for dir in ${dirs[*]}; do
	mkdir -p ~/edu/lth/d$year/$course_code/$dir;
done

touch ~/drop/lth/d$year/$course_code/questions.txt
