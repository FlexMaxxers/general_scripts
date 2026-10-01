#!/usr/bin/env bash
# usage: stations-run.sh 'command'      run a command string on every station
#        stations-run.sh -f script.sh   run a local script on every station
set -u

usage() {
  echo "usage: $(basename "$0") 'command' | -f script.sh" >&2
}

if [[ "${1:-}" == "-f" ]]; then
  MODE=file
  TARGET="${2:-}"
  if [[ -z "$TARGET" || ! -f "$TARGET" ]]; then
    echo "Error: script file '$TARGET' not found. Aborting." >&2
    usage
    exit 2
  fi
elif [[ -n "${1:-}" ]]; then
  MODE=cmd
  TARGET="$1"
else
  usage
  exit 2
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

run_host() {
  local host=$1 rc
  if [[ "$MODE" == "file" ]]; then
    ssh "${SSH_OPTS[@]}" "$host" 'bash -s' <"$TARGET" \
      >"$OUT_DIR/$host.out" 2>&1
  else
    ssh "${SSH_OPTS[@]}" -n "$host" "$TARGET" \
      >"$OUT_DIR/$host.out" 2>&1
  fi
  rc=$?
  echo "$rc" >"$OUT_DIR/$host.rc"
}

for host in "${HOSTS[@]}"; do
  run_host "$host" &
done
wait

fail=0
for host in "${HOSTS[@]}"; do
  rc=$(<"$OUT_DIR/$host.rc")
  echo "=== $host (exit $rc) ==="
  cat "$OUT_DIR/$host.out"
  (( rc != 0 )) && fail=1
done

echo "Logs kept in $OUT_DIR"
exit $fail