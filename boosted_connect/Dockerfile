ARG BUILD_FROM
FROM $BUILD_FROM

# Install frpc
ARG FRPC_VERSION=0.61.0
ARG TARGETARCH

RUN apk add --no-cache curl jq \
  && ARCH=$(uname -m) \
  && case "$ARCH" in \
       x86_64)  FRPC_ARCH="amd64" ;; \
       aarch64) FRPC_ARCH="arm64" ;; \
       armv7l)  FRPC_ARCH="arm" ;; \
       armhf)   FRPC_ARCH="arm" ;; \
       *)        echo "Unsupported arch"; exit 1 ;; \
     esac \
  && curl -fsSL "https://github.com/fatedier/frp/releases/download/v${FRPC_VERSION}/frp_${FRPC_VERSION}_linux_${FRPC_ARCH}.tar.gz" \
     | tar -xz -C /tmp \
  && mv "/tmp/frp_${FRPC_VERSION}_linux_${FRPC_ARCH}/frpc" /usr/local/bin/frpc \
  && chmod +x /usr/local/bin/frpc \
  && rm -rf /tmp/frp_*

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
