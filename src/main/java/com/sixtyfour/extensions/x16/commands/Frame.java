package com.sixtyfour.extensions.x16.commands;

import java.util.List;

import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;

/**
 * The FRAME command.
 */
public class Frame extends AbstractGeosCommand {

	/**
	 * Instantiates a new wait.
	 */
	public Frame() {
		super("FRAME");
	}



	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
	    return super.evalToCode(config, machine, "FRAME");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
	    Logger.log("Call to FRAME ignored by local runtime!");
		return null;
	}
}
