/*
 * J2MEWP: minimal JSR 120 (Wireless Messaging API 1.1) so games that link
 * against it load. There is no SMS on this platform: send() always fails
 * with an IOException, receive() never delivers a message.
 */
package com.sun.j2mewp.messaging;

import java.util.Date;
import javax.wireless.messaging.BinaryMessage;
import javax.wireless.messaging.TextMessage;

public class StubMessage implements TextMessage, BinaryMessage {
    private String address;
    private String text;
    private byte[] data;

    public StubMessage(String address) { this.address = address; }

    public String getAddress() { return address; }
    public void setAddress(String addr) { address = addr; }
    public Date getTimestamp() { return null; }
    public String getPayloadText() { return text; }
    public void setPayloadText(String t) { text = t; }
    public byte[] getPayloadData() { return data; }
    public void setPayloadData(byte[] d) { data = d; }
}
