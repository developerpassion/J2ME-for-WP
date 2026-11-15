/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Sprite3D extends Node {
    private boolean scaled;
    private Appearance appearance;
    private Image2D image;
    private int cx, cy, cw, ch;
    public Sprite3D(boolean scaled, Image2D image, Appearance appearance) {
        this.scaled = scaled; this.appearance = appearance; setImage(image);
    }
    public boolean isScaled() { return scaled; }
    public void setAppearance(Appearance appearance) { this.appearance = appearance; }
    public Appearance getAppearance() { return appearance; }
    public void setImage(Image2D image) {
        if (image == null) throw new NullPointerException();
        this.image = image; cx = 0; cy = 0; cw = image.getWidth(); ch = image.getHeight();
    }
    public Image2D getImage() { return image; }
    public void setCrop(int x, int y, int w, int h) { cx = x; cy = y; cw = w; ch = h; }
    public int getCropX() { return cx; }
    public int getCropY() { return cy; }
    public int getCropWidth() { return cw; }
    public int getCropHeight() { return ch; }
}
