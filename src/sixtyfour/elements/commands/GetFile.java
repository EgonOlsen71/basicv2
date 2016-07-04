package sixtyfour.elements.commands;

import java.util.List;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;


/**
 * The Class GetFile.
 */
public class GetFile
  extends Get
{
  
  /** The file number. */
  private Atom fileNumber = null;


  /**
	 * Instantiates a new gets the file.
	 */
  public GetFile()
  {
    super("GET#");
  }


  /* (non-Javadoc)
   * @see sixtyfour.elements.commands.Get#parse(java.lang.String, int, int, int, boolean, sixtyfour.system.Machine)
   */
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
    super.parse("GET" + linePart, lineCnt, lineNumber, linePos, lastPos, machine);
    return null;
  }


  /* (non-Javadoc)
   * @see sixtyfour.elements.commands.Get#execute(sixtyfour.system.Machine)
   */
  @Override
  public ProgramCounter execute(Machine machine)
  {
    for (int i = 0; i < vars.size(); i++)
    {
      Term indexTerm = indexTerms.get(i);
      Variable var = this.getVariable(machine, i);
      Character input = machine.getDeviceProvider().getChar(((Number) fileNumber.eval(machine)).intValue());
      if (input == 0)
      {
        input = ' ';
      }
      if (indexTerm != null)
      {
        List<Atom> pars = Parser.getParameters(indexTerm);
        int[] pis = new int[pars.size()];
        int cnt = 0;
        for (Atom par : pars)
        {
          pis[cnt++] = ((Number) par.eval(machine)).intValue();
        }
        if (var.getType().equals(Type.STRING))
        {
          var.setValue(input.toString(), pis);
        }
        else
        {
          input = ensureNumberKey(machine, input, false);
          var.setValue(input.toString(), pis);
        }
      }
      else
      {
        if (var.getType().equals(Type.STRING))
        {
          var.setValue(input.toString());
        }
        else
        {
          input = ensureNumberKey(machine, input, false);
          var.setValue(input.toString());
        }
      }
    }
    machine.getOutputChannel().setPrintConsumer(null, 0);
    return null;
  }
}
