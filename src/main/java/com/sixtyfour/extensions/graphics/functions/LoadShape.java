package com.sixtyfour.extensions.graphics.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.functions.AbstractFunction;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.system.Machine;


public class LoadShape
  extends AbstractFunction
{

  public LoadShape()
  {
    super("LOADSHAPE");
  }


  @Override
  public Type getType()
  {
    return Type.INTEGER;
  }


  @Override
  public Object eval(Machine machine)
  {
    if (term.getType().equals(Type.STRING))
    {
      String str = (String) term.eval(machine);
      if (str == null || str.length() == 0)
      {
        throw new RuntimeException("Illegal quantity error: " + this);
      }

      GraphicsDevice window = GraphicsDevice.getDevice(machine);
      String name = term.eval(machine).toString();
      if (window != null)
      {
        int id = window.addShape(name);
        if (id == -1)
        {
          throw new RuntimeException("Couldn't load shape " + name);
        }
        return id;
      }
      else
      {
        throw new RuntimeException("Graphics mode not enabled!");
      }
    }
    throw new RuntimeException("Type mismatch error: " + term.getType());
  }

}
