/* J2MEWP: JSR 75 FileConnection API only: listRoots() is empty and Connector.open of a file URL fails */
package javax.microedition.io.file;
public interface FileSystemListener {
    int ROOT_ADDED = 0;
    int ROOT_REMOVED = 1;
    void rootChanged(int state, String rootName);
}
