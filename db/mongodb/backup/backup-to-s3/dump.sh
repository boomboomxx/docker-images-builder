#!/bin/bash
FILE_DATA=$(date +%Y%m%d%H%M%S)

if [[ ${MONGO_URI} == "" ]]; then
        echo "Missing MONGO_URI env variable"
        exit 1
fi

mongodump --uri "${MONGO_URI}" -o /mongodump

echo "$MINIO_SERVER" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY" --api "$MINIO_API_VERSION"
mc config host add pg "$MINIO_SERVER" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY" --api "$MINIO_API_VERSION" > /dev/null
# Archive the backup folder and upload it to Minio for retention of 7 days.
tar -zcvf mongodump-"${FILE_DATA}".tar.gz /mongodump
mc mb pg/"${MINIO_BUCKET}"
mc cp mongodump-"${FILE_DATA}".tar.gz pg/"${MINIO_BUCKET}"
rm -rf *.tar.gz