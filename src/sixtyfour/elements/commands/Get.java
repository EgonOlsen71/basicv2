package sixtyfour.elements.commands;

import java.util.Locale;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;


public class Get
  extends AbstractCommand
{

  private Variable var;


  public Get()
  {
    super("GET");
  }


  @Override
  public Type getType()
  {
    return var.getType();
  }


  @Override
  public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine)
  {
    super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
    linePart = linePart.substring(3).trim();
    var = new Variable(linePart.toUpperCase(Locale.ENGLISH), null);
    return null;
  }


  @Override
  public ProgramCounter execute(Machine machine)
  {
    var = machine.add(var);
    Character input = machine.getInputProvider().readKey();
    if (var.getType().equals(Type.STRING))
    {
      if (input == null)
      {
        var.setValue("");
      }
      else
      {
        var.setValue(input.toString());
      }
    }
    else
    {
      if (input == null)
      {
        var.setValue(0);
      }
      else
      {
        var.setValue((int) input.charValue());
      }
    }
    machine.getOutputChannel().setPrintConsumer(null, 0);
    return null;
  }
}
