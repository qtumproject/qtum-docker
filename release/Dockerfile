FROM ubuntu

RUN set -ex \
    && apt-get update \
    && apt-get install -y -qq --no-install-recommends ca-certificates curl wget apt-utils jq

# install qtum binaries
ARG TARGETARCH
RUN set -ex \
    && case "${TARGETARCH}" in \
         amd64)   ARCH="x86_64" ;; \
         arm64)   ARCH="aarch64" ;; \
         arm)     ARCH="arm" ;; \
         riscv64) ARCH="riscv64" ;; \
         ppc64le) ARCH="powerpc64" ;; \
         *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
       esac \
    && QTUM_URL=$(curl -s https://api.github.com/repos/qtumproject/qtum/releases/latest \
        | jq -r --arg arch "$ARCH" '.assets[] | select(.name | test($arch + ".*-linux.*.tar.gz") and (test("debug") | not)) | .browser_download_url') \
    && echo "Downloading: $QTUM_URL" \
    && QTUM_DIST=$(basename "$QTUM_URL") \
    && wget -O "$QTUM_DIST" "$QTUM_URL" \
    && tar -xzvf "$QTUM_DIST" -C /usr/local --strip-components=1 \
    && rm -f "$QTUM_DIST"

# create data directory
ENV QTUM_DATA=/data
RUN mkdir $QTUM_DATA \
    && ln -sfn $QTUM_DATA /root/.qtum
VOLUME /data

EXPOSE 3888 3889 13888 13889
CMD ["qtumd"]
