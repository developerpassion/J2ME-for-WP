/* J2MEWP: JSR 82 stub - no Bluetooth for MIDlets (LocalDevice throws BluetoothStateException) */
package javax.bluetooth;
public class UUID {
    private static final String BASE = "0000000000001000800000805F9B34FB";
    private final String hex; // 32 upper-case hex digits
    public UUID(long uuidValue) {
        if (uuidValue < 0 || uuidValue > 0xFFFFFFFFL) throw new IllegalArgumentException();
        String s = Long.toString(uuidValue, 16).toUpperCase();
        while (s.length() < 8) s = "0" + s;
        hex = s + BASE.substring(8);
    }
    public UUID(String uuidValue, boolean shortUUID) {
        if (uuidValue == null) throw new NullPointerException();
        int n = uuidValue.length();
        if (n == 0 || n > 32 || (shortUUID && n > 8)) throw new IllegalArgumentException();
        for (int i = 0; i < n; i++)
            if (Character.digit(uuidValue.charAt(i), 16) < 0) throw new NumberFormatException();
        String s = uuidValue.toUpperCase();
        if (shortUUID) {
            while (s.length() < 8) s = "0" + s;
            hex = s + BASE.substring(8);
        } else {
            while (s.length() < 32) s = "0" + s;
            hex = s;
        }
    }
    public String toString() {
        int i = 0;
        while (i < 31 && hex.charAt(i) == '0') i++;
        return hex.substring(i);
    }
    public boolean equals(Object v) { return v instanceof UUID && ((UUID)v).hex.equals(hex); }
    public int hashCode() { return hex.hashCode(); }
}
