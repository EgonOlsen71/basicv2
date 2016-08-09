/*
 * 
 */
package com.sixtyfour;

/**
 * A simple helper class that allows for starting BASIC programs from the
 * command line. It takes the file name as the only parameter, then loads and
 * runs it once.
 */
public class Runtime {

	/**
	 * The main method.
	 * 
	 * @param args
	 *            the arguments. The first argument will be interpreted as the
	 *            file name, following arguments will be ignored.
	 */
	public static void main(String[] args) {
		if (args.length == 0) {
			throw new RuntimeException("No file name specified!");
		}
		String file = args[0];
		String[] code = Loader.loadProgram(file);
		Interpreter parser = new Interpreter(code);
		parser.run();
	}

}
