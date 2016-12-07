package com.sixtyfour.plugins;

/**
 * An interface for providing input
 * 
 * @author EgonOlsen
 */
public interface InputProvider {

	/**
	 * Reads a key.
	 * 
	 * @return the character
	 */
	Character readKey();

	/**
	 * Reads a string.
	 * 
	 * @return the string
	 */
	String readString();

}
