/*
 * 
 */
package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;


/**
 * The Class Pos.
 */
public class Pos
  extends AbstractFunction
{
  
  /**
	 * Instantiates a new pos.
	 */
  public Pos()
  {
    super("POS");
  }


  /* (non-Javadoc)
   * @see sixtyfour.parser.Atom#getType()
   */
  @Override
  public Type getType()
  {
    return Type.INTEGER;
  }


  /* (non-Javadoc)
   * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
   */
  @Override
  public Object eval(Machine memory)
  {
    if (!term.getType().equals(Type.STRING))
    {
      return memory.getOutputChannel().getCursor();
    }
    throw new RuntimeException("Formula too complex error: " + this);
  }

}
