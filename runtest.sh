#!/bin/bash --

make testjava
TESTFILE="/tmp/teststack"
rm -f $TESTFILE
${JAVA_HOME}/bin/java -agentpath:/home/scott/workspace/lightweight-java-profiler/build-64/liblagent.so=file=$TESTFILE teststack 2>/dev/null
[ ! -f "$TESTFILE" ] && echo "error $TESTFILE does not exist" && exit 1
[ ! -s "$TESTFILE" ] && echo "error $TESTFILE is empty" && exit 1
grep "teststack.method" $TESTFILE > /dev/null
if [ "$?" == 0 ]
then
    echo "test passed!" && exit 0
else
    echo "test did not pass - no occurrences of teststack.method in $TESTFILE" && exit 1
fi
