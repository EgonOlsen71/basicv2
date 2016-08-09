/*
 * 
 */
package com.sixtyfour;

/**
 * The Class Logger.
 */
public class Logger {

	/**
	 * Log.
	 * 
	 * @param msg
	 *            the msg
	 */
	public static void log(String msg) {
		System.out.println(msg);
	}

	/**
	 * Log.
	 * 
	 * @param msg
	 *            the msg
	 * @param t
	 *            the t
	 */
	public static void log(String msg, Throwable t) {
		System.out.println(msg);
		t.printStackTrace();
	}

	/**
	 * Log.
	 * 
	 * @param t
	 *            the t
	 */
	public static void log(Throwable t) {
		t.printStackTrace();
	}

}
