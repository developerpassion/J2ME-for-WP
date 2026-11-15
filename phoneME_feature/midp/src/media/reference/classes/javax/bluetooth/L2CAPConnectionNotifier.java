/* J2MEWP: JSR 82 stub - no Bluetooth for MIDlets (LocalDevice throws BluetoothStateException) */
package javax.bluetooth;
public interface L2CAPConnectionNotifier extends javax.microedition.io.Connection {
    L2CAPConnection acceptAndOpen() throws java.io.IOException;
}
