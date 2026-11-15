/* J2MEWP: JSR 75 FileConnection API only: listRoots() is empty and Connector.open of a file URL fails */
package javax.microedition.io.file;
public class ConnectionClosedException extends RuntimeException {
    public ConnectionClosedException() { super(); }
    public ConnectionClosedException(String detailMessage) { super(detailMessage); }
}
