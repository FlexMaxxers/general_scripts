#!/bin/bash
# This will revert back to a local bootloader.

while true; do
    read -p "Do you wish to revert back to local bootloader? (y/n): " yn
    case $yn in
        [Yy]* ) 
        	echo "Enabling local bootloader"

        	sudo rm /etc/profile.d/90-remote_bootloader.sh    
			sudo rm /etc/supervisor/waymo_env/remote_bootloader.conf

            echo "Local bootloader has been enabled. Please run 'printenv' to confirm."
            break
            ;;
        [Nn]* ) 
            echo "Execution canceled. Remote bootloader is still enabled."
            break
            ;;
        * ) 
            echo "Invalid entry. Please answer yes (y) or no (n)."
            ;;
    esac
done

echo "Script execution finished."
