package sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


public class CommandList
{
  public static final List<Command> COMMANDS = Collections.unmodifiableList(new ArrayList<Command>()
  {
    private static final long serialVersionUID = 1L;
    {
      add(new Let());
      add(new For());
      add(new If());
      add(new Then());
      add(new Goto());
      add(new Gosub());
      add(new For());
      add(new Next());
      add(new Read());
      add(new Data());
      add(new Poke());
      add(new Sys());
      add(new Return());
      add(new Print());
      add(new Dim());
      add(new Rem());
      add(new End());
    }
  });


  public static List<Command> getCommands()
  {
    return COMMANDS;
  }


  public static Command getLetCommand()
  {
    return COMMANDS.get(0);
  }
}
