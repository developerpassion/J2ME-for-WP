/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Mesh extends Node {
    private VertexBuffer vertices;
    private IndexBuffer[] submeshes;
    private Appearance[] appearances;
    public Mesh(VertexBuffer vertices, IndexBuffer submesh, Appearance appearance) {
        this(vertices, new IndexBuffer[] { submesh }, new Appearance[] { appearance });
    }
    public Mesh(VertexBuffer vertices, IndexBuffer[] submeshes, Appearance[] appearances) {
        if (vertices == null || submeshes == null) throw new NullPointerException();
        this.vertices = vertices;
        this.submeshes = submeshes;
        this.appearances = appearances != null ? appearances : new Appearance[submeshes.length];
    }
    public void setAppearance(int index, Appearance appearance) { appearances[index] = appearance; }
    public Appearance getAppearance(int index) { return appearances[index]; }
    public IndexBuffer getIndexBuffer(int index) { return submeshes[index]; }
    public VertexBuffer getVertexBuffer() { return vertices; }
    public int getSubmeshCount() { return submeshes.length; }
}
