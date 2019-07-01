#!/bin/bash
./client/build.sh
./toolchain/build.sh
cd simpleabi && docker build -t qtum-simpleabi .