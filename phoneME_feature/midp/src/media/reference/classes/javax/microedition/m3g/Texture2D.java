/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Texture2D extends Transformable {
    public static final int FILTER_BASE_LEVEL = 208, FILTER_LINEAR = 209, FILTER_NEAREST = 210;
    public static final int FUNC_ADD = 224, FUNC_BLEND = 225, FUNC_DECAL = 226, FUNC_MODULATE = 227, FUNC_REPLACE = 228;
    public static final int WRAP_CLAMP = 240, WRAP_REPEAT = 241;
    private Image2D image;
    private int blending = FUNC_MODULATE, blendColor, wrapS = WRAP_REPEAT, wrapT = WRAP_REPEAT;
    private int levelFilter = FILTER_BASE_LEVEL, imageFilter = FILTER_NEAREST;
    public Texture2D(Image2D image) { setImage(image); }
    public void setImage(Image2D image) { if (image == null) throw new NullPointerException(); this.image = image; }
    public Image2D getImage() { return image; }
    public void setFiltering(int levelFilter, int imageFilter) { this.levelFilter = levelFilter; this.imageFilter = imageFilter; }
    public int getLevelFilter() { return levelFilter; }
    public int getImageFilter() { return imageFilter; }
    public void setWrapping(int wrapS, int wrapT) { this.wrapS = wrapS; this.wrapT = wrapT; }
    public int getWrappingS() { return wrapS; }
    public int getWrappingT() { return wrapT; }
    public void setBlending(int func) { blending = func; }
    public int getBlending() { return blending; }
    public void setBlendColor(int rgb) { blendColor = rgb & 0xFFFFFF; }
    public int getBlendColor() { return blendColor; }
}
