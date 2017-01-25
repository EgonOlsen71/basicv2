package com.sixtyfour.extensions.textmode.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.commands.AbstractGraphicsCommand;
import com.sixtyfour.extensions.textmode.ConsoleDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;


public class Console
  extends AbstractGraphicsCommand
{

  public Console()
  {
    super("CONSOLE");
  }


  @Override
  public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine)
  {
    String ret = super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 1, 0);
    checkTypes(pars, linePart, Type.STRING);
    return ret;
  }


  @Override
  public BasicProgramCounter execute(Machine machine)
  {
    Atom m = pars.get(0);
    ConsoleDevice window = ConsoleDevice.getDevice(machine);
    int mode = VarUtils.getInt(m.eval(machine));
    if (window != null && mode == 0)
    {
      window.dispose();
    }
    else
    {
      if (mode > 0)
      {
        ConsoleDevice.openDevice(machine, 800, 500);
      }
    }
    return null;
  }

}
