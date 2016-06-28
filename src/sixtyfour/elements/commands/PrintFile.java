package sixtyfour.elements.commands;

import java.util.List;

import sixtyfour.elements.Type;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;


public class PrintFile
  extends Print
{
  private Atom fileNumber = null;


  public PrintFile()
  {
    super("PRINT#");
  }


  @Override
  public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine)
  {
    linePart = linePart.substring(this.name.length());
    int pos = linePart.indexOf(',');
    if (pos == -1)
    {
      pos = linePart.length();
    }
    term = Parser.getTerm(linePart.substring(0, pos), machine, false, true);
    linePart = pos != linePart.length() ? linePart.substring(pos + 1) : "";
    List<Atom> pars = Parser.getParameters(term);
    if (pars.size() != 1)
    {
      throw new RuntimeException("Syntax error: " + this);
    }
    fileNumber = pars.get(0);
    if (fileNumber.getType().equals(Type.STRING))
    {
      throw new RuntimeException("Type mismatch error: " + this);
    }
    super.parse("PRINT" + linePart, lineCnt, lineNumber, linePos, lastPos, machine);
    return null;
  }


  @Override
  public ProgramCounter execute(Machine machine)
  {
    int fn = ((Number) fileNumber.eval(machine)).intValue();
    return execute(machine, machine.getDeviceProvider(), fn);
  }

}