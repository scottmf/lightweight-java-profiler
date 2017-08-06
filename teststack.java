public class teststack {
    public static void main (String[] args) throws Exception {
        Thread t = new Thread(() -> {
            for (int i=0; i<10000; i++) {
                method(i);
                method2(i);
            }
        });
        t.setDaemon(false);
        t.start();
        t.join(15000);
    }

    private static void method2(int i) {
        try {
            Thread.sleep(5);
        } catch (Exception e) {}
    }

    private static void method(int i) {
        if (i % 500 == 0) {
            System.out.println(i);
        }
        try {
            Thread.sleep(5);
        } catch (Exception e) {}
    }

}
