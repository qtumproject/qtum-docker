#!/bin/bash
cd client 
./build.sh
cd ../toolchain
./build.sh
cd simpleabi && docker build -t qtum-simpleabi .