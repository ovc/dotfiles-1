#!/bin/bash
# Generates a sig file from parameters.
# $siggen.sh "role" "email"

role=
email="erik.westrup@gmail.com"
[[ -n "$1" ]] && role=", ${1}"
[[ -n "$2" ]] && email=$2

read -d '' out  << EOF
-- 
Erik Westrup${role}
<${email}>
(+46) 0738-286060 | 2r.se
Lagerbrings väg 8E, SE-22460 Lund, Sweden
-----------------------------------------
This e-mail is encrypted with 2ROT-13.
EOF

echo -e "\n"
echo -e "$out"
exit 0