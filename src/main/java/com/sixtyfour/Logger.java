/*
 * 
 */
package com.sixtyfour;

/**
 * A very basic Logger that outputs logging messages onto the console. If you
 * actually want have some reasonable logging, modify this implementation. The
 * interpreter/compiler/runtime doesn't log very much anyway.
 */
public class Logger {

	/**
	 * Logs a message.
	 * 
	 * @param msg
	 *            the message
	 */
	public static void log(String msg) {
		System.out.println(msg);
	}

	/**
	 * Logs a message and a Throwable.
	 * 
	 * @param msg
	 *            the message
	 * @param t
	 *            the throwable
	 */
	public static void log(String msg, Throwable t) {
		System.out.println(msg);
		t.printStackTrace();
	}

	/**
	 * Logs a Throwable.
	 * 
	 * @param t
	 *            the Throwable
	 */
	public static void log(Throwable t) {
		t.printStackTrace();
	}

}
