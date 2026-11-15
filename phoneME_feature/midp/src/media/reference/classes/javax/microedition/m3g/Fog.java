/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Fog extends Object3D {
    public static final int EXPONENTIAL = 80, LINEAR = 81;
    private int mode = LINEAR, color;
    private float density = 1f, near = 0f, far = 1f;
    public Fog() { }
    public void setMode(int mode) { this.mode = mode; }
    public int getMode() { return mode; }
    public void setLinear(float near, float far) { this.near = near; this.far = far; }
    public float getNearDistance() { return near; }
    public float getFarDistance() { return far; }
    public void setDensity(float density) { this.density = density; }
    public float getDensity() { return density; }
    public void setColor(int rgb) { color = rgb & 0xFFFFFF; }
    public int getColor() { return color; }
}
