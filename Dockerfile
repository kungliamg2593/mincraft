FROM alpine:latest
RUN \
  echo "http://dl-cdn.alpinelinux.org/alpine/v3.15/main" > /etc/apk/repositories && \
  echo "http://dl-cdn.alpinelinux.org/alpine/v3.15/community" >> /etc/apk/repositories && \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  apk add --no-cache nano sudo bash wget curl git tree grep openjdk18 && \
  mkdir /bin/ms && cd /bin/ms && \
  wget https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar && \
  echo "eula=true" > /bin/ms/eula.txt

ENTRYPOINT ["/usr/bin/java"]

CMD ["-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
