/* J2MEWP: JSR 75 FileConnection API only: listRoots() is empty and Connector.open of a file URL fails */
package javax.microedition.io.file;
public class IllegalModeException extends RuntimeException {
    public IllegalModeException() { super(); }
    public IllegalModeException(String detailMessage) { super(detailMessage); }
}
