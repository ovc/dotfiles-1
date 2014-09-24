# Utility bash functions.

# Time conversions.
epoch2iso8601() {
    local epoch="$1"
    date -d @$epoch +%Y-%m-%dT%H:%M:%S%z
}

iso86012epoch() {
    local iso="$1"
    date -d "$iso" +%s
}

