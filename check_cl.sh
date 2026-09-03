#!/bin/bash
# Checking the cl id for all tests.

# The following gets all the .yaml files for their associated test recipes that are currently running.
listOfTests = ps aux | grep testers | grep -P -o '(?<=--config-file=)[^\s]+'

# Create a for loop going through each *line* and based on the path, highlight the title and environment of the test then pipe the file to
# grep cl to get the cl id.
# Example output:
# /var/run/testers/ybr3_roll_and_motor_collect/debug/34966084c66344f73a151b733234b45cefb00d4c.yaml
# /var/run/testers/ybr3_rma_roll_and_motor_collect/staging/2516a1649ed2869f1c47d8fb3f404ea687899b69.yaml
# /var/run/testers/ybr3_roll_and_motor/prod/d75f2694b3172da78b79252631d28811fa5ce6a2.yaml
# /var/run/testers/ybr3_rma_roll_and_motor_collect/prod/a4eff52eb32cad2132f22a777b745deee48d5e97.yaml
# /var/run/testers/ybr3_rma_roll_and_motor/debug/19a2744262480baf08a29fb3b418250969562806.yaml
# /var/run/testers/ybr3_roll_and_motor/staging/bbfd4f0f135458b883c786e29d245b1d18865b14.yaml
# /var/run/testers/ybr3_roll_and_motor_collect/prod/34966084c66344f73a151b733234b45cefb00d4c.yaml
# /var/run/testers/ybr3_rma_roll_and_motor/staging/4514e69dbb20df88e342aff68ccf94a844d629aa.yaml


