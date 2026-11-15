/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Transform {
    private float[] m = new float[16];
    public Transform() { setIdentity(); }
    public Transform(Transform transform) { set(transform); }
    public void setIdentity() { for (int i = 0; i < 16; i++) m[i] = (i % 5 == 0) ? 1f : 0f; }
    public void set(Transform transform) {
        if (transform == null) throw new NullPointerException();
        System.arraycopy(transform.m, 0, m, 0, 16);
    }
    public void set(float[] matrix) { System.arraycopy(matrix, 0, m, 0, 16); }
    public void get(float[] matrix) { System.arraycopy(m, 0, matrix, 0, 16); }
    public void invert() { }
    public void transpose() {
        for (int r = 0; r < 4; r++)
            for (int c = r + 1; c < 4; c++) { float t = m[r * 4 + c]; m[r * 4 + c] = m[c * 4 + r]; m[c * 4 + r] = t; }
    }
    public void postMultiply(Transform transform) {
        float[] a = m, b = transform.m, r = new float[16];
        for (int i = 0; i < 4; i++)
            for (int j = 0; j < 4; j++) {
                float s = 0f;
                for (int k = 0; k < 4; k++) s += a[i * 4 + k] * b[k * 4 + j];
                r[i * 4 + j] = s;
            }
        m = r;
    }
    public void postScale(float sx, float sy, float sz) {
        Transform t = new Transform(); t.m[0] = sx; t.m[5] = sy; t.m[10] = sz; postMultiply(t);
    }
    public void postTranslate(float tx, float ty, float tz) {
        Transform t = new Transform(); t.m[3] = tx; t.m[7] = ty; t.m[11] = tz; postMultiply(t);
    }
    public void postRotate(float angle, float ax, float ay, float az) { }
    public void postRotateQuat(float qx, float qy, float qz, float qw) { }
    public void transform(VertexArray in, float[] out, boolean W) { }
    public void transform(float[] vectors) {
        for (int v = 0; v + 3 < vectors.length; v += 4) {
            float x = vectors[v], y = vectors[v + 1], z = vectors[v + 2], w = vectors[v + 3];
            for (int r = 0; r < 4; r++)
                vectors[v + r] = m[r * 4] * x + m[r * 4 + 1] * y + m[r * 4 + 2] * z + m[r * 4 + 3] * w;
        }
    }
}
