FROM alpine:latest

COPY dump.sh /

ENV MINIO_SERVER=""
ENV MINIO_BUCKET="mysql-backups/test-db"
ENV MINIO_ACCESS_KEY=""
ENV MINIO_SECRET_KEY=""
ENV MINIO_API_VERSION="S3v4"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk add --update ca-certificates openssl && update-ca-certificates \
    && apk add --update mysql-client bash openssh-client \
    && rm -rf /var/cache/apk/* \
    && wget https://dl.minio.org.cn/client/mc/release/linux-amd64/mc -O /usr/bin/mc \
    && chmod +x /usr/bin/mc \
    && chmod +x /dump.sh

ENTRYPOINT ["/dump.sh"]