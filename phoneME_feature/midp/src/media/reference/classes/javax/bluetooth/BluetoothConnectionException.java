/* J2MEWP: JSR 82 stub - no Bluetooth for MIDlets (LocalDevice throws BluetoothStateException) */
package javax.bluetooth;
public class BluetoothConnectionException extends java.io.IOException {
    public static final int UNKNOWN_PSM = 1, SECURITY_BLOCK = 2, NO_RESOURCES = 3,
        FAILED_NOINFO = 4, TIMEOUT = 5, UNACCEPTABLE_PARAMS = 6;
    private int error;
    public BluetoothConnectionException(int error) { this(error, null); }
    public BluetoothConnectionException(int error, String msg) { super(msg); this.error = error; }
    public int getStatus() { return error; }
}
