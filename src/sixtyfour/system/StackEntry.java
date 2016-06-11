package sixtyfour.system;

import sixtyfour.elements.commands.Command;


public class StackEntry
{
  private Command command;


  public StackEntry(Command command)
  {
    this.command = command;
  }


  public Command getCommand()
  {
    return command;
  }
}
