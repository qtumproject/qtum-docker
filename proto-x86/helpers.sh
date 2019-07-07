#!/bin/bash
function qx86start() {
    docker run --rm -v "${PWD}:/root/bind" --name qx86 -d qtum-alpine qtumd -regtest -logevents -printtoconsole
}
export -f qx86start

function qx86stop() {
    docker stop qx86
}
export -f qx86stop

alias qx86cli='docker  exec qx86 qtum-cli -regtest'

function qx86deploy() {
    docker exec -t qx86 qtum-cli -regtest createcontract `cat $1`
}
export -f qx86deploy

function qx86make() {
    docker run --rm -v "${PWD}:/root/bind" -w "/root/bind" qtumtoolchain-alpine make
}
export -f qx86make

function qx86simpleabi() {
    docker run --rm -it -v "${PWD}:/root/bind" -w /root/bind qtum-simpleabi -a "$1" -d -e
}

export -f qx86simpleabi
