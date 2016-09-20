FROM alpine:3.2
MAINTAINER Calvin Leung Huang <https://github.com/cleung2010>

RUN apk --update add nodejs git openssh && \
    rm -rf /var/cache/apk/* && \
    npm install git2consul@0.12.12 --global && \
    mkdir -p /etc/git2consul.d

ENTRYPOINT [ "/usr/bin/node", "/usr/lib/node_modules/git2consul" ]
