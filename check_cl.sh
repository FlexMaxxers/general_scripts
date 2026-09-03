#!/bin/bash
# Checking the cl id for all tests.

# The following gets all the .yaml files for their associated test recipes that are currently running.
listOfTests = ps aux | grep testers | grep -P -o '(?<=--config-file=)[^\s]+'

# Create a for loop going through each *line* and based on the path, highlight the title and environment of the test.

