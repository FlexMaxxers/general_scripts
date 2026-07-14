#!/bin/bash
set -uo pipefail
# Note: not using -e here, since we want the script to continue
# and log a warning even if one directory is missing, rather than
# aborting the whole run.

LOGFILE=/var/log/lgm_cleanup.log
echo "=== Run: $(date) ===" >> "$LOGFILE"

cleanup_no_lot() {
    local dir="$1"
    if [ -d "$dir" ]; then
        local count
        count=$(find "$dir" -mindepth 1 -mtime +7 | wc -l)
        echo "$dir: $count files older than 7 days, deleting..." >> "$LOGFILE"
        find "$dir" -mindepth 1 -mtime +7 -delete
    else
        echo "WARNING: $dir not found, skipping" >> "$LOGFILE"
    fi
}

cleanup_no_lot /data/lgm_fiber/no_lot
cleanup_no_lot /data/lgm_die/no_lot

if [ -d /data/lgm_wafer ]; then
    echo "Cleaning /data/lgm_wafer (dirs older than 180 days)..." >> "$LOGFILE"
    find /data/lgm_wafer -mindepth 1 -depth -type d -mtime +180 -print -exec rm -r {} + >> "$LOGFILE"
else
    echo "WARNING: /data/lgm_wafer not found, skipping" >> "$LOGFILE"
fi

echo "=== Done: $(date) ===" >> "$LOGFILE"