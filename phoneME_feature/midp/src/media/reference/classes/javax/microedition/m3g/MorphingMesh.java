/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class MorphingMesh extends Mesh {
    private VertexBuffer[] targets;
    private float[] weights;
    public MorphingMesh(VertexBuffer base, VertexBuffer[] targets, IndexBuffer submesh, Appearance appearance) {
        super(base, submesh, appearance); init(targets);
    }
    public MorphingMesh(VertexBuffer base, VertexBuffer[] targets, IndexBuffer[] submeshes, Appearance[] appearances) {
        super(base, submeshes, appearances); init(targets);
    }
    private void init(VertexBuffer[] t) { targets = t; weights = new float[t.length]; }
    public VertexBuffer getMorphTarget(int index) { return targets[index]; }
    public int getMorphTargetCount() { return targets.length; }
    public void setWeights(float[] w) { System.arraycopy(w, 0, weights, 0, weights.length); }
    public void getWeights(float[] w) { System.arraycopy(weights, 0, w, 0, weights.length); }
}
