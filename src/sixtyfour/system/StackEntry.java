package sixtyfour.system;

import sixtyfour.elements.commands.Command;
import sixtyfour.elements.commands.For;
import sixtyfour.elements.commands.Gosub;
import sixtyfour.elements.commands.On;

public class StackEntry {
	private Command command;

	public StackEntry(Command command) {
		this.command = command;
	}

	public Command getCommand() {
		return command;
	}

	public boolean isFor() {
		return command instanceof For;
	}

	public boolean isSubroutineCall() {
		return command instanceof Gosub || command instanceof On;
	}
}
