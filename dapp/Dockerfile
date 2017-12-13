FROM ubuntu as tools
MAINTAINER pandazwb

RUN apt-get update && \
  apt-get install -y wget unzip && \
  apt-get install -y curl vim-tiny less && \
  rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/mattn/goreman/releases/download/v0.0.10/goreman_linux_amd64.zip && \
  unzip -o -d /usr/local/bin goreman_linux_amd64.zip && \
  rm goreman_linux_amd64.zip

ENV QTUM_RELEASE qtum-0.14.10-x86_64-linux-gnu.tar.gz

RUN wget https://github.com/qtumproject/qtum/releases/download/mainnet-ignition-v1.1.4/$QTUM_RELEASE && \
  tar -xf $QTUM_RELEASE -C /usr/local --strip-components=1 --exclude=*-qt --exclude=test_qtum --exclude=qtum-tx && \
  rm $QTUM_RELEASE

RUN wget https://github.com/ethereum/solidity/releases/download/v0.4.19/solc-static-linux -O /usr/local/bin/solc && \
   chmod 0755 /usr/local/bin/solc

RUN wget https://github.com/qtumproject/solar/releases/download/0.0.7/solar-linux-amd64 -O /usr/local/bin/solar && chmod 0755 /usr/local/bin/solar

RUN wget https://github.com/hayeah/qtum-portal/releases/download/0.0.4/qtumportal-linux -O /usr/local/bin/qtumportal && chmod 0755 /usr/local/bin/qtumportal

# Use multi-stage build makes the image smaller by about 80 MB
FROM jeanblanchard/alpine-glibc

# RUN apt-get update && \
#   apt-get install -y curl vim-tiny less && \
#   rm -rf /var/lib/apt/lists/*

ENV QTUM_DATADIR /dapp/.qtum
ENV QTUM_RPC_USER qtum
ENV QTUM_RPC_PASS test
ENV QTUM_RPC http://$QTUM_RPC_USER:$QTUM_RPC_PASS@localhost:13889
ENV QTUM_NETWORK regtest

VOLUME /dapp

COPY --from=tools /usr/local/bin /usr/local/bin

COPY qcli /usr/local/bin
COPY qtumd-launch /usr/local/bin
COPY Procfile /Procfile

# 9888: qtumportal DApp RPC service
# 9899: qtumportal auth service
# 13889: qtumd RPC
EXPOSE 9888 9899 13889

WORKDIR /dapp

# 172.17.0.0/16 is the network submask for docker's bridge network.
# -rpcallowip=172.17.0.0/16 permits RPC access from docker host
CMD mkdir -p $QTUM_DATADIR && goreman -f /Procfile start