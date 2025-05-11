#!/bin/bash
# This script backs the minecraft world located in the directory $WORLD_DIR
# and then compresses it into a tar.gz file. And then it uploads it to the
# s3 bucket $S3_BUCKET.

# Usage: ./backup.sh
# Make sure to set the following environment variables:
# WORLD_DIR: The directory where the minecraft world is located.
# S3_BUCKET: The s3 bucket where the backup will be uploaded.
# AWS_ACCESS_KEY_ID: The access key id for the s3 bucket.
# AWS_SECRET_ACCESS_KEY: The secret access key for the s3 bucket.
# WORLD_NAME : The name of the world to be backed up.

while read var; do
    [ -z "${!var}" ] && { echo "$var is empty or not set. Exiting.."; exit 1; } 
done << EOF
WORLD_DIR
S3_BUCKET
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
WORLD_NAME
EOF 

# Check if the world directory exists
if [ ! -d "$WORLD_DIR" ]; then
  echo "The world directory $WORLD_DIR does not exist."
  exit 1
fi

# create a timestamp
TIMESTAMP=$(date +"%Y-%m-%d")
# create a compressed tar file of the world directory
tar -czf "/tmp/backup.tar.gz" -C "$WORLD_DIR" . 
# check if the tar command was successful
if [ $? -ne 0 ]; then
  echo "Failed to create the backup tar file."
  exit 1
fi
# upload the tar file to the s3 bucket
s3cmd put "/tmp/backup.tar.gz" "$S3_BUCKET/$TIMESTAMP/$WORLD_NAME.tar.gz"
rm "/tmp/backup.tar.gz"
exit 0


