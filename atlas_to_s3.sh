#!/bin/bash

# exit if any command fails
set -e

HOST="mongodb+srv://$ATLAS_USER:$ATLAS_PASSWORD@$CLUSTER.mongodb.net/$DB_NAME"

# Current time
TIME=`/bin/date +%d-%m-%Y-%T`

# Backup directory
DEST="/backup"

# Tar file of backup directory
FILE_NAME="$CLUSTER-$TIME.tar"
TAR="$DEST/../$FILE_NAME"

mkdir -p $DEST

# Log
echo "Backing up all db from $HOST to s3://$BUCKET/ on $TIME";

# Dump from mongodb host into backup directory
mongodump --forceTableScan --uri $HOST --out $DEST

# Remove some databases like admin, local, config
set +e

echo "Removing admin database..."
rm -rf "$DEST/admin"

echo "Removing local database..."
rm -rf "$DEST/local"

echo "Removing config database..."
rm -rf "$DEST/config"

set -e

# Create tar of backup directory
tar cvf $TAR -C $DEST .
# 　
# Upload tar to s3
aws s3 cp $TAR s3://$BUCKET/ --storage-class STANDARD_IA

# Remove tar file locally
rm -f $TAR

# Remove backup directory
rm -rf $DEST

# All done
echo "Backup available at https://s3.amazonaws.com/$BUCKET/$FILE_NAME.tar"
