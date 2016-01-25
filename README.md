# Lightweight Java Profiler

Forked from https://code.google.com/p/lightweight-java-profiler/

### Updates to project:

1. profiler will not run unless the file /tmp/profile exists
2. current state is dumped by issuing a SIGUSR1 to the java process
3. added test java code

##### to compile (switch to 32 bit binary by removing BITS=64):

    $ make BITS=64 clean all
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
