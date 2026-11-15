/* J2MEWP: Nokia virtual keyboard visibility listener (never called). */
package com.nokia.mid.ui;

public interface KeyboardVisibilityListener {
    void hideNotify(int keyboardCategory);
    void showNotify(int keyboardCategory);
}
