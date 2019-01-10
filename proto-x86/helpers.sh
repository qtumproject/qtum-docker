#!/bin/bash
export STARTQTUM="docker run --rm -v ""${PWD}:/root/bind"" --name qx86 -d qtumx86 qtum/src/qtumd -regtest -logevents"
export RESETQTUM="docker rm -f qx86 && $STARTQTUM"
export STOPQTUM='docker stop qx86'
export QCLI='docker exec qx86 qcli'

function qtumdeploy() {
    docker exec -t qx86 deploy_contract `hexdump -e \"%x\" $1` 
}
export -f qtumdeploy

export X86TB="docker run --rm -v ""${PWD}:/root/bind"" qtumx86 x86tb"
export QMAKE="docker run --rm -v ""${PWD}:/root/bind"" qtumx86 qmake"