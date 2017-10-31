FROM debian:stretch-slim
MAINTAINER pandazwb

ENV QTUM_VERSION 1.0.3
#ENV QTUM_URL https://github.com/qtumproject/qtum/releases/download/mainnet-ignition-v1.0.3/qtum-0.14.4-x86_64-linux-gnu.tar.gz

# install qtum binaries
COPY qtum-0.14.4-x86_64-linux-gnu.tar.gz /tmp/qtum.tar.gz
RUN set -ex \
	&& tar -xzvf /tmp/qtum.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm /tmp/qtum*

# create data directory
ENV QTUM_DATA /data
RUN mkdir $QTUM_DATA \
	&& ln -sfn $QTUM_DATA /root/.qtum \
VOLUME /data

EXPOSE 3888 3889 13888 13889
CMD ["qtumd"]
