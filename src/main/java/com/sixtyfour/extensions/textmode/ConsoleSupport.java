package com.sixtyfour.extensions.textmode;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.extensions.BasicExtension;
import com.sixtyfour.extensions.textmode.commands.Console;
import com.sixtyfour.extensions.textmode.commands.ConsoleFont;
import com.sixtyfour.system.Machine;

/**
 * A BASIC extension that adds PETSCII console support. For more details see
 * "CONSOLE SUPPORT.txt"
 * 
 * @author EgonOlsen
 * 
 */
public class ConsoleSupport implements BasicExtension {

	private final static List<Command> COMMANDS = Collections.unmodifiableList(new ArrayList<Command>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(new ConsoleFont());
			this.add(new Console());
		}
	});

	@Override
	public List<Command> getCommands() {
		return COMMANDS;
	}

	@Override
	public List<Function> getFunctions() {
		return null;
	}

	@Override
	public void reset(Machine machine) {
		ConsoleDevice window = ConsoleDevice.getDevice(machine);
		if (window != null) {
			window.dispose();
		}
	}

	@Override
	public List<String> getAdditionalIncludes() {
		return null;
	}

	@Override
	public Map<String, Integer> getLabel2Constant() {
		return null;
	}

}
