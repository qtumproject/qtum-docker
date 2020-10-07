FROM ubuntu as tools
MAINTAINER pandazwb

RUN apt-get update && \
  apt-get install -y wget unzip && \
  apt-get install -y curl vim-tiny less && \
  rm -rf /var/lib/apt/lists/*

ENV QTUM_RELEASE 0.15.2
ENV QTUM_RELEASE_TAR qtum-${QTUM_RELEASE}-x86_64-linux-gnu.tar.gz

RUN wget https://github.com/qtumproject/qtum/releases/download/mainnet-ignition-v${QTUM_RELEASE}/${QTUM_RELEASE_TAR} && \
  tar -xf $QTUM_RELEASE_TAR -C /usr/local --strip-components=1 --exclude=*-qt --exclude=test_qtum --exclude=qtum-tx && \
  rm $QTUM_RELEASE_TAR

RUN wget https://github.com/ethereum/solidity/releases/download/v0.4.24/solc-static-linux -O /usr/local/bin/solc && \
   chmod 0755 /usr/local/bin/solc

RUN wget -v https://github.com/qtumproject/solar/releases/download/0.0.14/solar-linux-amd64 -O /usr/local/bin/solar && chmod 0755 /usr/local/bin/solar 

RUN wget https://github.com/qtumproject/qtumportal/releases/download/0.0.8/qtumportal-linux -O /usr/local/bin/qtumportal && chmod 0755 /usr/local/bin/qtumportal

RUN wget -v https://github.com/dcb9/janus/releases/download/0.0.6/janus-linux-amd64 -O /usr/local/bin/janus && chmod 0755 /usr/local/bin/janus

# Use multi-stage build makes the image smaller by about 80 MB
FROM jeanblanchard/alpine-glibc

# RUN apt-get update && \
#   apt-get install -y curl vim-tiny less && \
#   rm -rf /var/lib/apt/lists/*

RUN apk --no-cache add supervisor
ENV QTUM_DATADIR /dapp/.qtum
ENV QTUM_RPC_USER qtum
ENV QTUM_RPC_PASS test
ENV QTUM_RPC http://$QTUM_RPC_USER:$QTUM_RPC_PASS@localhost:3889
ENV QTUM_NETWORK regtest

VOLUME /dapp

COPY --from=tools /usr/local/bin /usr/local/bin


COPY qcli /usr/local/bin
COPY qtumd-launch /usr/local/bin
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

## local test
#COPY janus-linux-amd64 /usr/local/bin/janus

# 9888: qtumportal DApp RPC service
# 9899: qtumportal auth service
# 3889: qtumd RPC
# 3888: peering port
# 13888: peering port (testnet)
# 23889: janus (adapter to Ethereum JSON RPC)
EXPOSE 9888 9899 3889 3888 13888 23889

WORKDIR /dapp

# 172.17.0.0/16 is the network submask for docker's bridge network.
# -rpcallowip=172.17.0.0/16 permits RPC access from docker host
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
