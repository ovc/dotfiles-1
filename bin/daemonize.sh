#!/usr/bin/env sh
# Wrapper to daemonize which apparently requires absolute path to the program to start (and I don't).

prog=$(which "$1")
shift
args="$@"
daemonize $prog $args
