/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class KeyframeSequence extends Object3D {
    public static final int CONSTANT = 192, LINEAR = 176, LOOP = 193, SLERP = 177, SPLINE = 178, SQUAD = 179, STEP = 180;
    private int keyframes, components, interpolation, duration, repeat = CONSTANT, first, last;
    public KeyframeSequence(int numKeyframes, int numComponents, int interpolation) {
        keyframes = numKeyframes; components = numComponents; this.interpolation = interpolation; last = numKeyframes - 1;
    }
    public int getComponentCount() { return components; }
    public int getKeyframeCount() { return keyframes; }
    public int getInterpolationType() { return interpolation; }
    public void setKeyframe(int index, int time, float[] value) { }
    public void setValidRange(int first, int last) { this.first = first; this.last = last; }
    public void setDuration(int duration) { this.duration = duration; }
    public int getDuration() { return duration; }
    public void setRepeatMode(int mode) { repeat = mode; }
    public int getRepeatMode() { return repeat; }
}
