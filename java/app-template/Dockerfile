FROM java:21.0.4-alpine
MAINTAINER szis
ENV APP_VERSION=''
ENV CUSTOM_JVM_OPTS=''
RUN mkdir -p /app/skywalking-agent
WORKDIR /
VOLUME /tmp
ADD target/APP_NAME.jar  APP_NAME.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java $CUSTOM_JVM_OPTS -Djava.security.egd=file:/dev/./urandom -jar /APP_NAME.jar"]
