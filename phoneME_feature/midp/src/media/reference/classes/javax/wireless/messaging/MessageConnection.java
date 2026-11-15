/*
 * J2MEWP: minimal JSR 120 (Wireless Messaging API 1.1) so games that link
 * against it load. There is no SMS on this platform: send() always fails
 * with an IOException, receive() never delivers a message.
 */
package javax.wireless.messaging;

import java.io.IOException;
import java.io.InterruptedIOException;

public interface MessageConnection extends javax.microedition.io.Connection {
    String TEXT_MESSAGE = "text";
    String BINARY_MESSAGE = "binary";
    String MULTIPART_MESSAGE = "multipart";

    Message newMessage(String type);
    Message newMessage(String type, String address);
    void send(Message msg) throws IOException, InterruptedIOException;
    Message receive() throws IOException, InterruptedIOException;
    void setMessageListener(MessageListener l) throws IOException;
    int numberOfSegments(Message msg);
}
