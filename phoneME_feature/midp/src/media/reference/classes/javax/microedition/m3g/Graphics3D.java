/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
import java.util.Hashtable;
/** Accepts every call and draws nothing; the 2D target keeps whatever the game drew in 2D. */
public class Graphics3D {
    public static final int ANTIALIAS = 2, DITHER = 4, TRUE_COLOR = 8, OVERWRITE = 16;
    static final int MAX_TEXTURE_UNITS = 2;
    private static Graphics3D instance;
    private Object target;
    private Camera camera;
    private int vx, vy, vw, vh, hints;
    private float near = 0f, far = 1f;
    private boolean depthBuffer;
    private java.util.Vector lights = new java.util.Vector();
    private Graphics3D() { }
    public static synchronized Graphics3D getInstance() {
        if (instance == null) instance = new Graphics3D();
        return instance;
    }
    public void bindTarget(Object target) { bindTarget(target, true, 0); }
    public void bindTarget(Object target, boolean depthBuffer, int hints) {
        if (target == null) throw new NullPointerException();
        if (this.target != null) throw new IllegalStateException();
        this.target = target; this.depthBuffer = depthBuffer; this.hints = hints;
        if (target instanceof javax.microedition.lcdui.Graphics) {
            javax.microedition.lcdui.Graphics g = (javax.microedition.lcdui.Graphics)target;
            vx = g.getClipX(); vy = g.getClipY(); vw = g.getClipWidth(); vh = g.getClipHeight();
        }
    }
    public Object getTarget() { return target; }
    public void releaseTarget() { target = null; }
    public boolean isDepthBufferEnabled() { return depthBuffer; }
    public int getHints() { return hints; }
    public void setViewport(int x, int y, int width, int height) { vx = x; vy = y; vw = width; vh = height; }
    public int getViewportX() { return vx; }
    public int getViewportY() { return vy; }
    public int getViewportWidth() { return vw; }
    public int getViewportHeight() { return vh; }
    public void setDepthRange(float near, float far) { this.near = near; this.far = far; }
    public float getDepthRangeNear() { return near; }
    public float getDepthRangeFar() { return far; }
    public void clear(Background background) { checkTarget(); }
    public void render(World world) { if (world == null) throw new NullPointerException(); checkTarget(); }
    public void render(Node node, Transform transform) { if (node == null) throw new NullPointerException(); checkTarget(); }
    public void render(VertexBuffer vertices, IndexBuffer triangles, Appearance appearance, Transform transform) { checkTarget(); }
    public void render(VertexBuffer vertices, IndexBuffer triangles, Appearance appearance, Transform transform, int scope) { checkTarget(); }
    public void setCamera(Camera camera, Transform transform) { this.camera = camera; }
    public Camera getCamera(Transform transform) { return camera; }
    public int addLight(Light light, Transform transform) {
        if (light == null) throw new NullPointerException();
        lights.addElement(light); return lights.size() - 1;
    }
    public void setLight(int index, Light light, Transform transform) { lights.setElementAt(light, index); }
    public void resetLights() { lights.removeAllElements(); }
    public int getLightCount() { return lights.size(); }
    public Light getLight(int index, Transform transform) { return (Light)lights.elementAt(index); }
    public static Hashtable getProperties() {
        Hashtable h = new Hashtable();
        h.put("supportAntialiasing", Boolean.FALSE);
        h.put("supportTrueColor", Boolean.FALSE);
        h.put("supportDithering", Boolean.FALSE);
        h.put("supportMipmapping", Boolean.FALSE);
        h.put("supportPerspectiveCorrection", Boolean.FALSE);
        h.put("supportLocalCameraLighting", Boolean.FALSE);
        h.put("maxLights", new Integer(8));
        h.put("maxViewportWidth", new Integer(1024));
        h.put("maxViewportHeight", new Integer(1024));
        h.put("maxViewportDimension", new Integer(1024));
        h.put("maxTextureDimension", new Integer(256));
        h.put("maxSpriteCropDimension", new Integer(256));
        h.put("maxTransformsPerVertex", new Integer(4));
        h.put("numTextureUnits", new Integer(MAX_TEXTURE_UNITS));
        return h;
    }
    private void checkTarget() { if (target == null) throw new IllegalStateException(); }
}
