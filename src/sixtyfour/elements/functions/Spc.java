package sixtyfour.elements.functions;

import sixtyfour.Memory;
import sixtyfour.elements.Type;
import sixtyfour.elements.commands.Print;


public class Spc
  extends AbstractFunction
{
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


  protected Spc(String name)
  {
    super(name);
  }


  public Spc()
  {
    super("SPC");
  }


  @Override
  public Type getType()
  {
    return Type.STRING;
  }


  @Override
  public Object eval(Memory memory)
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


  protected void ensureContext(Memory memory)
  {
    if (!(memory.getCurrentCommand() instanceof Print) || !memory.getCurrentOperator().isNop())
    {
      throw new RuntimeException("Systax error: " + this);
    }
  }
}
