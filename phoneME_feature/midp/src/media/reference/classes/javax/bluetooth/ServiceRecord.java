/* J2MEWP: JSR 82 stub - no Bluetooth for MIDlets (LocalDevice throws BluetoothStateException) */
package javax.bluetooth;
public interface ServiceRecord {
    int NOAUTHENTICATE_NOENCRYPT = 0, AUTHENTICATE_NOENCRYPT = 1, AUTHENTICATE_ENCRYPT = 2;
    DataElement getAttributeValue(int attrID);
    RemoteDevice getHostDevice();
    int[] getAttributeIDs();
    boolean populateRecord(int[] attrIDs) throws java.io.IOException;
    String getConnectionURL(int requiredSecurity, boolean mustBeMaster);
    void setDeviceServiceClasses(int classes);
    boolean setAttributeValue(int attrID, DataElement attrValue);
}
