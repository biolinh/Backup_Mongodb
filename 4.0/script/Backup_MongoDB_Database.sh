#!/bin/bash
# Shell script to backup MongoSql database 
# To backup Nysql databases file to /backup dir and later pick up by your 
# script. You can skip few databases from backup too.
# --------------------------------------------------------------------
MongoUSER="${MONGO_USER}"     # USERNAME
MongoPASS="${MONGO_PASS}"       # PASSWORD 
MongoHOST="${MONGO_HOST}"          # Hostname

MongoSTOREDAY="${MONGO_STORED_DAY}" # number of day to skip before remove.

# Linux bin paths, change this if it can not be autodetected via which command
MONGO="$(which mongo)"
MONGODUMP="$(which mongodump)"
TAR="$(which tar)"

# Backup Dest directory, change this if you have someother location
DEST="${MONGO_BACKUP_DIRECTORY}"

# Get hostname
HOST="$(hostname)"

# Get data in dd-mm-yyyy format
NOW="$(date +"%d-%m-%Y")"

OBD="$(date -d "$MySTOREDAY day ago" +"%d-%m-%Y")"
  
# Main directory where backup will be stored
MBD="$DEST/MongoDB/$MongoHOST/$NOW"

# Directory will be removed
RBD="$DEST/MongoDB/$MongoHOST/$OBD"

# File to store current backup file
FILE=""
# Store list of databases 
DBS="${MONGO_BACKUP_DB}"


[ ! -d $MBD ] && mkdir -p $MBD || :

for db in $DBS
do
	FILE="$db.$HOST.$NOW.gz"
	echo "Backup database $db"
	# do all inone job in pipe,
	# connect to mysql using mysqldump for select mysql database
	# and pipe it out to gz file in backup dir :)
        $MONGODUMP -u $MongoUSER -h $MongoHOST -p$MongoPASS --db $db --out $MBD
        cd $MBD && $TAR -czf $FILE.tar.gz $db
    echo "$db is backuped into: $FILE"    

done


#remove backupfile older than x days
echo "remove backupfile older than $MongoSTOREDAY"
echo "the day to remove  is $OBD"
mv $RBD /tmp && rm -rf /tmp/$RBD
