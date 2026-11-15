public class Hello {
    static int fib(int n) { return n < 2 ? n : fib(n - 1) + fib(n - 2); }
    public static void main(String[] a) {
        System.out.println("Hello from CLDC-HI on J2MEWP!");
        long t = System.currentTimeMillis();
        int r = fib(30);
        System.out.println("fib(30)=" + r + " in " + (System.currentTimeMillis() - t) + " ms");
    }
}
