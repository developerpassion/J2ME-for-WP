/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class CompositingMode extends Object3D {
    public static final int ALPHA = 64, ALPHA_ADD = 65, MODULATE = 66, MODULATE_X2 = 67, REPLACE = 68;
    private int blending = REPLACE;
    private float alphaThreshold, factor, units;
    private boolean depthTest = true, depthWrite = true, colorWrite = true, alphaWrite = true;
    public CompositingMode() { }
    public void setBlending(int mode) { blending = mode; }
    public int getBlending() { return blending; }
    public void setAlphaThreshold(float threshold) { alphaThreshold = threshold; }
    public float getAlphaThreshold() { return alphaThreshold; }
    public void setAlphaWriteEnable(boolean enable) { alphaWrite = enable; }
    public boolean isAlphaWriteEnabled() { return alphaWrite; }
    public void setColorWriteEnable(boolean enable) { colorWrite = enable; }
    public boolean isColorWriteEnabled() { return colorWrite; }
    public void setDepthWriteEnable(boolean enable) { depthWrite = enable; }
    public boolean isDepthWriteEnabled() { return depthWrite; }
    public void setDepthTestEnable(boolean enable) { depthTest = enable; }
    public boolean isDepthTestEnabled() { return depthTest; }
    public void setDepthOffset(float factor, float units) { this.factor = factor; this.units = units; }
    public float getDepthOffsetFactor() { return factor; }
    public float getDepthOffsetUnits() { return units; }
}
