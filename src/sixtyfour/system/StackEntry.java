package sixtyfour.system;

import sixtyfour.elements.commands.Command;
import sixtyfour.elements.commands.Gosub;

public class StackEntry {
	private Command command;

	public StackEntry(Command command) {
		this.command = command;
	}

	public Command getCommand() {
		return command;
	}

	public boolean isSubroutineCall() {
		return command instanceof Gosub;
	}
}
