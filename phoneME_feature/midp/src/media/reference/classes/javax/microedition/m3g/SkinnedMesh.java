/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class SkinnedMesh extends Mesh {
    private Group skeleton;
    public SkinnedMesh(VertexBuffer vertices, IndexBuffer submesh, Appearance appearance, Group skeleton) {
        super(vertices, submesh, appearance); this.skeleton = skeleton;
    }
    public SkinnedMesh(VertexBuffer vertices, IndexBuffer[] submeshes, Appearance[] appearances, Group skeleton) {
        super(vertices, submeshes, appearances); this.skeleton = skeleton;
    }
    public void addTransform(Node bone, int weight, int firstVertex, int numVertices) { }
    public void getBoneTransform(Node bone, Transform transform) { if (transform != null) transform.setIdentity(); }
    public int getBoneVertices(Node bone, int[] indices, float[] weights) { return 0; }
    public Group getSkeleton() { return skeleton; }
}
