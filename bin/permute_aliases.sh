#!/usr/bin/env bash
# Prints all unique permutation of a given program as bash alias commands to stdout. Ideal for generation of "make" aliases.
# Usage: ./permute_aliases.sh <program> >.bash_aliases_<program>
# source the generated file in you bash configuration file(s).

declare -A permutations

# In subject, swap subject[a_pos] with subject[b_pos].
swap() {
	local subject="$1"
	local a_pos="$2"
	local b_pos="$3"

	local a="${subject:${a_pos}:1}"
	local b="${subject:${b_pos}:1}"
	a_pos=$((a_pos + 1))
	b_pos=$((b_pos + 1))
	local permuted="$(echo "$subject" | sed -e "s/./${b}/${a_pos}" | sed -e "s/./${a}/${b_pos}")"
	echo "$permuted"
}

save_permutation() {
	local program="$1"
	local permutation="$2"

	if [ "$permuted" != "$program" ]; then
		if [[ ! ${permutations["${permutation}"]} ]]; then
			permutations+=(["${permutation}"]="${permutation}")
		fi
	fi
}

# Generate permutation aliases recursively.
permutate() {
	local program="$1"
	local subject="$2"
	local pos="$3"

	local i="$pos"
	for ((; $i < ${#subject}; i++)); do
		local permuted=$(swap "$subject" "$pos" "$i")
		save_permutation "$program" "$permuted"
		permutate "$program" "$permuted" $((pos+1))
	done
}

if [ "$#" -ne "1" ]; then
	echo "One argument expected: string to permute." 1>&2
	exit 1
else
	program="$1"
	echo "# Below follows all unique permutation aliases of \"${program}\", generated by \"${0##*/}\"."
	permutate "$program" "$program" 0
	printf "alias %s='make'\n" "${permutations[@]}"
fi
