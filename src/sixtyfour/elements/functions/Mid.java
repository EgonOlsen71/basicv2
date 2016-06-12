package sixtyfour.elements.functions;

import java.util.List;

import sixtyfour.elements.Type;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;


public class Mid
  extends AbstractFunction
{
  public Mid()
  {
    super("MID$");
  }


  @Override
  public Type getType()
  {
    return Type.STRING;
  }


  @Override
  public Object eval(Machine memory)
  {
    try
    {
      List<Atom> pars = Parser.getParameters(term);
      if (pars.size() != 2 && pars.size() != 3)
      {
        throw new RuntimeException("Wrong number of parameters: " + term);
      }
      Atom var = pars.get(0);
      int start = ((Number) pars.get(1).eval(memory)).intValue();
      int end = -999;
      if (pars.size() > 2)
      {
        end = ((Number) pars.get(2).eval(memory)).intValue() + start;
      }

      String txt = var.eval(memory).toString();
      if (end == -999)
      {
        end = txt.length();
      }

      try
      {
        return txt.substring(start, end);
      }
      catch (Exception e)
      {
        throw new RuntimeException("Illegal quantity error: " + txt + "/" + start + "/" + (end - start) + " | " + term);
      }
    }
    catch (Throwable t)
    {
      t.printStackTrace();
      throw new RuntimeException("Syntax error: " + term);
    }
  }

}
