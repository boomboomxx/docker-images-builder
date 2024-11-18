FROM eclipse-temurin:21.0.4_7-jre-alpine
COPY fonts/* /usr/share/fonts/

# 切换为 root user
USER root
# 更新源并安装依赖包
# 安装字体 ttf-dejavu 和 宋体
# 修改时区为中文时区
RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.tuna.tsinghua.edu.cn/alpine#g' /etc/apk/repositories \
    && apk update \ 
    && apk add --no-cache bash procps unzip curl tzdata fontconfig \
    && apk add ttf-dejavu \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && fc-cache -vf \
    && rm -rf /var/cache/apk/* /tmp/*

# 设置语言为中文
ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8
