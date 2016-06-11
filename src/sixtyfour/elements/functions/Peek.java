package sixtyfour.elements.functions;

import sixtyfour.Machine;
import sixtyfour.elements.Type;


public class Peek
  extends AbstractFunction
{
  public Peek()
  {
    super("PEEK");
  }


  @Override
  public Type getType()
  {
    return term.getType();
  }


  @Override
  public Object eval(Machine memory)
  {
    if (!getType().equals(Type.STRING))
    {
      return Integer.valueOf(memory.getRam()[((Number) term.eval(memory)).intValue()]);
    }
    throw new RuntimeException("Type mismatch error: " + getType());
  }
}
