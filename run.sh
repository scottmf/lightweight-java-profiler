#!/bin/bash -x

cd /workdir
make clean && make compile
./runtest.sh
