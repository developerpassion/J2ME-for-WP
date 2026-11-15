/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class VertexBuffer extends Object3D {
    private VertexArray positions, normals, colors;
    private VertexArray[] texCoords = new VertexArray[Graphics3D.MAX_TEXTURE_UNITS];
    private float[] posBias;
    private float posScale = 1f;
    private int defaultColor = 0xFFFFFFFF;
    public VertexBuffer() { }
    public int getVertexCount() { return positions != null ? positions.getVertexCount() : 0; }
    public void setPositions(VertexArray positions, float scale, float[] bias) { this.positions = positions; posScale = scale; posBias = bias; }
    public void setTexCoords(int index, VertexArray texCoords, float scale, float[] bias) { this.texCoords[index] = texCoords; }
    public void setNormals(VertexArray normals) { this.normals = normals; }
    public void setColors(VertexArray colors) { this.colors = colors; }
    public VertexArray getPositions(float[] scaleBias) {
        if (scaleBias != null) {
            scaleBias[0] = posScale;
            for (int i = 0; i < 3 && i + 1 < scaleBias.length; i++) scaleBias[i + 1] = posBias != null ? posBias[i] : 0f;
        }
        return positions;
    }
    public VertexArray getTexCoords(int index, float[] scaleBias) { return texCoords[index]; }
    public VertexArray getNormals() { return normals; }
    public VertexArray getColors() { return colors; }
    public void setDefaultColor(int argb) { defaultColor = argb; }
    public int getDefaultColor() { return defaultColor; }
}
