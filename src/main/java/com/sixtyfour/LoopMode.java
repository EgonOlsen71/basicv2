package com.sixtyfour;

/**
 * Enumeration for the different ways in which the BASIC compiler can deal with
 * simple busy wait loops like: FOR I=0TO1000:NEXTI
 * 
 * @author EgonOlsen
 */
public enum LoopMode {

	/**
	 * Default mode. In this mode, the loop will be executed just like any other
	 * loop.
	 */
	EXECUTE,
	/**
	 * In this mode, the loop will be replaced by a delay that is close to what
	 * an actual C64 would need to execute that loop. The loop's counter variable
	 * will contain the correct end value after the wait though.
	 */
	DELAY,
	/**
	 * In this mode, the loop won't be executed at all. The loop's counter
	 * variable will contain the correct end value anyway.
	 */
	REMOVE;

}
