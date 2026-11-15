/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Background extends Object3D {
    public static final int BORDER = 32, REPEAT = 33;
    private int color, mx = BORDER, my = BORDER, cx, cy, cw, ch;
    private boolean colorClear = true, depthClear = true;
    private Image2D image;
    public Background() { }
    public void setColorClearEnable(boolean enable) { colorClear = enable; }
    public boolean isColorClearEnabled() { return colorClear; }
    public void setDepthClearEnable(boolean enable) { depthClear = enable; }
    public boolean isDepthClearEnabled() { return depthClear; }
    public void setColor(int argb) { color = argb; }
    public int getColor() { return color; }
    public void setImage(Image2D image) {
        this.image = image;
        if (image != null) { cx = 0; cy = 0; cw = image.getWidth(); ch = image.getHeight(); }
    }
    public Image2D getImage() { return image; }
    public void setImageMode(int modeX, int modeY) { mx = modeX; my = modeY; }
    public int getImageModeX() { return mx; }
    public int getImageModeY() { return my; }
    public void setCrop(int x, int y, int w, int h) { cx = x; cy = y; cw = w; ch = h; }
    public int getCropX() { return cx; }
    public int getCropY() { return cy; }
    public int getCropWidth() { return cw; }
    public int getCropHeight() { return ch; }
}
