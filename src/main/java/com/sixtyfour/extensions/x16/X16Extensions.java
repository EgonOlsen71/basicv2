package com.sixtyfour.extensions.x16;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.extensions.BasicExtension;
import com.sixtyfour.extensions.x16.commands.Vpoke;
import com.sixtyfour.system.Machine;

/**
 * @author Foerster-H
 *
 */
public class X16Extensions implements BasicExtension {

    private final static List<Command> COMMANDS = Collections.unmodifiableList(new ArrayList<Command>() {
	private static final long serialVersionUID = 1L;
	{
	    this.add(new Vpoke());
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
	//
    }

}
