#!/bin/bash -x

function check_state() {
    pkill -SIGUSR1 -f teststack
    sleep 1
    while [ ! `ls /tmp/currstate*` ]; do sleep 1; done
    egrep "teststack.lambda$main$1" /tmp/currstate* > /dev/null
    if [ "$?" == 0 ]
    then
        cat /tmp/currstate*
        echo "test passed!"
    else
        cat /tmp/currstate*
        echo "test did not pass - no occurrences of teststack.method in /tmp/currstate*" && exit 1
    fi
    rm /tmp/currstate*
}

JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
TESTFILE="/tmp/teststack"
touch /tmp/profile
make testjava
rm -f $TESTFILE
${JAVA_HOME}/bin/java -agentpath:$PWD/build-64/liblagent.so=file=$TESTFILE teststack &
sleep 5
check_state
sleep 5
check_state
wait `jobs -p`
sleep 1
[ ! -f "$TESTFILE" ] && echo "error $TESTFILE does not exist" && exit 1
[ ! -s "$TESTFILE" ] && echo "error $TESTFILE is empty" && exit 1
exit 0
