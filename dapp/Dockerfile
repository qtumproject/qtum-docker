FROM ubuntu as tools
MAINTAINER pandazwb

RUN apt-get update && apt-get install -y curl lsof wget unzip

RUN wget https://github.com/ethereum/solidity/releases/download/v0.4.18/solc-static-linux -O /usr/local/bin/solc && \
   chmod 0755 /usr/local/bin/solc

RUN wget https://github.com/mattn/goreman/releases/download/v0.0.10/goreman_linux_amd64.zip && \
  unzip -o -d /usr/local/bin goreman_linux_amd64.zip

RUN wget https://github.com/qtumproject/qtum/releases/download/mainnet-ignition-v1.1.1/qtum-0.14.7-x86_64-linux-gnu.tar.gz && \
  tar -xf qtum-0.14.7-x86_64-linux-gnu.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt --exclude=test_qtum --exclude=qtum-tx

RUN wget https://github.com/hayeah/solar/releases/download/0.0.3/solar-linux-amd64 -O /usr/local/bin/solar && chmod 0755 /usr/local/bin/solar

RUN wget https://github.com/hayeah/qtum-portal/releases/download/0.0.3/qtumportal-linux -O /usr/local/bin/qtumportal && chmod 0755 /usr/local/bin/qtumportal

# second stage

FROM ubuntu
ENV QTUM_DATADIR /dapp/.qtum
ENV QTUM_RPC_USER qtum
ENV QTUM_RPC_PASS test
ENV QTUM_RPC http://$QTUM_RPC_USER:$QTUM_RPC_PASS@localhost:13889

VOLUME /dapp

COPY --from=tools /usr/local/bin /usr/local/bin

COPY qcli /usr/local/bin
COPY Procfile /Procfile
COPY qtum.conf /root/.qtum/qtum.conf

# 9888: qtumportal DApp RPC service
# 9899: qtumportal auth service
# 13889: qtumd RPC (don't expose)
EXPOSE 9888 9899

WORKDIR /dapp

# 172.17.0.0/16 is the network submask for docker's bridge network.
# -rpcallowip=172.17.0.0/16 permits RPC access from docker host
CMD mkdir -p $QTUM_DATADIR && goreman -f /Procfile start