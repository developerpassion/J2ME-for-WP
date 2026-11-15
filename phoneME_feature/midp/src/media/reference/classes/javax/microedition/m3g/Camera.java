/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Camera extends Node {
    public static final int GENERIC = 48, PARALLEL = 49, PERSPECTIVE = 50;
    private int type = GENERIC;
    private float[] p = new float[4];
    public Camera() { }
    public void setParallel(float fovy, float aspect, float near, float far) { type = PARALLEL; set(fovy, aspect, near, far); }
    public void setPerspective(float fovy, float aspect, float near, float far) { type = PERSPECTIVE; set(fovy, aspect, near, far); }
    public void setGeneric(Transform transform) { type = GENERIC; }
    public int getProjection(Transform transform) { if (transform != null) transform.setIdentity(); return type; }
    public int getProjection(float[] params) { if (params != null) System.arraycopy(p, 0, params, 0, 4); return type; }
    private void set(float a, float b, float c, float d) { p[0] = a; p[1] = b; p[2] = c; p[3] = d; }
}
