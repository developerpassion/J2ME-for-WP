/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Image2D extends Object3D {
    public static final int ALPHA = 96, LUMINANCE = 97, LUMINANCE_ALPHA = 98, RGB = 99, RGBA = 100;
    private int format, width, height;
    private boolean mutable;
    public Image2D(int format, Object image) {
        if (image == null) throw new NullPointerException();
        this.format = format;
        if (image instanceof javax.microedition.lcdui.Image) {
            javax.microedition.lcdui.Image i = (javax.microedition.lcdui.Image)image;
            width = i.getWidth(); height = i.getHeight();
        } else throw new IllegalArgumentException();
    }
    public Image2D(int format, int width, int height, byte[] image) { this(format, width, height); }
    public Image2D(int format, int width, int height, byte[] image, byte[] palette) { this(format, width, height); }
    public Image2D(int format, int width, int height) {
        if (width <= 0 || height <= 0) throw new IllegalArgumentException();
        this.format = format; this.width = width; this.height = height; mutable = true;
    }
    public void set(int x, int y, int width, int height, byte[] image) {
        if (!mutable) throw new IllegalStateException();
    }
    public boolean isMutable() { return mutable; }
    public int getFormat() { return format; }
    public int getWidth() { return width; }
    public int getHeight() { return height; }
}
