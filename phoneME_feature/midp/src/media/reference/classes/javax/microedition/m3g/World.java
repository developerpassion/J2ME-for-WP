/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class World extends Group {
    private Camera camera;
    private Background background;
    public World() { }
    public void setActiveCamera(Camera camera) { if (camera == null) throw new NullPointerException(); this.camera = camera; }
    public Camera getActiveCamera() { return camera; }
    public void setBackground(Background background) { this.background = background; }
    public Background getBackground() { return background; }
}
