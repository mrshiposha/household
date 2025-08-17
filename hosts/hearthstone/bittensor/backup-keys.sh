DATE=$(TZ=UTC date +%y_%m_%d)
BACKUP_FILE=keys-backup/keys_$DATE.sql.gz
REMOTE_PREFIX=/home/ubuntu
LOCAL_PREFIX=/home/mrshiposha/dev/work/bittensor

ssh bittensor-k 'docker exec -i keys-db pg_dump -U keys keys | gzip > '$REMOTE_PREFIX/$BACKUP_FILE
scp bittensor-k:/home/ubuntu/keys-backup/keys_$DATE.sql.gz $LOCAL_PREFIX/$BACKUP_FILE
