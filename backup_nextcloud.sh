#!/bin/bash

# backup volumes to my mega.nz account

docker pause nextcloud_app_1
docker exec nextcloud_db_1 pg_dump --username=nextcloud nextcloud |bzip2 > /tmp/nextcloud_db_$(date +%Y%m%d).txt.bz2
docker run -v nextcloud_data_dir:/volume -v /tmp:/backup --rm loomchild/volume-backup backup nextcloud_data_dir_$(date +%Y%m%d)
docker unpause nextcloud_app_1
megaput --no-progress --path=/Root/$(uname -n) /tmp/nextcloud_db_$(date +%Y%m%d).txt.bz2
if [ $? -ne 0 ] 
then
    echo "megaput failed for nextcloud_db"
else
    echo "megaput succeeded"
    # Can't clean up as file owned by root
    #rm /tmp/nextcloud_db_$(date +%Y%m%d).txt.bz2
fi
megaput --no-progress --path=/Root/$(uname -n) /tmp/nextcloud_data_dir_$(date +%Y%m%d).tar.bz2
if [ $? -ne 0 ] 
then
    echo "megaput failed for nextcloud_data_dir"
else
    echo "megaput succeeded"
    # Can't clean up as file owned by root
    # rm /tmp/nextcloud_data_dir_$(date +%Y%m%d).tar.bz2
fi
