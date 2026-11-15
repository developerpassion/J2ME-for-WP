/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class TriangleStripArray extends IndexBuffer {
    private int count;
    public TriangleStripArray(int[] indices, int[] stripLengths) { count = sum(stripLengths); }
    public TriangleStripArray(int firstIndex, int[] stripLengths) { count = sum(stripLengths); }
    private static int sum(int[] a) {
        if (a == null) throw new NullPointerException();
        int s = 0;
        for (int i = 0; i < a.length; i++) s += a[i] < 3 ? 0 : (a[i] - 2) * 3;
        return s;
    }
    public int getIndexCount() { return count; }
}
