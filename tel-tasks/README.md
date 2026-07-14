# Instructions on How to Use

The script in this directory must be deployed on stations with the any of the following directories: lgm_wafer, lgm_die, and/or lgm_fiber. The script can be placed at `/usr/local/bin/cleanup_lgm.sh` along with other system/user scripts for an easier time finding. Afterwards, run `sudo crontab -e` and specificy the entry `0 2 * * 0 /usr/local/bin/cleanup_lgm.sh` so that the task is run weekly on Sundays at 2 a.m. 

What the script does is deletes files in the specified directories that are older than 7 days for image files and 180 days for directories (pertaining to lgm_wafer).