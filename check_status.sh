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
sudo lsof /dev/vfio/2
