package sixtyfour.elements.functions;

import sixtyfour.Machine;
import sixtyfour.elements.Type;


public class Pos
  extends AbstractFunction
{
  public Pos()
  {
    super("POS");
  }


  @Override
  public Type getType()
  {
    return Type.INTEGER;
  }


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
