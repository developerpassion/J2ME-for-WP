/*
 * serial.c - javacall serial port (comm:) for Windows Phone / UWP (J2MEWP).
 *
 * Replaces javacall/implementation/win32/midp/serial.c, which uses Win32 COM
 * port APIs (CreateFile on COMx, Get/SetCommState...) that UWP does not allow.
 * Games do not use comm: connections, so every call reports "no ports".
 */
#include <stddef.h>
#include "javacall_serial.h"

javacall_result javacall_serial_list_available_ports(char* buffer, int maxBufLen) {
    if (buffer != NULL && maxBufLen > 0) buffer[0] = '\0';
    return JAVACALL_FAIL;
}

javacall_result javacall_serial_set_baudRate(javacall_handle hPort, int baudRate) {
    (void)hPort; (void)baudRate;
    return JAVACALL_FAIL;
}

javacall_result javacall_serial_get_baudRate(javacall_handle hPort, int *baudRate) {
    (void)hPort;
    if (baudRate != NULL) *baudRate = 0;
    return JAVACALL_FAIL;
}

javacall_result javacall_serial_configure(javacall_handle pHandle, int baudRate, int options) {
    (void)pHandle; (void)baudRate; (void)options;
    return JAVACALL_FAIL;
}

javacall_result javacall_serial_open_start(const char *devName, int baudRate,
                                           unsigned int options, javacall_handle *hPort) {
    (void)devName; (void)baudRate; (void)options;
    if (hPort != NULL) *hPort = (javacall_handle)0;
    return JAVACALL_FAIL;
}

javacall_result javacall_serial_open_finish(javacall_handle hPort) {
    (void)hPort;
    return JAVACALL_FAIL;
}

javacall_result javacall_serial_close_start(javacall_handle hPort) {
    (void)hPort;
    return JAVACALL_OK;
}

javacall_result javacall_serial_close_finish(javacall_handle hPort) {
    (void)hPort;
    return JAVACALL_OK;
}

javacall_result javacall_serial_read_start(javacall_handle hPort, unsigned char* buffer,
                                           int size, int *bytesRead) {
    (void)hPort; (void)buffer; (void)size;
    if (bytesRead != NULL) *bytesRead = 0;
    return JAVACALL_FAIL;
}

javacall_result javacall_serial_read_finish(javacall_handle hPort, unsigned char* buffer,
                                            int size, int *bytesRead) {
    return javacall_serial_read_start(hPort, buffer, size, bytesRead);
}

javacall_result javacall_serial_write_start(javacall_handle hPort, unsigned char* buffer,
                                            int size, int *bytesWritten) {
    (void)hPort; (void)buffer; (void)size;
    if (bytesWritten != NULL) *bytesWritten = 0;
    return JAVACALL_FAIL;
}

javacall_result javacall_serial_write_finish(javacall_handle hPort, unsigned char* buffer,
                                             int size, int *bytesWritten) {
    return javacall_serial_write_start(hPort, buffer, size, bytesWritten);
}
