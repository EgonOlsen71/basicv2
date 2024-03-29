/*
 * 
 */
package com.sixtyfour;

import java.io.PrintStream;
import java.util.WeakHashMap;

/**
 * A very basic Logger that outputs logging messages onto the console. If you
 * actually want have some reasonable logging, modify this implementation. The
 * interpreter/compiler/runtime doesn't log very much anyway.
 */
public class Logger {

	private static PrintStream out = System.out;
	private static WeakHashMap<Thread, PrintStream> streams = new WeakHashMap<>();

	/**
	 * Logs a message.
	 * 
	 * @param msg the message
	 */
	public static void log(String msg) {
		getPrintStream().println(msg);
	}

	/**
	 * Logs a message and a Throwable.
	 * 
	 * @param msg the message
	 * @param t   the throwable
	 */
	public static void log(String msg, Throwable t) {
		getPrintStream().println(msg);
		t.printStackTrace(getPrintStream());
	}

	/**
	 * Logs a Throwable.
	 * 
	 * @param t the Throwable
	 */
	public static void log(Throwable t) {
		t.printStackTrace(getPrintStream());
	}

	/**
	 * Sets a new PrintStream for outputting the log messages. The default is
	 * System.out
	 * 
	 * @param ps the new PrintStream
	 */
	public static void setPrintStream(PrintStream ps) {
		out = ps;
	}

	/**
	 * Sets a printstream bound to the current thread. Instead of the global one,
	 * this one will be used, if the logging happens in this thread. Once the thread
	 * dies, the entry will be automatically removed as well.
	 * 
	 * @param ps the new PrintStream
	 */
	public static void setThreadBoundPrintStream(PrintStream ps) {
		streams.put(Thread.currentThread(), ps);
	}

	private static PrintStream getPrintStream() {
		return streams.getOrDefault(Thread.currentThread(), out);
	}

}
