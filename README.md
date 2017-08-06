# Lightweight Java Profiler

Forked from https://code.google.com/p/lightweight-java-profiler/

### Updates to project:

1. profiler will not run unless the file /tmp/profile exists
2. current state is dumped by issuing a SIGUSR1 to the java process
3. added test java code

#### to compile/test in a docker container
    $ make docker-compile
<details>
  <summary>Output (Click to expand)</summary>
<pre>
  docker build . -t ljp-jessie:latest -q
  sha256:d1a391f06294ffa83ab47d7345df5c944d9cb2ee0feb7c8879ba4cb9ec5e476b
  docker run --privileged=true -it -v /home/scott/workspace/lightweight-java-profiler:/workdir ljp-jessie:latest
  + cd /workdir
  + make clean
  rm -rf build-64/* *.class
  + make compile
  g++ -I/usr/lib/jvm/java-8-openjdk-amd64//include -I/usr/lib/jvm/java-8-openjdk-amd64//include/linux -mfpmath=sse -std=gnu++0x -fdiagnostics-show-option -fno-exceptions -fno-omit-frame-pointer -fno-strict-aliasing -funsigned-char -fno-asynchronous-unwind-tables -m64 -msse2 -g -D__STDC_FORMAT_MACROS -Wframe-larger-than=16384 -Wno-unused-but-set-variable -Wunused-but-set-parameter -Wvla -Wno-conversion-null -Wno-builtin-macro-redefined -Wall -Werror -Wformat-security -Wno-char-subscripts -Wno-sign-compare -Wno-strict-overflow -Wwrite-strings -Wnon-virtual-dtor -Woverloaded-virtual -O2 -Fvisibility=hidden -fPIC -c /workdir/src/profiler.cc -o build-64/profiler.pic.o
  g++ -I/usr/lib/jvm/java-8-openjdk-amd64//include -I/usr/lib/jvm/java-8-openjdk-amd64//include/linux -mfpmath=sse -std=gnu++0x -fdiagnostics-show-option -fno-exceptions -fno-omit-frame-pointer -fno-strict-aliasing -funsigned-char -fno-asynchronous-unwind-tables -m64 -msse2 -g -D__STDC_FORMAT_MACROS -Wframe-larger-than=16384 -Wno-unused-but-set-variable -Wunused-but-set-parameter -Wvla -Wno-conversion-null -Wno-builtin-macro-redefined -Wall -Werror -Wformat-security -Wno-char-subscripts -Wno-sign-compare -Wno-strict-overflow -Wwrite-strings -Wnon-virtual-dtor -Woverloaded-virtual -O2 -Fvisibility=hidden -fPIC -c /workdir/src/display.cc -o build-64/display.pic.o
  g++ -I/usr/lib/jvm/java-8-openjdk-amd64//include -I/usr/lib/jvm/java-8-openjdk-amd64//include/linux -mfpmath=sse -std=gnu++0x -fdiagnostics-show-option -fno-exceptions -fno-omit-frame-pointer -fno-strict-aliasing -funsigned-char -fno-asynchronous-unwind-tables -m64 -msse2 -g -D__STDC_FORMAT_MACROS -Wframe-larger-than=16384 -Wno-unused-but-set-variable -Wunused-but-set-parameter -Wvla -Wno-conversion-null -Wno-builtin-macro-redefined -Wall -Werror -Wformat-security -Wno-char-subscripts -Wno-sign-compare -Wno-strict-overflow -Wwrite-strings -Wnon-virtual-dtor -Woverloaded-virtual -O2 -Fvisibility=hidden -fPIC -c /workdir/src/entry.cc -o build-64/entry.pic.o
  g++ -mfpmath=sse -std=gnu++0x -fdiagnostics-show-option -fno-exceptions -fno-omit-frame-pointer -fno-strict-aliasing -funsigned-char -fno-asynchronous-unwind-tables -m64 -msse2 -g -D__STDC_FORMAT_MACROS -Wframe-larger-than=16384 -Wno-unused-but-set-variable -Wunused-but-set-parameter -Wvla -Wno-conversion-null -Wno-builtin-macro-redefined -Wall -Werror -Wformat-security -Wno-char-subscripts -Wno-sign-compare -Wno-strict-overflow -Wwrite-strings -Wnon-virtual-dtor -Woverloaded-virtual -O2 -shared -o build-64/liblagent.so \
    -Bsymbolic build-64/profiler.pic.o build-64/display.pic.o build-64/entry.pic.o -ldl
  + ./runtest.sh
  + JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
  + TESTFILE=/tmp/teststack
  + touch /tmp/profile
  + make testjava
  /usr/lib/jvm/java-8-openjdk-amd64//bin/javac teststack.java
  + rm -f /tmp/teststack
  + sleep 5
  + /usr/lib/jvm/java-8-openjdk-amd64//bin/java -agentpath:/workdir/build-64/liblagent.so=file=/tmp/teststack teststack
  0
  + check_state
  + pkill -SIGUSR1 -f teststack
  ++ ls /tmp/currstate-2017-08-06-22-10-32
  + '[' '!' /tmp/currstate-2017-08-06-22-10-32 ']'
  + egrep 'teststack\.method|teststack\.main' /tmp/currstate-2017-08-06-22-10-32
  + '[' 0 == 0 ']'
  + echo 'test passed!'
  test passed!
  + rm /tmp/currstate-2017-08-06-22-10-32
  + sleep 5
  500
  + check_state
  + pkill -SIGUSR1 -f teststack
  ++ ls /tmp/currstate-2017-08-06-22-10-37
  + '[' '!' /tmp/currstate-2017-08-06-22-10-37 ']'
  + egrep 'teststack\.method|teststack\.main' /tmp/currstate-2017-08-06-22-10-37
  + '[' 0 == 0 ']'
  + echo 'test passed!'
  test passed!
  + rm /tmp/currstate-2017-08-06-22-10-37
  ++ jobs -p
  + wait 66
  1000
  1500
  2000
  2500
  + sleep 1
  + '[' '!' -f /tmp/teststack ']'
  + '[' '!' -s /tmp/teststack ']'
  + exit 0
</pre>
</details>


##### to compile (switch to 32 bit binary by removing BITS=64):

    $ make BITS=64 clean compile
    rm -rf build-64/* *.class
    g++ -I/usr/jdk/latest/include -I/usr/jdk/latest/include/linux -mfpmath=sse -std=gnu++0x -fdiagnostics-show-option -fno-exceptions -fno-omit-frame-pointer -fno-strict-aliasing -funsigned-char -fno-asynchronous-unwind-tables -m64 -msse2 -g -D__STDC_FORMAT_MACROS -Wframe-larger-than=16384 -Wno-unused-but-set-variable -Wunused-but-set-parameter -Wvla -Wno-conversion-null -Wno-builtin-macro-redefined -Wall -Werror -Wformat-security -Wno-char-subscripts -Wno-sign-compare -Wno-strict-overflow -Wwrite-strings -Wnon-virtual-dtor -Woverloaded-virtual -O2 -Fvisibility=hidden -fPIC -c /home/scott/workspace/lightweight-java-profiler/src/display.cc -o build-64/display.pic.o
    g++ -I/usr/jdk/latest/include -I/usr/jdk/latest/include/linux -mfpmath=sse -std=gnu++0x -fdiagnostics-show-option -fno-exceptions -fno-omit-frame-pointer -fno-strict-aliasing -funsigned-char -fno-asynchronous-unwind-tables -m64 -msse2 -g -D__STDC_FORMAT_MACROS -Wframe-larger-than=16384 -Wno-unused-but-set-variable -Wunused-but-set-parameter -Wvla -Wno-conversion-null -Wno-builtin-macro-redefined -Wall -Werror -Wformat-security -Wno-char-subscripts -Wno-sign-compare -Wno-strict-overflow -Wwrite-strings -Wnon-virtual-dtor -Woverloaded-virtual -O2 -Fvisibility=hidden -fPIC -c /home/scott/workspace/lightweight-java-profiler/src/entry.cc -o build-64/entry.pic.o
    g++ -I/usr/jdk/latest/include -I/usr/jdk/latest/include/linux -mfpmath=sse -std=gnu++0x -fdiagnostics-show-option -fno-exceptions -fno-omit-frame-pointer -fno-strict-aliasing -funsigned-char -fno-asynchronous-unwind-tables -m64 -msse2 -g -D__STDC_FORMAT_MACROS -Wframe-larger-than=16384 -Wno-unused-but-set-variable -Wunused-but-set-parameter -Wvla -Wno-conversion-null -Wno-builtin-macro-redefined -Wall -Werror -Wformat-security -Wno-char-subscripts -Wno-sign-compare -Wno-strict-overflow -Wwrite-strings -Wnon-virtual-dtor -Woverloaded-virtual -O2 -Fvisibility=hidden -fPIC -c /home/scott/workspace/lightweight-java-profiler/src/profiler.cc -o build-64/profiler.pic.o
    g++ -mfpmath=sse -std=gnu++0x -fdiagnostics-show-option -fno-exceptions -fno-omit-frame-pointer -fno-strict-aliasing -funsigned-char -fno-asynchronous-unwind-tables -m64 -msse2 -g -D__STDC_FORMAT_MACROS -Wframe-larger-than=16384 -Wno-unused-but-set-variable -Wunused-but-set-parameter -Wvla -Wno-conversion-null -Wno-builtin-macro-redefined -Wall -Werror -Wformat-security -Wno-char-subscripts -Wno-sign-compare -Wno-strict-overflow -Wwrite-strings -Wnon-virtual-dtor -Woverloaded-virtual -O2 -shared -o build-64/liblagent.so \
          -Bsymbolic build-64/display.pic.o build-64/entry.pic.o build-64/profiler.pic.o -ldl

##### to run test:

    $ ./runtest.sh
    /usr/jdk/latest/bin/javac teststack.java
    0
    500
    1000
    1500
    test passed!
    $ ls /tmp/teststack
    /tmp/teststack
    $ head /tmp/teststack
    1
    1 41    java.lang.String.replace(String.java:2067)
            sun.invoke.util.BytecodeDescriptor.unparseSig(BytecodeDescriptor.java:132)
            sun.invoke.util.BytecodeDescriptor.unparseMethod(BytecodeDescriptor.java:119)
            sun.invoke.util.BytecodeDescriptor.unparse(BytecodeDescriptor.java:104)
            java.lang.invoke.MethodType.toMethodDescriptorString(MethodType.java:1090)
            java.lang.invoke.InvokerBytecodeGenerator.emitStaticInvoke(InvokerBytecodeGenerator.java:840)
            java.lang.invoke.InvokerBytecodeGenerator.generateCustomizedCodeBytes(InvokerBytecodeGenerator.java:689)
            java.lang.invoke.InvokerBytecodeGenerator.generateCustomizedCode(InvokerBytecodeGenerator.java:616)
            java.lang.invoke.LambdaForm.compileToBytecode(LambdaForm.java:629)

##### to dump current state of the test prog (script runs equivalent of kill -USR1 &lt;pid&gt;):

    $ ./runanddumpstate.sh
    /usr/jdk/latest/bin/javac teststack.java
    $ date
    Fri Jan 22 16:48:22 PST 2016
    $ ls /tmp/currstate-2016-01-22-16-48-19 /tmp/teststack
    /tmp/currstate-2016-01-22-16-48-19  /tmp/teststack
    $ head /tmp/currstate-2016-01-22-16-48-19
    1 40    java.lang.Object.hashCode(Object.java:-1)
            java.lang.invoke.MethodType.hashCode(MethodType.java:777)
            java.lang.invoke.MethodType$ConcurrentWeakInternSet$WeakEntry.<init>(MethodType.java:1284)
            java.lang.invoke.MethodType$ConcurrentWeakInternSet.get(MethodType.java:1230)
            java.lang.invoke.MethodType.makeImpl(MethodType.java:301)
            java.lang.invoke.MethodType.methodType(MethodType.java:206)
            java.lang.invoke.LambdaForm.signatureType(LambdaForm.java:538)
            java.lang.invoke.LambdaForm.methodType(LambdaForm.java:503)
            java.lang.invoke.LambdaForm.compileToBytecode(LambdaForm.java:623)
            java.lang.invoke.DirectMethodHandle.maybeCompile(DirectMethodHandle.java:265)
