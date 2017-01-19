package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;


/**
 * The ROTATESHAPE command. This is similar to DRAWSHAPE but supports rotation. On the other hand, it's (unlike
 * DRAWSHAPE) limited to uniform scaling.
 * 
 * @author Foerster-H
 *
 */
public class RotateShape
  extends AbstractGraphicsCommand
{

  public RotateShape()
  {
    super("ROTATESHAPE");
  }


  @Override
  public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine)
  {
    return super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 5, 0);
  }


  @Override
  public BasicProgramCounter execute(Machine machine)
  {
    Atom id = pars.get(0);
    checkType(id);
    Atom x = pars.get(1);
    checkType(x);
    Atom y = pars.get(2);
    checkType(y);
    Atom d = pars.get(3);
    checkType(d);
    float zoom = VarUtils.getFloat(d.eval(machine));
    d = pars.get(4);
    checkType(d);
    float rot = VarUtils.getFloat(d.eval(machine));
    GraphicsDevice window = GraphicsDevice.getDevice(machine);
    if (window != null)
    {
      window.drawRotatedShape(VarUtils.getInt(id.eval(machine)), VarUtils.getInt(x.eval(machine)),
          VarUtils.getInt(y.eval(machine)), zoom, rot);
    }
    return null;
  }

}
