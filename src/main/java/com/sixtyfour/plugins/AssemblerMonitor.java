package com.sixtyfour.plugins;

/**
 * Interface to listen to what the Assembler is doing...
 * 
 * @author EgonOlsen
 *
 */
public interface AssemblerMonitor {

	void doneWithLine(int addr, int lineNumber, String line);
}
