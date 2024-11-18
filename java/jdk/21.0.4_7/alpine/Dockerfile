FROM eclipse-temurin:21.0.4_7-jdk-alpine
COPY fonts/* /usr/share/fonts/
COPY arthas.zip /tools/

USER root
RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.tuna.tsinghua.edu.cn/alpine#g' /etc/apk/repositories \
    && apk update && apk add --no-cache bash \
    && apk add --no-cache procps unzip curl bash tzdata fontconfig busybox-extras \
    && apk add ttf-dejavu \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && fc-cache -vf \
    && unzip /tools/arthas.zip -d /tools/arthas \
    && cd /tools/arthas \
    && sh /tools/arthas/install-local.sh \
    && rm -f /tools/arthas.zip \
    && rm -rf /var/cache/apk/* /tmp/*

ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8
