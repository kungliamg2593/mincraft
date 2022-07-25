#sudo podman build --tls-verify=false -t quay.io/kungliamg2593/alpine.ms . --no-cache
#sudo podman login quay.io
#sudo podman push --tls-verify=false -t quay.io/kungliamg2593/alpine.ms:latest
#sudo podman run --rm --name a1 -h a1 -d -p 25565:25565 quay.io/kungliamg2593/alpine.ms
#sudo podman run --rm --name a1 -h a1 -p 25565:25565 quay.io/kungliamg2593/alpine.ms
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
  java -Xmx1024M -Xms1024M -jar server.jar nogui && \
  cat /bin/ms/eula.txt |sed -e 's/false/true/g' > /bin/ms/eula.txt

ENTRYPOINT ["/usr/bin/java"]

CMD ["-Xmx1024M", "-Xms1024M", "-jar", "/bin/ms/server.jar", "nogui"]
