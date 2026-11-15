/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class PolygonMode extends Object3D {
    public static final int CULL_BACK = 160, CULL_FRONT = 161, CULL_NONE = 162;
    public static final int SHADE_FLAT = 164, SHADE_SMOOTH = 165;
    public static final int WINDING_CCW = 168, WINDING_CW = 169;
    private int culling = CULL_BACK, shading = SHADE_SMOOTH, winding = WINDING_CCW;
    private boolean twoSided, localCamera, perspective;
    public PolygonMode() { }
    public void setCulling(int mode) { culling = mode; }
    public int getCulling() { return culling; }
    public void setWinding(int mode) { winding = mode; }
    public int getWinding() { return winding; }
    public void setShading(int mode) { shading = mode; }
    public int getShading() { return shading; }
    public void setTwoSidedLightingEnable(boolean enable) { twoSided = enable; }
    public boolean isTwoSidedLightingEnabled() { return twoSided; }
    public void setLocalCameraLightingEnable(boolean enable) { localCamera = enable; }
    public void setPerspectiveCorrectionEnable(boolean enable) { perspective = enable; }
}
