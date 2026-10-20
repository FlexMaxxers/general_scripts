#!/bin/bash
# Grab the cl number from PROD builds

tests=("PROD" "DEBUG" "STAGING")

for i in ${tests[@]};
do
    echo "Grabbing $i CLs:"
    echo "------------------"
    ps aux | grep $i | awk -F'--config-file=' '{print $2}' | awk '{print $1}' | xargs grep -w "cl_number" | sed -E "s|.*/testers/([^/]+)/.*cl_number: '([0-9]+)'.*|\1 \2|"
    echo "------------------"
done

