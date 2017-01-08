/*
 * 
 */
package com.sixtyfour.plugins;

/**
 * A print consumer takes strings and consumes them somehow.
 */
public interface PrintConsumer {

	/**
	 * Prints a text without a line break.
	 * 
	 * @param id
	 *            a channel id
	 * @param txt
	 *            the text
	 */
	void print(int id, String txt);

	/**
	 * Prints a text followed by a line break.
	 * 
	 * @param id
	 *            a channel id
	 * @param txt
	 *            the text
	 */
	void println(int id, String txt);

	/**
	 * Prints a system message without a line break.
	 * 
	 * @param id
	 *            a channel id
	 * @param txt
	 *            the text
	 */
	void systemPrint(int id, String txt);

	/**
	 * Prints a system message followed by a line break.
	 * 
	 * @param id
	 *            a channel id
	 * @param txt
	 *            the text
	 */
	void systemPrintln(int id, String txt);

}
