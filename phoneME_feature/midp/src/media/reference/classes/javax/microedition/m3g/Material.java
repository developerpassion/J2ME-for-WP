/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Material extends Object3D {
    public static final int AMBIENT = 1024, DIFFUSE = 2048, EMISSIVE = 4096, SPECULAR = 8192;
    private int ambient = 0x333333, diffuse = 0xFFCCCCCC, emissive, specular;
    private float shininess;
    private boolean vertexColorTracking;
    public Material() { }
    public void setColor(int target, int argb) {
        if ((target & AMBIENT) != 0) ambient = argb & 0xFFFFFF;
        if ((target & DIFFUSE) != 0) diffuse = argb;
        if ((target & EMISSIVE) != 0) emissive = argb & 0xFFFFFF;
        if ((target & SPECULAR) != 0) specular = argb & 0xFFFFFF;
    }
    public int getColor(int target) {
        switch (target) {
            case AMBIENT: return ambient;
            case DIFFUSE: return diffuse;
            case EMISSIVE: return emissive;
            case SPECULAR: return specular;
        }
        throw new IllegalArgumentException();
    }
    public void setShininess(float shininess) { this.shininess = shininess; }
    public float getShininess() { return shininess; }
    public void setVertexColorTrackingEnable(boolean enable) { vertexColorTracking = enable; }
    public boolean isVertexColorTrackingEnabled() { return vertexColorTracking; }
}
