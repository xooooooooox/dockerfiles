FROM docker:27.5.1
LABEL \
    org.opencontainers.image.authors="xooooooooox <xozozsos@gmail.com>" \
    org.opencontainers.image.licenses="Apache-2.0" \
    org.opencontainers.image.description="include bash, bind-tools, curl, jq, util-linux, wget, yq, etc." \
    org.opencontainers.image.version="27.5.1"

ARG TZ="Asia/Shanghai"

ENV TZ=${TZ}

RUN apk add --no-cache \
      bash \
      bind-tools \
      busybox-extras \
      ca-certificates \
      curl \
      jq \
      libc6-compat \
      tzdata \
      util-linux \
      wget \
      yq \
  && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
  && echo "$TZ" > /etc/timezone
