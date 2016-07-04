/*
 * 
 */
package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;


/**
 * The Class Peek.
 */
public class Peek
  extends AbstractFunction
{
  
  /**
	 * Instantiates a new peek.
	 */
  public Peek()
  {
    super("PEEK");
  }


  /* (non-Javadoc)
   * @see sixtyfour.parser.Atom#getType()
   */
  @Override
  public Type getType()
  {
    return term.getType();
  }


  /* (non-Javadoc)
   * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
   */
  @Override
  public Object eval(Machine memory)
  {
    if (!getType().equals(Type.STRING))
    {
      return Integer.valueOf(memory.getRam()[((Number) term.eval(memory)).intValue() & 0xff]);
    }
    throw new RuntimeException("Type mismatch error: " + getType());
  }
}
