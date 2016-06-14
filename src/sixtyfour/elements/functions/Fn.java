package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.elements.commands.Def;
import sixtyfour.system.Machine;


public class Fn
  extends AbstractFunction
{
  public Fn()
  {
    super("FN");
  }


  @Override
  public Type getType()
  {
    return Type.REAL;
  }


  @Override
  public Object eval(Machine machine)
  {
    Def def = (Def) machine.getFunction(this.functionName);
    if (def == null)
    {
      throw new RuntimeException("Undef'd function error: " + this + "/" + this.functionName);
    }
    if (term.getType().equals(Type.STRING))
    {
      throw new RuntimeException("Type mismatch error: " + this);
    }
    Object val = term.eval(machine);
    Variable placeHolder = machine.getVariable(def.getVarName());
    placeHolder.setValue(((Number) val).floatValue());
    return def.eval(machine);
  }


  @Override
  public boolean hasPostfix()
  {
    return true;
  }

}
