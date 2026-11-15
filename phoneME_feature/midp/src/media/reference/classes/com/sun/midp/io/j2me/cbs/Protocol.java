/*
 * J2MEWP: minimal JSR 120 (Wireless Messaging API 1.1) so games that link
 * against it load. There is no SMS on this platform: send() always fails
 * with an IOException, receive() never delivers a message.
 */
package com.sun.midp.io.j2me.cbs;

import java.io.IOException;
import javax.microedition.io.Connection;
import com.sun.cldc.io.ConnectionBaseInterface;
import com.sun.j2mewp.messaging.StubMessageConnection;

public class Protocol implements ConnectionBaseInterface {
    public Connection openPrim(String name, int mode, boolean timeouts)
            throws IOException {
        return new StubMessageConnection("cbs:" + name);
    }
}
