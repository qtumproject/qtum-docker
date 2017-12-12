# Quickstart

This is a qtum-qt image, launch GUI wallet

## Get docker image

You might take either way:

### Pull a image from Public Docker hub

```
$ docker pull qtum/qtum:qtum-qt
```

### Or, build qtum image with provided Dockerfile

```
$docker build --rm -t qtum/qtum:qtum-qt .
```

## Prepare data path & qtum.conf

In order to use user-defined config file, as well as save block chain data, -v option for docker is recommended.

First chose a path to save qtum block chain data:

```
sudo rm -rf /data/qtum-data
sudo mkdir -p /data/qtum-data
sudo chmod a+w /data/qtum-data
```

Create your config file, refer to the example [qtum.conf]!(https://github.com/qtumproject/qtum/blob/1a926b980f03e97322c7dd787835bec1730f35d2/contrib/debian/examples/qtum.conf). Then please create the file ${PWD}/qtum.conf with content:

```
rpcuser=qtum
rpcpassword=qtumtest
```

User can set their own config file on demands.

## Launch qtum-qt

For Linux:

```
$ docker run -it --rm -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -v ${PWD}/qtum.conf:/root/.qtum/qtum.conf -v /data/qtum-data/:/root/.qtum/ qtum/qtum:qtum-qt
```

For Mac:

Please refer to
[https://cntnr.io/running-guis-with-docker-on-mac-os-x-a14df6a76efc](https://cntnr.io/running-guis-with-docker-on-mac-os-x-a14df6a76efc) about how to run gui with docker on mac.

```
## install & launch socat
$ brew install socat
$ socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"

## install & open Xquartz
$ brew install xquartz
$ open -a Xquartz

## then set Xquartz preferences "Security-'Allow connections from network clients'"

## launch qtum-qt 
$ docker run -e DISPLAY=<your_ip>:0 -v ${PWD}/qtum.conf:/root/.qtum/qtum.conf -v /data/qtum-data/:/root/.qtum/ qtum/qtum:qtum-qt

```


`${PWD}/qtum.conf` will be used, and blockchain data saved under /data/qtum-data/


## exit qtum-qt

Just close the gui wallet.


