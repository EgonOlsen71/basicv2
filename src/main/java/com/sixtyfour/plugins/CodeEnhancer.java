package com.sixtyfour.plugins;

/**
 * Interface to enhance the actual BASIC code programmatically by a first and a
 * last command, which will be executed before and after the actual program's
 * code.
 * 
 * @author EgonOlsen
 * 
 */
public interface CodeEnhancer {
	/**
	 * The first command. This has to be a single command or null.
	 * 
	 * @return the command or null
	 */
	String getFirstCommand();

	/**
	 * The last command. This has to be a single command or null.
	 * 
	 * @return the command or null
	 */
	String getLastCommand();
}
