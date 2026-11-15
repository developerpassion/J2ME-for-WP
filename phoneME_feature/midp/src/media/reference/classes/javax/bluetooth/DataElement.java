/* J2MEWP: JSR 82 stub - no Bluetooth for MIDlets (LocalDevice throws BluetoothStateException) */
package javax.bluetooth;
public class DataElement {
    public static final int NULL = 0x0000, U_INT_1 = 0x0008, U_INT_2 = 0x0009, U_INT_4 = 0x000A,
        U_INT_8 = 0x000B, U_INT_16 = 0x000C, INT_1 = 0x0010, INT_2 = 0x0011, INT_4 = 0x0012,
        INT_8 = 0x0013, INT_16 = 0x0014, URL = 0x0040, UUID = 0x0018, BOOL = 0x0028,
        STRING = 0x0020, DATSEQ = 0x0030, DATALT = 0x0038;
    private final int type;
    private Object value;
    private long lvalue;
    private boolean bvalue;
    private java.util.Vector seq;
    public DataElement(int valueType) {
        type = valueType;
        if (type == DATSEQ || type == DATALT) seq = new java.util.Vector();
        else if (type != NULL) throw new IllegalArgumentException();
    }
    public DataElement(boolean bool) { type = BOOL; bvalue = bool; }
    public DataElement(int valueType, long value) { type = valueType; lvalue = value; }
    public DataElement(int valueType, Object value) { type = valueType; this.value = value; }
    public void addElement(DataElement elem) { seq().addElement(elem); }
    public void insertElementAt(DataElement elem, int index) { seq().insertElementAt(elem, index); }
    public int getSize() { return seq().size(); }
    public boolean removeElement(DataElement elem) { return seq().removeElement(elem); }
    public int getDataType() { return type; }
    public long getLong() { return lvalue; }
    public boolean getBoolean() { if (type != BOOL) throw new ClassCastException(); return bvalue; }
    public Object getValue() {
        if (seq != null) return seq.elements();
        if (value == null) throw new ClassCastException();
        return value;
    }
    private java.util.Vector seq() { if (seq == null) throw new ClassCastException(); return seq; }
}
