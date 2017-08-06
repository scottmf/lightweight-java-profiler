#!/bin/bash -x

#export LD_LIBRARY_PATH="${JAVA_HOME}/lib/amd64/:${JAVA_HOME}/lib/visualvm/profiler/lib/deployed/jdk15/linux-amd64/:${JAVA_HOME}/jre/lib/amd64/:${LD_LIBRARY_PATH}"
make testjava
touch /tmp/profile
rm /tmp/currstate-*
TESTFILE="/tmp/teststack"
rm -f $TESTFILE
${JAVA_HOME}/bin/java -agentpath:$PWD/build-64/liblagent.so=file=$TESTFILE teststack 2>&1 >/dev/null &
sleep 5
pkill -USR1 -f teststack
sleep 5
pkill -USR1 -f teststack
sleep 5
pkill -USR1 -f teststack
sleep 2
pkill -f teststack
