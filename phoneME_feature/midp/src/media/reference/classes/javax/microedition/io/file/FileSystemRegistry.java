/* J2MEWP: JSR 75 FileConnection API only: listRoots() is empty and Connector.open of a file URL fails */
package javax.microedition.io.file;
import java.util.Enumeration;
import java.util.Vector;
public class FileSystemRegistry {
    private FileSystemRegistry() { }
    public static boolean addFileSystemListener(FileSystemListener listener) {
        if (listener == null) throw new NullPointerException();
        return true;
    }
    public static boolean removeFileSystemListener(FileSystemListener listener) {
        if (listener == null) throw new NullPointerException();
        return true;
    }
    public static Enumeration listRoots() { return new Vector().elements(); }
}
