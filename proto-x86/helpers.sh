#!/bin/bash
function qx86start() {
    docker run --rm -v "${PWD}:/root/bind" --name qx86 -d qtumx86 qtum/src/qtumd -regtest -logevents
}
export -f qx86start

function qx86stop() {
    docker stop qx86
}
export -f qx86stop

alias qx86cli='docker exec qx86 qcli'

function qx86deploy() {
    docker exec -t qx86 deploy_contract `cat $1`
}
export -f qx86deploy

function qx86tb() {
    docker run --rm -v "${PWD}:/root/bind" qtumx86 x86tb
}
export -f qx86tb

function qx86make() {
    docker run --rm -v "${PWD}:/root/bind" qtumx86 qmake "$@"
}
export -f qx86make

