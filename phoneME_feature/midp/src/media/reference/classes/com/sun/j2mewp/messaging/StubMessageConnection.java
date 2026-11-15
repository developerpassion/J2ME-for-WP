/*
 * J2MEWP: minimal JSR 120 (Wireless Messaging API 1.1) so games that link
 * against it load. There is no SMS on this platform: send() always fails
 * with an IOException, receive() never delivers a message.
 */
package com.sun.j2mewp.messaging;

import java.io.IOException;
import java.io.InterruptedIOException;
import javax.wireless.messaging.Message;
import javax.wireless.messaging.MessageConnection;
import javax.wireless.messaging.MessageListener;

public class StubMessageConnection implements MessageConnection {
    private final String url;
    private boolean closed;

    public StubMessageConnection(String url) { this.url = url; }

    private void check() throws IOException {
        if (closed) throw new IOException("connection closed");
    }

    public Message newMessage(String type) { return newMessage(type, url); }

    public Message newMessage(String type, String address) {
        if (!TEXT_MESSAGE.equals(type) && !BINARY_MESSAGE.equals(type)) {
            throw new IllegalArgumentException("unsupported message type " + type);
        }
        return new StubMessage(address);
    }

    public void send(Message msg) throws IOException, InterruptedIOException {
        check();
        if (msg == null) throw new NullPointerException();
        System.out.println("[sms] send blocked: " + msg.getAddress());
        throw new IOException("SMS not supported");
    }

    public Message receive() throws IOException, InterruptedIOException {
        check();
        throw new InterruptedIOException("SMS not supported");
    }

    public void setMessageListener(MessageListener l) throws IOException { check(); }

    public int numberOfSegments(Message msg) { return msg == null ? 0 : 1; }

    public void close() throws IOException { closed = true; }
}
