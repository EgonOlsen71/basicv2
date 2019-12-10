/*
 * 
 */
package com.sixtyfour;

import java.io.PrintStream;

/**
 * A very basic Logger that outputs logging messages onto the console. If you
 * actually want have some reasonable logging, modify this implementation. The
 * interpreter/compiler/runtime doesn't log very much anyway.
 */
public class Logger {

	private static PrintStream out=System.out;
    
    	/**
	 * Logs a message.
	 * 
	 * @param msg the message
	 */
	public static void log(String msg) {
	    	out.println(msg);
	}

	/**
	 * Logs a message and a Throwable.
	 * 
	 * @param msg the message
	 * @param t   the throwable
	 */
	public static void log(String msg, Throwable t) {
	    	out.println(msg);
		t.printStackTrace(out);
	}

	/**
	 * Logs a Throwable.
	 * 
	 * @param t the Throwable
	 */
	public static void log(Throwable t) {
		t.printStackTrace(out);
	}
	
	/**
	 * Sets a new PrintStream for outputting the log messages.
	 * The default is System.out
	 * 
	 * @param ps the new PrintStream
	 */
	public void setPrintStream(PrintStream ps) {
	    out=ps;
	}

}
