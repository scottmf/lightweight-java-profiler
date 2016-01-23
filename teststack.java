public class teststack {
    public static void main (String[] args) throws Exception {
        Thread t = new Thread(() -> {
            for (int i=0; i<2000; i++) {
                method(i);
            }
        });
        t.start();
        t.join();
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
