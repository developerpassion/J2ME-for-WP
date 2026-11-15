/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Group extends Node {
    private java.util.Vector children = new java.util.Vector();
    public Group() { }
    public void addChild(Node child) {
        if (child == null) throw new NullPointerException();
        children.addElement(child);
        child.setParent(this);
    }
    public void removeChild(Node child) { if (children.removeElement(child)) child.setParent(null); }
    public int getChildCount() { return children.size(); }
    public Node getChild(int index) { return (Node)children.elementAt(index); }
    public boolean pick(int scope, float x, float y, Camera camera, RayIntersection ri) { return false; }
    public boolean pick(int scope, float ox, float oy, float oz, float dx, float dy, float dz, RayIntersection ri) { return false; }
}
