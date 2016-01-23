#!/bin/bash --

make testjava
TESTFILE="/tmp/teststack"
rm -f $TESTFILE
${JAVA_HOME}/bin/java -agentpath:/home/scott/workspace/lightweight-java-profiler/build-64/liblagent.so=file=$TESTFILE teststack 2>&1 > /dev/null &
sleep 5
pkill -USR1 -f teststack
