/*
 * 
 */
package sixtyfour.elements.commands;

import java.util.List;

import sixtyfour.elements.Type;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;
import sixtyfour.util.VarUtils;


/**
 * The Class Sys.
 */
public class Sys
  extends AbstractCommand
{
  
  /** The pars. */
  private List<Atom> pars;


  /**
	 * Instantiates a new sys.
	 */
  public Sys()
  {
    super("SYS");
  }


  /* (non-Javadoc)
   * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int, int, int, boolean, sixtyfour.system.Machine)
   */
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


  /* (non-Javadoc)
   * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.Machine)
   */
  @Override
  public ProgramCounter execute(Machine machine)
  {
    Atom addr = pars.get(0);
    List<Atom> vals = pars.subList(1, pars.size());
    if (addr.getType().equals(Type.STRING))
    {
      throw new RuntimeException("Type mismatch error: " + this);
    }
    int memAddr = VarUtils.getInt(addr.eval(machine));
    if (memAddr < 0 || memAddr > 65535)
    {
      throw new RuntimeException("Illegal quantity error: " + this);
    }
    Object[] params = null;
    if (!vals.isEmpty())
    {
      params = new Object[vals.size()];
      int cnt = 0;
      for (Atom val : vals)
      {
        params[cnt++] = val.eval(machine);
      }
    }
    machine.getSystemCallListener().sys(memAddr, params);

    return null;

  }

}
