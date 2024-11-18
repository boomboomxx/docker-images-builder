FROM alpine:latest
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk update && apk add ca-certificates wget && update-ca-certificates \
    && wget -O /tmp/mc https://dl.minio.org.cn/client/mc/release/linux-amd64/mc \
    && chmod +x /tmp/mc


FROM mongo:7.0.4
COPY --from=0 /tmp/mc /usr/bin/mc
ENV MINIO_SERVER=""
ENV MINIO_BUCKET=""
ENV MINIO_ACCESS_KEY=""
ENV MINIO_SECRET_KEY=""
ENV MINIO_API_VERSION="S3v4"

COPY dump.sh /
RUN chmod +x /dump.sh
ENTRYPOINT ["/dump.sh"]