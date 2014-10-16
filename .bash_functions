# Utility bash functions.
# vi: ft=sh

# Time conversions.
epoch2iso8601() {
    local epoch="$1"
    date -d @$epoch +%Y-%m-%dT%H:%M:%S%z
}
export -f epoch2iso8601

iso86012epoch() {
    local iso="$1"
    date -d "$iso" +%s
}
export -f iso86012epoch
