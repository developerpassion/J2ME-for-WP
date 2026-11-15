/*
 * J2MEWP: java.lang.StringBuilder for CLDC 1.1.
 *
 * Many "J2ME" games are compiled with javac -source 1.5+, which turns string
 * concatenation into new StringBuilder().append(..).toString(). CLDC 1.1 only
 * has StringBuffer, so such games die with NoClassDefFoundError. This class
 * provides the subset of the J2SE API that javac and typical game code use,
 * implemented on top of StringBuffer (no CharSequence/Appendable in CLDC).
 */
package java.lang;

public final class StringBuilder {
    private final StringBuffer sb;

    public StringBuilder() { sb = new StringBuffer(); }
    public StringBuilder(int capacity) { sb = new StringBuffer(capacity); }
    public StringBuilder(String str) { sb = new StringBuffer(String.valueOf(str)); }

    public StringBuilder append(Object obj) { sb.append(obj); return this; }
    public StringBuilder append(String str) { sb.append(str); return this; }
    public StringBuilder append(StringBuffer s) { sb.append((Object) s); return this; }
    public StringBuilder append(StringBuilder s) { sb.append(s == null ? "null" : s.toString()); return this; }
    public StringBuilder append(char[] str) { sb.append(str); return this; }
    public StringBuilder append(char[] str, int offset, int len) { sb.append(str, offset, len); return this; }
    public StringBuilder append(boolean b) { sb.append(b); return this; }
    public StringBuilder append(char c) { sb.append(c); return this; }
    public StringBuilder append(int i) { sb.append(i); return this; }
    public StringBuilder append(long l) { sb.append(l); return this; }
    public StringBuilder append(float f) { sb.append(f); return this; }
    public StringBuilder append(double d) { sb.append(d); return this; }

    public StringBuilder insert(int offset, Object obj) { sb.insert(offset, obj); return this; }
    public StringBuilder insert(int offset, String str) { sb.insert(offset, str); return this; }
    public StringBuilder insert(int offset, char[] str) { sb.insert(offset, str); return this; }
    public StringBuilder insert(int offset, boolean b) { sb.insert(offset, b); return this; }
    public StringBuilder insert(int offset, char c) { sb.insert(offset, c); return this; }
    public StringBuilder insert(int offset, int i) { sb.insert(offset, i); return this; }
    public StringBuilder insert(int offset, long l) { sb.insert(offset, l); return this; }
    public StringBuilder insert(int offset, float f) { sb.insert(offset, f); return this; }
    public StringBuilder insert(int offset, double d) { sb.insert(offset, d); return this; }

    public StringBuilder delete(int start, int end) { sb.delete(start, end); return this; }
    public StringBuilder deleteCharAt(int index) { sb.deleteCharAt(index); return this; }
    public StringBuilder reverse() { sb.reverse(); return this; }

    public StringBuilder replace(int start, int end, String str) {
        int len = sb.length();
        if (start < 0 || start > len || start > end) throw new StringIndexOutOfBoundsException();
        if (end > len) end = len;
        sb.delete(start, end);
        sb.insert(start, str);
        return this;
    }

    public int indexOf(String str) { return sb.toString().indexOf(str); }
    public int indexOf(String str, int fromIndex) { return sb.toString().indexOf(str, fromIndex); }
    public String substring(int start) { return sb.toString().substring(start); }
    public String substring(int start, int end) { return sb.toString().substring(start, end); }

    public int length() { return sb.length(); }
    public int capacity() { return sb.capacity(); }
    public void ensureCapacity(int minimumCapacity) { sb.ensureCapacity(minimumCapacity); }
    public void setLength(int newLength) { sb.setLength(newLength); }
    public char charAt(int index) { return sb.charAt(index); }
    public void setCharAt(int index, char ch) { sb.setCharAt(index, ch); }
    public void getChars(int srcBegin, int srcEnd, char[] dst, int dstBegin) { sb.getChars(srcBegin, srcEnd, dst, dstBegin); }

    public String toString() { return sb.toString(); }
}
