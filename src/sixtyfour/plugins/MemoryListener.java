/*
 * 
 */
package sixtyfour.plugins;

/**
 * The listener interface for receiving memory events. The class that is
 * interested in processing a memory event implements this interface, and the
 * object created with that class is registered with a component using the
 * component's <code>addMemoryListener<code> method. When
 * the memory event occurs, that object's appropriate
 * method is invoked.
 * 
 * @see MemoryEvent
 */
public interface MemoryListener {

	/**
	 * Poke.
	 * 
	 * @param addr
	 *            the addr
	 * @param value
	 *            the value
	 */
	void poke(int addr, int value);

	/**
	 * Wait.
	 * 
	 * @param addr
	 *            the addr
	 * @param value
	 *            the value
	 * @param inverse
	 *            the inverse
	 * @return true, if successful
	 */
	boolean wait(int addr, int value, int inverse);
}
