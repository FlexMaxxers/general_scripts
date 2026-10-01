#!/usr/bin/env bash
# tmux-all.sh
SESSION="stations"
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

mapfile -t HOSTS < <(grep -vE '^\s*(#|$)' "$HOSTS_FILE")

tmux kill-session -t "$SESSION" 2>/dev/null

tmux new-session -d -s "$SESSION" -n all "ssh ${HOSTS[0]}"
tmux select-pane -t "$SESSION:all" -T "${HOSTS[0]}"
for host in "${HOSTS[@]:1}"; do
  tmux split-window -t "$SESSION:all" "ssh $host"
  tmux select-pane -t "$SESSION:all" -T "$host"
  tmux select-layout -t "$SESSION:all" tiled
done

tmux set-window-option -t "$SESSION:all" pane-border-status top
tmux set-window-option -t "$SESSION:all" pane-border-format " #{pane_title} "
tmux set-window-option -t "$SESSION:all" remain-on-exit on
tmux set-window-option -t "$SESSION:all" synchronize-panes on
tmux attach -t "$SESSION"