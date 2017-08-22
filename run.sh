#!/bin/bash -x

cd /workdir
make clean && make compile
[ $? != 0 ] && exit 1
./runtest.sh
