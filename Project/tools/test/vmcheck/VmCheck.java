import javax.microedition.midlet.MIDlet;
import javax.microedition.lcdui.*;
import java.util.*;

/* J2MEWP: interpreter self-test for new VM ports. Prints "[chk] name got expected OK|BAD" to j2me.log. */
public class VmCheck extends MIDlet implements Runnable {
    static int bad;
    static int i(String s) { return Integer.parseInt(s); }
    static long l(String s) { return Long.parseLong(s); }

    static void ck(String n, long got, long exp) {
        if (got != exp) bad++;
        System.out.println("[chk] " + n + " " + got + " " + exp + (got == exp ? " OK" : " BAD"));
    }
    static void ckb(String n, boolean got, boolean exp) { ck(n, got ? 1 : 0, exp ? 1 : 0); }

    public void startApp() { new Thread(this).start(); }
    public void pauseApp() {}
    public void destroyApp(boolean u) {}

    public void run() {
        long a = l("123456789012"), b = l("-98765"), z = l("0"), big = l("4294967296");
        int x = i("1000"), y = i("-7");
        ck("ladd", a + b, 123456690247L);
        ck("lsub", a - b, 123456887777L);
        ck("lmul", a * b, -12193209766770180L);
        ck("ldiv", a / b, -1250005L);
        ck("lrem", a % b, 45187L);
        ck("lneg", -a, -123456789012L);
        ck("lshl", a << 3, 987654312096L);
        ck("lshl40", b << 40, -108593265917296640L);
        ck("lshr", b >> 2, -24692L);
        ck("lushr", b >>> 40, 16777215L);
        ck("land", a & big - 1, 3197704724L);
        ck("lor", a | 1, 123456789013L);
        ck("lxor", a ^ b, -123456756697L);
        ckb("lcmp_gt", a > b, true);
        ckb("lcmp_lt", b < z, true);
        ckb("lcmp_eq", a == l("123456789012"), true);
        ckb("lcmp_hi", big > l("4294967295"), true);
        ckb("lcmp_hi2", l("4294967295") < big, true);
        ckb("lcmp_neg", l("-4294967296") < l("-1"), true);
        ck("i2l", (long) y, -7L);
        ck("l2i", (int) a, -1097262572L);
        ck("iadd", x + y, 993);
        ck("imul", x * y, -7000);
        ck("idiv", x / y, -142);
        ck("irem", x % y, 6);
        ck("ishr", y >> 1, -4);
        ck("iushr", y >>> 28, 15);
        float f = Float.parseFloat("2.5"); double d = Double.parseDouble("-1.25");
        ck("fmul", (long) (f * 4), 10);
        ck("dmul", (long) (d * 8), -10);
        ck("f2l", (long) (f * 1e9f), 2500000000L);
        ck("d2l", (long) (d * 1e12), -1250000000000L);
        ck("l2d", (long) ((double) a / 2), 61728394506L);
        int w = 0;
        for (int k = 0; k < 300; k++) w += k;   // big loop: iinc / goto (wide iinc below)
        ck("loop", w, 44850);
        int v = i("500"); v -= 400; v += 1000;  // iinc_w
        ck("iinc_w", v, 1100);
        StringBuffer sb = new StringBuffer(); sb.append(a).append(',').append(d);
        System.out.println("[chk] str " + sb.toString());
        long t0 = System.currentTimeMillis();
        System.out.println("[chk] time " + t0);
        ckb("time_sane", t0 > l("1500000000000"), true);
        try {
            for (int k = 0; k < 3; k++) {
                long s0 = System.currentTimeMillis();
                Thread.sleep(50);
                long dt = System.currentTimeMillis() - s0;
                System.out.println("[chk] sleep50 took " + dt + (dt >= 40 && dt < 500 ? " OK" : " BAD"));
            }
            Object o = new Object();
            synchronized (o) {
                long s0 = System.currentTimeMillis();
                o.wait(100);
                System.out.println("[chk] wait100 took " + (System.currentTimeMillis() - s0));
            }
        } catch (InterruptedException e) {
            System.out.println("[chk] interrupted");
        }
        more();
        System.out.println("[chk] DONE bad=" + bad);
        notifyDestroyed();
    }

    // ---- round 2: threads, switches, arrays, exceptions, interfaces, Canvas ----
    static final Object lock = new Object();
    static volatile boolean flag;
    static int counter;
    static synchronized void inc() { counter++; }

    interface Shape { int area(); }
    static class Sq implements Shape { int s; Sq(int s) { this.s = s; } public int area() { return s * s; } }

    static int tsw(int k) { switch (k) { case 0: return 10; case 1: return 11; case 2: return 12; case 3: return 13; default: return -1; } }
    static int lsw(int k) { switch (k) { case -1000: return 1; case 7: return 2; case 100000: return 3; default: return 0; } }
    static int thrower(int k) { if (k > 0) throw new IllegalStateException("x"); return k; }

    static class Init { static int v; static { v = sm() + 1; } static synchronized int sm() { return 41; } }
    int paints;
    void more() {
        ck("clinit_sync", Init.v, 42);
        ck("tswitch", tsw(i("2")) + tsw(i("9")), 11);
        ck("lswitch", lsw(i("100000")) * 10 + lsw(i("-1000")), 31);
        int[][] m = new int[i("3")][i("4")]; m[2][3] = 5;
        ck("multianew", m.length * 100 + m[2].length * 10 + m[2][3], 345);
        Object[] oa = new String[2];
        try { oa[0] = new Object(); ck("aastore_exc", 0, 1); } catch (ArrayStoreException e) { ck("aastore_exc", 1, 1); }
        try { int[] q = new int[2]; q[i("5")] = 1; ck("aioobe", 0, 1); } catch (ArrayIndexOutOfBoundsException e) { ck("aioobe", 1, 1); }
        try { String sn = null; if (i("1") > 0) sn.length(); ck("npe", 0, 1); } catch (NullPointerException e) { ck("npe", 1, 1); }
        try { thrower(i("1")); ck("athrow", 0, 1); } catch (IllegalStateException e) { ck("athrow", 1, 1); }
        try { int zz = i("0"); ck("idiv0", 10 / zz, -1); } catch (ArithmeticException e) { ck("idiv0", 1, 1); }
        try { long zz = l("0"); ck("ldiv0", 10L / zz, -1); } catch (ArithmeticException e) { ck("ldiv0", 1, 1); }
        Shape sh = new Sq(i("6"));
        ck("invokeinterface", sh.area(), 36);
        Object ob = sh;
        ckb("instanceof", ob instanceof Shape, true);
        try { String bad = (String) ob; ck("checkcast", 0, 1); } catch (ClassCastException e) { ck("checkcast", 1, 1); }
        ck("hash", "abc".hashCode(), 96354);
        try {
            // wait()/notify() across threads
            flag = false;
            Thread w = new Thread() { public void run() {
                synchronized (lock) { while (!flag) { try { lock.wait(); } catch (InterruptedException e) {} } }
            } };
            w.start();
            Thread.sleep(50);
            synchronized (lock) { flag = true; lock.notifyAll(); }
            long s0 = System.currentTimeMillis();
            w.join();
            System.out.println("[chk] notify+join took " + (System.currentTimeMillis() - s0));
            // contention on a synchronized method
            counter = 0;
            Thread[] ts = new Thread[3];
            for (int k = 0; k < 3; k++) { ts[k] = new Thread() { public void run() { for (int j = 0; j < 20000; j++) { inc(); if ((j & 1023) == 0) Thread.yield(); } } }; ts[k].start(); }
            for (int k = 0; k < 3; k++) ts[k].join();
            ck("sync_counter", counter, 60000);
            // busy thread + sleeping thread (preemption)
            flag = false;
            Thread spin = new Thread() { public void run() { long x = 0; while (!flag) x++; } };
            spin.start();
            long s1 = System.currentTimeMillis();
            Thread.sleep(100);
            flag = true; spin.join();
            System.out.println("[chk] sleep100 vs spinner took " + (System.currentTimeMillis() - s1));
        } catch (InterruptedException e) { System.out.println("[chk] interrupted2"); }
        // Canvas: repaint + serviceRepaints + callSerially
        final Canvas c = new Canvas() { protected void paint(Graphics g) { paints++; g.setColor(0xff0000); g.fillRect(0, 0, getWidth(), getHeight()); } };
        Display d = Display.getDisplay(this);
        d.setCurrent(c);
        for (int k = 0; k < 50 && !c.isShown(); k++) { try { Thread.sleep(20); } catch (InterruptedException e) {} }
        System.out.println("[chk] canvas shown=" + c.isShown() + " size=" + c.getWidth() + "x" + c.getHeight());
        long s2 = System.currentTimeMillis();
        for (int k = 0; k < 5; k++) { c.repaint(); c.serviceRepaints(); }
        System.out.println("[chk] 5x serviceRepaints took " + (System.currentTimeMillis() - s2) + " paints=" + paints);
        flag = false;
        d.callSerially(new Runnable() { public void run() { flag = true; } });
        for (int k = 0; k < 50 && !flag; k++) { try { Thread.sleep(20); } catch (InterruptedException e) {} }
        ckb("callSerially", flag, true);
        round6();
        round5();
        round4();
        queueTest();
        gameLoop(c);
    }

    // ---- round 3: EventQueue-like producer/consumer, game loop ----
    static Object qlock = new Object();
    static int[] q = new int[64];
    static int qh, qt, got;
    static volatile boolean qdone;
    void queueTest() {
        qh = qt = got = 0; qdone = false;
        final int N = 3000;
        Thread cons = new Thread() { public void run() {
            while (true) {
                int v;
                synchronized (qlock) {
                    while (qh == qt && !qdone) { try { qlock.wait(); } catch (InterruptedException e) {} }
                    if (qh == qt) return;
                    v = q[qh & 63]; qh++;
                    qlock.notifyAll();
                }
                synchronized (qlock) { synchronized (this) { got += (v == got ? 1 : 1000000); } }
            }
        } };
        cons.start();
        long s0 = System.currentTimeMillis();
        for (int k = 0; k < N; k++) {
            synchronized (qlock) {
                while (qt - qh >= 64) { try { qlock.wait(); } catch (InterruptedException e) {} }
                q[qt & 63] = k; qt++;
                qlock.notifyAll();
            }
            if ((k % 100) == 0) { try { Thread.sleep(1); } catch (InterruptedException e) {} }
            if ((k % 37) == 0) Thread.yield();
        }
        synchronized (qlock) { qdone = true; qlock.notifyAll(); }
        try { cons.join(); } catch (InterruptedException e) {}
        System.out.println("[chk] queue " + N + " msgs took " + (System.currentTimeMillis() - s0));
        ck("queue_got", got, N);
    }

    void gameLoop(Canvas c) {
        int p0 = paints;
        long s0 = System.currentTimeMillis();
        for (int k = 0; k < 150; k++) {
            c.repaint();
            c.serviceRepaints();
            try { Thread.sleep(20); } catch (InterruptedException e) {}
            if ((k % 50) == 49) System.out.println("[chk] frame " + (k + 1) + " paints=" + (paints - p0) + " t=" + (System.currentTimeMillis() - s0));
        }
        ckb("gameloop_paints", paints - p0 >= 140, true);
    }
    // ---- round 4: arraycopy, collections, strings, rare bytecodes ----
    static int fin;
    static int withFinally(int k) { try { if (k > 0) return k * 2; fin += 1; return -1; } finally { fin += 10; } }
    static long dupx(long[] a, int i) { return a[i] = a[i + 1] = l("5") + i; }
    static int dupx1(int[] a, int i) { return a[i] = i("7") + i; }
    static int fieldInc; static int incr() { return ++fieldInc; }
    int ifld; long lfld;
    void round4() {
        int bad0 = bad;
        int n = 0;
        for (int len = 0; len <= 40; len++) for (int so = 0; so < 5; so++) for (int dof = 0; dof < 5; dof++) {
            byte[] b1 = new byte[50], b2 = new byte[50], b3 = new byte[50];
            for (int k = 0; k < 50; k++) { b1[k] = (byte) (k * 7 + 3); b2[k] = b3[k] = (byte) -k; }
            System.arraycopy(b1, so, b2, dof, len);
            for (int k = 0; k < len; k++) b3[dof + k] = b1[so + k];
            for (int k = 0; k < 50; k++) if (b2[k] != b3[k]) { n++; System.out.println("[chk] bad byte copy so=" + so + " do=" + dof + " len=" + len); break; }
            char[] c1 = new char[50], c2 = new char[50], c3 = new char[50];
            for (int k = 0; k < 50; k++) { c1[k] = (char) (k * 31 + 1000); c2[k] = c3[k] = (char) k; }
            System.arraycopy(c1, so, c2, dof, len);
            for (int k = 0; k < len; k++) c3[dof + k] = c1[so + k];
            for (int k = 0; k < 50; k++) if (c2[k] != c3[k]) { n++; System.out.println("[chk] bad char copy so=" + so + " do=" + dof + " len=" + len); break; }
            short[] s1 = new short[50], s2 = new short[50], s3 = new short[50];
            for (int k = 0; k < 50; k++) { s1[k] = (short) (k * -1001); s2[k] = s3[k] = (short) k; }
            System.arraycopy(s1, so, s2, dof, len);
            for (int k = 0; k < len; k++) s3[dof + k] = s1[so + k];
            for (int k = 0; k < 50; k++) if (s2[k] != s3[k]) { n++; System.out.println("[chk] bad short copy so=" + so + " do=" + dof + " len=" + len); break; }
            int[] i1 = new int[50], i2 = new int[50], i3 = new int[50];
            for (int k = 0; k < 50; k++) { i1[k] = k * 100003; i2[k] = i3[k] = -k; }
            System.arraycopy(i1, so, i2, dof, len);
            for (int k = 0; k < len; k++) i3[dof + k] = i1[so + k];
            for (int k = 0; k < 50; k++) if (i2[k] != i3[k]) { n++; System.out.println("[chk] bad int copy so=" + so + " do=" + dof + " len=" + len); break; }
            long[] l1 = new long[50], l2 = new long[50], l3 = new long[50];
            for (int k = 0; k < 50; k++) { l1[k] = k * 4000000007L; l2[k] = l3[k] = -k; }
            System.arraycopy(l1, so, l2, dof, len);
            for (int k = 0; k < len; k++) l3[dof + k] = l1[so + k];
            for (int k = 0; k < 50; k++) if (l2[k] != l3[k]) { n++; System.out.println("[chk] bad long copy so=" + so + " do=" + dof + " len=" + len); break; }
            Object[] o1 = new Object[50], o2 = new Object[50], o3 = new Object[50];
            for (int k = 0; k < 50; k++) { o1[k] = new Integer(k); o2[k] = o3[k] = "x"; }
            System.arraycopy(o1, so, o2, dof, len);
            for (int k = 0; k < len; k++) o3[dof + k] = o1[so + k];
            for (int k = 0; k < 50; k++) if (o2[k] != o3[k]) { n++; System.out.println("[chk] bad obj copy so=" + so + " do=" + dof + " len=" + len); break; }
            int[] ov = new int[50], ex = new int[50];
            for (int k = 0; k < 50; k++) ov[k] = ex[k] = k;
            System.arraycopy(ov, so, ov, dof, len);
            int[] tmp = new int[len]; for (int k = 0; k < len; k++) tmp[k] = ex[so + k]; for (int k = 0; k < len; k++) ex[dof + k] = tmp[k];
            for (int k = 0; k < 50; k++) if (ov[k] != ex[k]) { n++; System.out.println("[chk] bad int overlap so=" + so + " do=" + dof + " len=" + len); break; }
            byte[] bo = new byte[50], be = new byte[50];
            for (int k = 0; k < 50; k++) bo[k] = be[k] = (byte) k;
            System.arraycopy(bo, so, bo, dof, len);
            byte[] bt = new byte[len]; for (int k = 0; k < len; k++) bt[k] = be[so + k]; for (int k = 0; k < len; k++) be[dof + k] = bt[k];
            for (int k = 0; k < 50; k++) if (bo[k] != be[k]) { n++; System.out.println("[chk] bad byte overlap so=" + so + " do=" + dof + " len=" + len); break; }
            if (n > 20) break;
        }
        ck("arraycopy_mismatches", n, 0);
        try { System.arraycopy(new int[3], 0, new int[3], 2, 2); ck("arraycopy_aioobe", 0, 1); } catch (ArrayIndexOutOfBoundsException e) { ck("arraycopy_aioobe", 1, 1); }
        try { System.arraycopy(new int[3], 0, new byte[3], 0, 1); ck("arraycopy_ase", 0, 1); } catch (ArrayStoreException e) { ck("arraycopy_ase", 1, 1); }
        Vector v = new Vector();
        for (int k = 0; k < 500; k++) v.addElement(new Integer(k));
        int sum = 0; for (int k = 0; k < v.size(); k++) sum += ((Integer) v.elementAt(k)).intValue();
        ck("vector_sum", sum, 124750);
        v.removeElementAt(10); v.insertElementAt("a", 0);
        ck("vector_ops", ((Integer) v.elementAt(11)).intValue() * 10 + v.size(), 110 + 500);
        try { v.elementAt(9999); ck("vector_aioobe", 0, 1); } catch (ArrayIndexOutOfBoundsException e) { ck("vector_aioobe", 1, 1); }
        Hashtable h = new Hashtable();
        for (int k = 0; k < 300; k++) h.put("k" + k, new Integer(k * 3));
        ck("hashtable", ((Integer) h.get("k123")).intValue() + h.size(), 369 + 300);
        String str = "Mr Bean Racer " + i("2");
        ck("str_len", str.length(), 15);
        ck("str_charAt", str.charAt(3), 'B');
        ck("str_indexOf", str.indexOf("Racer") * 100 + str.indexOf('z'), 799);
        ckb("str_equals", str.substring(3, 7).equals("Bean"), true);
        ck("str_cmp", "abc".compareTo("abd"), -1);
        StringBuffer sb = new StringBuffer();
        for (int k = 0; k < 200; k++) sb.append((char) ('a' + k % 26));
        ck("sb_len", sb.length() + sb.charAt(27), 200 + 'b');
        ck("str_upper", "Hello".toUpperCase().charAt(1), 'E');
        ck("int_parse", Integer.parseInt("-12345") + Integer.parseInt("ff", 16), -12345 + 255);
        ckb("str_tostring", Integer.toString(i("-42")).equals("-42"), true);
        fin = 0;
        ck("finally", withFinally(i("3")) * 100 + withFinally(i("0")), 600 - 1);
        ck("finally_count", fin, 21);
        long[] la = new long[4]; ck("dup2_x", dupx(la, 1) + la[1] + la[2], 18);
        int[] ia = new int[4]; ck("dup_x2", dupx1(ia, 2) + ia[2], 18);
        ck("i2b", (byte) i("200"), -56); ck("i2c", (char) i("-1"), 65535); ck("i2s", (short) i("40000"), -25536);
        byte[] bb = { (byte) 0xF0 }; char[] cc = { (char) 0xF000 }; short[] ss = { (short) 0xF000 };
        ck("baload", bb[0], -16); ck("caload", cc[0], 61440); ck("saload", ss[0], -4096);
        float nan = Float.NaN, one = Float.parseFloat("1");
        ckb("fcmpl", nan > one, false); ckb("fcmpg", nan < one, false); ckb("fcmp_eq", one == one, true);
        Object on = null; if (i("1") > 0) on = null;
        ckb("ifnull", on == null, true);
        ifld = 5; ifld += incr(); lfld = l("10"); lfld *= 3; lfld -= ifld;
        ck("field_ops", lfld * 10 + ifld, 240 + 6);
        int[][] tri = new int[3][]; for (int k = 0; k < 3; k++) tri[k] = new int[k + 1];
        tri[2][2] = 9; ck("jagged", tri[2].length * 10 + tri[2][2], 39);
        System.out.println("[chk] round4 bad=" + (bad - bad0));
    }

    // ---- round 5: Nokia FullCanvas size (Mr Bean waits for getWidth/getHeight != 0) ----
    static class FC extends com.nokia.mid.ui.FullCanvas { int p; protected void paint(Graphics g) { p++; } }
    void round5() {
        FC f = new FC();
        System.out.println("[chk] fullcanvas before setCurrent " + f.getWidth() + "x" + f.getHeight());
        Display.getDisplay(this).setCurrent(f);
        for (int k = 0; k < 30; k++) {
            if (f.isShown() && f.getWidth() > 0 && f.getHeight() > 0) break;
            try { Thread.sleep(100); } catch (InterruptedException e) {}
        }
        System.out.println("[chk] fullcanvas shown=" + f.isShown() + " size=" + f.getWidth() + "x" + f.getHeight() + " paints=" + f.p);
        ckb("fullcanvas_size", f.getWidth() > 0 && f.getHeight() > 0, true);
    }

    // ---- round 6: which display change breaks Thread.sleep ----
    void sleepProbe(String tag) {
        long t0 = System.currentTimeMillis();
        StringBuffer sb = new StringBuffer();
        for (int k = 0; k < 5; k++) {
            long s0 = System.currentTimeMillis();
            try { Thread.sleep(20); } catch (InterruptedException e) {}
            sb.append(System.currentTimeMillis() - s0).append(' ');
        }
        System.out.println("[chk] sleep20x5 after " + tag + ": " + sb.toString());
    }
    void round6() {
        Display d = Display.getDisplay(this);
        sleepProbe("start");
        Canvas c1 = new Canvas() { protected void paint(Graphics g) {} };
        d.setCurrent(c1);
        try { Thread.sleep(200); } catch (InterruptedException e) {}
        sleepProbe("plain canvas shown");
        c1.setFullScreenMode(true);
        try { Thread.sleep(200); } catch (InterruptedException e) {}
        sleepProbe("setFullScreenMode(true) " + c1.getWidth() + "x" + c1.getHeight());
        Canvas c2 = new Canvas() { protected void paint(Graphics g) {} };
        d.setCurrent(c2);
        try { Thread.sleep(200); } catch (InterruptedException e) {}
        sleepProbe("second plain canvas");
    }
}
