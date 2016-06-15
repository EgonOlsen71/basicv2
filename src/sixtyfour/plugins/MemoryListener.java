package sixtyfour.plugins;

public interface MemoryListener {

	void poke(int addr, int value);

	boolean wait(int addr, int value, int inverse);
}
