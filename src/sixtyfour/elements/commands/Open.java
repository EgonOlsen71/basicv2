package sixtyfour.elements.commands;

import java.util.List;

import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.plugins.DeviceProvider;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;


public class Open
  extends AbstractCommand
{
  private List<Atom> pars;


  public Open()
  {
    super("OPEN");
  }


  @Override
  public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine)
  {
    super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
    term = Parser.getTerm(this, linePart, machine, true);
    pars = Parser.getParameters(term);

    if (pars.isEmpty())
    {
      throw new RuntimeException("Syntax error: " + this);
    }

    return null;
  }


  @Override
  public ProgramCounter execute(Machine machine)
  {
    DeviceProvider device = machine.getDeviceProvider();

    try
    {
      switch (pars.size())
      {
        case 1:
          device.open(((Number) pars.get(0).eval(machine)).intValue());
          break;
        case 2:
          device.open(((Number) pars.get(0).eval(machine)).intValue(), ((Number) pars.get(1).eval(machine)).intValue());
          break;
        case 3:
          device.open(((Number) pars.get(0).eval(machine)).intValue(), ((Number) pars.get(1).eval(machine)).intValue(),
              ((Number) pars.get(2).eval(machine)).intValue());
          break;
        case 4:
          device.open(((Number) pars.get(0).eval(machine)).intValue(), ((Number) pars.get(1).eval(machine)).intValue(),
              ((Number) pars.get(2).eval(machine)).intValue(), (String) pars.get(3).eval(machine));
          break;
      }
    }
    catch (ClassCastException e)
    {
      throw new RuntimeException("Syntax error: " + this);
    }

    return null;

  }
}
