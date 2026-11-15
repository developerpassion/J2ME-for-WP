/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Appearance extends Object3D {
    private int layer;
    private CompositingMode compositing;
    private Fog fog;
    private PolygonMode polygon;
    private Material material;
    private Texture2D[] textures = new Texture2D[Graphics3D.MAX_TEXTURE_UNITS];
    public Appearance() { }
    public void setLayer(int layer) { this.layer = layer; }
    public int getLayer() { return layer; }
    public void setFog(Fog fog) { this.fog = fog; }
    public Fog getFog() { return fog; }
    public void setPolygonMode(PolygonMode polygonMode) { polygon = polygonMode; }
    public PolygonMode getPolygonMode() { return polygon; }
    public void setCompositingMode(CompositingMode compositingMode) { compositing = compositingMode; }
    public CompositingMode getCompositingMode() { return compositing; }
    public void setTexture(int index, Texture2D texture) { textures[index] = texture; }
    public Texture2D getTexture(int index) { return textures[index]; }
    public void setMaterial(Material material) { this.material = material; }
    public Material getMaterial() { return material; }
}
