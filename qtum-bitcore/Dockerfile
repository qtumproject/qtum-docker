FROM ubuntu
MAINTAINER pandazwb

RUN set -ex \
    && apt-get update \
    && apt-get install -y -qq --no-install-recommends ca-certificates git wget apt-utils \
    && apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils \
    && apt-get install -y libboost-all-dev \
	&& apt-get install -y software-properties-common \
	&& add-apt-repository -y ppa:bitcoin/bitcoin \
	&& apt-get update \
	&& apt-get install -y libdb4.8-dev libdb4.8++-dev \
	&& apt-get install -y libzmq3-dev \
 	&& rm -rf /var/lib/apt/lists/*

# install qtum from github
RUN cd /tmp && git clone --recursive https://github.com/qtumproject/qtum.git \
	&& cd qtum \
	&& ./autogen.sh \
	&& ./configure --enable-bitcore-rpc --without-gui \
	&& make install  \
	&& rm -rf /tmp/*

# create data directory
ENV QTUM_DATA /data
RUN mkdir $QTUM_DATA \
	&& ln -sfn $QTUM_DATA /root/.qtum \
VOLUME /data

EXPOSE 3888 3889 13888 13889
CMD ["qtumd"]
