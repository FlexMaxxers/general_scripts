#!/bin/bash

# Navigate to the bin directory where the interactive_shell.par file is located

cd ~/bin

# station1: the station's environment forces remote bootload, which fails for
# this build; override it for this process only
SECURE_BOOTLOAD_METHOD=local REMOTE_BOOTLOADER_SERVICE_ADDRESS= \
REMOTE_BOOTLOADER_CREDENTIALS_FILENAME= ./interactive_shell.par


./interactive_shell.par
