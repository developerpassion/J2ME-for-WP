/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class VertexArray extends Object3D {
    private int count, comps, size;
    public VertexArray(int numVertices, int numComponents, int componentSize) {
        if (numVertices < 1 || numComponents < 2 || numComponents > 4 || componentSize < 1 || componentSize > 2)
            throw new IllegalArgumentException();
        count = numVertices; comps = numComponents; size = componentSize;
    }
    public void set(int firstVertex, int numVertices, short[] values) { }
    public void set(int firstVertex, int numVertices, byte[] values) { }
    public void get(int firstVertex, int numVertices, short[] values) { }
    public void get(int firstVertex, int numVertices, byte[] values) { }
    public int getVertexCount() { return count; }
    public int getComponentCount() { return comps; }
    public int getComponentType() { return size; }
}
