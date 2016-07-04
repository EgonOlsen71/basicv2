/*
 * 
 */
package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.elements.commands.Print;
import sixtyfour.system.Machine;


/**
 * The Class Spc.
 */
public class Spc
  extends AbstractFunction
{
  
  /** The Constant SPACES. */
  protected final static String SPACES;


  static
  {
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < 255; i++)
    {
      sb.append(' ');
    }
    SPACES = sb.toString();
  }


  /**
	 * Instantiates a new spc.
	 * 
	 * @param name
	 *            the name
	 */
  protected Spc(String name)
  {
    super(name);
  }


  /**
	 * Instantiates a new spc.
	 */
  public Spc()
  {
    super("SPC");
  }


  /* (non-Javadoc)
   * @see sixtyfour.parser.Atom#getType()
   */
  @Override
  public Type getType()
  {
    return Type.STRING;
  }


  /* (non-Javadoc)
   * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
   */
  @Override
  public Object eval(Machine memory)
  {
    ensureContext(memory);
    if (term.getType().equals(Type.STRING))
    {
      throw new RuntimeException("Type mismatch error: " + this);
    }
    int num = ((Number) term.eval(memory)).intValue();
    if (num < 0 || num > 255)
    {
      throw new RuntimeException("Illegal quantity error: " + this);
    }
    return SPACES.substring(0, num);
  }


  /**
	 * Ensure context.
	 * 
	 * @param memory
	 *            the memory
	 */
  protected void ensureContext(Machine memory)
  {
    if (!(memory.getCurrentCommand() instanceof Print) || !memory.getCurrentOperator().isNop())
    {
      throw new RuntimeException("Systax error: " + this);
    }
  }
}
