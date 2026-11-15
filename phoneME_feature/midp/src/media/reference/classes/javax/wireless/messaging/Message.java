/*
 * J2MEWP: minimal JSR 120 (Wireless Messaging API 1.1) so games that link
 * against it load. There is no SMS on this platform: send() always fails
 * with an IOException, receive() never delivers a message.
 */
package javax.wireless.messaging;

public interface Message {
    String getAddress();
    void setAddress(String addr);
    java.util.Date getTimestamp();
}
