#!/usr/bin/env sh
# Delete unused dependency packages with yaourt.
yaourt -Qtd | awk '{ print $1 }' | sed -e 's/.*\///' | yaourt -Rs -
