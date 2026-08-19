#!/bin/bash
# This will revert back to a local bootloader.

while true; do
    read -p "Do you wish to revert back to local bootloader? This will require a reboot. (y/n): " yn
    case $yn in
        [Yy]* ) 
        	echo "Enabling local bootloader"

        	sudo rm /etc/profile.d/90-remote_bootloader.sh    
			sudo rm /etc/supervisor/waymo_env/remote_bootloader.conf

            echo "Local bootloader has been enabled. Please run 'printenv | grep SECURE' to confirm after reboot."

            echo "Now rebooting."
            for i in {5..1}; do
                echo -ne "Rebooting in $i seconds... (Press Ctrl+C to abort)\r"
                sleep 1
            done
            echo -e "\nRebooting now!"
            sudo reboot
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
