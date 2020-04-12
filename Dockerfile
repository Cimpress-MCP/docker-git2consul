FROM alpine:3.2

MAINTAINER Calvin Leung Huang <https://github.com/calvn>

COPY config /setup/config
COPY run.sh /run.sh

RUN apk --update add nodejs git openssh ca-certificates && \
  rm -rf /var/cache/apk/* && \
  npm install git2consul@0.12.13 --global && \
  mkdir -p /etc/git2consul.d && \
  chmod +x /run.sh

ENTRYPOINT ["/run.sh"]

CMD [ "/usr/bin/node", "/usr/lib/node_modules/git2consul" ]

