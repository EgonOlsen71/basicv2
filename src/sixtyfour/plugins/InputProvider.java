/*
 * 
 */
package sixtyfour.plugins;

/**
 * The Interface InputProvider.
 * 
 * @author EgonOlsen
 */
public interface InputProvider {

	/**
	 * Read key.
	 * 
	 * @return the character
	 */
	Character readKey();

	/**
	 * Read string.
	 * 
	 * @return the string
	 */
	String readString();

}
