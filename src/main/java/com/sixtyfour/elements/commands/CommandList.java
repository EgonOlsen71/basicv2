package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * A list that contains all the commands.
 */
public class CommandList {

	/** The COMMANDS. */
	private static List<Command> COMMANDS = Collections.unmodifiableList(new ArrayList<Command>() {
		private static final long serialVersionUID = 1L;
		{
			add(new Let());
			add(new For());
			add(new If());
			add(new Goto());
			add(new Gosub());
			add(new Next());
			add(new Read());
			add(new Data());
			add(new Poke());
			add(new Sys());
			add(new Return());
			add(new PrintFile());
			add(new Print());
			add(new PrintShortcut());
			add(new Dim());
			add(new Rem());
			add(new End());
			add(new Stop());
			add(new New());
			add(new Lst());
			add(new Def());
			add(new GetFile());
			add(new Get());
			add(new On());
			add(new Wait());
			add(new Run());
			add(new Cont());
			add(new InputFile());
			add(new Input());
			add(new Restore());
			add(new Clr());
			add(new Open());
			add(new Close());
			add(new Cmd());
			add(new Load());
			add(new Save());
			add(new Verify());
		}
	});

	private final static Command LET = COMMANDS.get(0);

	public static void registerNewCommands(List<Command> commands) {
		if (commands != null && !commands.isEmpty()) {
			commands = new ArrayList<Command>(commands);
			commands.addAll(COMMANDS);
			COMMANDS = Collections.unmodifiableList(commands);
			List<String> names=new ArrayList<String>();
			for (Command command:COMMANDS) {
			  for (String name:names) {
			    if (command.getName().startsWith(name)) {
			      throw new RuntimeException("Naming conflict: "+command.getName() + " is hidden by "+name);
			    }
			  }
			  names.add(command.getName());
			}
		}
	}

	/**
	 * Gets all commands.
	 * 
	 * @return the commands
	 */
	public static List<Command> getCommands() {
		return COMMANDS;
	}

	/**
	 * Gets the LET command.
	 * 
	 * @return the let command
	 */
	public static Command getLetCommand() {
		return LET;
	}
}
