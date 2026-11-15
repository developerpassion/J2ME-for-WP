/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Loader {
    private Loader() { }
    public static Object3D[] load(String name) throws java.io.IOException {
        if (name == null) throw new NullPointerException();
        throw new java.io.IOException("M3G (JSR 184) is not supported: " + name);
    }
    public static Object3D[] load(byte[] data, int offset) throws java.io.IOException {
        if (data == null) throw new NullPointerException();
        throw new java.io.IOException("M3G (JSR 184) is not supported");
    }
}
