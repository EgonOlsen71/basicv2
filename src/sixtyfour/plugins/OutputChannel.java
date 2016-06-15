package sixtyfour.plugins;

public interface OutputChannel {

	public abstract void print(String txt);

	public abstract void print(String txt, boolean clean);

	public abstract void println(String txt);

	public abstract void println(String txt, boolean clean);

	public abstract int getCursor();

	public abstract void setCursor(int cursor);

}