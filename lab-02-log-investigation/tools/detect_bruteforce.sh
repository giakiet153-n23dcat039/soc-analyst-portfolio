#!/bin/bash

LOGFILE=""
THRESHOLD=5

while getopts "f:t:" opt; do
    case $opt in
        f) LOGFILE="$OPTARG" ;;
        t) THRESHOLD="$OPTARG" ;;
        *) echo "Usage: $0 -f <logfile> -t <threshold>"; exit 1 ;;
    esac
done

if [[ -z "$LOGFILE" || ! -f "$LOGFILE" ]]; then
    echo "Error: log file not found."
    exit 1
fi

echo "=== Brute-Force Detection ==="
echo "Log file: $LOGFILE"
echo "Threshold: $THRESHOLD failed attempts"
echo

grep "Failed password" "$LOGFILE" |
awk '{
    for (i=1; i<=NF; i++) {
        if ($i == "from") {
            print $(i+1)
            break
        }
    }
}' |
sort |
uniq -c |
sort -nr |
while read count ip; do
    if [ "$count" -ge "$THRESHOLD" ]; then
        echo "[ALERT] $ip - $count failed login attempts"
    else
        echo "[INFO]  $ip - $count failed login attempts"
    fi
done
