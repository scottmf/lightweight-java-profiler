# Lightweight Java Profiler

### Updates to project:

1. profiler will not run unless the file /tmp/profile exists
2. current state can be dumped by issuing a SIGUSR1 to the java process
3. added test java code

to run:
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

to dump current state:

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
