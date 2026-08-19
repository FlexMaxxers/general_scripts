#!/bin/bash
# Enables remote bootloader, should prompt user if they wish to proceed since it 
# will reboot the station

while true; do
    read -p "Enabling remote bootloader will reboot the station. Do you wish to proceed? (y/n): " yn
    case $yn in
        [Yy]* ) 
        	echo "Enabling remote bootloader"

        	sudo salt-call state.apply remote_bootloader
            
            echo "Remote bootloader has been enabled but a reboot is still required. Upon reboot, run 'printenv' to confirm bootloader is set to remote."
            
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
            echo "Reboot canceled. Remote bootloader has not been enabled."
            break
            ;;
        * ) 
            echo "Invalid entry. Please answer yes (y) or no (n)."
            ;;
    esac
done

echo "Script execution finished."
