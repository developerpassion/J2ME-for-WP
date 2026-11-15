/* J2MEWP: JSR 82 stub - no Bluetooth for MIDlets (LocalDevice throws BluetoothStateException) */
package javax.bluetooth;
public class LocalDevice {
    private LocalDevice() { }
    public static LocalDevice getLocalDevice() throws BluetoothStateException {
        throw new BluetoothStateException("Bluetooth is not available");
    }
    public static boolean isPowerOn() { return false; }
    public static String getProperty(String property) { return null; }
    public DiscoveryAgent getDiscoveryAgent() { return null; }
    public String getFriendlyName() { return null; }
    public DeviceClass getDeviceClass() { return null; }
    public boolean setDiscoverable(int mode) throws BluetoothStateException {
        throw new BluetoothStateException("Bluetooth is not available");
    }
    public int getDiscoverable() { return DiscoveryAgent.NOT_DISCOVERABLE; }
    public String getBluetoothAddress() { return null; }
    public ServiceRecord getRecord(javax.microedition.io.Connection notifier) {
        throw new IllegalArgumentException();
    }
    public void updateRecord(ServiceRecord srvRecord) throws ServiceRegistrationException {
        throw new ServiceRegistrationException();
    }
}
