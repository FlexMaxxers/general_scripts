#!/bin/bash
TESTER=$(ps aux | grep DEBUG | awk -F'--config-file=' '{print $1}' | sed -n 's#.* \(/software/.*\.par\).*#\1#p')
CONFIG_FILE=$(ps aux | grep DEBUG | awk -F'--config-file=' '{print $2}' | awk -F'--env' '{print $1}')
ENV="DEBUG"


if [ -z "$1" ]; then
    echo "Usage: $0 <number_of_loops>"
    exit 1
fi

RUNS="$1"

echo "Starting $LOOPs iterations for $ENV"

for ((i=1; i<=RUNS; i++))
do
    echo "Run: $i of $RUNS"
    sudo $TESTER \
    --operator=mirandaricardo_automated \
    --config-value=start_test_no_wait=True \
    --config-file=$CONFIG_FILE \
    --env=$ENV
done

echo "Loop for $ENV complete."