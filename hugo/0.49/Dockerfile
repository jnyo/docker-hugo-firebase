# use latest Node (alpine)
FROM node:alpine

# set hugo version
ENV HUGO_VERSION=0.49
ENV HUGO_DOWNLOAD_URL=https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

RUN apk add --update --no-cache --virtual build-dependencies

RUN apk add --update --no-cache \
        bash \
        build-base \
        ca-certificates \
        git \
        libcurl \
        libxml2-dev \
        libxslt-dev \
        openssh \
        rsync \
        wget && \
     wget "$HUGO_DOWNLOAD_URL" && \
     tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
     mv hugo /usr/bin/hugo && \
     rm -r hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
     rm -r LICENSE && \
     rm -r README.md && \
     npm -g config set user root && \
     npm install -g firebase-tools && \
     apk del build-dependencies && \
     rm /var/cache/apk/*

EXPOSE 1313
