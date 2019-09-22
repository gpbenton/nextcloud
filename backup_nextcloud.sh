#!/bin/bash

# backup volumes to my mega.nz account

BACKUP_DIR=${HOME}/nextcloud/backup

docker pause nextcloud_app_1
docker exec nextcloud_db_1 pg_dump --username=nextcloud nextcloud |bzip2 > ${BACKUP_DIR}/nextcloud_db_backup.txt.bz2
docker run -v nextcloud_data_dir:/volume -v ${BACKUP_DIR}:/backup --rm loomchild/volume-backup backup nextcloud_data_dir_backup
docker unpause nextcloud_app_1
