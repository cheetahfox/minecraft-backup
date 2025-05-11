# minecraft-backup
A simple Docker container that can archive and upload a Minecraft world to a S3 bucket

More Documentation for myself soonish

Make sure to set the following environment variables:
WORLD_DIR: The directory where the minecraft world is located.
S3_BUCKET: The s3 bucket where the backup will be uploaded.
AWS_ACCESS_KEY_ID: The access key id for the s3 bucket.
AWS_SECRET_ACCESS_KEY: The secret access key for the s3 bucket.
WORLD_NAME : The name of the world to be backed up.