#/bin/bash

DATE=$(date +%H-%M-%S)
BACKUP=db-$DATE.sql

DB_HOST=$1
DB_PASSWORD=$2
AWS_SECRET=$3
BUCKET_NAME=$4

mysqldump -u root -h $DB_HOST -p$DB_PASSWORD --all-databases > /tmp/$BACKUP  && \
export AWS_ACCESS_KEY_ID=AKIAJRWZWY3CPV3F3JPQ && \
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET && \
echo "Uploading your $BACKUP backup" && \
aws s3 cp /tmp/db-$DATE.sql s3://$BUCKET_NAME/$BACKUP
