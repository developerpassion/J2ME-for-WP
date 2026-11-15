/* J2MEWP: JSR 82 stub - no Bluetooth for MIDlets (LocalDevice throws BluetoothStateException) */
package javax.bluetooth;
public class DeviceClass {
    private final int record;
    public DeviceClass(int record) {
        if ((record & 0xFF000000) != 0) throw new IllegalArgumentException();
        this.record = record;
    }
    public int getServiceClasses() { return record & 0xFFE000; }
    public int getMajorDeviceClass() { return record & 0x001F00; }
    public int getMinorDeviceClass() { return record & 0x0000FC; }
}
