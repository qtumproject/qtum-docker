# Quickstart

This Dockerfile trace the latest dev version of qtum-bitcore, which is forked of Bitcore to work on Qtum - Not as well tested and primarily used for the extra RPC calls needed for the block explorer

## Get docker image

You might take either way:

### Pull a image from Public Docker hub

```
$ docker pull qtum/qtum-bitcore:latest
```

### Or, build qtum image with provided Dockerfile

This is recommended since it ensures build the latest dev version of qtum-bitcore.

```
$docker build --rm -t qtum/qtum-bitcore:latest .
```

## Prepare data path and qtum.conf

In order to use user-defined config file, as well as save block chain data, -v option for docker is recommended.

First chose a path to save qtum block chain data:

```
sudo rm -rf /data/qtum-data
sudo mkdir -p /data/qtum-data
sudo chmod a+w /data/qtum-data
```

Create your config file, refer to the example [qtum.conf]!(https://github.com/qtumproject/qtum/blob/1a926b980f03e97322c7dd787835bec1730f35d2/contrib/debian/examples/qtum.conf). Note rpcuser and rpcpassword to required for later `qtum-cli` usage for docker, so it is better to set those two options. Then please create the file ${PWD}/qtum.conf with content:

```
rpcuser=qtum
rpcpassword=qtumtest

# This will allow you to RPC from your localhost outside the container
rpcallowip=0.0.0.0/0
rpcbind=0.0.0.0
```

## Launch qtumd

To launch qtum node:

```
## to launch qtumd
$ docker run -d --rm --name qtum_node \
             -v ${PWD}/qtum.conf:/root/.qtum/qtum.conf \
             -v /data/qtum-data/:/root/.qtum/ \
             -p 127.0.0.1:3889:3889 \
             qtum/qtum-bitcore:latest qtumd

## check docker processed
$ docker ps

## to stop qtumd
$ docker run -i --network container:qtum_node \
             -v ${PWD}/qtum.conf:/root/.qtum/qtum.conf \
             -v /data/qtum-data/:/root/.qtum/ \
             qtum/qtum-bitcore:latest qtum-cli stop
```

`${PWD}/qtum.conf` will be used, and blockchain data saved under /data/qtum-data/

## Interact with `qtumd` using `qtum-cli`

Use following docker command to interact with your qtum node with `qtum-cli`:

```
$ docker run -i --network container:qtum_node \
             -v ${PWD}/qtum.conf:/root/.qtum/qtum.conf \
             -v /data/qtum-data/:/root/.qtum/ \
             qtum/qtum-bitcore:latest qtum-cli getblockchaininfo
```

For more qtum-cli commands, use:

```
$ docker run -i --network container:qtum_node \
             -v ${PWD}/qtum.conf:/root/.qtum/qtum.conf \
             -v /data/qtum-data/:/root/.qtum/ \
             qtum/qtum-bitcore:latest qtum-cli help
```

## RPC from outside container

While the qtum-bitcore node container is running, you can do RPC outside the container on your localhost like this:

```
curl -i --user qtum:qtumtest --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getblockchaininfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:3889/
```

