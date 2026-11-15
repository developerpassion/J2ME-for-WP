/* J2MEWP: JSR 184 (M3G) stub - API surface only, nothing is rendered; Loader.load throws IOException */
package javax.microedition.m3g;
public class AnimationTrack extends Object3D {
    public static final int ALPHA = 256, AMBIENT_COLOR = 257, COLOR = 258, CROP = 259, DENSITY = 260,
        DIFFUSE_COLOR = 261, EMISSIVE_COLOR = 262, FAR_DISTANCE = 263, FIELD_OF_VIEW = 264,
        INTENSITY = 265, MORPH_WEIGHTS = 266, NEAR_DISTANCE = 267, ORIENTATION = 268, PICKABILITY = 269,
        SCALE = 270, SHININESS = 271, SPECULAR_COLOR = 272, SPOT_ANGLE = 273, SPOT_EXPONENT = 274,
        TRANSLATION = 275, VISIBILITY = 276;
    private KeyframeSequence sequence;
    private AnimationController controller;
    private int property;
    public AnimationTrack(KeyframeSequence sequence, int property) {
        if (sequence == null) throw new NullPointerException();
        this.sequence = sequence; this.property = property;
    }
    public void setController(AnimationController controller) { this.controller = controller; }
    public AnimationController getController() { return controller; }
    public KeyframeSequence getKeyframeSequence() { return sequence; }
    public int getTargetProperty() { return property; }
}
