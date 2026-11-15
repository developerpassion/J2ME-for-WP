/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public abstract class Transformable extends Object3D {
    private float[] t = new float[3];
    private float[] s = { 1f, 1f, 1f };
    private float[] o = { 0f, 0f, 0f, 1f };
    Transformable() { }
    public void setOrientation(float angle, float ax, float ay, float az) { o[0] = angle; o[1] = ax; o[2] = ay; o[3] = az; }
    public void postRotate(float angle, float ax, float ay, float az) { }
    public void preRotate(float angle, float ax, float ay, float az) { }
    public void getOrientation(float[] angleAxis) { System.arraycopy(o, 0, angleAxis, 0, 4); }
    public void setScale(float sx, float sy, float sz) { s[0] = sx; s[1] = sy; s[2] = sz; }
    public void scale(float sx, float sy, float sz) { s[0] *= sx; s[1] *= sy; s[2] *= sz; }
    public void getScale(float[] xyz) { System.arraycopy(s, 0, xyz, 0, 3); }
    public void setTranslation(float tx, float ty, float tz) { t[0] = tx; t[1] = ty; t[2] = tz; }
    public void translate(float tx, float ty, float tz) { t[0] += tx; t[1] += ty; t[2] += tz; }
    public void getTranslation(float[] xyz) { System.arraycopy(t, 0, xyz, 0, 3); }
    public void setTransform(Transform transform) { }
    public void getTransform(Transform transform) { if (transform != null) transform.setIdentity(); }
    public void getCompositeTransform(Transform transform) { if (transform != null) transform.setIdentity(); }
}
