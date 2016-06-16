package sixtyfour.elements.functions;

import java.util.List;

import sixtyfour.elements.Constant;
import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;


public class ArrayAccess
  extends AbstractFunction
{

  private String variableName;
  private Type variableType;


  public ArrayAccess()
  {
    super("[]");
  }


  @Override
  public Type getType()
  {
    return variableType;
  }


  @Override
  public Object eval(Machine memory)
  {
    List<Atom> pars = Parser.getParameters(term);
    int[] pis = new int[pars.size()];
    int cnt = 0;
    for (Atom par : pars)
    {
      pis[cnt++] = ((Number) par.eval(memory)).intValue();
    }
    Variable vary = memory.getVariable(variableName);
    if (vary == null)
    {
      // No such array...revert to a constant
      if (variableType.equals(Type.REAL))
      {
        return new Constant<Float>(0f);
      }
      if (variableType.equals(Type.INTEGER))
      {
        return new Constant<Integer>(0);
      }
      if (variableType.equals(Type.STRING))
      {
        return new Constant<String>("");
      }
    } 

    return vary.getValue(pis);
  }


  public void setVariable(Variable variable)
  {
    this.variableType = variable.getType();
    this.variableName = variable.getName();
  }
}
