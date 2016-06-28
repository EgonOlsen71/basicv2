package sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Parser;
import sixtyfour.plugins.OutputChannel;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;


public class Input
  extends AbstractCommand
{

  private List<Variable> vars = new ArrayList<Variable>();
  private String comment = "";


  public Input()
  {
    super("INPUT");
  }


  @Override
  public Type getType()
  {
    return Type.NONE;
  }


  @Override
  public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine)
  {
    super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
    linePart = Parser.removeWhiteSpace(linePart);
    linePart = linePart.substring(5).trim();
    if (linePart.length() == 0)
    {
      throw new RuntimeException("Syntax error: " + this);
    }
    int pos = linePart.indexOf('"');
    if (pos != -1)
    {
      if (linePart.length() < 4 || pos != 0)
      {
        throw new RuntimeException("Syntax error: " + this);
      }
      int pos2 = linePart.indexOf("\";", pos + 1);
      if (pos2 == -1 || pos2 == linePart.length() - 2)
      {
        throw new RuntimeException("Syntax error: " + this);
      }
      comment = linePart.substring(pos + 1, pos2);
      linePart = linePart.substring(pos2 + 2);
    }
    String[] parts = linePart.split(",");
    for (String part : parts)
    {
      Variable var = new Variable(part.trim().toUpperCase(Locale.ENGLISH), null);
      vars.add(var);
    }
    return null;
  }


  @Override
  public ProgramCounter execute(Machine machine)
  {
    List<String> queue = new ArrayList<String>();
    OutputChannel out = machine.getOutputChannel();
    for (int i = 0; i < vars.size(); i++)
    {
      if (i == 0)
      {
        if (comment != null)
        {
          out.print(0, comment);
        }
        out.print(0, "?");
      }
      else
      {
        if (queue.isEmpty())
        {
          out.print(0, "??");
        }
      }
      Variable var = vars.get(i);
      var = machine.add(var);
      String input = null;
      if (queue.isEmpty())
      {
        input = machine.getInputProvider().readString();
        if (input == null)
        {
          input = "";
        }
        String[] parts = input.split(",");
        if (parts.length > 1)
        {
          for (int p = 1; p < parts.length; p++)
          {
            queue.add(parts[p]);
          }
        }
        input = parts[0];
      }
      else
      {
        input = queue.remove(0);
      }

      if (var.getType().equals(Type.STRING))
      {
        if (input != null)
        {
          var.setValue(input);
        }
      }
      else
      {
        if (input != null)
        {
          if (var.getType().equals(Type.INTEGER))
          {
            try
            {
              Integer num = Integer.valueOf(input);
              var.setValue(num);
            }
            catch (NumberFormatException nfe)
            {
              out.println(0, "?Redo from start");
              queue.clear();
              i = -1;
            }
          }
          else
          {
            try
            {
              Float num = Float.valueOf(input);
              var.setValue(num);
            }
            catch (NumberFormatException nfe)
            {
              out.println(0, "?Redo from start");
              queue.clear();
              i = -1;
            }
          }
        }
      }
    }
    return null;
  }
}
