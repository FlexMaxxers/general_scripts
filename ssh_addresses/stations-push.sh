#!/usr/bin/env bash
# usage: stations-push.sh [-s] <local-path> <remote-dest-dir>
#   -s   use scp instead of rsync
set -u

usage() {
  echo "usage: $(basename "$0") [-s] <local-path> <remote-dest-dir>" >&2
}

USE_SCP=0
while getopts "s" opt; do
  case $opt in
    s) USE_SCP=1 ;;
    *) usage; exit 2 ;;
  esac
done
shift $((OPTIND - 1))

if (( $# != 2 )); then
  usage
  exit 2
fi
SRC="$1"
DEST="$2"

if [[ ! -e "$SRC" ]]; then
  echo "Error: local path '$SRC' does not exist. Aborting." >&2
  exit 1
fi

HOSTS_FILE="$PWD/stations.txt"

if [[ ! -f "$HOSTS_FILE" ]]; then
  echo "Error: stations.txt not found in $PWD. Aborting." >&2
  exit 1
fi

mapfile -t HOSTS < <(grep -vE '^\s*(#|$)' "$HOSTS_FILE")

if (( ${#HOSTS[@]} == 0 )); then
  echo "Error: stations.txt in $PWD has no hosts. Aborting." >&2
  exit 1
fi

OUT_DIR="$(mktemp -d)"
SSH_OPTS=(-o BatchMode=yes -o ConnectTimeout=5)

push_host() {
  local host=$1 rc
  if (( USE_SCP )); then
    scp -r "${SSH_OPTS[@]}" "$SRC" "$host:$DEST" \
      >"$OUT_DIR/$host.out" 2>&1
  else
    rsync -az --partial -e "ssh ${SSH_OPTS[*]}" "$SRC" "$host:$DEST" \
      >"$OUT_DIR/$host.out" 2>&1
  fi
  rc=$?
  echo "$rc" >"$OUT_DIR/$host.rc"
}

for host in "${HOSTS[@]}"; do
  push_host "$host" &
done
wait

fail=0
for host in "${HOSTS[@]}"; do
  rc=$(<"$OUT_DIR/$host.rc")
  if (( rc == 0 )); then
    echo "[$host] OK"
  else
    echo "[$host] FAILED (exit $rc)"
    sed 's/^/    /' "$OUT_DIR/$host.out"
    fail=1
  fi
done

echo "Logs kept in $OUT_DIR"
exit $fail