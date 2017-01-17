package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.elements.commands.AbstractCommand;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;

/**
 * The CLEAR command.
 * 
 * @author EgonOlsen
 * 
 */
public class Clear extends AbstractCommand {

	public Clear() {
		super("CLEAR");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, com.sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		if (linePart.trim().length() > 5) {
			throw new RuntimeException("Syntax error: " + this);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.clear(); 
		} 
		return null;
	}

}
