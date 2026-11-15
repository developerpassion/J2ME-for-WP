/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class Light extends Node {
    public static final int AMBIENT = 128, DIRECTIONAL = 129, OMNI = 130, SPOT = 131;
    private int mode = DIRECTIONAL, color = 0xFFFFFF;
    private float intensity = 1f, c = 1f, l = 0f, q = 0f, angle = 45f, exponent = 0f;
    public Light() { }
    public void setMode(int mode) { this.mode = mode; }
    public int getMode() { return mode; }
    public void setIntensity(float intensity) { this.intensity = intensity; }
    public float getIntensity() { return intensity; }
    public void setColor(int rgb) { color = rgb & 0xFFFFFF; }
    public int getColor() { return color; }
    public void setSpotAngle(float angle) { this.angle = angle; }
    public float getSpotAngle() { return angle; }
    public void setSpotExponent(float exponent) { this.exponent = exponent; }
    public float getSpotExponent() { return exponent; }
    public void setAttenuation(float constant, float linear, float quadratic) { c = constant; l = linear; q = quadratic; }
    public float getConstantAttenuation() { return c; }
    public float getLinearAttenuation() { return l; }
    public float getQuadraticAttenuation() { return q; }
}
