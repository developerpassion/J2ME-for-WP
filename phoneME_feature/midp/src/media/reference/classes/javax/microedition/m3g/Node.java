/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public abstract class Node extends Transformable {
    public static final int NONE = 144, ORIGIN = 145, X_AXIS = 146, Y_AXIS = 147, Z_AXIS = 148;
    private Node parent;
    private boolean rendering = true, picking = true;
    private float alpha = 1f;
    private int scope = -1;
    Node() { }
    void setParent(Node p) { parent = p; }
    public Node getParent() { return parent; }
    public boolean getTransformTo(Node target, Transform transform) {
        if (transform != null) transform.setIdentity();
        return true;
    }
    public void setAlignment(Node zRef, int zTarget, Node yRef, int yTarget) { }
    public void align(Node reference) { }
    public Node getAlignmentReference(int axis) { return null; }
    public int getAlignmentTarget(int axis) { return NONE; }
    public void setAlphaFactor(float alphaFactor) { alpha = alphaFactor; }
    public float getAlphaFactor() { return alpha; }
    public void setRenderingEnable(boolean enable) { rendering = enable; }
    public boolean isRenderingEnabled() { return rendering; }
    public void setPickingEnable(boolean enable) { picking = enable; }
    public boolean isPickingEnabled() { return picking; }
    public void setScope(int scope) { this.scope = scope; }
    public int getScope() { return scope; }
}
