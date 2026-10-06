#!/bin/bash
# Checks the supervisorctl status to make sure all testers are running
# Checks to make sure that kuiper DRAM check is running or not.
# If a warning is returned for the second command, that is okay

echo "Checking statuses for all testers: DEBUG, STAGING, PROD"
echo "-------------------------------------------------------"
sudo supervisorctl status testers:*

echo ""

echo "Checking for Kuiper_dram test"
echo "-----------------------------"

found=0
for dev in /dev/vfio/[0-9]*; do
    if [ -e "$dev" ]; then
        echo "Checking $dev"
        sudo lsof "$dev"
        found=1
    fi
done

if [ "$found" -eq 0 ]; then
    echo "No VFIO group device found under /dev/vfio"
fi

echo -e "\nChecking Bootloader method. If it is blank, we are local."
echo "---------------"
printenv | grep SECURE
