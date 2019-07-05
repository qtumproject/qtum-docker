# Quickstart

This Dockerfile trace the latest dev version of qtum.

## Get docker image

You might take either way:

### Pull a image from Public Docker hub

```
$ docker pull qtum/qtum:dev
```

### Or, build qtum image with provided Dockerfile

This is recommended since it ensures build the latest dev version.

```
$docker build --rm -t qtum/qtum:dev .
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
```
## Launch qtumd

To launch qtum node:

```
## to launch qtumd
$ docker run -d --rm --name qtum_node -v ${PWD}/qtum.conf:/root/.qtum/qtum.conf -v /data/qtum-data/:/root/.qtum/ qtum/qtum:dev qtumd

## check docker processed
$ docker ps

## to stop qtumd
$ docker run -i --network container:qtum_node -v ${PWD}/qtum.conf:/root/.qtum/qtum.conf -v /data/qtum-data/:/root/.qtum/ qtum/qtum:dev qtum-cli stop
```

`${PWD}/qtum.conf` will be used, and blockchain data saved under /data/qtum-data/

## Interact with `qtumd` using `qtum-cli`

Use following docker command to interact with your qtum node with `qtum-cli`:

```
$ docker run -i --network container:qtum_node -v ${PWD}/qtum.conf:/root/.qtum/qtum.conf -v /data/qtum-data/:/root/.qtum/ qtum/qtum:dev qtum-cli getblockchaininfo
```

For more qtum-cli commands, use:

```
$ docker run -i --network container:qtum_node -v ${PWD}/qtum.conf:/root/.qtum/qtum.conf -v /data/qtum-data/:/root/.qtum/ qtum/qtum:dev qtum-cli help
```

