FROM ubuntu

RUN set -ex \
    && apt-get update \
    && apt-get install -y -qq --no-install-recommends ca-certificates curl wget apt-utils jq

# install qtum binaries
RUN set -ex \
    && echo `curl -s https://api.github.com/repos/qtumproject/qtum/releases/latest | jq -r ".assets[] | select(.name | test(\"$(uname -p | sed s/ppc/powerpc/ | sed s/armv7l/arm/).*-linux.*.tar.gz\")) | .browser_download_url"` > /tmp/qtum_url \
    && QTUM_URL=`cat /tmp/qtum_url` \
    && QTUM_DIST=$(basename $QTUM_URL) \
    && wget -O $QTUM_DIST $QTUM_URL \
	&& tar -xzvf $QTUM_DIST -C /usr/local --strip-components=1 \
	&& rm /tmp/qtum*

# create data directory
ENV QTUM_DATA /data
RUN mkdir $QTUM_DATA \
	&& ln -sfn $QTUM_DATA /root/.qtum \
VOLUME /data

EXPOSE 3888 3889 13888 13889
CMD ["qtumd"]
