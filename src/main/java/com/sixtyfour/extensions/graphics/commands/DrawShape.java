package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

public class DrawShape extends AbstractGraphicsCommand {

  public DrawShape() {
    super("DRAWSHAPE");
  }

  @Override
  public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
    return super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 3, 2);
  }

  @Override
  public BasicProgramCounter execute(Machine machine) {
    Atom id = pars.get(0);
    checkType(id);
    Atom x = pars.get(1);
    checkType(x);
    Atom y = pars.get(2);
    checkType(y);
    int xd=-1;
    int yd=-1;
    if (pars.size()>3) {
      Atom d = pars.get(3);
      checkType(d);
      xd=VarUtils.getInt(d.eval(machine));
      d = pars.get(4);
      checkType(d);
      yd=VarUtils.getInt(d.eval(machine));
    }
    GraphicsDevice window = GraphicsDevice.getDevice(machine);
    if (window != null) {
      window.drawShape(VarUtils.getInt(id.eval(machine)), VarUtils.getInt(x.eval(machine)), VarUtils.getInt(y.eval(machine)), xd, yd);
    }
    return null;
  }

}
