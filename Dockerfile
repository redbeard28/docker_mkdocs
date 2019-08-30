FROM alpine:latest
MAINTAINER redbeard28 <https://github.com/redbeard28/docker_mkdocs>

RUN apk add --update python3 py-pip && pip3 install --upgrade pip && pip3 install mkdocs && pip install mkdocs-awesome-pages-plugin && rm -rf /var/cache/apk/*

WORKDIR /work

VOLUME /work
EXPOSE 8000

ENTRYPOINT ["mkdocs"]
