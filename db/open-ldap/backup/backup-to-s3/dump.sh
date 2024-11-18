#!/bin/bash
FILE_DATA=$(date +%Y%m%d%H%M%S)

if [[ ${LDAP_HOST} == "" ]]; then
        echo "Missing LDAP_HOST env variable"
        exit 1
fi
if [[ ${LDAP_BASE_DN} == "" ]]; then
        echo "Missing LDAP_BASE_DN env variable"
        exit 1
fi
if [[ ${LDAP_BIND_DN} == "" ]]; then
        echo "Missing LDAP_BIND_DN env variable"
        exit 1
fi
if [[ ${LDAP_BIND_PASS} == "" ]]; then
        echo "Missing LDAP_BIND_PASS env variable"
        exit 1
fi
ldapsearch -H "${LDAP_HOST}"  -LLL -w "${LDAP_BIND_PASS}" -x -D "${LDAP_BIND_DN}" -b "${LDAP_BASE_DN}" > /ldapdump/ldap_data.ldif

mc config host add pg "$MINIO_SERVER" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY" --api "$MINIO_API_VERSION" > /dev/null

# Archive the backup folder and upload it to Minio for retention of 7 days.
tar -zcvf ldapdump-"${FILE_DATA}".tar.gz ldapdump
mc mb pg/"${MINIO_BUCKET}"
mc cp ldapdump-"${FILE_DATA}".tar.gz pg/"${MINIO_BUCKET}"
#mc rm --recursive --force --older-than 7d pg/${MINIO_BUCKET}
rm -rf *.tar.gz