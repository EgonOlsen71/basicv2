/*
 * 
 */
package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.elements.commands.Def;
import sixtyfour.system.Machine;


/**
 * The Class Fn.
 */
public class Fn
  extends AbstractFunction
{
  
  /**
	 * Instantiates a new fn.
	 */
  public Fn()
  {
    super("FN");
  }


  /* (non-Javadoc)
   * @see sixtyfour.parser.Atom#getType()
   */
  @Override
  public Type getType()
  {
    return Type.REAL;
  }


  /* (non-Javadoc)
   * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
   */
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


  /* (non-Javadoc)
   * @see sixtyfour.elements.functions.AbstractFunction#hasPostfix()
   */
  @Override
  public boolean hasPostfix()
  {
    return true;
  }

}
