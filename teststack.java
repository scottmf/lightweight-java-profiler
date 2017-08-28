public class teststack {
    public static void main (String[] args) throws Exception {
        Thread t = new Thread(() -> {
            for (int i=0; i<20000; i++) {
                if (i % 500 == 0) {
                    System.out.println(i);
                }
                try {
                    Thread.sleep(1000);
                } catch (Exception e) {}
            }
        });
        Thread adding = new Thread(() -> {
            int i=0;
            while (true) {
                i++;
            }
        });
        adding.setDaemon(true);
        adding.start();
        t.setDaemon(true);
        t.start();
        t.join(30000);
    }
}
