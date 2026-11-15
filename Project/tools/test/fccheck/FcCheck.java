import javax.microedition.midlet.MIDlet;
import javax.microedition.lcdui.*;

/* J2MEWP: reproduces Mr Bean Racer 2's start-up (FullCanvas made in the MIDlet constructor,
   game thread waits for a non-zero canvas size). Logs "[fc] ..." lines to j2me.log. */
public class FcCheck extends MIDlet {
    static G canvas;
    public FcCheck() {
        System.out.println("[fc] MIDlet constructor");
        canvas = new G(this, Display.getDisplay(this));
        System.out.println("[fc] canvas created, size " + canvas.getWidth() + "x" + canvas.getHeight());
    }
    public void startApp() { System.out.println("[fc] startApp"); canvas.start(); }
    public void pauseApp() {}
    public void destroyApp(boolean u) {}

    static final class G extends com.nokia.mid.ui.FullCanvas implements Runnable {
        static Display display; static MIDlet midlet; static Thread thread;
        static int d, e; static int paints;
        G(MIDlet m, Display dsp) { midlet = m; display = dsp; }
        synchronized void start() { if (thread == null) { thread = new Thread(this); thread.start(); } }
        protected void paint(Graphics g) { paints++; g.setColor(0x00ff00); g.fillRect(0, 0, getWidth(), getHeight()); }
        public void run() {
            int loops = 0;
            while (display.getCurrent() != this) {
                System.out.println("[fc] setCurrent (current=" + display.getCurrent() + ")");
                display.setCurrent(this);
                try { Thread.sleep(100); } catch (Exception ex) {}
            }
            System.out.println("[fc] is current, shown=" + isShown());
            while (d == 0 || e == 0) {
                d = getWidth(); e = getHeight();
                if (loops++ % 10 == 0) System.out.println("[fc] size " + d + "x" + e + " shown=" + isShown() + " loops=" + loops);
                if (loops > 50) { System.out.println("[fc] GAVE UP: size stays " + d + "x" + e); break; }
                try { Thread.sleep(100); } catch (Exception ex) {}
            }
            System.out.println("[fc] size ok " + d + "x" + e + ", painting");
            for (int k = 0; k < 30; k++) { repaint(); serviceRepaints(); try { Thread.sleep(30); } catch (Exception ex) {} }
            System.out.println("[fc] DONE paints=" + paints);
            ((FcCheck) midlet).notifyDestroyed();
        }
    }
}
