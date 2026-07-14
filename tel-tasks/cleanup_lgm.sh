#!/bin/bash
set -euo pipefail

LOGFILE=/var/log/lgm_cleanup.log
echo "=== Run: $(date) ===" >> "$LOGFILE"

echo "lgm_fiber count: $(find /data/lgm_fiber/no_lot -mindepth 1 -mtime +7 | wc -l)" >> "$LOGFILE"
echo "lgm_die count: $(find /data/lgm_die/no_lot -mindepth 1 -mtime +7 | wc -l)" >> "$LOGFILE"

find /data/lgm_fiber/no_lot -mindepth 1 -mtime +7 -delete
find /data/lgm_die/no_lot -mindepth 1 -mtime +7 -delete

find /data/lgm_wafer -mindepth 1 -depth -type d -mtime +180 -print -exec rm -r {} + >> "$LOGFILE"

echo "=== Done: $(date) ===" >> "$LOGFILE"