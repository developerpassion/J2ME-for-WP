/* J2MEWP: JSR 82 stub - no Bluetooth for MIDlets (LocalDevice throws BluetoothStateException) */
package javax.bluetooth;
import java.io.IOException;
public interface L2CAPConnection extends javax.microedition.io.Connection {
    int DEFAULT_MTU = 672, MINIMUM_MTU = 48;
    int getTransmitMTU() throws IOException;
    int getReceiveMTU() throws IOException;
    void send(byte[] data) throws IOException;
    int receive(byte[] inBuf) throws IOException;
    boolean ready() throws IOException;
}
