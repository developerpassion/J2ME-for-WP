/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public abstract class Object3D {
    private int userID;
    private Object userObject;
    private AnimationTrack[] tracks = new AnimationTrack[0];
    Object3D() { }
    public final int animate(int time) { return 0; }
    public final Object3D duplicate() { return this; }
    public Object3D find(int userID) { return this.userID == userID ? this : null; }
    public int getReferences(Object3D[] references) { return 0; }
    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }
    public Object getUserObject() { return userObject; }
    public void setUserObject(Object userObject) { this.userObject = userObject; }
    public void addAnimationTrack(AnimationTrack t) {
        if (t == null) throw new NullPointerException();
        AnimationTrack[] n = new AnimationTrack[tracks.length + 1];
        System.arraycopy(tracks, 0, n, 0, tracks.length);
        n[tracks.length] = t;
        tracks = n;
    }
    public AnimationTrack getAnimationTrack(int index) { return tracks[index]; }
    public void removeAnimationTrack(AnimationTrack t) { }
    public int getAnimationTrackCount() { return tracks.length; }
}
