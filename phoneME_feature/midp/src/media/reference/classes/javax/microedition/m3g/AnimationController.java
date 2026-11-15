/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class AnimationController extends Object3D {
    private float speed = 1f, weight = 1f;
    private int start, end;
    public AnimationController() { }
    public void setActiveInterval(int start, int end) { this.start = start; this.end = end; }
    public int getActiveIntervalStart() { return start; }
    public int getActiveIntervalEnd() { return end; }
    public void setSpeed(float speed, int worldTime) { this.speed = speed; }
    public float getSpeed() { return speed; }
    public void setPosition(float sequenceTime, int worldTime) { }
    public float getPosition(int worldTime) { return 0f; }
    public void setWeight(float weight) { this.weight = weight; }
    public float getWeight() { return weight; }
    public int getRefWorldTime() { return 0; }
}
