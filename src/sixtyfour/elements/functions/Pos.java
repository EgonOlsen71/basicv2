package sixtyfour.elements.functions;

import sixtyfour.Memory;
import sixtyfour.OutputChannel;
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
  public Object eval(Memory memory)
  {
    if (!term.getType().equals(Type.STRING))
    {
      return OutputChannel.getCursor();
    }
    throw new RuntimeException("Formula too complex error: " + this);
  }

}
